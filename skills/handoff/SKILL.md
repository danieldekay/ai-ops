---
name: handoff
description: Use when finishing work that another agent will continue, or when receiving work from another agent. Structures inter-agent communication to minimize copy-paste and token waste. Use at the end of a sprint, review, or build cycle.
source: canonicalized 2026-11-25 from the installed copy (origin marcusglee11/LifeOS/.claude/skills/handoff/, unverified upstream) — now owned and maintained in ai-ops
---

# Agent Handoff

Structure handoffs between agents (Codex, Claude Code, Antigravity) so the receiving agent gets maximum context with minimum tokens.

## Outbound Handoff (You finished work, another agent continues)

### Step 1: Verify Clean State

```bash
pytest runtime/tests -q
git status --porcelain=v1
```

If tests fail or working tree is dirty, fix before handing off.

### Step 2: Generate Handoff Summary

Produce a structured handoff block the user can paste to the next agent:

```
Branch: <branch-name>
Commits: <first-sha>..<last-sha>
Test Results:
- <targeted result>
- <expanded/full result>
What Was Done:
- <1-line summary per commit or logical unit>
What Remains:
- <specific next steps, if any>
- <open questions or decisions needed>
Key Files (optional):
- <file>: <what changed and why>
Gotchas (optional):
- <anything non-obvious: test fixtures, env vars, patterns to follow>
```

The first five sections are mandatory and must stay in this exact order:
1. Branch
2. Commits
3. Test Results
4. What Was Done
5. What Remains

### Rules for Handoff Summaries

- **Reference commits, not code** — the next agent can read the diffs
- **Be specific about what remains** — "finish the feature" is useless; "add token extraction to steward phase matching the pattern at line 412" is useful
- **Flag decisions made** — if you chose approach A over B, say why, so the next agent doesn't re-litigate
- **Flag pre-existing issues** — if you noticed broken tests or tech debt outside your scope, mention it so the next agent doesn't waste time investigating

## Inbound Handoff (You're picking up another agent's work)

### Step 1: Read the Handoff

Parse the structured block for: branch, commits, what was done, what remains.

### Step 2: Orient

```bash
git checkout <branch>
git log --oneline -10
git diff main..<branch> --stat
pytest runtime/tests -q
```

### Step 3: Verify Claims

- Do the commits match the summary?
- Do tests actually pass as claimed?
- Are the "key files" actually the ones that changed?

If claims don't match reality, note discrepancies and proceed with what's actually there.

### Step 4: Continue Work

Pick up from "What remains" in the handoff. Follow existing patterns in the code that was just written.

## Handoff to Codex (Specific)

Codex works from a task prompt, not a conversation. Structure the handoff as a self-contained task:

```
Task: <what to do>
Branch: <branch-name>
Context: <1-2 sentences of why this matters>

Scope:
- <specific file or module to modify>
- <specific file or module to modify>

Acceptance criteria:
- <testable condition>
- <testable condition>

Patterns to follow:
- See <file:line> for the existing pattern
- Match <specific convention> used in <sibling module>

Do NOT:
- <specific anti-pattern to avoid>
- Modify files outside scope
```

## Handoff from Codex (Specific)

Codex returns a build summary. To process it:

1. Read the summary for branch, commits, test results
2. Checkout the branch and verify
3. If the user says "review this build" — invoke the `review-build` skill

## Compact Context Update

After completing or ingesting a handoff, refresh compact context:

```bash
python3 scripts/workflow/active_work.py refresh
python3 scripts/workflow/active_work.py show
```

## Anti-Patterns

- **Wall of prose** — handoffs should be structured, not narrative
- **Copy-pasting full diffs** — reference commits instead
- **Vague next steps** — "finish up" means nothing; be specific
- **Missing branch/commit info** — the receiving agent needs coordinates, not just descriptions
- **Re-explaining the codebase** — the receiving agent has CLAUDE.md and can explore
- **Conditional timing** — never write "begin only after X merges/completes." The receiving agent blocks until X is done, burning context or failing silently. Instead: provide a direct file path or commit SHA that works NOW. If the resource truly isn't available yet, say "read from `<absolute_path>` in the worktree — available immediately" or defer the handoff until it is.
