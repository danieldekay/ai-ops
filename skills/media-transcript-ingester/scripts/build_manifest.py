#!/usr/bin/env python3
"""Scan a run directory and write manifest.json coverage report."""

from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


def load_meta(item_dir: Path) -> dict[str, Any] | None:
    meta_path = item_dir / "metadata.json"
    if not meta_path.exists():
        return None
    try:
        return json.loads(meta_path.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        return {"id": item_dir.name, "status": "error", "error": "invalid metadata.json"}


def infer_status(item_dir: Path, meta: dict[str, Any] | None) -> str:
    if meta and meta.get("status") in ("ok", "missing", "error"):
        return meta["status"]
    readable = item_dir / "readable.md"
    raw_dir = item_dir / "raw"
    has_raw = raw_dir.is_dir() and any(raw_dir.iterdir())
    has_text = readable.exists() and readable.stat().st_size > 0
    if has_text or has_raw:
        return "ok" if has_text else "missing"
    return "missing"


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--root", required=True, type=Path)
    ap.add_argument("--out", type=Path, default=None)
    args = ap.parse_args()

    root: Path = args.root
    if not root.is_dir():
        print(f"error: root not a directory: {root}", file=sys.stderr)
        return 1

    items: list[dict[str, Any]] = []
    for child in sorted(root.iterdir()):
        if not child.is_dir():
            continue
        if child.name.startswith("."):
            continue
        # skip bulk staging dirs that are not item packs
        if child.name in ("raw-youtube", "audio", "parakeet-raw", "raw"):
            continue
        meta = load_meta(child)
        status = infer_status(child, meta)
        entry = {
            "id": (meta or {}).get("id") or child.name,
            "status": status,
            "transcript_method": (meta or {}).get("transcript_method"),
            "path": child.name,
            "title": (meta or {}).get("title"),
            "source_url": (meta or {}).get("source_url"),
            "error": (meta or {}).get("error"),
        }
        items.append(entry)

    counts = {
        "items": len(items),
        "with_transcript": sum(1 for i in items if i["status"] == "ok"),
        "missing": sum(1 for i in items if i["status"] == "missing"),
        "errors": sum(1 for i in items if i["status"] == "error"),
    }
    manifest = {
        "generated_at": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "root": str(root.resolve()),
        "counts": counts,
        "items": items,
    }

    out = args.out or (root / "manifest.json")
    out.write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(
        f"Wrote {out} — items={counts['items']} ok={counts['with_transcript']} "
        f"missing={counts['missing']} errors={counts['errors']}"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
