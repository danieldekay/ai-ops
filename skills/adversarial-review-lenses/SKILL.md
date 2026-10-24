---
name: adversarial-review-lenses
description: >
  adversarial review, review lenses, hostile review, red team this plan,
  spec conflict, production hostility, security review of this change
---

# Adversarial Review Lenses

## When to Use

Use this skill when a plan, spec, diff, or PR body needs a hostile read before it ships. It is meant for a deliberate bug-hunt pass, not a normal approval review.

Run it when:
- a proposal looks plausible but has hidden drift
- a change touches auth, file paths, scheduling, or production assumptions
- a diff or brief is being reviewed before commit or merge
- you need to `red team this plan` or look for `spec conflict` / `production hostility` / security gaps

## Operating rules

- Artifact-level review only (plans, specs, diffs, PR bodies).
- Run lenses as read-only subagents.
- **max 2 lenses per round**.
- Never the author's own lens.
- Curated relay of claims; each finding needs `file:line` + failure scenario + remedy.
- A round that finds no blocker must say so with the checks it ran.

## Lens 1 — Spec-conflict & archive safety

Purpose: catch hidden drift between repo rules, OpenSpec artifacts, and actual worktree state.

Checklist (12–15 probes):
1. Does the change contradict the repo's AGENTS.md / OpenSpec instructions in either wording or required path ownership?
2. Does the brief request a write outside the allowed-file list or outside the current repo root?
3. Is a new file created in a place that the brief explicitly prohibited?
4. Are there uncommitted or untracked files that are not listed in the task output?
5. Are there archived copies or generated files that should be excluded from the diff?
6. Does the work rewrite a canonical rule or skill without preserving the source-of-truth path?
7. Are there explicit contract files (OpenSpec, docs, changelog) that should have been updated and were skipped?
8. Does the brief ask for a patch that would change a security or auth rule without a corresponding review artifact?
9. Do generated or temp files exist in the repo root after the run (`.tmp_*`, backups, lockfiles, snapshots)?
10. Does the change introduce a new naming convention not present in the repo?
11. Is the task mutating code without verifying the current repo scope and parent files?
12. Is there evidence the change touches both the local project and a parent/shared dependency without coordinating ownership?
13. Does the brief rely on a file path that no longer exists or was moved?
14. Does the change assume a rule file or gate exists that is actually only advisory at runtime? Name the real enforcement surface (CI job, hook, runtime warden).
15. Is the final patch more than the allowed blast radius for the issue under review?

Output format:
`Blocker / Should-fix / Nice-to-have | file:line | failure scenario | remedy`

Stopping rule: stop after 2 blockers or after 15 probes, whichever comes first; do not continue a long speculative run.

## Lens 2 — Production-hostility / ops

Purpose: catch issues that look fine locally but fail under real production or host constraints.

Checklist (12–15 probes):
1. Does the job require shell access but the brief lacks `shell: true` and the child still runs commands?
2. Is there a hidden dependency on WP-Cron, cron, or queue workers that is not invoked or checked?
3. Does the fix assume `nginx` is configured the same as local dev, but the site uses `.htaccess` or another front-end layer?
4. Is the change safe when file permissions, symlinks, or service-account ownership differ across hosts?
5. Are retention policies, log rotation, or temp-file cleanup missing for a mutating export or sync job?
6. Does the fix write to a temp path or mount that is not cleaned up after failure?
7. Are scheduled jobs or asynchronous workers left with no visibility or timeout guard?
8. Does the code assume a single-site install when multisite or subdirectory installs are valid?
9. Does the fix create a path with inadequate permissions or wrong owner for a production service?
10. Is the timeout or polling logic hard-coded without a safe abort path?
11. Does the change rely on live network calls without fallback or retry policy?
12. Are streaming downloads or large file responses limited by memory or timeouts?
13. Does the patch create an import/export race condition or duplicate side effects on retry?
14. Is the service expected to run under a demoted user or a non-root container and the fix assumes root privileges?
15. Does the patch drop an observability or audit trail when a production job fails?

Output format:
`Blocker / Should-fix / Nice-to-have | file:line | failure scenario | remedy`

Stopping rule: stop after 2 blockers or after 15 probes; do not chase speculative production paths without a concrete host fact.

## Lens 3 — Security & authorization

Purpose: catch gaps in authz, trust boundaries, file safety, and secret handling.

Checklist (12–15 probes):
1. Does the change allow an unauthenticated request to mutate state or trigger an action?
2. Are capability checks missing or weakened for custom post types, REST endpoints, or admin screens?
3. Does the patch trust user input without sanitization or escaping?
4. Is a secret or API key printed, logged, or left in a temp file?
5. Does the change bypass a permission gate or use a weakened capability check (`current_user_can`, `is_admin`, etc.)?
6. Are file paths user-controlled without normalization or boundaries?
7. Does the job write to a directory outside the allowed-file list or a restricted project root?
8. Does the patch create a download or export route that leaks data to the wrong audience or bypasses auth checks?
9. Does the code use a weak fallback like `|| true` that suppresses a security or authorization failure?
10. Could the use of cron or job scheduling cause privilege escalation or hidden side effects?
11. Does a bulk action or import path skip dedupe / validation and accept malicious content?
12. Are retention or file cleanup settings missing for sensitive export artifacts?
13. Does the patch rely on a fake or over-broad mock for auth or capability semantics?
14. Is there an unsafe redirect, nonce bypass, or XSS vector introduced by HTML rendering?
15. Are silent retries or duplicate worker jobs capable of repeating a privileged action multiple times?

Output format:
`Blocker / Should-fix / Nice-to-have | file:line | failure scenario | remedy`

Stopping rule: stop after 2 blockers or after 15 probes; if the auth path is unaudited, do not continue to deeper logic review until a blocker is fixed.

## Output format

Return a concise review with each finding in one line:

`Blocker / Should-fix / Nice-to-have | file:line | failure scenario | remedy`

If no blocker is found, say:
`No blocker found: ran Lens 1 and Lens 2; no issue evident in this artifact.`

## Stopping rule

Stop after 2 blockers, after 15 probes, or when a blocker has a concrete fix path and the remedy is explicit. A lens run is not a long speculative pass.
