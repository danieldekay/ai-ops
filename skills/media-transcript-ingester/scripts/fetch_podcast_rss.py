#!/usr/bin/env python3
"""Fetch podcast transcripts from RSS/Atom (Podcasting 2.0 podcast:transcript)."""

from __future__ import annotations

import argparse
import json
import re
import sys
import urllib.request
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import Any
from urllib.parse import urlparse

PODCAST_NS = "https://podcastindex.org/namespace/1.0"
ITUNES_NS = "http://www.itunes.com/dtds/podcast-1.0.dtd"
ATOM_NS = "http://www.w3.org/2005/Atom"

NS = {
    "podcast": PODCAST_NS,
    "itunes": ITUNES_NS,
    "atom": ATOM_NS,
}


def _local(tag: str) -> str:
    if "}" in tag:
        return tag.rsplit("}", 1)[-1]
    return tag


def _text(el: ET.Element | None) -> str | None:
    if el is None or el.text is None:
        return None
    t = el.text.strip()
    return t or None


def _attr(el: ET.Element, *names: str) -> str | None:
    for n in names:
        if n in el.attrib and el.attrib[n].strip():
            return el.attrib[n].strip()
    return None


def _slug(value: str, fallback: str) -> str:
    s = re.sub(r"[^\w.-]+", "-", value.strip(), flags=re.UNICODE).strip("-").lower()
    return (s[:80] or fallback)


def download(url: str, dest: Path) -> None:
    dest.parent.mkdir(parents=True, exist_ok=True)
    req = urllib.request.Request(url, headers={"User-Agent": "media-transcript-ingester/1.0"})
    with urllib.request.urlopen(req, timeout=120) as resp, dest.open("wb") as f:
        f.write(resp.read())


def parse_feed(xml_bytes: bytes) -> list[dict[str, Any]]:
    root = ET.fromstring(xml_bytes)
    items: list[dict[str, Any]] = []

    # RSS 2.0 channel/item
    channel = root.find("channel")
    if channel is not None:
        for item in channel.findall("item"):
            items.append(_rss_item(item))
        return items

    # Atom
    if _local(root.tag) == "feed":
        for entry in root.findall("atom:entry", NS) or root.findall("{%s}entry" % ATOM_NS):
            items.append(_atom_entry(entry))
        return items

    raise SystemExit(f"Unsupported feed root: {_local(root.tag)}")


def _transcripts_from(el: ET.Element) -> list[dict[str, str]]:
    out: list[dict[str, str]] = []
    # podcast:transcript with namespace
    for t in el.iter():
        if _local(t.tag) != "transcript":
            continue
        url = _attr(t, "url", "href")
        if not url:
            continue
        out.append(
            {
                "url": url,
                "type": _attr(t, "type") or "text/plain",
                "language": _attr(t, "language", "lang") or "",
            }
        )
    return out


def _enclosure(el: ET.Element) -> dict[str, str] | None:
    enc = el.find("enclosure")
    if enc is not None:
        url = _attr(enc, "url")
        if url:
            return {"url": url, "type": _attr(enc, "type") or "", "length": _attr(enc, "length") or ""}
    # media:content / atom link rel=enclosure
    for link in el.findall("atom:link", NS) + el.findall("{%s}link" % ATOM_NS) + el.findall("link"):
        rel = _attr(link, "rel") or ""
        href = _attr(link, "href", "url")
        if href and (rel == "enclosure" or ( _attr(link, "type") or "").startswith("audio")):
            return {"url": href, "type": _attr(link, "type") or "", "length": _attr(link, "length") or ""}
    return None


def _guid(el: ET.Element, title: str, enclosure_url: str | None) -> str:
    g = el.find("guid")
    raw = _text(g) or _text(el.find("atom:id", NS)) or enclosure_url or title or "episode"
    return _slug(raw, "episode")


def _rss_item(item: ET.Element) -> dict[str, Any]:
    title = _text(item.find("title")) or "Untitled"
    link = _text(item.find("link"))
    enc = _enclosure(item)
    transcripts = _transcripts_from(item)
    eid = _guid(item, title, enc["url"] if enc else None)
    return {
        "id": eid,
        "title": title,
        "source_url": link or (enc["url"] if enc else None),
        "published_at": _text(item.find("pubDate")),
        "enclosure": enc,
        "transcripts": transcripts,
        "needs_parakeet": len(transcripts) == 0,
    }


def _atom_entry(entry: ET.Element) -> dict[str, Any]:
    title = _text(entry.find("atom:title", NS)) or _text(entry.find("{%s}title" % ATOM_NS)) or "Untitled"
    link_el = entry.find("atom:link[@rel='alternate']", NS)
    if link_el is None:
        link_el = entry.find("atom:link", NS)
    link = _attr(link_el, "href") if link_el is not None else None
    enc = _enclosure(entry)
    transcripts = _transcripts_from(entry)
    eid = _guid(entry, title, enc["url"] if enc else None)
    return {
        "id": eid,
        "title": title,
        "source_url": link or (enc["url"] if enc else None),
        "published_at": _text(entry.find("atom:published", NS)) or _text(entry.find("atom:updated", NS)),
        "enclosure": enc,
        "transcripts": transcripts,
        "needs_parakeet": len(transcripts) == 0,
    }


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--feed", required=True, help="Podcast RSS/Atom URL or local XML path")
    ap.add_argument("--out", required=True, type=Path, help="Output run directory")
    ap.add_argument("--download-transcripts", action="store_true", default=True)
    ap.add_argument("--no-download-transcripts", action="store_false", dest="download_transcripts")
    args = ap.parse_args()

    out: Path = args.out
    out.mkdir(parents=True, exist_ok=True)

    feed = args.feed
    if urlparse(feed).scheme in ("http", "https"):
        req = urllib.request.Request(feed, headers={"User-Agent": "media-transcript-ingester/1.0"})
        with urllib.request.urlopen(req, timeout=120) as resp:
            xml_bytes = resp.read()
    else:
        xml_bytes = Path(feed).read_bytes()

    episodes = parse_feed(xml_bytes)
    downloaded = 0

    for ep in episodes:
        item_dir = out / ep["id"]
        raw_dir = item_dir / "raw"
        if args.download_transcripts and ep["transcripts"]:
            raw_dir.mkdir(parents=True, exist_ok=True)
            for i, tr in enumerate(ep["transcripts"]):
                ext = ".vtt" if "vtt" in (tr.get("type") or "") else ".txt"
                if tr["url"].endswith(".srt"):
                    ext = ".srt"
                elif tr["url"].endswith(".vtt"):
                    ext = ".vtt"
                dest = raw_dir / f"podcast-transcript-{i}{ext}"
                try:
                    download(tr["url"], dest)
                    tr["local_path"] = str(dest.relative_to(out))
                    downloaded += 1
                    ep["needs_parakeet"] = False
                except Exception as exc:  # noqa: BLE001 — per-item soft fail
                    tr["error"] = str(exc)
                    ep.setdefault("errors", []).append(str(exc))

    catalog = {
        "feed": feed,
        "episode_count": len(episodes),
        "with_transcript": sum(1 for e in episodes if not e["needs_parakeet"]),
        "needs_parakeet": sum(1 for e in episodes if e["needs_parakeet"]),
        "transcripts_downloaded": downloaded,
        "episodes": episodes,
    }
    catalog_path = out / "rss-episodes.json"
    catalog_path.write_text(json.dumps(catalog, indent=2) + "\n", encoding="utf-8")
    print(f"Wrote {catalog_path} ({catalog['with_transcript']} with transcript, {catalog['needs_parakeet']} need Parakeet)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
