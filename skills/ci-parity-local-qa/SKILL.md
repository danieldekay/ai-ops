---
name: "ci-parity-local-qa"
description: "Before pushing to a repo with a CI deploy gate, run the exact commands CI runs in a local minimal-dependency environment. Use when deploying a repo with a GitHub Actions or similar gate, when CI keeps failing after pushes that looked fine locally, or when \"npm run build passed but CI is red\"."
version: 1
created: "2026-10-04"
updated: "2026-10-04"
---
## When to Use
Any repo where a deploy/publish CI workflow would block a push. Trigger when: (1) preparing a push to a repo with a CI gate, (2) a CI failure appeared that local builds did not reproduce, (3) pushing a blog post or scheduled content that must deploy cleanly. Skip for repos without a CI gate, or for pure documentation pushes where CI runs no meaningful checks.

## Procedure
1. Read the CI workflow file (.github/workflows/*) and enumerate exactly what commands the gate runs (typescript check, tests, build, lints) and in what dependency context.
2. Create a local gate script (e.g. scripts/qa-gate.sh + npm run qa) that mirrors the CI steps in order and exits non-zero on any failure.
3. CRITICAL: replicate the CI dependency environment, not the dev environment. If CI installs only a subset (e.g. pandas+pytest), build a separate minimal venv (e.g. .qa-venv, gitignored) with exactly those deps — the project venv usually has heavy packages installed that mask module-level import failures in test collection.
4. Auto-bootstrap the minimal venv on first gate run so the gate is self-sufficient on fresh clones.
5. Run the gate before EVERY push to the gated repo. Treat npm run build alone as insufficient if CI runs anything else.
6. If the gate fails, fix locally and iterate until green, then push — a green local gate should deploy green on the first CI run.
7. After any CI environment or workflow change, re-sync the local gate script with the workflow.

## Pitfalls
- The project .venv having heavier deps than CI is the classic trap: local pytest passes, CI test collection dies on ModuleNotFoundError. Always collect tests in a CI-parity minimal venv.
- Do not skip the type-check step because the build passes — CI treats them as separate gates.
- Export-dependent tests fail on CI runners where raw data is absent; mirror the repo's skipif pattern (e.g. needs_export) instead of letting them red-light every deploy.
- A broken CI gate can silently block ALL pushes for hours while local builds stay green — check the most recent CI runs before assuming a red run is about your change.

## Verification
1. npm run qa (or the repo's gate command) exits 0 with all steps green.
2. A push following a green local gate completes the CI run as success on the first attempt.
3. The minimal venv is gitignored and auto-bootstrapped on fresh clones.