---
name: token-efficiency
description: Audits, scores, and rewrites AI configuration files to maximize token efficiency with zero behavior loss. Use when asked to optimize, compress, or reduce tokens in copilot-instructions.md, AGENTS.md, .github/instructions/*.md, .github/copilot-instructions.md, .github/agents/*.agent.md, skills/*/SKILL.md, or any system prompt / AI instruction file. Runs a 4-phase workflow: inventory → waste detection → rewrite → measure. Triggers on: "reduce tokens", "optimize instructions", "compress prompt", "too verbose", "token budget", "shrink system prompt", "refactor copilot config", "clean up instructions".
---

# Token Efficiency Optimizer

Audits, scores, and rewrites AI configuration files to eliminate waste and maximize information density per token — without changing behavior or intent.

## When to Use This Skill

- File exceeds budget limits (see table below)
- Prose paragraphs enumerate items that should be bullets or tables
- Multiple files contain overlapping rules
- User says: "optimize", "compress", "reduce tokens", "too verbose", "shrink", "refactor"
- Pre-task context cost reduction before a large agentic session

## Prerequisites

- Read access to the files in scope
- Optional: `tiktoken` (`pip install tiktoken`) for exact GPT-4o/o3 counts
- Optional: `ttok` CLI (`pip install ttok`) for quick shell counting
- No tools? Use estimate: tokens ≈ words × 0.75

## Phase 1 — Inventory & Clarify

1. If no files are specified, **ask the user** which scope to audit:
   - Current repo only
   - Specific file(s)
   - Global `~/.github/` personal skills
   - Full prompt-ops setup
2. Scan for all AI config files in scope:
   - `.github/copilot-instructions.md`
   - `.github/instructions/*.instructions.md` (with `applyTo` globs)
   - `.github/agents/*.agent.md`
   - `AGENTS.md` (root + subdirectories)
   - `skills/*/SKILL.md` (frontmatter `description` + body)
   - Any user-specified files
3. Count tokens per file; record baseline:

```markdown
| File | Lines | Tokens | Budget | Status |
|------|-------|--------|--------|--------|
| .github/copilot-instructions.md | 142 | 1,840 | 1,500 | OVER |
| .github/instructions/agent-skills.instructions.md | 287 | 3,910 | 1,200 | OVER |
| AGENTS.md | 48 | 610 | 1,000 | OK |
```

4. Ask the user to confirm scope and priorities before proceeding to rewrite.

## Phase 2 — Waste Detection

Score each file (1 point per pattern found):

| # | Pattern | Detection Heuristic |
|---|---------|--------------------|
| 1 | **Redundant preamble** | First 10 lines repeat the filename or state the obvious role |
| 2 | **Prose list** | 3+ consecutive sentences enumerating items without bullets |
| 3 | **Duplicated rule** | Same constraint appears in 2+ files in the same repo |
| 4 | **Over-explained example** | Example block longer than the rule it illustrates |
| 5 | **Filler phrases** | "Please remember", "It is important that", "Always make sure", "You should" |
| 6 | **Nested repetition** | Section header restates parent section |
| 7 | **Loaded frontmatter** | YAML `description` contains prose duplicating the body |
| 8 | **Unused `applyTo`** | Glob matches no files in repo |
| 9 | **Philosophy preamble** | Opening paragraph explains what AI/Copilot is or its role in general |
| 10 | **Changelog in instructions** | Version history or changelog entries inside the file |

**Waste score → action:**
- 0–2: no action needed
- 3–4: schedule rewrite
- 5–6: high priority
- 7+: critical bloat

Report score and list each pattern with line numbers. **Preserve original intent** — flag ambiguous cuts and ask the user before removing them.

## Phase 3 — Rewrite

Apply in order. See full examples in [token-efficiency-patterns.md](./references/token-efficiency-patterns.md).

**Quick wins (automated):**
- Strip filler phrases
- Convert prose enumerations to bullet lists
- Trim YAML `description` to ≤60 words
- Delete redundant preambles

**Structural rewrites:**
- Replace paragraph explanations with one imperative rule + one inline example
- Merge duplicate rules into canonical location; reference from others
- Use `applyTo` scoping to split catch-all files into narrowly focused files

**Progressive loading refactor:**
- Move rarely-needed content (full examples, troubleshooting tables, large references) to `references/` subfolder
- Keep main file ≤150 lines / ≤1,500 tokens; link to references
- Move large workflows (>5 steps) to `references/*.md` per [agent-skills guidelines](../../.github/instructions/agent-skills.instructions.md)

**Iterative polish (from `finalize-agent-prompt` pattern):**
- After rewriting, re-read the file as if you are the AI agent receiving it
- Check: is every rule still unambiguous? Is intent fully preserved?
- Make one final pass for spelling, grammar, and clarity without changing meaning

## Phase 4 — Measure & Report

1. Recount tokens for all rewritten files.
2. Produce diff table:

```markdown
| File | Before | After | Saved | % |
|------|--------|-------|-------|---|
| .github/copilot-instructions.md | 1,840 | 920 | 920 | 50% |
```

3. List any trade-offs: content removed, merged rules, coverage gaps.
4. Commit: `refactor(prompts): reduce token count by XX% — token-efficiency audit`

## Token Budget Reference

| File Type | Soft Limit | Hard Limit | Load Trigger |
|-----------|-----------|------------|-------------|
| `.github/copilot-instructions.md` | 800 | 1,500 | Every Copilot request |
| `.github/instructions/*.md` | 600 | 1,200 | Per `applyTo` glob match |
| `.github/agents/*.agent.md` | 1,200 | 2,500 | When agent is invoked |
| `AGENTS.md` | 500 | 1,000 | Every coding agent session |
| `skills/*/SKILL.md` body | 400 | 800 | On skill activation |
| `skills/*/references/*.md` | 1,000 | 3,000 | On demand only |

## Quick-Win Cheat Sheet

```
BEFORE (31 tokens): "Please remember to always make sure that you validate
                     all user input before passing it to any function."
AFTER  (7 tokens):  "Validate all user input before passing to any function."

BEFORE: 4-sentence prose listing 5 rules          → AFTER: 5-bullet list     → ~60% saved
BEFORE: YAML description = 200-word paragraph     → AFTER: 1 sentence ≤60w   → ~150 tokens saved
BEFORE: 600-line SKILL.md loaded on every turn    → AFTER: 120-line + refs/  → ~83% context saved
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| No token counter available | Words × 0.75 estimate; or [platform.openai.com/tokenizer](https://platform.openai.com/tokenizer) |
| Rewrite changes Copilot behavior | Re-add removed rule as single imperative bullet; prose is never needed |
| `applyTo` scope unclear | Glob is relative to workspace root; test with `glob` in VS Code file search |
| Merged rule conflicts | Keep canonical copy in the most-specific `instructions/` file; delete from general file |
| User unsure which files to include | Default to: copilot-instructions + all instructions/ + AGENTS.md + active skills |

## References

- [Rewrite Patterns & Token Counting Scripts](./references/token-efficiency-patterns.md)
- [Agent Skills Guidelines for This Repo](../../.github/instructions/agent-skills.instructions.md)
- [VS Code Copilot Customization Docs](https://code.visualstudio.com/docs/copilot/copilot-customization)
- [OpenAI Tokenizer](https://platform.openai.com/tokenizer)
- [ttok CLI](https://github.com/simonw/ttok)
- Inspired by: [finalize-agent-prompt](https://github.com/github/awesome-copilot/tree/main/skills/finalize-agent-prompt), [boost-prompt](https://github.com/github/awesome-copilot/tree/main/skills/boost-prompt), [copilot-instructions-blueprint-generator](https://github.com/github/awesome-copilot/tree/main/skills/copilot-instructions-blueprint-generator) from [github/awesome-copilot](https://github.com/github/awesome-copilot)
