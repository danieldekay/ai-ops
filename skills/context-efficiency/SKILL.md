---
name: context-efficiency
description: >
  Always-on context hygiene. Reduces token waste by using rtk (Rust Token Killer)
  as a CLI proxy for all terminal commands and offloading memory to external MCPs.
  Apply to every session — no exceptions. Triggers: any terminal command, any task
  that reads files or runs shell commands, any research task that would keep large
  outputs in-context.
author: Daniel Kaesmayr
metadata:
  version: "1.1.0"
  category: meta
---

# Context Efficiency

Three rules. Follow all three at all times.

> **Why this matters:** In a typical 2-hour coding session, an agent runs ~60 shell commands
> averaging 3,500 tokens of output each — 210,000 tokens of CLI noise alone, nearly filling a
> 200K window before reasoning even begins. RTK users report sessions lasting ~3× longer before
> hitting the context wall. (Source: rushis.com, 2025)

---

## Rule 1: Always prefix CLI commands with `rtk`

`rtk` is installed at `~/.local/bin/rtk`. It intercepts stdout and compresses it before the
context window ever sees it. Savings range from 60% to 99%.

**Every terminal command gets the prefix. No exceptions.**

```bash
# ❌ Never
git diff HEAD~1
find . -name "*.py"
pytest -v
grep -r "pattern" src/

# ✅ Always
rtk git diff HEAD~1
rtk find . -name "*.py"
rtk pytest
rtk grep "pattern" src/
```

This applies in `&&` chains too:

```bash
rtk git add . && rtk git commit -m "msg" && rtk git push
```

### High-impact commands

| Workflow     | Command                              | Typical saving |
| ------------ | ------------------------------------ | -------------- |
| Tests        | `rtk pytest` / `rtk vitest run`      | 90–99%         |
| Lint / types | `rtk ruff check .` / `rtk mypy src/` | 80–90%         |
| Git diff     | `rtk git diff`                       | 80%            |
| File search  | `rtk find <pattern>`                 | 70%            |
| Text search  | `rtk grep <pattern> <path>`          | 75%            |
| Errors only  | `rtk err <any-command>`              | varies         |
| Log analysis | `rtk log <file>`                     | 70%            |

### One-time setup (preferred)

```bash
rtk init -g       # installs global hook — no prefix needed after this, rtk applies automatically
```

If the global hook is not installed, fall back to explicit prefix on every command.
Check cumulative savings at any time: `rtk gain`

If a project has no `.rtk/` config: `rtk init` creates `CLAUDE.md` + `.rtk/filters.toml`.

---

## Rule 2: Offload memory — never hold large content in context

**Just-in-time retrieval beats upfront loading.** Only bring information into context when you
actively need it for the current step.

### Threshold strategy (from Anthropic context engineering guidance)

| Context size | Strategy                                                         |
| ------------ | ---------------------------------------------------------------- |
| < 10K tokens | Simple append, no action needed                                  |
| 10K–50K      | Compress: summarize completed steps, drop raw tool outputs       |
| 50K–100K     | Offload: write findings to external memory, retrieve selectively |
| > 100K       | Isolate: delegate to a sub-agent, bring back only the summary    |

### External memory: use MCPs for persistence

Route persistent data to external stores rather than keeping it inline in context.

| Situation                    | Action                                                                                    |
| ---------------------------- | ----------------------------------------------------------------------------------------- |
| Research or insights to save | Write to a Zettelkasten MCP or equivalent note store — not inline in context              |
| Looking up existing research | Query the note store **before** reading files                                             |
| Bookmarking a source         | Use a bookmark MCP (e.g. Raindrop) — not a full URL paste                                 |
| Library/API docs             | Use a context7-style doc MCP for targeted fetch, not a full dump                          |

### Narrow reads

Use search tools (`grep_search`, `semantic_search`) before `read_file`. Specify exact line ranges.
Never load a file to "see what's in it" — search first, read only the relevant section.

---

## Rule 3: Keep context lean — avoid context pollution

**Context pollution** (too many tools, too much irrelevant history, redundant data) degrades
reasoning quality even when the window has space. Active hygiene rules:

- **Don't front-load.** Don't dump files, docs, or search results into context unless you need
  them for the current step. Retrieve dynamically.
- **Summarize, don't accumulate.** After completing a sub-task, reduce what stays in context to
  a 1–2 sentence outcome. Drop the intermediate steps.
- **Sub-agents for heavy exploration.** When a task requires deep file reading or many tool
  calls, delegate to a sub-agent. It can burn 50K+ tokens internally but returns only a
  distilled 1–2K token summary to the main context. (Anthropic research: sub-agents achieve
  90% performance improvement despite using 15× more tokens overall.)
- **Tool minimalism.** Each unused tool in scope is dead weight. Load skills and context only
  when they are relevant to the current task.

---

## What this skill does NOT cover

Writing quality, skill selection, test strategies — those are separate skills.
This skill is only about not wasting context on CLI noise, redundant reads, and pollution.
