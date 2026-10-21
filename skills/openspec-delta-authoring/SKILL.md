---
name: "openspec-delta-authoring"
description: "Author and archive OpenSpec changes without archive-refusal surprises: MODIFIED deltas must carry ALL existing scenario headers verbatim, docs-only changes need skip_specs: true, delta files live under specs/<capability>/spec.md with ## ADDED/MODIFIED/REMOVED headers. Triggers: \"openspec change\", \"openspec archive\", \"openspec validate failed\", \"MODIFIED omits scenario(s)\", writing spec deltas."
version: 1
created: "2026-10-06"
updated: "2026-10-06"
---
## When to Use
Creating or reviewing openspec change deltas (specs/ blocks), fixing validate/archive aborts, or sweeping spec references in a docs-only change.

## Procedure
1. Run `openspec validate <change>` BEFORE proposing to archive; fix every ERROR until clean (INFO lines are cosmetic).
2. For each MODIFIED requirement: open the current spec (openspec/specs/<capability>/spec.md) and copy EVERY existing #### Scenario block verbatim into the change's delta block — a MODIFIED replaces the whole requirement on archive, so any missing scenario reads as dropped and the archive aborts.
3. NEVER rename an existing scenario inside a delta — renaming = dropping. Add new scenarios alongside the originals; update their WHEN/THEN text if the behavior changed.
4. Copy inherited scenarios with their original script names only if still true; if a referenced script was renamed by another change landing in the same archive pass, fix the name in the copied text (precedent: kg_build.py → kg.py build).
5. Docs-only changes (no capability change): create .openspec.yaml with `schema: spec-driven` + `skip_specs: true` — otherwise validate fails with a missing-delta error; the validator's own error message prescribes this.
6. Stale Purpose/Technical Notes/tables inside openspec/specs/ that are NOT requirement text are corrected directly as reference-sweep tasks in a docs-only change (kg-cli-consolidation precedent) — no delta needed.
7. Archive order for stacked changes: oldest first (`openspec archive <oldest> --yes`), re-run `openspec validate --all` after each; aborts apply nothing, so a failed archive is always safe to retry.
8. Keep verification scripts inside the change dir (openspec/changes/<change>/scripts/) — they rename into openspec/changes/archive/ on archive and stay runnable as regression scripts (kg-parallel-ingest precedent).
9. Commit the proposal as its own commit BEFORE dispatching implementation agents; commit implementation pathspec-scoped; commit the archive last and push.

## Pitfalls
- No notable pitfalls recorded yet.

## Verification
1. openspec validate <change> exits clean before archive
2. openspec validate --all passes after archive
3. git log shows the delta scenarios present in openspec/specs/<capability>/spec.md post-archive