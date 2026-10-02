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

Run `ctx_overview(task)` and/or `ctx_compose(task)` yourself — you have the MCP
tools and they are 10× cheaper than the child's CLI equivalents. Extract:

- 2–4 vetted file paths (verify they exist and are the RIGHT ones — a wrong brief
  costs the child one targeted grep, not a fail)
- one targeted search hint (exact symbol/regex, scoped path)
- the quality-gate or verification command, if the task mutates code

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
```

### 3. Parent: verify

Subagent claims are not evidence. Re-run the gate tool yourself (`ruff`,
`basedpyright`, `pytest --co`), check `git diff` for scope creep and over-deletion,
and grep for references to any moved/deleted symbol.

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

- ❌ Mandating `lean-ctx overview` in a scoped child task — 15K tok of tree, zero task signal
- ❌ Child runs `lean-ctx session task` — clobbers the parent's triage signal
- ❌ Telling a child to call `ctx_share`/`ctx_compile`/`ctx_agent` — tools don't exist there
- ❌ Building dispatch on ctx_agent/ctx_task/ctx_workflow — hidden Research substrate, disabled
- ❌ Recording durable facts with `lean-ctx knowledge remember` — store is noise-polluted; use wiki
- ❌ Running `lean-ctx knowledge consolidate` (or `--all`) after cleaning the knowledge store — it re-imports the session diary as new facts and re-creates the junk (measured: 0 facts → 7 immediately). If a clean is needed, remove items and skip consolidate; never consolidate as a "tidy-up" step.
- ❌ Trusting "DONE" without re-running the gate tool yourself

## Fallback

No lean-ctx CLI available in the child → same recipe minus the CLI lines: brief in
prompt, native tools, verify gates yourself. The brief is the mechanism; lean-ctx
CLI in the child is a compression aid, not the handoff channel.
