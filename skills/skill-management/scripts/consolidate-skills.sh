#!/usr/bin/env bash
# consolidate-skills.sh — Option B: single-canonical + curated global skills dir.
# Part of the skill-management skill (ai-ops/skills/skill-management).
#
# SAFE BY DESIGN: dedupe is done by default (reversible, no capability loss).
# Curation (archiving non-global skills) is OPT-IN and only ever moves files —
# nothing is deleted; everything relocated goes to a dated backup dir.
#
# Default behavior (--dry-run or --apply with no options):
#   1. Dedupe redundant real copies in ~/.pi/agent/skills (pi also reads
#      ~/.agents/skills) -> moved to backup.
#   2. Move stray non-skill files out of ~/.agents/skills -> backup.
# Curation (optional):
#   --archive-file <names>  a file of skill names (one per line, '#' comments)
#                           to de-load by moving into ~/.agents/skills/_archive/
#                           (not loaded, not deleted).
#
# Usage:
#   consolidate-skills.sh [--archive-file <path>] [--dry-run|--apply] [--verbose]

set -u

SKILLS="${SKILLS:-$HOME/.agents/skills}"
PI_SKILLS="$HOME/.pi/agent/skills"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.agents/.skill-mgmt-backup-$STAMP"  # OUTSIDE scan tree; never loaded
ARCHIVE="$SKILLS/_archive"
PATCH=""
VERBOSE=0
APPLY=0
ARCHIVE_FILE=""

usage() { sed -n '3,26p' "$0" | sed 's/^# \{0,1\}//'; exit "${1:-2}"; }

while [ $# -gt 0 ]; do
  case "$1" in
    --archive-file) ARCHIVE_FILE="${2:?archive-file required}"; shift 2;;
    --dry-run)   APPLY=0; shift;;
    --apply)     APPLY=1; shift;;
    --verbose)   VERBOSE=1; shift;;
    -h|--help)   usage 0;;
    *) echo "unknown arg: $1"; usage;;
  esac
done

set -u
# names to archive (explicit opt-in list)
ARCHIVE_NAMES=""
if [ -n "$ARCHIVE_FILE" ]; then
  ARCHIVE_NAMES=$(grep -vE '^\s*(#|$)' "$ARCHIVE_FILE" 2>/dev/null || true)
fi
in_archive() { printf '%s\n' "$ARCHIVE_NAMES" | grep -qx "$1"; }

dd() { # dry-run/apply print helper: $1 = msg
  if [ $APPLY -eq 1 ]; then printf '  %s\n' "$1"; else printf '  WOULD %s\n' "$1"; fi
}

[ -d "$SKILLS" ] || { echo "skills dir missing: $SKILLS"; exit 2; }
[ $APPLY -eq 1 ] && mkdir -p "$BACKUP"

move_safe() { # $1=src  $2=reason  $3=into  (into: backup|archive)
  if [ $APPLY -eq 1 ]; then
    dest="$BACKUP"
    [ "$3" = "archive" ] && { mkdir -p "$ARCHIVE"; dest="$ARCHIVE"; }
    mv "$1" "$dest/$(basename "$1")" 2>/dev/null \
      && printf '  MOVED -> %s: %s (%s)\n' "$dest" "$1" "$2"
  else
    printf '  WOULD move -> %s: %s (%s)\n' "$3" "$1" "$2"
  fi
}

echo "=============================================================="
echo " Option B consolidation   [$( [ $APPLY -eq 1 ] && echo APPLY || echo DRY-RUN )]"
echo " canonical : $SKILLS"
echo " backup    : $BACKUP"
echo " archive   : $ARCHIVE (only from --archive-file)"
echo "----------------------------------------------"

# --- STEP 1 (optional curation): archive only explicitly listed names ---
if [ -n "$ARCHIVE_NAMES" ]; then
  echo "STEP 1 — archive explicitly-listed skills (curation)"
  for name in $ARCHIVE_NAMES; do
    [ -d "$SKILLS/$name" ] || continue
    move_safe "$SKILLS/$name" "archive-listed (de-load)" "archive"
  done
else
  echo "STEP 1 — curation: none (no --archive-file given) — nothing de-loaded"
fi

# --- STEP 2 (always): dedupe redundant real copies in ~/.pi/agent/skills ---
echo "STEP 2 — dedupe $PI_SKILLS (pi also reads $SKILLS)"
[ -d "$PI_SKILLS" ] || echo "  (no $PI_SKILLS)"
for entry in "$PI_SKILLS"/*; do
  [ -e "$entry" ] || continue
  name="$(basename "$entry")"
  [ "$name" = ".DS_Store" ] && continue
  if [ -d "$SKILLS/$name" ] || [ -d "$ARCHIVE/$name" ]; then
    move_safe "$entry" "redundant-pi-copy (canonical on disk)" "backup"
  elif [ -L "$entry" ]; then
    [ $VERBOSE -eq 1 ] && echo "  skip (already symlink): $name"
  else
    [ $VERBOSE -eq 1 ] && echo "  keep (pi-only, not canonical): $name"
  fi
done

# --- STEP 3 (always): shift stray non-skill files out of the scan tree ---
echo "STEP 3 — stray non-skill files in $SKILLS"
for entry in "$SKILLS"/*; do
  [ -f "$entry" ] || continue
  case "$(basename "$entry")" in
    .DS_Store|.skill-mgmt-backup-*) continue;;
  esac
  move_safe "$entry" "stray-non-skill-file" "backup"
done

echo "----------------------------------------------"
if [ $APPLY -eq 1 ]; then
  echo "DONE (applied). Relocated files are in: $BACKUP"
else
  echo "DRY-RUN ONLY — nothing changed. Run with --apply to execute."
fi
echo "=============================================================="
