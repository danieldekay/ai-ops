---
name: openspec-subagent-waves
description: >
  Implement an OpenSpec change through gated subagent waves with a
  parent-curated brief per wave. Use when the user says "implement
  <openspec-change> with subagents", "implement via waves", or when a
  validated openspec/changes/<id>/ needs proposal/design/tasks turned into
  verified, committed code. Covers the preflight, parallel disjoint lanes,
  adoption, gates, adversarial review, and close-out arc plus the
  shared-tree hazards (generated artifacts, parallel sessions, post-commit-only gates).
author: Daniel Kaesmayr
metadata:
  version: "1.0.0"
  category: dev
  validated: "2026-10-24 tmd_theme ETVL + ECI session"
---

# OpenSpec Subagent Waves

Implement one validated OpenSpec change as an ordered wave arc, one writer per
file set, every wave gated before the next. The parent orchestrates and owns
git; children own scoped edits and gates.

## When to Use

- A change under `openspec/changes/<id>/` has proposal + design + tasks and
  the user asks to implement it with agents.
- Not for: planning (use openspec-propose), single one-line fixes (direct),
  or changes whose gates cannot run locally.

## Procedure

1. **Read everything first** — proposal, design, tasks, the delta spec, and
   the touched source files. The design section numbers (§B8, §B9...) are the
   implementation contract; quote them in briefs.
2. **Wave 0 preflight (no production code):** baseline gates BEFORE any edit
   (test suite, pixel-diff at 0.0000%, run-verify snapshot), live-data
   re-confirmation of the design's measured numbers, owner decisions recorded
   in the change's `verification.md`. If any gate is red pre-edit, STOP.
3. **Parallel disjoint waves:** split tasks by FILE SET, not by phase — two
   children on disjoint files beat one child on everything. Anything touching
   the same module is one child.
4. **Adoption wave:** templates/routing converge on the new helper/partial in
   ONE wave so the tree never renders half-migrated.
5. **Gates wave:** rerun everything, produce before/after tables, refresh
   baselines deliberately (pixel-diff --update) BEFORE creating test fixtures
   — fixtures must never leak into baselines.
6. **Adversarial review:** read-only child, 2 lenses, never the author's own
   lens. Fix-first verdicts get a bounded fix round + gate rerun before commit.
7. **Close-out:** spec sync (diff review: exactly which requirements
   added/modified), CHANGELOG, evidence comment on the tracking issue, then
   parent commits, then post-commit-only gates, then archive + close the bead.

## Pitfalls

- **Generated artifacts bundle all sources.** A sibling change's uncommitted
  partial (e.g. surfaces/detail.css into a bundled style.css) contaminates
  your build. Prove artifact gates against the COMMITTED tree:
  `git archive HEAD | tar -x` + rebuild, or stash the foreign source,
  rebuild, commit, pop, rebuild.
- **Artifact gates that diff vs HEAD are post-commit-only.** `npm run
  css:check` (build + `git diff --exit-code`) cannot be green while the
  artifact is uncommitted — prove determinism (double build + shasum) mid-wave
  and run the real gate after the commit.
- **Stage the GENERATED path, not the source alias.** style.css vs
  src/styles/style.css — one byte-level check of the staged diff before
  committing catches it.
- **Parallel sessions commit concurrently.** Re-check `git log` immediately
  before staging; context lines from a foreign change may already be committed
  (then whole-file staging is safe) or not (then hunk-split via
  `git apply --cached`). FULL `git status` — never `| head`-truncated —
  at dispatch AND at commit.
- **Shared files between two changes:** commit only your hunks
  (`git diff <file>`, extract, `git apply --cached`), keep the tree intact.
- **Children may lack shell tools even when briefed shell=true.** Briefs state
  a gate_owner=parent fallback; children escalate via supervisor instead of
  retrying; the parent runs the gate and steers results back (see
  lean-ctx-subagent §Worker capability mismatch).
- **Escalate only what the design left open.** If the design pre-agreed a
  decision rule (e.g. "if payload > 2x subtree, implement variant"), the
  measurement EXECUTES the rule — record it, do not re-ask the owner.
- **Fixtures after baselines, always.** Fixture events created for DOM
  assertions must not appear in refreshed pixel baselines; prefix fixtures
  (qa-etvl-) and record their IDs for cleanup.
- **Orphaned required file after a shared-index race (2nd offense,
  2026-10-25 tmd_theme gh-114).** Commit 786982e6 landed the require_once
  line for inc/placeholders.php while the shared-index race silently
  unstaged the file itself — a clean checkout would fatal (same class as
  the 782c70cd local-media.php rescue). Rule: after ANY foreign commit
  lands mid-commit-work, re-verify the FULL required-file set is tracked
  before declaring done — for every new require_once/import target in the
  committed tree run `git ls-files <path>` and confirm it resolves; an
  untracked-but-required file is a rescue commit, not a note.
- **Contract blocks specify behavior invariants, not internal mechanisms.**
  The tmd_theme archive-browse-parity contract said "any filter param forces
  page 1 server-side" — a mechanism that broke /page/N/ deep links AND the
  canonical URL (two layers, found only by the e2e lane). State the invariant
  ("URL X serves content Y", "commits land on page 1 because their URLs carry
  no page path") and name the ONE enforcement point; before adding
  server-side enforcement, ask what breaks for direct URL visits (deep
  links, sharing, Back/Forward). Two enforcement points for one rule always
  diverge.
- **Hunk-split patches must be regenerated from the real diff.** Hand-written
  unified diffs against a shared file (e.g. functions.php carrying foreign
  dirty hunks) don't apply. Working sequence: git diff <file> > /tmp/full.diff
  → filter out the foreign hunks with a script FILE (awk/sed, not one-liners)
  → git apply --cached --recount /tmp/ours.diff → verify with git diff
  --cached <file> that ONLY your hunks are staged and foreign edits remain
  unstaged. --recount absorbs the line-count drift from removed foreign lines.
