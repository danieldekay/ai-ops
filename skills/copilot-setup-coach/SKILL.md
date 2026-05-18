---
name: copilot-setup-coach
description: >
  Progressive VS Code + GitHub Copilot setup coach. Interviews the user and/or
  scans their workspace to determine their current maturity level, then guides
  them through one small, high-value improvement at a time. Covers the full
  stack: Copilot license, extensions, global and scoped instructions, prompts,
  custom agents, skills, MCP servers, and governance workflows.
  Maintains session continuity via Zettelkasten notes between conversations.
  Use when starting a new setup, stuck on what to configure next, onboarding
  a colleague, or doing a periodic health check.
  Triggers: "help me set up Copilot", "what should I configure next",
  "copilot setup", "onboard me to Copilot", "improve my AI setup",
  "set up GitHub Copilot", "what MCP should I install", "show me what to do next",
  "copilot health check", "audit my Copilot setup", "next improvement".
author: Daniel Kaesmayr
metadata:
  version: "1.0.1"
  category: onboarding
---

# Copilot Setup Coach

Progressive, interview-driven coaching for VS Code + GitHub Copilot configuration.
Advances one layer at a time so the learning curve stays manageable.

---

## Philosophy

> Don't configure everything at once. Each layer builds on the last.
> One improvement per session compounds faster than a big-bang setup that gets abandoned.

The skill uses a **Maturity Model** with 8 layers. You only need to think about
the *next* layer — everything above it can wait.

```
L0  Not started ──────────────────────────────── baseline
L1  Foundation      (license + extensions)
L2  Global rules    (copilot-instructions.md)
L3  Scoped rules    (*.instructions.md)
L4  Prompts & Agents (.prompt.md, .agent.md)
L5  Skills           (npx skills add)
L6  MCPs             (mcp.json)
L7  Full stack       (governance + team rollout)  ── expert
```

---

## Entry Points

There are two ways to start. The agent should choose based on what's available:

| Entry point | When to use |
|---|---|
| **Interview mode** | First session, blank workspace, user not sure where they are |
| **Scan mode** | Existing workspace, user wants an audit, user says "check what I have" |

In practice, **run the scan first** and use interview questions only to fill gaps.

---

## Phase 0 — Scan Workspace

Before asking questions, collect evidence from the workspace.

### Files to check

```bash
# Global Copilot config
ls -la .github/copilot-instructions.md 2>/dev/null
ls -la .github/instructions/ 2>/dev/null
ls -la .github/prompts/ 2>/dev/null
ls -la .github/agents/ 2>/dev/null

# Skills (both standard install locations)
ls -la .agents/skills/ 2>/dev/null
ls -la .github/skills/ 2>/dev/null

# MCP servers
cat .vscode/mcp.json 2>/dev/null || cat ~/dotfiles/vscode/mcp.json 2>/dev/null

# VS Code extensions (Copilot family)
code --list-extensions 2>/dev/null | grep -i copilot
```

### Maturity scoring from scan

| Evidence found | Score contribution |
|---|---|
| `GitHub.copilot` **or** `GitHub.copilot-chat` extension installed | +L1 |
| `.github/copilot-instructions.md` exists and is non-empty | +L2 |
| At least one `.instructions.md` file | +L3 |
| At least one `.prompt.md` or `.agent.md` | +L4 |
| `.agents/skills/` or `.github/skills/` contains ≥1 skill | +L5 |
| `mcp.json` with ≥1 server configured | +L6 |
| `.github/workflows/` with a Copilot governance check | +L7 |

Record the highest layer fully satisfied — that is the **current level**.

---

## Phase 1 — Interview (Fill Gaps)

Ask only what the scan couldn't determine. Use `#askQuestions` (one round, max 5 questions).
Map answers to maturity layer and priority signals.

### Question set

**Q1 — Role & goals** *(always ask if not obvious from workspace)*
> "What's your primary role? (developer / researcher / data scientist / manager / other)
> And what's the #1 thing you want AI to help you with day-to-day?"

*Maps to*: which layers matter most, which skills to recommend.

**Q2 — Copilot license** *(ask only if extension not found)*
> "Do you have a GitHub Copilot Individual, Business, or Enterprise license?
> (Or are you still evaluating?)"

*Maps to*: L1 gate — nothing else matters until this is confirmed.

**Q3 — Current frustrations** *(always ask — highest signal)*
> "What's the most annoying or repetitive thing Copilot currently does wrong,
> or a task you wish it could handle but can't?"

*Maps to*: identify the single highest-value next improvement.

**Q4 — Team context** *(ask if workspace has team indicators: multiple contributors, CI, etc.)*
> "Are you setting this up just for yourself, or for a team / department?
> Do colleagues use the same workspace repo?"

*Maps to*: whether to prioritize shared `.github/` config vs personal dotfiles,
and whether governance workflows are relevant.

**Q5 — Time available** *(ask if session focus unclear)*
> "How much time do you have right now — quick win (10 min), focused session (1 hr),
> or full setup (2+ hrs)?"

*Maps to*: how many layers to tackle in this session.

---

## Phase 2 — Produce Assessment

Summarize findings in this format — keep it brief (max 10 lines):

```
Current level: L3 (Scoped Rules)
──────────────────────────────────────────
✅ L1  Foundation           GitHub Copilot extension installed and active
✅ L2  Global rules         copilot-instructions.md exists (247 words)
✅ L3  Scoped rules         3 .instructions.md files found
⬜ L4  Prompts & Agents     No .prompt.md or .agent.md found           ← NEXT
⬜ L5  Skills               No skills installed
⬜ L6  MCPs                 No mcp.json found
⬜ L7  Full stack           No governance workflows

Top frustration: "Copilot doesn't know our commit style"
Recommended next improvement: Add conventional-commit.instructions.md (15 min)
```

Then ask:
> "Does this look right? Ready to tackle the next improvement, or do you want to
> fix something at a different level first?"

---

## Phase 3 — Execute Next Layer

Work through the next layer using the playbook below. **Do not skip ahead.**

---

### L1 — Foundation

**Goal**: Copilot extension active and signed in.

**Detect**: `code --list-extensions | grep -E "GitHub\.copilot|GitHub\.copilot-chat"`

L1 is satisfied by **either** extension:
- `GitHub.copilot` — inline completions (classic)
- `GitHub.copilot-chat` — chat interface (also bundles completions in recent versions)

**Actions**:
1. Install at least one: `ext install GitHub.copilot` or `ext install GitHub.copilot-chat`
2. Sign in via VS Code account menu (GitHub SSO)
3. Verify: open any file → Copilot status bar should show ✓

**Check L1 complete**: Completions appear in any open file.

---

### L2 — Global Instructions

**Goal**: A single `.github/copilot-instructions.md` that sets the baseline for
all Copilot interactions in this workspace.

**Detect**: `cat .github/copilot-instructions.md`

**What to put in it** (start minimal, grow over time):
- Project description (1-2 sentences)
- Tech stack and language versions
- 2-3 non-negotiable coding standards
- Links to key documentation or skills

**Starter template**:

```markdown
# [Project Name] — Copilot Instructions

## Project
[Brief description of what this repo does and who it's for]

## Tech Stack
- Language: [e.g. Python 3.11, TypeScript 5]
- Framework: [e.g. FastAPI, Next.js 14]
- Testing: [e.g. pytest, vitest]
- Package manager: [e.g. uv, pnpm]

## Standards
- [Standard 1, e.g. "Follow conventional commits (feat/fix/docs/...)"]
- [Standard 2, e.g. "All functions need type annotations"]
- [Standard 3, e.g. "No print statements — use the logger"]
```

**Interview prompt** if user is unsure what to write:
> "Tell me in 1-2 sentences what this repo does and what tech it uses.
> I'll generate a starter `copilot-instructions.md` for you."

**Check L2 complete**: File exists, non-empty, references the real project.

---

### L3 — Scoped Instructions

**Goal**: Path-scoped `.instructions.md` files that give Copilot focused rules
for specific file types, folders, or tasks.

**Detect**: `ls .github/instructions/*.instructions.md`

**When to add a scoped instruction**:
- A specific language or file type has its own style rules
- A folder (e.g. `tests/`) needs different conventions
- A recurring task (e.g. writing commit messages, reviewing PRs) has a fixed protocol

**High-value starters by role**:

| Role | First scoped instruction to add |
|---|---|
| Developer | `python.instructions.md` or `typescript.instructions.md` |
| Researcher | `research-documentation.instructions.md` |
| Data scientist | `notebook.instructions.md` or `r.instructions.md` |
| All roles | `conventional-commit.instructions.md` |

**Frontmatter format**:

```markdown
---
applyTo: "**/*.py"
description: "Python coding conventions"
---

# Python Style

- Use type hints on all function signatures
- Docstrings follow Google format
- Imports: stdlib → third-party → local (blank line between groups)
```

**Reference**: The `copilot-control-plane-architecture` skill covers
conflict resolution and advanced scoping patterns.

```bash
npx skills add danieldekay/copilot-config-promptops --skill copilot-control-plane-architecture
```

**Check L3 complete**: At least one `.instructions.md` covers your primary language.

---

### L4 — Prompts & Agents

**Goal**: Reusable task playbooks (`.prompt.md`) and role-scoped agents (`.agent.md`)
for recurring workflows.

**Detect**: `ls .github/prompts/ .github/agents/`

**When to add a prompt**:
- A task has a fixed protocol you run more than twice a week
- The task requires collecting context from multiple files before acting
- You want the workflow available to teammates without documentation

**When to add an agent**:
- A role needs restricted tool access (read-only, no file writes, etc.)
- You want a persona that always behaves a certain way (e.g. security reviewer)

**High-value first prompts**:

```
.github/prompts/
├── create-pr-description.prompt.md   ← write PR descriptions from diff
├── review-code.prompt.md             ← security + quality checklist
├── daily-standup.prompt.md           ← summarise recent commits for standup
└── research-note.prompt.md           ← capture research into Zettelkasten
```

**Minimal `.prompt.md` template**:

```markdown
---
mode: agent
description: "Write a PR description from the current diff"
---

Review the current staged diff and write a GitHub PR description with:
- A single-line summary (conventional commit format)
- ## What changed (bullet list of logical changes)
- ## Why (motivation, linked issue if known)
- ## How to test (commands or steps to verify)
```

**Check L4 complete**: At least one prompt file that you've actually invoked.

---

### L5 — Skills

**Goal**: Install the skills most relevant to your role.

**Detect**: `ls .agents/skills/ .github/skills/`

**Priority skills by role**:

| Role | Must-have skills |
|---|---|
| Developer | `copilot-control-plane-architecture`, `drawio` |
| Researcher | `deep-web-research`, `zettelkasten-mcp`, `thinking-frameworks` |
| Data scientist | `scientific-visualization`, `thinking-frameworks` |
| Manager | `thinking-frameworks` |
| All | `copilot-control-plane-architecture` |

**Install command**:

```bash
# Role-specific (replace <skill-name>)
npx skills add danieldekay/copilot-config-promptops --skill <skill-name>
```

**After installing**, verify the skill is visible to Copilot:
- Check that `.agents/skills/<skill-name>/SKILL.md` exists
- In VS Code Chat, ask: "@workspace what skills do I have installed?"

**Reference**:
```bash
# See all available skills in the repo
npx skills add danieldekay/copilot-config-promptops --list
```

**Check L5 complete**: At least one role-specific skill installed.

---

### L6 — MCP Servers

**Goal**: Connect Copilot to external tools and data sources via MCP servers.

**Detect**: `cat .vscode/mcp.json` or `cat ~/dotfiles/vscode/mcp.json`

**What is MCP?** Model Context Protocol servers extend Copilot with real-time tools —
web search, knowledge bases, GitHub, calendars, and more.

**High-value MCPs**:

| MCP Server | What it enables | Install |
|---|---|---|
| `zettelkasten-mcp` | Read/write personal knowledge base | See `zettelkasten-mcp` skill |
| `github` | Create issues, PRs, search code | Built-in with Copilot Enterprise |
| `tavily` | Web search in chat | API key from tavily.com |
| `semanticscholar` | Academic paper search | No key needed |

**Minimal `mcp.json` template** (`.vscode/mcp.json`):

```json
{
  "servers": {
    "zettelkasten": {
      "type": "stdio",
      "command": "uvx",
      "args": ["--from", "git+https://github.com/entanglr/zettelkasten-mcp.git", "zettelkasten-mcp"],
      "env": {
        "ZETTELKASTEN_NOTES_DIR": "${env:HOME}/projects/notes-workspace/data/notes",
        "ZETTELKASTEN_DATABASE_PATH": "${env:HOME}/projects/notes-workspace/data/db/zettelkasten.db"
      }
    }
  }
}
```

**Check L6 complete**: At least one MCP server listed in `mcp.json` and responding
in a Copilot chat session.

---

### L7 — Full Stack (Governance + Team)

**Goal**: CI/CD checks enforce Copilot config quality; team members use a consistent setup.

**When this matters**: Your team has ≥3 people and the `.github/` config is growing.

**Actions**:
1. Add a `copilot-instructions-lint.yml` workflow that fails on missing required sections
2. Add the `copilot-control-plane-architecture` skill to audit the config quarterly
3. Document the team's install process in `AGENTS.md`
4. Pin skills to a version tag so all team members use identical skill versions:
   ```bash
   npx skills add danieldekay/copilot-config-promptops --skill <skill-name>
   ```

**Reference**: `copilot-control-plane-architecture` skill covers governance workflows
in detail.

---

## Phase 4 — Save Progress

After each session, capture the current state so future sessions can resume
without re-interviewing. Use **whichever storage method is available** — prefer
Zettelkasten, fall back to a local file.

### Detect which method to use

```bash
# Check if zettelkasten MCP is reachable
zk_list_notes 2>/dev/null && echo "ZK available" || echo "ZK unavailable"
```

| Result | Method |
|---|---|
| ZK available | Use `zk_create_note` / `zk_update_note` (preferred) |
| ZK unavailable | Write to `docs/ai-setup/copilot-setup-state.md` |

---

### Method A — Zettelkasten (preferred)

**Use `zk_create_note` (or `zk_update_note` if the note exists)**:

```markdown
---
type: fleeting
tags: [copilot-setup, workspace-config, <role>]
---

# Copilot Setup State — [workspace name]

**Date:** [today]
**Current level:** L[N] — [layer name]
**Completed layers:** L0–L[N]
**Next improvement:** [description]
**Skipped / deferred:** [anything intentionally skipped with reason]

## Session notes
[What was done, what worked, what needs follow-up]
```

**In future sessions**, search for this note first:
```
zk_search_notes("copilot-setup [workspace-name]")
```
If found, skip interview questions already answered and jump directly to Phase 3.

---

### Method B — Local file fallback

When Zettelkasten is not configured, create or update
`docs/ai-setup/copilot-setup-state.md` in the workspace root.

Create the folder if it doesn't exist:
```bash
mkdir -p docs/ai-setup
```

File format:

```markdown
# Copilot Setup State — [workspace name]

> Auto-generated by copilot-setup-coach. Update after each session.
> When zettelkasten-mcp is available, migrate this file there with zk_create_note.

## Current State

- **Last updated:** [today]
- **Current level:** L[N] — [layer name]
- **Completed layers:** L0–L[N]
- **Next improvement:** [description]
- **Skipped / deferred:** [anything intentionally skipped with reason]

## Session Log

### [date]
[What was done, what worked, what needs follow-up]

### [date]
[...]
```

**In future sessions**, read this file first:
```bash
cat docs/ai-setup/copilot-setup-state.md
```
If found, skip interview questions already answered and jump directly to Phase 3.

> **Tip**: commit `docs/ai-setup/copilot-setup-state.md` to version control.
> It acts as a shared onboarding record for the whole team.

---

## Anti-Patterns to Avoid

| Anti-pattern | Why it hurts | What to do instead |
|---|---|---|
| Setting up all layers at once | Overwhelm → partial completion → abandoned config | Do one layer per session |
| Copying instructions from a colleague verbatim | Stale rules don't match your context | Use their file as a *template*, adapt to your stack |
| Writing 500-line `copilot-instructions.md` | Low signal:noise → Copilot ignores or misapplies | Keep global instructions under 300 words; use scoped files |
| Installing all skills at once | Context window bloat, skills you never use | Install max 3 new skills per session, only when triggered |
| Skipping L2 and going straight to skills/MCPs | No baseline means inconsistent behavior | Always have a `copilot-instructions.md` before adding complexity |
| Never updating skills | Stale skills produce wrong outputs | Run `update-skills` weekly |

---

## Quick-Reference Decision Tree

```
User asks for help with Copilot setup
        │
        ▼
Run workspace scan (Phase 0)
        │
        ├── No Copilot extension → go to L1 playbook
        ├── No copilot-instructions.md → go to L2 playbook
        ├── No .instructions.md files → go to L3 playbook
        ├── No prompts/agents → go to L4 playbook
        ├── No skills → go to L5 playbook
        ├── No MCPs → go to L6 playbook
        └── Has L1–L6 → go to L7 (governance) or "you're well set up!"
```

---

## Related Skills

| Skill | When to use |
|---|---|
| `copilot-control-plane-architecture` | Deep audit, conflict resolution, governance workflows |
| `zettelkasten-mcp` | Set up and use the Zettelkasten MCP server |
| `thinking-frameworks` | When designing what to put in instructions or prompts |

Install any related skill with:
```bash
npx skills add danieldekay/copilot-config-promptops --skill <skill-name>
```

---

## Reporting Issues With This Skill

If any part of this skill fails — a scan command doesn't work, a playbook step is wrong,
a layer description no longer matches VS Code's actual behavior — open an issue on
the repository.

Common drift signals for this skill:
- VS Code extension IDs have changed (`GitHub.copilot` → something else)
- `mcp.json` schema or location has changed
- `npx skills add` CLI syntax has changed
- A new Copilot feature creates a missing layer (e.g. L8)
- Zettelkasten note format or tool names have changed
