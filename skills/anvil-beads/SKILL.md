---
name: anvil-beads
description: Use when implementing or reviewing Medium/Large code changes in a Beads-enabled repository where completion must be backed by durable baseline, verification, regression, and adversarial-review evidence.
---

# Anvil on Beads

Use Beads as the durable verification graph for evidence-first coding.

**Core principle:** completion is a state that must be proven from executed checks and durable Beads records, not asserted from agent memory.

**REQUIRED SUB-SKILL:** Use `beads` for Beads CLI conventions and durable task handling.

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

## Evidence Rule

A verification result is valid only when:

1. the actual tool/command ran,
2. its real result was observed,
3. a durable evidence bead was created afterward.

Never create passing evidence in advance. Never overwrite failed attempts; create a new attempt.

If `anvil-check` is available, use it for command-based checks so execution and evidence recording are mechanically coupled. Otherwise run the command first, then record the observed result.

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
8. Close the evidence gate only when its predicate is satisfied from Beads state.
9. Commit only after the gate closes; link the commit to the root bead.
10. Close the root bead last.

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
