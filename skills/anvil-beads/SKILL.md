---
name: anvil-beads
description: Use when implementing or reviewing Medium/Large code changes in a Beads-enabled repository where completion must be backed by durable baseline, verification, regression, and adversarial-review evidence.
---

# Anvil on Beads

Use Beads as the durable verification graph for evidence-first coding.

**Core principle:** completion is a state that must be proven from executed checks and durable Beads records, not asserted from agent memory.

**REQUIRED SUB-SKILL:** Use `beads` for Beads CLI conventions and durable task handling.

## Bundled Tools

This skill ships two dependency-free Python helpers:

- `scripts/anvil-check` — executes a shell command, captures the real exit code/output hash, creates and closes an immutable evidence bead, then returns the tested command's exit code.
- `scripts/anvil-bundle` — reads Beads JSON, validates the completion predicate, renders the Evidence Bundle, and can close the evidence gate.

When this skill is installed elsewhere, resolve these paths relative to this `SKILL.md`. In this repository they are:

```bash
python3 skills/anvil-beads/scripts/anvil-check --help
python3 skills/anvil-beads/scripts/anvil-bundle --help
```

For command-based verification, use `anvil-check` whenever available. Do not replace it with a manual `bd create` sequence unless the helper itself is unavailable.

## When to Use

Use for:

- bug fixes and feature work where regressions matter,
- multi-file refactors,
- risky changes such as auth, migrations, concurrency, deletion, public APIs,
- work delegated across fresh-context subagents,
- tasks that may survive compaction, session reset, or agent handoff.

Do not require the full protocol for documentation-only microchanges or trivial one-line edits unless the touched area is high risk.

## Contract

For Medium/Large work, maintain one root bead and a small graph:

```text
root
├─ baseline
├─ implementation
├─ verification
├─ adversarial review(s)
├─ readiness (Large only)
└─ evidence gate
```

Use dependencies so the final evidence gate cannot become complete before required work.

Tag workflow beads so tooling can discover them:

```text
anvil_schema = anvil-beads/v1
anvil_kind   = workflow
anvil_root   = <root id>
anvil_stage  = baseline | implementation | verification | review | readiness
```

Tag the final gate with:

```text
anvil_schema = anvil-beads/v1
anvil_kind   = gate
anvil_root   = <root id>
anvil_stage  = evidence-gate
```

## Evidence Rule

A verification result is valid only when:

1. the actual tool/command ran,
2. its real result was observed,
3. a durable evidence bead was created afterward.

Never create passing evidence in advance. Never overwrite failed attempts; create a new attempt.

For shell/CLI checks, use the bundled recorder:

```bash
python3 skills/anvil-beads/scripts/anvil-check \
  --root <root-id> \
  --phase baseline \
  --name pytest \
  -- pytest -q
```

Repeat with `--phase after` after implementation. The helper auto-increments attempts and preserves failed attempts.

If command arguments/output may contain secrets, use `--command-label` and one or more `--redact-regex` flags. Never store secrets in Beads.

For non-shell evidence such as IDE diagnostics or reviewer verdicts, record the observed result manually with the same metadata schema and close the evidence bead when finalized. Reviewer check names must be unique (for example `review-codex`, `review-gemini`, `review-claude`).

If the bundled helper is genuinely unavailable, run the command first and only then record the observed result.

Record at least:

```text
anvil_schema = anvil-beads/v1
anvil_kind   = evidence
anvil_root   = <root id>
anvil_phase  = baseline | after | review | readiness
anvil_check  = <stable name>
anvil_attempt= <n>
anvil_command= <command/tool>
anvil_exit_code = <code|n/a>
anvil_passed = true|false
```

Never query Beads' underlying Dolt/SQL database directly. Use `bd`.

## Required Gates

| Size | After-state evidence | Adversarial review | Readiness |
|---|---:|---:|---|
| Medium | ≥2 independent signals | 1 fresh reviewer | — |
| Large / high-risk | ≥3 independent signals | 3 fresh reviewers | observability, degradation, secrets/config |

Baseline capture is mandatory before implementation. A broken baseline may be recorded and tolerated; a new regression may not.

Reviewer verdicts do not count as test/build/runtime signals.

## Workflow

1. Run `bd prime`; inspect existing task context before creating a new root.
2. Capture baseline diagnostics/tests/build where applicable.
3. Implement minimally; create durable discovered-work beads when new required work appears.
4. Run diagnostics, parse/build/type/lint/tests and runtime smoke checks as applicable.
5. Record every meaningful attempt after execution.
6. Stage the diff and dispatch fresh-context reviewer(s). Do not give reviewers the implementer's private reasoning.
7. Turn material reviewer findings into durable fix work and re-run verification after fixes.
8. Run the deterministic bundle validator:
   ```bash
   python3 skills/anvil-beads/scripts/anvil-bundle --root <root-id> --close-gate
   ```
9. Treat a non-zero bundle exit as a blocked task. Do not manually close the gate to bypass it.
10. Commit only after the gate closes; link the commit to the root bead.
11. Close the root bead last.

## Handoff

A fresh agent should be able to recover with:

```bash
bd prime
bd show <root-id> --json
bd ready --json
git status --short
git log -1 --oneline
```

Do not rely on conversation history to explain remaining work.

## Common Mistakes

- **Beads as transcript:** record meaningful work/evidence, not every shell command.
- **One mutable test bead:** preserve each attempt; failures are part of the audit trail.
- **Review replaces tests:** it does not.
- **Baseline must pass:** wrong; baseline must be captured.
- **Changed pre-existing failure means no regression:** not mechanically provable. If baseline and after both fail but their output hashes differ, the bundle stays blocked until stronger evidence resolves the ambiguity.
- **Agent closes gate manually:** gate closure follows evidence, not confidence.
- **High confidence with open gate:** prohibited.
- **Markdown TODO/ledger beside Beads:** avoid parallel sources of truth.

## Completion Test

Before saying "done", verify:

```text
baseline captured
AND required after-state signals exist
AND latest required checks are acceptable
AND required fresh reviews passed
AND blocking findings are resolved
AND no regression vs baseline
AND evidence gate is closed
```

If any term is false, the task is not complete.
