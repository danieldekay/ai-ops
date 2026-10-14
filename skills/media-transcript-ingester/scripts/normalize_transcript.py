#!/usr/bin/env python3
"""Normalize VTT/SRT/plain/.parakeet.txt into readable.md + segments.jsonl + metadata.json."""

from __future__ import annotations

import argparse
import json
import re
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


TS_VTT = re.compile(
    r"(?P<h>\d{2}):(?P<m>\d{2}):(?P<s>\d{2})\.(?P<ms>\d{3})\s*-->\s*"
    r"(?P<h2>\d{2}):(?P<m2>\d{2}):(?P<s2>\d{2})\.(?P<ms2>\d{3})"
)
TS_SRT = re.compile(
    r"(?P<h>\d{2}):(?P<m>\d{2}):(?P<s>\d{2}),(?P<ms>\d{3})\s*-->\s*"
    r"(?P<h2>\d{2}):(?P<m2>\d{2}):(?P<s2>\d{2}),(?P<ms2>\d{3})"
)
TAG_RE = re.compile(r"</?[^>]+>")
SPEAKER_RE = re.compile(r"^<v\s+([^>]+)>", re.I)


def to_seconds(h: str, m: str, s: str, ms: str) -> float:
    return int(h) * 3600 + int(m) * 60 + int(s) + int(ms) / 1000.0


def clean_text(line: str) -> tuple[str | None, str]:
    speaker = None
    m = SPEAKER_RE.match(line)
    if m:
        speaker = m.group(1).strip()
        line = line[m.end() :]
    line = TAG_RE.sub("", line)
    line = line.replace("&nbsp;", " ").replace("&amp;", "&").replace("&lt;", "<").replace("&gt;", ">")
    return speaker, line.strip()


def parse_vtt(text: str) -> list[dict[str, Any]]:
    segments: list[dict[str, Any]] = []
    blocks = re.split(r"\n\s*\n", text.replace("\r\n", "\n"))
    for block in blocks:
        lines = [ln for ln in block.split("\n") if ln.strip() and not ln.strip().startswith("WEBVTT") and not ln.strip().startswith("NOTE")]
        if not lines:
            continue
        ts_line = None
        body_start = 0
        for i, ln in enumerate(lines):
            if "-->" in ln:
                ts_line = ln
                body_start = i + 1
                break
        if not ts_line:
            continue
        m = TS_VTT.search(ts_line)
        if not m:
            continue
        start = to_seconds(m.group("h"), m.group("m"), m.group("s"), m.group("ms"))
        end = to_seconds(m.group("h2"), m.group("m2"), m.group("s2"), m.group("ms2"))
        speaker = None
        parts: list[str] = []
        for ln in lines[body_start:]:
            sp, cleaned = clean_text(ln)
            if sp and not speaker:
                speaker = sp
            if cleaned:
                parts.append(cleaned)
        if not parts:
            continue
        segments.append({"start": start, "end": end, "text": " ".join(parts), "speaker": speaker})
    return segments


def parse_srt(text: str) -> list[dict[str, Any]]:
    segments: list[dict[str, Any]] = []
    blocks = re.split(r"\n\s*\n", text.replace("\r\n", "\n"))
    for block in blocks:
        lines = [ln for ln in block.split("\n") if ln.strip()]
        if len(lines) < 2:
            continue
        # optional numeric index
        idx = 0
        if lines[0].isdigit():
            idx = 1
        if idx >= len(lines) or "-->" not in lines[idx]:
            continue
        m = TS_SRT.search(lines[idx])
        if not m:
            continue
        start = to_seconds(m.group("h"), m.group("m"), m.group("s"), m.group("ms"))
        end = to_seconds(m.group("h2"), m.group("m2"), m.group("s2"), m.group("ms2"))
        parts = []
        speaker = None
        for ln in lines[idx + 1 :]:
            sp, cleaned = clean_text(ln)
            if sp and not speaker:
                speaker = sp
            if cleaned:
                parts.append(cleaned)
        if parts:
            segments.append({"start": start, "end": end, "text": " ".join(parts), "speaker": speaker})
    return segments


def parse_plain(text: str) -> list[dict[str, Any]]:
    body = text.strip()
    if not body:
        return []
    return [{"start": None, "end": None, "text": body, "speaker": None}]


def load_segments(path: Path) -> list[dict[str, Any]]:
    raw = path.read_text(encoding="utf-8", errors="replace")
    suffix = path.suffix.lower()
    name = path.name.lower()
    if suffix == ".vtt" or name.endswith(".vtt"):
        return parse_vtt(raw)
    if suffix == ".srt":
        return parse_srt(raw)
    return parse_plain(raw)


def readable_from_segments(segments: list[dict[str, Any]], title: str | None, source_url: str | None) -> str:
    lines: list[str] = []
    if title:
        lines.append(f"# {title}")
        lines.append("")
    if source_url:
        lines.append(f"Source: {source_url}")
        lines.append("")
    paras: list[str] = []
    buf: list[str] = []
    for seg in segments:
        t = seg["text"].strip()
        if not t:
            continue
        buf.append(t)
        if t.endswith((".", "?", "!", "…")) and len(" ".join(buf)) > 200:
            paras.append(" ".join(buf))
            buf = []
    if buf:
        paras.append(" ".join(buf))
    if not paras and segments:
        paras = [segments[0]["text"]]
    lines.extend(paras)
    lines.append("")
    return "\n\n".join(lines) if paras else "\n".join(lines)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--raw", required=True, type=Path, help="Raw transcript file (vtt/srt/txt)")
    ap.add_argument("--out-dir", required=True, type=Path, help="Item directory")
    ap.add_argument("--id", default=None)
    ap.add_argument("--metadata-extra", default="{}", help="JSON object merged into metadata.json")
    args = ap.parse_args()

    raw: Path = args.raw
    out_dir: Path = args.out_dir
    out_dir.mkdir(parents=True, exist_ok=True)
    raw_dir = out_dir / "raw"
    raw_dir.mkdir(parents=True, exist_ok=True)

    if not raw.exists():
        print(f"error: raw file not found: {raw}", file=sys.stderr)
        return 1

    # Keep a copy under raw/ if not already there
    dest_raw = raw
    try:
        raw.resolve().relative_to(raw_dir.resolve())
    except ValueError:
        dest_raw = raw_dir / raw.name
        if raw.resolve() != dest_raw.resolve():
            dest_raw.write_bytes(raw.read_bytes())

    try:
        extra = json.loads(args.metadata_extra)
        if not isinstance(extra, dict):
            raise ValueError("metadata-extra must be a JSON object")
    except json.JSONDecodeError as exc:
        print(f"error: invalid --metadata-extra: {exc}", file=sys.stderr)
        return 2

    segments = load_segments(dest_raw if dest_raw.exists() else raw)
    item_id = args.id or extra.get("id") or out_dir.name
    title = extra.get("title")
    source_url = extra.get("source_url")

    status = "ok"
    error = None
    if not segments or not any((s.get("text") or "").strip() for s in segments):
        status = "missing"
        error = "empty transcript"

    readable = readable_from_segments(segments, title, source_url)
    (out_dir / "readable.md").write_text(readable, encoding="utf-8")
    with (out_dir / "segments.jsonl").open("w", encoding="utf-8") as f:
        for seg in segments:
            f.write(json.dumps(seg, ensure_ascii=False) + "\n")

    retrieved = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    meta: dict[str, Any] = {
        "id": item_id,
        "source_type": extra.get("source_type"),
        "source_url": source_url,
        "playlist_id": extra.get("playlist_id"),
        "title": title,
        "creator": extra.get("creator"),
        "published_at": extra.get("published_at"),
        "language": extra.get("language"),
        "transcript_method": extra.get("transcript_method"),
        "transcript_quality": extra.get("transcript_quality", "unreviewed"),
        "duration_seconds": extra.get("duration_seconds"),
        "retrieved_at": extra.get("retrieved_at", retrieved),
        "artifacts": {
            "raw_transcript": str(dest_raw.relative_to(out_dir)) if dest_raw.exists() else str(raw),
            "readable_transcript": "readable.md",
            "segments": "segments.jsonl",
            "metadata": "metadata.json",
        },
        "status": status,
        "error": error,
    }
    # Preserve any additional keys from extra without overwriting core status unless provided
    for k, v in extra.items():
        if k not in meta or meta[k] is None:
            meta[k] = v
    meta["status"] = status
    meta["error"] = error

    (out_dir / "metadata.json").write_text(json.dumps(meta, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"Normalized {item_id}: {len(segments)} segments, status={status}")
    return 0 if status == "ok" else 1


if __name__ == "__main__":
    sys.exit(main())
