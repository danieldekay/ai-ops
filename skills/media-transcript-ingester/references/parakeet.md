[mode overridden: auto -> full, reason=instruction file requires complete content]

# Parakeet ASR (not Whisper)

This skill bundles the Swift CLI at:

`scripts/parakeet/` (executable target `TangocynicParakeet`)

## Requirements

- macOS 14+ and Swift 6.3+
- VibeSonic installed with Parakeet TDT v3 Core ML model
- VibeSonic bundled ffmpeg for MP4/MOV (or system ffmpeg only for non-MP4 inputs the tool accepts)

## Invoke

```bash
export PARAKEET_PACKAGE="${PARAKEET_PACKAGE:-$SKILL_DIR/scripts/parakeet}"

swift run --package-path "$PARAKEET_PACKAGE" TangocynicParakeet \
  /path/to/audio-or-folder \
  /path/to/parakeet-output
```

- Supported: mp4, mov, m4a, wav, mp3, aiff, flac
- Output: `<filename>.parakeet.txt` (plain text; existing files skipped)
- Model override: `PARAKEET_MODEL_DIR`

## Provenance

When normalizing Parakeet output set:

- `transcript_method`: `parakeet`
- `transcript_quality`: `unreviewed`

## Do not use by default

- OpenAI Whisper
- faster-whisper
- WhisperX

Only suggest those if the user explicitly refuses Parakeet or is not on Apple Silicon / VibeSonic.
