---
name: test-witness-discipline
description: >
  Our overlay on top of the third-party `test-driven-development` and
  `verification-before-completion` skills. Carries Daniel's hardened TDD
  conventions that would otherwise live as in-place edits to installed
  third-party copies. Use when writing a failing test, asserting an error
  code/reason, deciding whether to mock a mutating endpoint, declaring a
  deferred verification, or patching a behavior that the third-party TDD
  skill does not pin down. Triggers: "RED hygiene", "first failing test
  assertion", "mock fidelity", "mock-fidelity-limited", "real WP route",
  "deferred verification", "wait cap", "bounded wait".
author: Daniel Kaesmayr
metadata:
  version: "1.1.0"
  category: meta
  overlay_of:
    - "obra/superpowers/test-driven-development"
    - "obra/superpowers/verification-before-completion"
---

# Test Witness Discipline

## Why this overlay exists

`test-driven-development` and `verification-before-completion` are third-party
APM-pack skills installed at `~/.agents/skills/` from the repo's manifest.
We do **not** edit installed third-party copies — reinstall/update overwrites
in-place edits, and authored-IP hygiene says a dependency is not ours to patch.
Instead, our conventions live here in ai-ops and this skill overlays both
third-party skills: it does not repeat their whole content, it adds the
hardened rules that are Daniel's.

Read the two third-party skills for the base method; apply this overlay on top.

## 1. RED hygiene (assert the specific failure, keep it permanently)

The first failing test must assert the **actual error code, status code,
reason, or exception text** that the bug is supposed to emit. A vague
assertion is not a RED check.

- Required: `expect(error.code).toBe('E_INVALID_API_KEY')`,
  `expect(response.status).toBe(404)`,
  `expect(response.body.error).toContain('invalid token')`.
- Do not write `expect(res.status).toBe(500)` when the bug's real signature is
  `404` or `E_INVALID_API_KEY`; do not accept a "got X, expected Y" output when
  the intended reason is absent from the assertion.
- If the failure is not specific enough to assert, the test is not a valid RED
  check — rewrite it before writing any implementation.
- **Keep the specific assertion in the regression test permanently.** Never
  weaken it later to a generic pass/fail statement to make the suite pass.

## 2. Mock fidelity (real-route / real-WP contract for mutating endpoints)

- Prefer **real-route or integration coverage for mutating endpoints and
  state-changing flows**. A mock is allowed only when the real dependency is
  external, unavailable, or genuinely impossible to run in the harness.
- Every mock must disclose the WP semantics it does **not** model, e.g.:
  - `WP_REST_Response::set_status` is not modeled
  - `save_post` hooks are not fired
  - real WP sanitization / capability checks are not exercised
  - session or cron side effects are missing
- If the mock omits a real WP contract, label the test
  `mock-fidelity-limited` and add a real integration test for the mutating
  path **before the feature can ship**.
- Mock at the right level: learn every side effect of the real method before
  replacing it; mock the slow or external operation and keep what the test
  depends on real. When unsure, run the test against the real dependency.
- **Stub shapes come from the provider's source, never from the consumer's
  code.** Before stubbing any RPC/event payload, read the emitting function's
  `return { ... }` in the provider's source and copy the shape verbatim. A
  stub derived from the consumer's accessor chain validates the consumer's
  *assumption* — if that assumption is wrong, implementation and test share
  the same wrong shape and the suite stays green against a broken contract
  (validated live 2026-10-24: pi-subagents `cost` reply — `total` **is** the
  usage object; a `.usage`-nested stub passed 5/5 while the widget rendered
  nothing).

## 3. Bounded wait / deferred verification

Never block the session on a single CI or deploy watch command:

1. Hard wait cap: `<= 120s` for a blocking poll unless a supervisor explicitly
   approves a longer limit.
2. If the run does not resolve within the cap, record run id, time, and
   partial evidence, and declare `deferred_verification`.
3. Leave an open loop with the next action and exact owner; do not idle in a
   watch loop.
4. End the session or continue only on a new decision path — never wait
   indefinitely for CI.

A deferred verification is a first-class outcome, not a failure; report:
`status: deferred_verification`, `why: <wait cap reached / external dependency
/ no shell access / blocked by runtime>`, `next_step: <exact check or rerun>`.

## Verification

- Every failing test asserted a specific error code/reason (not a generic
  pass/fail), and that assertion is still present verbatim in the committed
  regression test.
- Every mutating-endpoint test either runs a real route/integration path or
  is labeled `mock-fidelity-limited` with the uncovered WP semantics listed
  and a real integration test scheduled before ship.
- No completion claim waits on a watch loop; anything unresolved is reported
  as `deferred_verification` with owner + next step.