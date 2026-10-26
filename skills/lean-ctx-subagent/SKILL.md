---
name: lean-ctx-subagent
description: >
  Dispatch subagents with an evidence-based lean-ctx session start: parent-curated
  brief in the prompt + CLI-only child discipline. Use when delegating tasks to
  subagents in a lean-ctx-enabled session — replaces raw dispatch with context
  that targets what the child actually needs. Triggers: "dispatch subagent",
  "delegate to agent", "spawn agent", "parallel agents", "subagent context",
  "session start for subagent".
author: Daniel Kaesmayr
metadata:
  version: "2.0.0"
  category: dev
  evidence: measured on tangoatlas 2026-09-27 (lean-ctx 3.10.4)
---

# LeanCTX Subagent Dispatch (v2 — measured)

Subagents in the Pi harness get **no `ctx_*` MCP tools** and **no `lean_ctx` tool** —
CLI only. The harness (`subagent` tool, `runs.run`/`runs.all`) owns orchestration;
lean-ctx owns context + state. Coordination tools (`ctx_agent`, `ctx_task`,
`ctx_workflow`, `ctx_share`, `ctx_handoff`) are hidden local-compat substrate —
do not build dispatch on them.

## Measured ground truth (2026-09-27, do not re-litigate without new evidence)

| Claim | Result |
|---|---|
| Child gets global constitution | ✅ via AGENTS.md injection |
| Child gets MCP ctx_* tools | ❌ never; CLI only |
| `lean-ctx session task` in child | ⚠️ works BUT overwrites the parent's shared session.task |
| CLI `lean-ctx overview` | ❌ dumb file tree (~15–18K tok), no task filter, no briefing, no pack merge |
| MCP `ctx_overview(task)` (parent) | ✅ task-filtered, ~1.5K tok, facts+hotspots+briefing |
| `lean-ctx knowledge recall` in child | ⚠️ works, but store is diary noise; curated facts live in the wiki |
| ctx_pack auto-load → overview merge | ❌ zero effect observed (CLI or MCP) |
| CLI pack/install commands | ❌ do not exist; ctxpkg is MCP-only (`ctx_pack`) |
| CLI `handoff`/`share`/`agent` commands | ❌ do not exist |
| Brief-fed child vs bare-bootstrap child | ✅ same correct answer, fewer discovery steps, self-corrects a wrong brief with one targeted grep |

## The dispatch recipe

### 1. Parent: curate the brief (before spawning)

Before any dispatch, the parent must provide a concrete brief that is read from disk and contains:

- `allowed_files`: the exact file set the child may read or edit. No broader exploratory write set is implied.
- `write_policy`: `no_new_files`, `edit_only`, or `allowed_new_files:<list>`; default is `no_new_files`.
- `tool_capability`: `shell: true|false`, `git: true|false`, `network: true|false`, and which tools the child actually has.
- `gate_command`: the exact verification command that proves the task and whether the parent or child runs it.
- `metric`: for any count or "how many" question, the artifact that produces the evidence (file glob, workflow, command) — never a bare number.
- `metric_excludes`: what that count does not cover. A count without an exclusion list is not evidence.
- `owner`: who is responsible for each gate or side-effect step.

Parent preflight REQUIRED:

1. Read the brief targets from disk before the child starts.
2. Run `git status --porcelain` once before dispatch.
3. Compare every intended path against `allowed_files`. If a path is outside the list, reject the brief; do not delegate.
4. If `shell: false`, the brief must explicitly name the parent as the only runner for shell/gate commands.
5. If `shell: true`, the brief must say which commands the child may run, and the child must not invent additional shell actions.

The child must confirm the effective capabilities in its first reply: `allowed_files=...`, `shell=<true|false>`, `gate_owner=<parent|child>`, `write_policy=<...>`, and `git_status_checked=<true|false>`.

> **3.11 update (measured 2026-10-21, lean-ctx 3.11.4):** first-class agent
> identities now exist on the CLI: `lean-ctx agent register --id <id> --role
> coder --owner daniel@kaesmayr.net` → `agent suspend|decommission <id>`.
> The old ground truth "CLI agent commands do not exist" expired with 3.11.
> The AGENTS.md child carve-out was updated accordingly (2026-10-21): children
> register at session start and decommission at exit — unregistered children
> show as "unknown" in the AGENTS panel. The MCP coordination tools
> (`ctx_agent`/`ctx_task`) remain hidden substrate and stay off-limits for
> dispatch.

Run `ctx_overview(task)` and/or `ctx_compose(task)` yourself — you have the MCP
tools and they are 10× cheaper than the child's CLI equivalents. Extract:

- a fresh agent id for the child: `pi-<agent-name>-<6char>` (e.g. `pi-worker-shell-a1b2c3`)

- 2–4 vetted file paths (verify they exist and are the RIGHT ones — a wrong brief
  costs the child one targeted grep, not a fail)
- one targeted search hint (exact symbol/regex, scoped path)
- the quality-gate or verification command, if the task mutates code

### 1a. Metric contract — a count must name its evidence artifact (measured 2026-10-24)

A brief that asks "how many X have Y" without naming the artifact that proves it produces correct-but-useless answers.

- Every count metric names the artifact (for example "eval-file contracts under `tests/Integration/` executed by
  `.github/workflows/v4-wordpress-integration.yml`"), the claim it proves, and `metric_excludes` — what the count
  does not cover.
- If you cannot name the artifact, do not ask for a count. Ask for a **list** with files named. A list cannot be
  over-generalised; a percentage can.
- Pre-dispatch question: "If the child answers this literally, could the answer be correct and useless?" If yes,
  rewrite the brief before spawning.
- The child's first reply line must restate scope: `Measured: <artifact>. Excludes: <what>.`

Worked example (real, 2026-10-24): a brief asked how many of 66 mutating routes had "a test that executes the success
path". The child measured PHPUnit files under `tests/API` and answered "6–10 of 66". Arithmetically correct, and
practically wrong: the repository's witness layer is `tests/Integration/*.php` eval-file contracts run through
`wp eval-file`, which contribute nothing to a PHPUnit count. The corrected metric — production write routes lacking a
real-WordPress contract — was **4**. Same repo, same day, opposite conclusion.

### 2. Child prompt template

```
Task: <one-paragraph task>

Pre-vetted file list from the parent (start here, do not explore widely):
- <path1>
- <path2>
If none fit, search narrowly (grep <exact symbol> in <scoped path>) before widening.

CLI discipline (you have no MCP ctx_* tools):
- cd to the project root first — CLI writes bind to the daemon session root, not cwd
- Do NOT run `lean-ctx session task` — the parent owns session.task
- Reads: lean-ctx read <file> [-m map|signatures|lines:N-M]; full only for edit prep
- Shell: lean-ctx -c "<cmd>"; exact output: lean-ctx raw "<cmd>"
- Search: lean-ctx grep <pattern> <path>
- Report findings for parallel siblings: lean-ctx knowledge remember "<finding>" (short-term only)
- Durable conclusions: report them back in your output — the parent files them in the wiki
Verify your own work — run the gate tool before reporting DONE.

Identity (3.11+): register your agent id as your first step and decommission at exit:
lean-ctx agent register --id <agent-id-from-parent> --role coder --owner daniel@kaesmayr.net
lean-ctx agent decommission <agent-id>   # on completion; `agent suspend <id> --reason` on early exit
```

Each run gets a fresh id; never reuse ids across runs. If `agent register`
does not exist in the installed lean-ctx (< 3.11), skip silently.

### 3. Parent: verify

Subagent claims are not evidence. Re-run the gate tool yourself (`ruff`,
`basedpyright`, `pytest --co`), check `git diff` for scope creep and over-deletion,
and grep for references to any moved/deleted symbol.

Two hardened rules (2026-10-22, repeat warden corrections):

- **Relayed causal claims need own reproduction.** A child's root-cause/diagnosis
  statement ("pre-existing bug", "env gap", "load-order issue") is a claim, not a
  finding. Reproduce it with your own command, quote your own output, and mark
  anything you did not check as unverified with the reason. Detect the refined
  version of the claim too — e.g. "pre-existing" is only provable back to the
  last change you actually inspected, not to the bug's true onset.
- **Brief claims must be read from disk before dispatch.** Do not characterize
  changes/flags (e.g. "declares skip_specs", file paths, task counts) from list
  output or impressions; read the change dirs/files and verify every factual
  statement in the brief. Wrong brief facts cost a supervisor round-trip or a
  blocked child.
- **Probe/leak claims need raw output in the artifact, and a parent re-probe
  when load-bearing (2026-10-25, tmd_theme gh-124/gh-141).** A lane verdict
  resting on an observed surface (REST response, probe, render output) must
  paste the raw command + output into its artifact — a paraphrase like "probe
  shows X is present" is not evidence and can be wrong (one lane recorded a
  refuted REST excerpt leak as fact). When sibling lanes' verdicts conflict on
  a shared surface, the parent runs its own probe BEFORE accepting either; a
  paraphrased claim contradicted by another lane is adjudicated by fresh raw
  output only.

## Memory routing

- **Long-term/durable → LLM wiki**: parent files child findings via `wiki_observe`
  / `wiki_retro`. Never `ctx_knowledge`.
- **Short-term, session/feature-scoped, parallel-agent exchange → `ctx_knowledge`**:
  children may `lean-ctx knowledge remember` intermediate findings for siblings and
  the parent to recall. Treat as ephemeral — it decays and gets polluted.
- **Session state → `ctx_session`/`lean-ctx session`**: parent-owned. Children only
  append `finding`/`decision` values if instructed, never `task`.

## Context packages (ctx_pack) — current status

`ctx_pack` (MCP-only) creates versioned `.ctxpkg` packages from the live knowledge
store. Measured caveats: silently embeds the full knowledge graph even when the
graph layer is not requested (summary said "Graph nodes: 0", file had 26,874
nodes); auto-load has no observable effect on `overview`; no CLI install path for
children. **Do not use as the subagent session-start mechanism** until the export
is scoped and a real consumption path exists. If a portable handoff is needed,
write a markdown brief file and pass its path in the child prompt.

## Anti-patterns (all measured)

### Shell-boundary discipline

- One command per tool call. Do not bundle multiple commands into a single shell line.
- Never use inline interpreters to do one-off logic: no `node -e`, `python3 -c`, `perl -0pi`, or similar one-liners as a substitute for a proper script or tool call.
- No speculative chained commands (`&&`, `||`, or shell globbing) unless the brief explicitly authorizes the exact sequence and the result is required for the task.
- After a `BLOCKED` result or repeated failure on the same command pattern, stop retrying variants of the same failed approach. Change the method, narrow the probe, or use a structured tool.
- Prefer a structured tool (read/search/edit/runner) over ad-hoc shell pipelines when the tool can answer the question directly.
- If the task requires shell access, the brief must say so up front and the child must name its effective `shell: true|false` state before editing.
- Never put backticks or `$(...)` inside a shell `-m` / `-c` argument: the shell substitutes them before the tool sees the text. A `git commit -m "...`metric`..."` silently dropped the word (measured 2026-10-24). Write the message/body to a file and pass the file (`git commit -F /tmp/msg`).

- ❌ Mandating `lean-ctx overview` in a scoped child task — 15K tok of tree, zero task signal
- ❌ Child runs `lean-ctx session task` — clobbers the parent's triage signal
- ❌ Telling a child to call `ctx_share`/`ctx_compile`/`ctx_agent` — tools don't exist there
- ❌ Building dispatch on ctx_agent/ctx_task/ctx_workflow — hidden Research substrate, disabled
- ❌ Recording durable facts with `lean-ctx knowledge remember` — store is noise-polluted; use wiki
- ❌ Running `lean-ctx knowledge consolidate` (or `--all`) after cleaning the knowledge store — it re-imports the session diary as new facts and re-creates the junk (measured: 0 facts → 7 immediately). If a clean is needed, remove items and skip consolidate; never consolidate as a "tidy-up" step.
- ❌ Trusting "DONE" without re-running the gate tool yourself
- ❌ Telling a child to switch to the NATIVE `edit` tool after it read files with `ctx_read`
  (measured 2026-10-23, tmd_core lane): native `edit` requires a prior NATIVE `read` of that
  exact path, so a lean-ctx-first child deadlocks in a retry loop on "RETRYABLE — Edit without
  read". Reads through `ctx_read`/`lean-ctx read` do NOT satisfy it. Brief children to edit with
  `ctx_edit` (no read requirement, `replace_all: true` for repeated patterns), or to call the
  native `read` immediately before a native `edit`. Same applies to `ctx_patch` anchored ops,
  which want anchors from `ctx_read(mode="anchored")`.
- ❌ Dispatching without the `task` field present in the call (validated 2026-10-21,
  7 occurrences in one session): async single-child calls arrive with an EMPTY
  task ("Task:" signature, taskHash sha256("")) when the field is omitted or
  the call shape is fumbled (e.g. `agent` passed where `workflow: true` was
  intended). The child correctly refuses to improvise and blocks. Recovery:
  deliver the real brief via `subagent_supervisor` reply to the child's
  supervisor ask — that channel worked every time. Prevention: include `task`
  in EVERY dispatch, and verify the child's fork first-message is the real
  brief before waiting (probe-first below is mandatory, not advisory).

## Fallback

No lean-ctx CLI available in the child → same recipe minus the CLI lines: brief in
prompt, native tools, verify gates yourself. The brief is the mechanism; lean-ctx
CLI in the child is a compression aid, not the handoff channel.

## Parallel-lane implementation (measured 2026-10-06, kg-parallel-ingest)

For multi-lane implementation in one checkout, partition by FILE OWNERSHIP and
run disjoint lanes in parallel — no worktrees needed:

1. Parent pre-reads the codebase and puts exact anchors in each brief:
   file paths + line numbers of every function the lane touches, the CLI
   surface, vocabulary sets, and any format maps (e.g. bucket→heading maps).
   A child with anchors skips exploration entirely.
2. One lane per file set; lanes never touch another lane's files. Doc lanes
   document the TARGET surface from design.md, not current code.
3. Dependent lanes sequence inside one workflow script: `const [a, c] =
   await Promise.all([runs.run(A), runs.run(C)])`, then lane B only if A's
   output lacks ABORT. B preconditions on grepping for A's landed symbols.
4. Every lane commits PATHSPEC-scoped to its own files only
   (`git add <own> && git commit -- <own>`) — this is what kept a concurrent
   foreign session's bd-init commit from clobbering lane work mid-run.
5. Parent NEVER trusts DONE: re-run every gate itself, `git log --oneline`
   for attribution, and `git status` for scope creep. Corpus-count
   discrepancies between lanes (731 vs 952 nodes) were a concurrent
   session's promotion, not a bug — check `git log` before diagnosing.
6. Merge/registration tests run only on /tmp copies of the repo (.git
   included); the real shared data files are never touched by test runs.

## Dispatch failure protocol (validated 2026-10-04, round-9 FB session)

- PROBE-FIRST IS MANDATORY: before fanning out, verify each child's fork session first-user-text is the real task (6-char "Task: " = the empty-task sticky emission). With sticky emission active, the only reliable delivery channel is the supervisor reply: let the child block on its supervisor request, answer with "read <brief-path> and execute it exactly".
- **Self-inflicted empty-task variant (added 2026-10-21):** empty briefs are usually the DISPATCHER's own omission (task field missing, `agent` passed instead of `workflow: true`) — fix the call, don't blame the harness. Verified recovery: reply to the blocked child's supervisor ask with the full brief; steer only works for running (non-blocked) children.
- Check the known-failure skill (subagent-workflowscript-triage) at the FIRST subagent rejection — identical repeated rejections are a documented signature, not a transient error.
- lean-ctx has no line-numbered read: `lean-ctx raw` is a shell wrapper (a file path executes as a command) and `lean-ctx read` emits no line numbers. Reviewer lanes citing file:line evidence use the native read tool for evidence (lean-ctx read for orientation, `lean-ctx raw "sed -n 'X,Yp'"` for exact windows).
## Worker capability mismatch (validated 2026-10-24, tmd_theme ETVL/ECI session)

- Some worker profiles resolve WITHOUT a shell tool even when the brief says
  `shell: true` — three of six children that session could read/write/escalate
  but never run `npm`, `git`, or `lean-ctx`. The child stalls at the gate and
  escalates via supervisor (good behavior — the brief told it to).
- Prevention, in the brief template: (1) state `gate_owner: parent` fallback
  explicitly — "if your allowlist lacks shell, finish all edits, then escalate
  the gate via contact_supervisor instead of retrying"; (2) name the exact
  allowed commands AND the escalation path; (3) do not assume the `coder`
  agent profile has shell — probe once (first child reply must confirm
  capabilities) and adapt routing, not the child.
- Parent-side gate ownership: after a shell-less child lands edits, the PARENT
  runs the gate commands and steers the result back to the child for its final
  report. Budget one extra round-trip per shell-less lane.

