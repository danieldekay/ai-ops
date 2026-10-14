# Output schema

## metadata.json

```json
{
  "id": "stable-item-id",
  "source_type": "youtube|podcast|local",
  "source_url": "https://...",
  "playlist_id": null,
  "title": "Episode title",
  "creator": "Original creator",
  "published_at": null,
  "language": "en",
  "transcript_method": "youtube_manual|youtube_auto|podcast_rss|parakeet",
  "transcript_quality": "unreviewed",
  "duration_seconds": null,
  "retrieved_at": "2026-10-14T00:00:00Z",
  "artifacts": {
    "raw_transcript": "raw/....",
    "readable_transcript": "readable.md",
    "segments": "segments.jsonl",
    "metadata": "metadata.json"
  },
  "status": "ok|missing|error",
  "error": null
}
```

## segments.jsonl

One JSON object per line:

```json
{"start": 12.34, "end": 18.9, "text": "Segment text", "speaker": null}
```

- Times in seconds (float). Use `null` for `end` or both when the source has no timestamps (e.g. plain Parakeet text → one segment, `start`/`end` null).
- `speaker` only when present in the source.

## readable.md

Front matter optional; body is the full transcript as plain markdown paragraphs (cue timestamps stripped for readability). Keep a short header with title + source URL when known.

## manifest.json

```json
{
  "generated_at": "2026-10-14T00:00:00Z",
  "root": "/path/to/run",
  "counts": {
    "items": 10,
    "with_transcript": 7,
    "missing": 2,
    "errors": 1
  },
  "items": [
    {
      "id": "...",
      "status": "ok|missing|error",
      "transcript_method": "...",
      "path": "<item-id>",
      "title": "...",
      "source_url": "..."
    }
  ]
}
```
