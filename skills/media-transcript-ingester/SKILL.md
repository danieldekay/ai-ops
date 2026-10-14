---
name: media-transcript-ingester
description: >
  Ingest YouTube videos/playlists/channels and podcast RSS feeds into normalized
  transcript evidence packs with light timestamp segments. Use whenever the user
  asks to download captions, extract transcripts, transcribe a podcast episode,
  process a YouTube playlist into text, build a media evidence archive, or fill
  gaps with local ASR — even if they say Whisper. Prefer existing captions/RSS
  transcripts first; use the repo Parakeet CLI (not Whisper) only for missing
  audio. Also use for TangoAtlas / research ingestion workflows that need
  provenance, manifests, and segment anchors.
compatibility: Requires yt-dlp and ffmpeg on PATH. Parakeet ASR needs macOS + VibeSonic Parakeet TDT v3 (or PARAKEET_MODEL_DIR) and the Swift package at PARAKEET_PACKAGE.
---

# Media Transcript Ingester

Reusable acquisition workflow: **existing transcripts first**, Parakeet only for gaps, always leave a manifest that shows what is missing.

## Why this order

Publisher captions and Podcasting 2.0 transcripts are cheaper and often better than ASR — especially for multilingual tango interviews (en/de/es/it). Running ASR on everything wastes compute and can overwrite human-edited text with errors on vocabulary like cabeceo, milonga, cortina, tanda, orchestra and dancer names.

A spoken claim is **evidence of what was said**, not proof that the claim is true. Keep that distinction for any downstream knowledge work.

## Prerequisites

| Tool | Role |
|------|------|
| `yt-dlp` | YouTube (and YouTube-hosted) captions / optional audio |
| `ffmpeg` | Audio extract when needed (`brew install yt-dlp ffmpeg`) |
| Parakeet CLI | Local ASR for gaps — see `references/parakeet.md` |
| Python 3 | Bundled RSS / normalize / manifest scripts |

```bash
# Defaults to the Swift package bundled under this skill:
#   $SKILL_DIR/scripts/parakeet
export PARAKEET_PACKAGE="${PARAKEET_PACKAGE:-$SKILL_DIR/scripts/parakeet}"
# optional: export PARAKEET_MODEL_DIR=...
```

Skill scripts live next to this file under `scripts/` (including the Parakeet Swift package at `scripts/parakeet`). Resolve `SKILL_DIR` as the directory containing `SKILL.md`.

## Workflow

```
Input URL or local media
  → route by source type
  → retrieve existing transcripts
  → list gaps in working notes / partial manifest
  → download audio only for gaps → Parakeet
  → normalize each item (md + segments + metadata)
  → build_manifest.py (coverage SSOT)
```

### 1. Route the input

| Input | First path | Fallback |
|-------|------------|----------|
| YouTube video / playlist / channel | `scripts/fetch_youtube_subs.sh` | Audio extract → Parakeet |
| Podcast RSS / Atom URL | `scripts/fetch_podcast_rss.py` | Enclosure audio → Parakeet |
| Local audio/video file or folder | — | Parakeet directly |

### 2. YouTube captions

```bash
mkdir -p "$OUT/raw-youtube" && cd "$OUT"
bash "$SKILL_DIR/scripts/fetch_youtube_subs.sh" "$OUT/raw-youtube" \
  "https://www.youtube.com/playlist?list=..."
```

Lang prefs default to `en.*,de.*,es.*,it.*`. The script writes `.vtt` + `.info.json` and does **not** download video by default.

**Archive caution:** Do not append a video id to `--download-archive` until a caption or Parakeet transcript for that id exists. Otherwise caption-less videos stay skipped forever.

For items still missing captions:

```bash
bash "$SKILL_DIR/scripts/fetch_youtube_subs.sh" --audio-for-ids "$OUT/missing-ids.txt" \
  "$OUT/audio" "https://www.youtube.com/playlist?list=..."
# then Parakeet on $OUT/audio
```

### 3. Podcast RSS

```bash
python3 "$SKILL_DIR/scripts/fetch_podcast_rss.py" \
  --feed "https://example.com/podcast.xml" \
  --out "$OUT"
```

Downloads `podcast:transcript` files when present; writes `rss-episodes.json` listing episodes that need ASR (`needs_parakeet: true` + enclosure URL).

### 4. Parakeet for gaps only

```bash
swift run --package-path "$PARAKEET_PACKAGE" TangocynicParakeet \
  "$OUT/audio" "$OUT/parakeet-raw"
```

Skips outputs that already exist. Details: `references/parakeet.md`. **Do not** default to Whisper / faster-whisper while this skill is active.

### 5. Normalize each item

Create one directory per item (`<stable-id>/`) with `raw/` holding the source transcript file, then:

```bash
python3 "$SKILL_DIR/scripts/normalize_transcript.py" \
  --raw "$ITEM/raw/captions.en.vtt" \
  --out-dir "$ITEM" \
  --metadata-extra '{"source_type":"youtube","source_url":"...","transcript_method":"youtube_auto"}'
```

Produces `readable.md`, `segments.jsonl`, `metadata.json`. Schema: `references/output-schema.md`.

`transcript_method` values: `youtube_manual` | `youtube_auto` | `podcast_rss` | `parakeet`.

### 6. Manifest (required)

```bash
python3 "$SKILL_DIR/scripts/build_manifest.py" --root "$OUT" --out "$OUT/manifest.json"
```

Never treat a run as complete without reading the manifest. Missing and error rows must stay visible.

## Output layout

```
<run-dir>/
  <item-id>/
    raw/
    readable.md
    segments.jsonl
    metadata.json
  manifest.json
```

Default `transcript_quality`: `unreviewed`.

## Quality checks (v1)

- Manifest counts: `with_transcript` / `missing` / `errors`
- Flag empty or near-empty body text
- Record language + method; do not auto-“fix” tango vocabulary in v1
- Prefer manual captions over auto over Parakeet when several exist

## Out of scope

Claim extraction, vector indexes, speaker diarization, cloud STT, writing directly into TangoAtlas DB. Those are separate project skills/workers that consume this evidence pack.

## Quick checklist

1. Confirm `yt-dlp` (and Parakeet only if gaps expected)
2. Fetch existing transcripts
3. Fill gaps with Parakeet
4. Normalize all items
5. Build manifest and report coverage to the user
