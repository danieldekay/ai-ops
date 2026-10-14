#!/usr/bin/env bash
# Fetch YouTube captions (no video) via yt-dlp. Optionally extract audio for a list of IDs.
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  fetch_youtube_subs.sh [--archive FILE] [--sub-langs LANGS] <out-dir> <youtube-url>
  fetch_youtube_subs.sh --audio-for-ids <ids-file> <out-dir> <youtube-url>

Captions mode writes .vtt + .info.json under out-dir (skip-download).
Audio mode extracts m4a/wav for video IDs listed one-per-line in ids-file.

Do NOT treat --archive as proof of a transcript: only append an ID after a
caption or Parakeet file for that ID actually exists.
EOF
}

ARCHIVE=""
SUB_LANGS="en.*,de.*,es.*,it.*"
AUDIO_IDS=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --archive)
      ARCHIVE="${2:?}"
      shift 2
      ;;
    --sub-langs)
      SUB_LANGS="${2:?}"
      shift 2
      ;;
    --audio-for-ids)
      AUDIO_IDS="${2:?}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      break
      ;;
  esac
done

if [[ $# -lt 2 ]]; then
  usage
  exit 2
fi

OUT_DIR="${1:?}"
URL="${2:?}"
mkdir -p "$OUT_DIR"

if ! command -v yt-dlp >/dev/null 2>&1; then
  echo "error: yt-dlp not found (brew install yt-dlp ffmpeg)" >&2
  exit 1
fi

COMMON=(
  --yes-playlist
  --ignore-errors
  -o "${OUT_DIR}/%(playlist_index)s - %(title)s [%(id)s].%(ext)s"
)

if [[ -n "$AUDIO_IDS" ]]; then
  if [[ ! -f "$AUDIO_IDS" ]]; then
    echo "error: ids file not found: $AUDIO_IDS" >&2
    exit 1
  fi
  # Prefer per-id watch URLs over brittle match-filter regexes (bash 3.2 safe).
  count=0
  while IFS= read -r vid || [[ -n "$vid" ]]; do
    [[ -z "$vid" || "$vid" =~ ^[[:space:]]*# ]] && continue
    count=$((count + 1))
    yt-dlp \
      -o "${OUT_DIR}/%(title)s [%(id)s].%(ext)s" \
      --extract-audio \
      --audio-format m4a \
      --audio-quality 0 \
      --ignore-errors \
      "https://www.youtube.com/watch?v=${vid}"
  done < "$AUDIO_IDS"
  if [[ "$count" -eq 0 ]]; then
    echo "error: no ids in $AUDIO_IDS" >&2
    exit 1
  fi
  exit 0
fi

ARGS=(
  "${COMMON[@]}"
  --skip-download
  --write-subs
  --write-auto-subs
  --sub-langs "$SUB_LANGS"
  --sub-format "vtt/best"
  --write-info-json
)

if [[ -n "$ARCHIVE" ]]; then
  ARGS+=(--download-archive "$ARCHIVE")
fi

yt-dlp "${ARGS[@]}" "$URL"
echo "Captions pass finished under $OUT_DIR"
echo "Reminder: only archive IDs that have a real transcript artifact."
