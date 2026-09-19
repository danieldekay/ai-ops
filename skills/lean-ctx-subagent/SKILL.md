---
name: lean-ctx-subagent
description: >
  Dispatch subagents using lean-ctx multi-agent coordination tools (ctx_agent, ctx_share,
  ctx_compile, ctx_handoff, ctx_task). Use when delegating tasks to subagents in a
  lean-ctx-enabled session — replaces raw runSubagent with context-efficient dispatch
  that shares cached file contexts, persists session state, and enables agent handoff.
  Triggers: "dispatch subagent", "delegate to agent", "spawn agent", "multi-agent",
  "parallel agents", "agent handoff", "subagent with context", "ctx_agent", "ctx_share".
author: Daniel Kaesmayr
metadata:
  version: "1.0.0"
  category: dev
---

# LeanCTX Subagent Dispatch

Dispatch subagents with lean-ctx multi-agent coordination. Replaces raw `runSubagent` with context sharing, session persistence, and structured handoff.

**Why:** Raw subagents inherit zero context. lean-ctx lets you push cached file contexts, register agents in a shared diary, and hand off tasks with minimal token overhead.

## When to Use

| Scenario | Use |
|----------|-----|
| Delegate implementation task to subagent | ✅ This skill |
| Parallel independent tasks | ✅ Dispatch multiple agents |
| Task needs project context files | ✅ `ctx_share` pushes cached reads |
| Long-running multi-step work | ✅ `ctx_session` persists across turns |
| Switching between agent roles | ✅ `ctx_agent action=handoff` |
| No lean-ctx MCP tools available | ❌ Use `subagent-driven-development` instead |

## Pre-Flight: Check lean-ctx Availability

```dot
"lean-ctx MCP tools available?" -> "Use this skill" [label="yes"]
                          -> "Use subagent-driven-development" [label="no"]
```

If `ctx_agent`, `ctx_share`, `ctx_compile` are not callable, fall back to `superpowers:subagent-driven-development`.

## The Dispatch Workflow

### 1. Register the Agent (once per session)

```text
ctx_agent action=register
  name="implementer"
  role="Implementation agent for Task N"
  task="What this agent is working on"
```

Registers the agent in the shared multi-agent registry. Other agents can see active agents via `ctx_agent action=list`.

### 2. Build Context Package

```text
ctx_compile
  task="Task description for subagent"
  paths=["src/foo.py", "src/bar.py"]
  budget=4000
```

Knapsack+Boltzmann minimal context package. Selects the most relevant files and compresses them into a token-budgeted package. Returns a `.ctxpkg` handle.

**Alternative:** If you've already read files via `ctx_read`, use `ctx_share` to push cached contexts directly:

```text
ctx_share action=push
  agent="implementer"
  paths=["src/foo.py", "src/bar.py"]
```

Pushes cached file contexts to the target agent. The subagent receives them via `ctx_share action=pull` — zero re-read cost.

### 3. Dispatch the Subagent

Use `runSubagent` with a prompt that includes lean-ctx bootstrap instructions:

```
Subagent (general-purpose):
  description: "Implement Task N: [name]"
  prompt: |
    You are a lean-ctx subagent. Bootstrap before starting work.

    ## Bootstrap (run in order)
    1. ctx_agent action=register name="<your-role>" task="<task>"
    2. ctx_share action=pull — receive shared context from parent
    3. ctx_session action=load — restore session state
    4. ctx_knowledge action=wakeup — surface prior findings

    ## Task
    [Full task description]

    ## Context Package
    .ctxpkg handle: [handle from ctx_compile]
    OR shared files: [list of paths pushed via ctx_share]

    ## Rules
    - Use ctx_read (not Read), ctx_shell (not Bash), ctx_search (not Grep)
    - Record findings: ctx_session action=finding value="..."
    - Record decisions: ctx_session action=decision value="..."
    - On completion: ctx_session action=save
    - On handoff: ctx_agent action=handoff target="<next-agent>" summary="..."
    - **Verify your own work** — run the quality gate tool before reporting DONE
    - **Check for collateral damage** — search for other imports of moved/deleted symbols
    - **Never claim success without running the tool** — "I think it passes" is not evidence
```

### 4. Monitor & Coordinate

```text
ctx_agent action=list           # See active agents + their tasks
ctx_agent action=diary agent="implementer"  # Read agent's diary entries
ctx_session action=status       # Check session state
```

### 5. Handoff / Completion

When the subagent finishes:

```text
ctx_agent action=handoff
  from="implementer"
  to="reviewer"
  summary="Task N complete. Changes in src/foo.py. Tests pass."
```

Or for the final agent:

```text
ctx_session action=decision value="Task N complete. Next: Task N+1."
ctx_knowledge action=remember content="Non-obvious finding from this task"
ctx_gain                          # Check savings
```

## Context Sharing Patterns

### Pattern A: Pre-read + Push (recommended)

Parent reads files via `ctx_read` (cached), then pushes to subagent:

```
Parent:  ctx_read path="src/foo.py" mode=full     # cached
         ctx_share action=push agent="impl" paths=["src/foo.py"]

Subagent: ctx_share action=pull                    # receives cached context, ~13 tok
```

### Pattern B: Compile Package

Parent builds a minimal context package:

```
Parent:  ctx_compile task="Fix auth bug" paths=["src/auth.py", "src/middleware.py"] budget=3000

Subagent: [include .ctxpkg handle in prompt]
          ctx_read path="src/auth.py" mode=full    # loads from package
```

### Pattern C: Knowledge Transfer

Cross-agent knowledge without re-reading:

```
Agent 1:  ctx_knowledge action=remember content="Auth uses RS256, key at secrets/jwt.pub"

Agent 2:  ctx_knowledge action=recall query="auth JWT"   # surfaces Agent 1's finding
```

## Session Persistence Across Turns

Subagents operate in their own session. To persist state across multiple turns of coordination:

```text
# At end of each turn:
ctx_session action=save

# At start of next turn:
ctx_session action=load
ctx_session action=status   # See what was happening
```

## Parallel Dispatch

For independent tasks, dispatch multiple agents in one turn:

```
Turn 1:
  runSubagent(prompt="... Agent A ...") +
  runSubagent(prompt="... Agent B ...")

Turn 2:
  ctx_agent action=diary agent="A"
  ctx_agent action=diary agent="B"
  [coordinate based on diary entries]
```

## Token Savings

| Operation | Raw runSubagent | lean-ctx dispatch |
|-----------|-----------------|-------------------|
| Share 5 files | Re-read in subagent (~5K tok) | `ctx_share` push/pull (~65 tok) |
| Session state | Re-explain (~2K tok) | `ctx_session load` (~400 tok) |
| Cross-agent knowledge | Re-discover or re-read | `ctx_knowledge recall` (~200 tok) |
| Handoff | Full summary prose | `ctx_agent handoff` (~150 tok) |

## Trust-but-Verify: Mandatory Validation

**Subagent claims are NOT evidence.** Always verify their work before marking tasks complete.

### After Each Subagent Completes

1. **Run the quality gates yourself** — don't trust the subagent's claim of "0 errors" or "all pass"
2. **Check the actual files changed** — `git diff HEAD` to see what was modified
3. **Verify the specific tool the subagent claimed to fix** — if they said "ruff passes", run `uv run ruff check` yourself
4. **Look for collateral damage** — subagents may fix their task but break adjacent code

### Common Subagent Failure Modes

| Failure | Symptom | Prevention |
|---------|---------|------------|
| False "DONE" | Tool still reports errors after subagent claims success | Always re-run the tool |
| Partial fix | Some violations fixed, others remain | Check full tool output, not just subagent summary |
| Over-deletion | Removes code that was actually used | Check git diff for removed imports/functions |
| Stale imports | Fixes one import but misses others | Search for all references to moved/deleted symbols |
| Scope creep | Changes files outside task scope | Review git diff stat |

### Validation Checklist

```
□ Run the tool the subagent claimed to fix (ruff, basedpyright, etc.)
□ Check git diff for unexpected changes
□ Verify no new import errors introduced
□ Confirm subagent didn't delete used code
□ Check adjacent files for breakage
□ Run test collection on changed test files (--co flag)
□ Check git log for recent commits that may have caused breakage
```

### When Validation Finds Issues

**If the subagent's work is incomplete** (e.g., ruff still reports errors):
- Fix inline if trivial (e.g., `ruff check --fix`)
- Dispatch a fix subagent with the specific remaining issues
- Re-validate after fix

**If the subagent's work is wrong** (e.g., deleted used code):
- Revert the change: `git checkout <file>`
- Re-dispatch with corrected prompt
- Flag the failure mode for future reference

**If pre-existing breakage is exposed** (e.g., test collection fails on unrelated import):
- Check `git log --oneline -S "symbol" -- path/` to find when the symbol was removed
- Determine if the breakage is from the subagent or from prior commits
- If prior commits: escalate to human with evidence (commit hash + diff)
- If subagent: fix and re-validate

## Anti-Patterns

- ❌ Dispatching subagent without `ctx_share` or `ctx_compile` — subagent re-reads everything
- ❌ Subagent uses native Read/Bash/Grep — loses compression savings
- ❌ No `ctx_session save` — state lost on context compaction
- ❌ No `ctx_agent register` — invisible to other agents
- ❌ Parent doesn't check `ctx_agent diary` — misses subagent findings
- ❌ Trusting subagent "DONE" without running quality gates
- ❌ Parallel dispatch without sequential validation
- ❌ Ignoring git diff output after subagent completes

## Fallback

If lean-ctx MCP tools are unavailable, invoke `superpowers:subagent-driven-development` instead.

### Fallback: subagent-driven-development

When lean-ctx is not available:

1. **Create a todo list** — one item per fix
2. **Dispatch implementer subagents** — one per task (parallel if independent)
3. **Validate immediately after each subagent** — run quality gates before dispatching the next
4. **Fix issues found during validation** — dispatch fix subagents or fix inline
5. **Run final whole-branch review** — after all tasks complete

**Critical difference from lean-ctx path:** No shared context or session persistence. Each subagent starts fresh. Validation is even more important since subagents can't see each other's work.

### Pre-Dispatch Checklist (Fallback)

```
□ Task is scoped to specific files/symbols
□ Quality gate command is known (e.g., `uv run ruff check`)
□ Validation command is known (e.g., `uv run pytest --co`)
□ Subagent prompt includes exact tool commands to verify success
□ Subagent prompt warns against over-deletion and scope creep
```