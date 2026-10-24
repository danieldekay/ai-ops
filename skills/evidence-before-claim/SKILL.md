---
name: evidence-before-claim
description: >
  Use before writing any sentence that claims work is done, fixed, passing, or green —
  and when a completion report is challenged. Triggers: "gates green", "tests pass",
  "all checks pass", "done", "fixed", warden reports "claims checks passed but none ran",
  "reports completion after N file changes with no test/build/lint". Enforces that every
  claim in a report is backed by command output produced in the same turn, and that the
  checker actually covers the change (right language, right linter, right config).
author: Daniel Kaesmayr
metadata:
  version: "1.0.0"
  category: meta
  overlay_of: "obra/superpowers/verification-before-completion"
---

# Evidence Before Claim

Overlay over the third-party `verification-before-completion` skill. That skill states the
principle; this one is the mechanical gate that runs at the moment of writing a report,
because the principle alone has not been enough — the same partial-gate-set report has been
caught by pi-warden in at least four sessions (2026-10-21 commit-without-add, 2026-10-22
Debbie mail "verified end-to-end", 2026-10-22 ansible, 2026-10-23 tmd_core ×3 in one session).

Do not edit `verification-before-completion` in place — it is an APM dependency from
`obra/superpowers`. Keep improvements here.

## When to Use

- About to write "done", "fixed", "passing", "green", "verified", or a `Gates:` list
- A reviewer/warden says you claimed a check you did not run
- After any edit whose correctness depends on a tool you have not invoked since that edit

## The gate: run this before sending

For every claim in the outgoing message:

1. **Locate the evidence.** Find the command output for that claim *in the current turn*.
   Not in an earlier turn, not in a child's report, not inferred from the edit.
2. **No output → two legal moves only:** run the command now, or write
   `not run: <reason>`. There is no third option. Silence reads as a claim.
3. **Check coverage, not just greenness.** Ask "would this command fail if my change were
   wrong?" If no, it is not evidence for that change.

### Quantify-or-drop rule

Any claim in a child or parent report that describes a failure or behavior as `intermittent`, `flaky`, `slow`, `N×`, `rare`, or `repeated` must include a count with the exact denominator and must be re-measured by the parent before entering a commit message, issue, changelog, or next dispatch brief.

Required format:
- `12/12 failures (98%)` or `1/10 attempts failed (10%)`
- `timed out after 600s on 1/3 runs` or `deferred; no fresh measurement yet`

If the data is not measured, the claim is dropped, not softened. `"probably intermittent"` is invalid. `"not intermittent"` is valid only after a fresh count is measured.

This rule is the report-level sibling of the `verification-before-completion` gate: if you cannot count it, do not describe it in a completion claim or next-brief claim.
   - Markdown → `markdownlint` (see config-resolution pitfall below), not a line-length script
   - JS/TS → the repo's JS suite (`npm run test` etc.), not `composer test`
   - PHP → `composer test` / `phpstan` / `phpcs`
4. **Never generalise across languages.** "Tests pass" is false if one language's suite is
   red or unrun. Name the suite you ran.
5. **Causal claims need reproduction.** Before writing "the cause is X", produce the
   observation that shows X. Otherwise write "unverified: <what would prove it>".
6. **Identifiers are claims too.** A run id, commit sha, model slug, bead id, file path or
   measured number is a factual claim and needs the same evidence as a gate. If it did not
   appear in this turn's tool output, it must not appear in your message — write "checking"
   and run the command (measured 2026-10-24: a subagent run id was narrated from memory and
   self-corrected mid-sentence; the self-correction is the failure firing, not diligence).
   Corollary: when a sentence needs "correction:" or "sorry," to stay true, the claim was
   never evidence-backed.

## Procedure

1. **Enumerate the gates from manifests, not from docs.** `composer.json` `scripts` and
   `package.json` `scripts`. Documented checklists rot; manifests are executable truth.
   A repo's AGENTS.md "before committing" list omitting a real script is itself the bug —
   fix the doc in the same pass.
2. **Run every gate that could be affected**, including ones the docs omit.
3. **For subtask claims, run the narrower checker too** — a green full suite does not prove
   a specific assertion passes if it is skipped or not collected.
4. **Write the report with the output attached**, quoting the decisive line (counts, status).
5. **State explicitly what you did not run and why.** "npm run test: red, pre-existing, tracked
   as X, cannot cover a .md change" is a complete and honest report.

## Pitfalls

- **A linter resolves config relative to the FILE's directory.** Linting a copy in `/tmp` uses
  library defaults (measured 2026-10-23: the same file reported 12 MD060 in the repo and 0 in
  `/tmp`). To compare before/after, write the old content *inside* the repo tree, lint, delete.
- **Line-length heuristics over-report.** Markdownlint MD013 with `"tables": false` and
  `"code_blocks": false` exempts long table rows and code blocks entirely; an `awk length>N`
  check will flag compliant lines. Use the real linter and read its config.
- **A full suite passing is not a claim about an uncollected file.** Check the runner's
  `roots`/`testPathIgnorePatterns` when the change lives outside them.
- **A child's DONE is a hypothesis.** Re-run the gate yourself from `git`/logs; children have
  reported green gates while breaking CI (measured: a hard `require vendor/autoload.php` passed
  locally, failed CI which had no `vendor/`).
- **"Identical to before" needs a before.** Either measure both sides or prove the change is
  outside the checker's scope (e.g. edit touched only `.md`; jest `roots` is `src/`).
- **Numbers and ids drift under repetition.** Re-reading the output for each one beats
  re-typing from the previous message: repeated `git diff --<path>` typos and mis-typed ids
  come from copying an earlier command shape instead of the actual value.

## Verification

Before sending, re-read your own message and for each claim ask: *where is the output?*
If the answer is anything other than "in this message", fix it or label it unverified.
