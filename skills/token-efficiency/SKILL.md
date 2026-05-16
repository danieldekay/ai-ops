---
name: token-efficiency
description: Audits and rewrites AI configuration files to maximize token efficiency. Use when asked to optimize, compress, or reduce tokens in copilot-instructions.md, AGENTS.md, .github/instructions/*.md, .github/copilot-instructions.md, system prompts, or any AI instruction/skill file. Eliminates redundancy, converts prose to structured syntax, applies progressive-loading patterns, and measures before/after token counts. Triggers on: "reduce tokens", "optimize instructions", "compress prompt", "too verbose", "token budget", "shrink system prompt", "refactor copilot config".
---

# Token Efficiency Optimizer

Audits, scores, and rewrites AI configuration files (copilot-instructions, AGENTS.md, `.github/instructions`, skill files, system prompts) to remove waste and maximize information density per token.

## When to Use This Skill

- User says: "optimize", "compress", "reduce tokens", "too verbose", "shrink", "refactor" any AI config file
- A `.github/copilot-instructions.md` or `AGENTS.md` file exceeds 300 lines
- An instruction file has noticeable prose paragraphs that could be bullet lists or tables
- You are reviewing a set of skills/instructions before a large agentic task to reduce context cost
- User wants to measure token usage across their prompt-ops setup

## Prerequisites

- Access to the files to be optimized (read permission on target repo or local workspace)
- Optional: `tiktoken` Python library for precise GPT-4o / o3 token counting
- Optional: [ttok](https://github.com/simonw/ttok) CLI for quick shell-based counting

## Step-by-Step Workflow

### Phase 1 — Inventory & Measure

1. List all AI config files in scope:
   - `.github/copilot-instructions.md`
   - `.github/instructions/*.instructions.md`
   - `.github/agents/*.agent.md`
   - `AGENTS.md` (root and subdirectories)
   - `skills/*/SKILL.md`
   - Any additional files the user specifies
2. Count tokens per file using the method available (see [Token Counting Methods](./references/token-efficiency-patterns.md#token-counting-methods)).
3. Record baseline in a markdown table:

```markdown
| File | Lines | Tokens | Priority |
|------|-------|--------|----------|
| .github/copilot-instructions.md | 142 | 1,840 | HIGH |
| .github/instructions/agent-skills.instructions.md | 287 | 3,910 | HIGH |
```

4. Flag files with **Waste Score ≥ 3** (see scoring below) as HIGH priority.

### Phase 2 — Waste Detection

Score each file for these waste patterns (1 point each):

| # | Pattern | Detection Heuristic |
|---|---------|--------------------|
| 1 | **Redundant preamble** | First 10 lines repeat the filename or restate the obvious role | 
| 2 | **Prose-instead-of-list** | 3+ consecutive sentences that enumerate items without bullets | 
| 3 | **Duplicated context** | Same constraint/rule appears in 2+ files in the same repo | 
| 4 | **Over-explained examples** | Example blocks longer than the rule they illustrate | 
| 5 | **Filler phrases** | "Please remember to", "It is important that", "Always make sure", "You should" | 
| 6 | **Nested repetition** | A section header restates the parent section | 
| 7 | **Loaded frontmatter** | YAML frontmatter contains prose descriptions that duplicate the body | 
| 8 | **Unused applyTo** | `applyTo` glob matches no files in the repo | 

Report total waste score and list each detected pattern with line numbers.

### Phase 3 — Rewrite

Apply rewrites in priority order. See [Rewrite Patterns](./references/token-efficiency-patterns.md#rewrite-patterns) for full examples.

**Quick wins (apply first):**
- Strip filler phrases (automated find/replace)
- Convert prose lists to bullet syntax
- Merge duplicate rules across files into one canonical location, reference from others

**Structural rewrites:**
- Replace paragraph explanations with a single imperative rule + one example
- Move large reference tables to `references/` subfolder; link from SKILL.md
- Use `applyTo` scoping to split a large catch-all instruction file into focused, narrowly-scoped files that only load when relevant

**Progressive loading refactor:**
- Extract rarely-needed content (e.g., full examples, troubleshooting tables) into `references/` files
- Keep the main instruction file to under 150 lines / ~1,500 tokens
- Link to reference files with relative paths

### Phase 4 — Measure & Report

1. Recount tokens for all rewritten files.
2. Produce a diff summary table:

```markdown
| File | Before | After | Saved | % |
|------|--------|-------|-------|---|
| .github/copilot-instructions.md | 1,840 | 920 | 920 | 50% |
```

3. List any trade-offs: content removed, coverage gaps, or rules merged.
4. Commit changes with message: `refactor(prompts): reduce token count by XX% — token-efficiency audit`

## Token Budget Guidelines

Recommended upper limits for each file type (GPT-4o tokens):

| File Type | Soft Limit | Hard Limit | Notes |
|-----------|-----------|------------|-------|
| `.github/copilot-instructions.md` | 800 | 1,500 | Loaded on every Copilot request |
| `.github/instructions/*.md` | 600 | 1,200 | Loaded per matching file |
| `.github/agents/*.agent.md` | 1,200 | 2,500 | Full agent system prompt |
| `AGENTS.md` | 500 | 1,000 | Loaded by coding agents globally |
| `skills/*/SKILL.md` (body only) | 400 | 800 | Body loads only on skill activation |
| `skills/*/references/*.md` | 1,000 | 3,000 | Loaded on demand only |

## Quick-Win Rewrites Cheat Sheet

```
BEFORE: "Please remember to always make sure that you validate input data 
         before processing it, as this is important for security."
AFTER:  "Validate all input before processing."
Saved: ~18 tokens (75% reduction)

BEFORE: Multi-line prose paragraph listing 5 rules
AFTER:  5-bullet list, each ≤10 words
Saved: ~40% on average

BEFORE: YAML description field contains 200-word explanation
AFTER:  YAML description = 1 sentence (≤60 words); details in body
Saved: ~150 tokens
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Token count tool not available | Count words × 0.75 as rough estimate; use online tokenizer at platform.openai.com/tokenizer |
| Rewrite breaks Copilot behavior | Re-add the removed rule as a single imperative bullet; prose is not needed |
| `applyTo` scope unclear | Check VS Code Copilot docs: glob patterns relative to workspace root |
| Merged rule produces conflicts | Use a canonical `rules/` folder and `#include`-style references where supported |

## References

- [Token Efficiency Patterns Reference](./references/token-efficiency-patterns.md) — full rewrite examples, anti-patterns library, token counting scripts
- [Agent Skills File Guidelines](../../.github/instructions/agent-skills.instructions.md) — canonical skill structure rules for this repo
- [VS Code Custom Instructions Docs](https://code.visualstudio.com/docs/copilot/copilot-customization)
- [OpenAI Tokenizer](https://platform.openai.com/tokenizer)
