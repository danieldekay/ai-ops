# Parakeet TDT v3 batch transcription

Bundled with the `media-transcript-ingester` skill. Transcribes audio/video with the Parakeet TDT v3 Core ML model from VibeSonic. Does not download model weights or modify source media.

## Requirements

- macOS 14+ and Swift 6.3+
- VibeSonic with Parakeet TDT v3 model
- VibeSonic bundled `ffmpeg` for MP4/MOV inputs

## Run

From this folder (or via `PARAKEET_PACKAGE` pointing here):

```sh
swift run TangocynicParakeet \
  /path/to/audio-or-folder \
  /path/to/output-folder
```

Arguments: `<file-or-folder> [output-folder]`. Extensions: mp4, mov, m4a, wav, mp3, aiff, flac. Override model with `PARAKEET_MODEL_DIR`. Existing `*.parakeet.txt` outputs are skipped.
