# Token Efficiency Patterns Reference

Detailed reference for the `token-efficiency` skill. Contains extended examples, anti-pattern library, and counting scripts.

---

## Token Counting Methods

### Python (tiktoken — most accurate for GPT-4o / o3)

```python
import tiktoken, pathlib

enc = tiktoken.get_encoding("cl100k_base")  # GPT-4o, o3, Claude use similar BPE

def count_file(path: str) -> int:
    text = pathlib.Path(path).read_text(encoding="utf-8")
    return len(enc.encode(text))

# Count all instruction files in a repo
import glob
for f in glob.glob(".github/**/*.md", recursive=True) + ["AGENTS.md"] + glob.glob("skills/*/SKILL.md"):
    try:
        n = count_file(f)
        print(f"{n:>6}  {f}")
    except FileNotFoundError:
        pass
```

### Shell (ttok CLI)

```bash
# Install: pip install ttok
cat .github/copilot-instructions.md | ttok

# Batch count all instruction files
find .github/instructions skills -name '*.md' -exec sh -c 'printf "%6d  %s\n" $(cat "$1" | ttok) "$1"' _ {} \;
```

### Quick estimate (no tools)

```
Tokens ≈ word_count × 0.75   (English prose)
Tokens ≈ word_count × 0.65   (code-heavy or structured markdown)
```

---

## Rewrite Patterns

### Pattern 1 — Strip Filler Phrases

Filler phrases consume 5–15 tokens each and carry zero instruction value.

| Remove | Replace with |
|--------|-------------|
| `Please remember to always make sure that you` | *(nothing — the verb that follows is enough)* |
| `It is important that you` | *(nothing)* |
| `You should always` | *(imperative verb)* |
| `When working on this project, please` | *(imperative verb)* |
| `As a helpful assistant, you` | *(imperative verb)* |
| `Note that` | *(nothing, or fold into the rule)* |
| `Keep in mind that` | *(nothing)* |

**Example:**
```
BEFORE (31 tokens):
  "Please remember to always make sure that you validate
   all user input before passing it to any function."

AFTER (7 tokens):
  "Validate all user input before passing to any function."
```

---

### Pattern 2 — Prose List → Bullet List

BEFORE (~60 tokens):
```
When writing code, you should use TypeScript instead of JavaScript.
You should also prefer async/await over callbacks. Furthermore, make
sure that all functions have explicit return types. Additionally,
use named exports instead of default exports.
```

AFTER (~22 tokens):
```markdown
Code style:
- TypeScript over JavaScript
- async/await over callbacks
- Explicit return types on all functions
- Named exports only
```

Saved: ~62%

---

### Pattern 3 — Redundant Preamble Removal

The first section of many instruction files restates what the file is. Copilot already knows the filename.

BEFORE (~45 tokens):
```markdown
# Custom Instructions for This Project

This file contains custom instructions for GitHub Copilot when working
on this project. These instructions define the coding standards, preferred
libraries, and architectural patterns to follow.
```

AFTER (0 tokens — delete entirely):
Start directly with the first meaningful rule or section.

---

### Pattern 4 — Over-Explained Example Reduction

Examples should be shorter than the rule they illustrate.

BEFORE (~80 tokens for the example block alone):
```markdown
## Error Handling
Always throw meaningful errors. Here is an example of how to do this correctly:

```typescript
// GOOD: meaningful error
throw new Error(`User ${userId} not found in database`);

// BAD: generic error
throw new Error('Error');

// ALSO BAD: no error message
throw new Error();
```
Make sure you follow this pattern in all your code.
```

AFTER (~30 tokens):
```markdown
## Error Handling
Throw descriptive errors: `throw new Error(\`User ${userId} not found\`)`.
```

---

### Pattern 5 — Duplicate Rule Deduplication

When the same rule appears in multiple files (e.g., both `copilot-instructions.md` and an `instructions/*.md` file):

1. Keep the rule in the most-specific file (the narrowly-scoped `instructions/` file with a tight `applyTo` glob).
2. Remove it from the broad file.
3. If it must stay in both: use a one-line reference comment `<!-- see: .github/instructions/coding-style.instructions.md -->` so a human knows where the canonical version lives.

---

### Pattern 6 — YAML Frontmatter Diet

Frontmatter `description` fields in instruction files are loaded into context. Keep them under 40 words.

BEFORE (~55 tokens in description):
```yaml
---
description: 'This file contains detailed guidelines for how to structure and write
  instruction files for GitHub Copilot in this project, including formatting rules,
  naming conventions, best practices, and examples of good and bad instructions.'
applyTo: '**/.github/instructions/**/*.md'
---
```

AFTER (~15 tokens in description):
```yaml
---
description: 'Guidelines for writing Copilot instruction files in this repo.'
applyTo: '**/.github/instructions/**/*.md'
---
```

---

### Pattern 7 — Progressive Loading Refactor

Move large reference tables, full workflow steps, and troubleshooting guides out of the main file into `references/` sub-files. The main `SKILL.md` body should link to them.

```
BEFORE:
  SKILL.md — 600 lines, 7,200 tokens
  (loads entirely on every skill activation)

AFTER:
  SKILL.md — 120 lines, 1,400 tokens (overview + links)
  references/detailed-workflows.md — 480 lines, 5,800 tokens
  (loads only when Copilot references it)

Active context reduction: 83% on initial activation
```

Links from SKILL.md:
```markdown
See [detailed workflows](./references/detailed-workflows.md) for full step-by-step procedures.
```

---

### Pattern 8 — applyTo Scoping

A single large `copilot-instructions.md` that tries to cover all cases should be split into focused instruction files with tight `applyTo` globs.

BEFORE: one 500-line file loaded on every request

AFTER: split into focused files, each loaded only when relevant:

```yaml
# coding-style.instructions.md
applyTo: '**/*.{ts,tsx,js,jsx}'

# php-wordpress.instructions.md  
applyTo: '**/*.php'

# testing.instructions.md
applyTo: '**/*.{test,spec}.{ts,js}'

# docs.instructions.md
applyTo: '**/*.md'
```

Each narrowly-scoped file loads only when Copilot works on matching files, reducing per-request context from 500 lines to the relevant 50–100 lines.

---

## Anti-Pattern Library

Common patterns found in the wild that balloon token counts:

| Anti-Pattern | Example | Fix |
|-------------|---------|-----|
| Philosophy preamble | "AI is a tool that should empower developers..." | Delete |
| Role restatement | "As a coding assistant, you should..." | Delete |
| Double negative rules | "Don't not use..." | Rephrase as positive |
| Exhaustive negative list | "Never use var, never use callbacks, never use..." | One positive rule |
| Markdown heading for 1 rule | `## Always use semicolons` then one sentence | Fold into parent section |
| Changelog in instructions | Version history inside a SKILL.md | Move to CHANGELOG.md |
| Screenshot alt-text padding | Excessive image descriptions | Trim to ≤10 words |
| JSON examples with comments | Large annotated JSON blocks | Use code + 1-line annotation |

---

## Scoring Reference

Waste score interpretation:

| Score | Action |
|-------|--------|
| 0–2 | No action needed; minor polish optional |
| 3–4 | Recommend rewrite; schedule for next sprint |
| 5–6 | High priority; likely >40% token reduction available |
| 7–8 | Critical; file is significantly bloated |

---

## Commit Message Template

```
refactor(prompts): reduce token count by {X}% — token-efficiency audit

Files changed:
- {file}: {before} → {after} tokens (-{saved}, -{pct}%)
- {file}: {before} → {after} tokens (-{saved}, -{pct}%)

Patterns applied: {list patterns used}
Total saved: {total_tokens} tokens across {n} files
```
