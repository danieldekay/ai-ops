# Media Transcript Ingester Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Ship a global Agent Skill that turns YouTube URLs, podcast RSS feeds, and local media into normalized transcript evidence packs with light segments, using yt-dlp / RSS first and Parakeet (not Whisper) for gaps.

**Architecture:** `SKILL.md` orchestrates; deterministic scripts handle yt-dlp, RSS parsing, VTT/SRT/text normalization, and manifest building. Parakeet Swift package is bundled at `scripts/parakeet/` and invoked via `PARAKEET_PACKAGE` (default: skill-local path).

**Tech Stack:** Bash, Python 3 stdlib, yt-dlp, ffmpeg, Swift Parakeet (FluidAudio / VibeSonic)

---

### Task 1: Skill skeleton + references

**Files:**
- Create: `skills/media-transcript-ingester/SKILL.md`
- Create: `skills/media-transcript-ingester/references/output-schema.md`
- Create: `skills/media-transcript-ingester/references/parakeet.md`

**Step 1:** Write SKILL.md with pushy description, workflow, routing table, env vars, evidence semantics.  
**Step 2:** Document metadata / segments / manifest schemas and Parakeet invocation.

### Task 2: YouTube subtitle fetcher

**Files:**
- Create: `skills/media-transcript-ingester/scripts/fetch_youtube_subs.sh`

**Step 1:** Wrapper for `yt-dlp --skip-download --write-subs --write-auto-subs --write-info-json` with lang prefs.  
**Step 2:** Support optional archive file; document that agents must only append after transcript exists.  
**Step 3:** Optional `--audio-missing` mode to extract audio for items without captions.

### Task 3: Podcast RSS fetcher

**Files:**
- Create: `skills/media-transcript-ingester/scripts/fetch_podcast_rss.py`

**Step 1:** Parse RSS/Atom; collect `podcast:transcript` and enclosure URLs.  
**Step 2:** Download transcript files when present; emit JSON listing missing (Parakeet candidates).

### Task 4: Normalize + segments

**Files:**
- Create: `skills/media-transcript-ingester/scripts/normalize_transcript.py`

**Step 1:** Accept VTT / SRT / plain text / `.parakeet.txt`.  
**Step 2:** Write `readable.md`, `segments.jsonl`, merge into `metadata.json`.

### Task 5: Manifest builder

**Files:**
- Create: `skills/media-transcript-ingester/scripts/build_manifest.py`

**Step 1:** Scan run directory; count with_transcript / missing / errors.  
**Step 2:** Write `manifest.json`.

### Task 6: Evals + install notes

**Files:**
- Create: `skills/media-transcript-ingester/evals/evals.json`

**Step 1:** Three prompts (playlist plan, RSS prefer transcript, local Parakeet).  
**Step 2:** Install to `~/.agents/skills/media-transcript-ingester` (symlink or copy) and hand off APM command.

### Task 7: Smoke-test scripts offline

**Step 1:** Normalize a tiny sample VTT fixture.  
**Step 2:** Build manifest over a fake item dir.  
**Step 3:** Close bead when done.
