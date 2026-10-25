#!/usr/bin/env bash
# publish-skill.sh — one command after editing skills in ai-ops.
#
# Encodes the full skill-publish-flow: stage the EXACT skill path, commit,
# push, verify the global manifest declaration, then run `apm update
# --global --yes` + `apm install -g --force` in the BACKGROUND (it takes
# 2–3 min) with a verification pass afterwards. Never edit ~/.agents/skills
# directly — this script is the only sanctioned path to the installed layer.
#
# Usage:
#   publish-skill.sh SKILL [SKILL...]          publish + bg apm refresh
#   publish-skill.sh --sync SKILL              foreground apm refresh instead
#   publish-skill.sh --dry-run SKILL           show what would happen
#   publish-skill.sh --no-push SKILL           commit only, skip git push
#   publish-skill.sh --declare SKILL           auto-add missing manifest line
#   publish-skill.sh --status                  show last background job result
#   publish-skill.sh --verify SKILL [SKILL...] verify installed == canonical now
#
# Exit codes: 0 ok, 1 usage/declaration error, 2 git failure, 3 bg job failed.
set -u

AIOPS="${AIOPS_DIR:-$HOME/coding/ai-ops}"
MANIFEST="${APM_MANIFEST:-$HOME/.apm/apm.yml}"
INSTALLED="${INSTALLED_SKILLS:-$HOME/.agents/skills}"
LOG_DIR="${APM_PUBLISH_LOG_DIR:-/tmp/apm-publish}"
LOCK="$LOG_DIR/running.pid"

MODE=publish      # publish | verify | status
SYNC=0; DRY=0; PUSH=1; DECLARE=0; COMMIT_MSG=""
while [ $# -gt 0 ]; do
  case "$1" in
    --sync) SYNC=1 ;;
    --dry-run) DRY=1 ;;
    --no-push) PUSH=0 ;;
    --declare) DECLARE=1 ;;
    -m) shift; COMMIT_MSG="${1:-}" ;;
    --verify) MODE=verify ;;
    --status) MODE=status ;;
    -h|--help) sed -n '2,25p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*) echo "unknown flag: $1" >&2; exit 1 ;;
    *) break ;;
  esac
  shift
done

mkdir -p "$LOG_DIR"

# ---------- --status: report last bg job ----------
if [ "$MODE" = status ]; then
  last=$(ls -t "$LOG_DIR"/job-*.log 2>/dev/null | head -1)
  [ -n "$last" ] || { echo "no background publish jobs yet"; exit 0; }
  echo "== $last =="
  tail -20 "$last"
  grep -q "PUBLISH RESULT: OK" "$last" && echo "RESULT: OK" || echo "RESULT: check log above"
  exit 0
fi

[ $# -ge 1 ] || { echo "usage: publish-skill.sh [--sync|--dry-run|--no-push|--declare] SKILL [SKILL...]"; exit 1; }
SKILLS=("$@")

# ---------- shared helpers ----------
verify_skills() {
  local ok=0 n bad=""
  n=$(ls "$INSTALLED" 2>/dev/null | wc -l | tr -d ' ')
  for s in "$@"; do
    if [ ! -d "$INSTALLED/$s" ]; then
      echo "MISSING INSTALLED: $s"; bad="$bad $s"; ok=1
    elif ! diff -q "$AIOPS/skills/$s/SKILL.md" "$INSTALLED/$s/SKILL.md" >/dev/null 2>&1; then
      echo "DIFF: $s (installed != canonical)"; bad="$bad $s"; ok=0
    else
      echo "OK: $s"
    fi
  done
  echo "installed-count: $n"
  return $ok
}

declare_check() {
  # returns 0 if declared; with DECLARE=1 inserts the line when missing.
  local s="$1"
  if grep -qF "skills/$s/" "$MANIFEST" 2>/dev/null; then return 0; fi
  if [ "$DECLARE" = 1 ] && [ "$DRY" = 0 ]; then
    # insert right under the `dependencies:` list header, same indent as siblings
    awk -v ins="    - danieldekay/ai-ops/skills/$s/" '
      !done && /^dependencies:/ { print; print ins; done=1; next } { print }
    ' "$MANIFEST" > "$MANIFEST.tmp" && mv "$MANIFEST.tmp" "$MANIFEST"
    grep -qF "skills/$s/" "$MANIFEST" || { echo "FAILED to declare $s in $MANIFEST" >&2; return 1; }
    echo "DECLARED: $s (added to $MANIFEST)"
    return 0
  fi
  echo "WARNING: $s is NOT declared in $MANIFEST — it will NOT deploy." >&2
  echo "         add:    - danieldekay/ai-ops/skills/$s/" >&2
  echo "         (or rerun with --declare)" >&2
  return 1
}

# ---------- --verify mode ----------
if [ "$MODE" = verify ]; then
  verify_skills "${SKILLS[@]}"; exit $?
fi

# ---------- publish mode ----------
cd "$AIOPS" || { echo "cannot cd $AIOPS" >&2; exit 2; }

declare -a to_publish=()
for s in "${SKILLS[@]}"; do
  [ -f "skills/$s/SKILL.md" ] || { echo "no such skill: skills/$s" >&2; exit 1; }
  if git status --porcelain -- "skills/$s" | grep -q .; then
    to_publish+=("$s")
  else
    echo "no uncommitted changes in skills/$s (still verifying declaration + refresh)"
  fi
done

if [ "$DRY" = 1 ]; then
  echo "DRY RUN — would commit: ${to_publish[*]:-(nothing)}"
  for s in "${SKILLS[@]}"; do declare_check "$s" || true; done
  exit 0
fi

# single-flight guard: one bg apm job at a time (shared lockfile)
if [ -f "$LOCK" ] && kill -0 "$(cat "$LOCK")" 2>/dev/null; then
  echo "a publish job is already running (pid $(cat "$LOCK")):" >&2
  echo "  publish-skill.sh --status   # or wait for it to finish" >&2
  exit 3
fi

# commit each skill separately (exact pathspec — never git add -A)
for s in "${to_publish[@]}"; do
  msg="${COMMIT_MSG:-skills: update $s}"
  git add "skills/$s" || exit 2
  git commit -m "$msg" -- "skills/$s" >/dev/null || { echo "commit failed for $s" >&2; exit 2; }
  echo "COMMITTED: $s"
done

if [ "$PUSH" = 1 ] && [ "${#to_publish[@]}" -gt 0 ]; then
  git push || { echo "git push failed — apm refresh SKIPPED (fix push, then rerun with --no-push)" >&2; exit 2; }
  echo "PUSHED: ${to_publish[*]}"
fi

# declaration check for every requested skill
declare_ok=0
for s in "${SKILLS[@]}"; do
  declare_check "$s" && declare_ok=$((declare_ok+1))
done
[ "$declare_ok" -eq "${#SKILLS[@]}" ] || { echo "fix the declaration(s) above, then rerun (apm refresh NOT started)" >&2; exit 1; }

# ---------- background apm refresh ----------
stamp=$(date +%Y%m%d-%H%M%S)
log="$LOG_DIR/job-$stamp.log"
skill_list="${SKILLS[*]}"

run_refresh() {
  echo "apm update --global --yes  (started $(date))"
  apm update --global --yes || { echo "PUBLISH RESULT: FAIL (apm update)"; return 1; }
  echo "apm install -g --force"
  apm install -g --force || { echo "PUBLISH RESULT: FAIL (apm install)"; return 1; }
  echo "--- verification ---"
  # shellcheck disable=SC2086
  if verify_skills $skill_list; then
    echo "PUBLISH RESULT: OK"
  else
    echo "PUBLISH RESULT: FAIL (verification)"
    return 1
  fi
}

if [ "$SYNC" = 1 ]; then
  run_refresh
  exit $?
fi

echo "$$" > "$LOCK"
(
  run_refresh
  rc=$?
  echo "PUBLISH EXIT: $rc"
  rm -f "$LOCK"
) >> "$log" 2>&1 &

echo "BG JOB STARTED: $log"
echo "check with:  publish-skill.sh --status"
