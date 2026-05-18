---
name: llm-wiki
description: >
  Build and maintain a persistent, compounding LLM wiki — a structured collection of
  interlinked markdown pages that sits between you and raw sources. Implements the
  Karpathy LLM Wiki pattern: the LLM incrementally reads sources, integrates knowledge
  into wiki pages (not re-derives it on every query), and files answers back so knowledge
  compounds over time. Three core operations: INGEST a new source into the wiki, QUERY
  the wiki and file the answer back, LINT the wiki for health. Integrates with Zettelkasten
  MCP for atomic cross-domain notes, plus web search, Semantic Scholar, and the workspace's
  existing log.md and inbox. Distinct from wiki-builder (which scaffolds wikis) — this skill
  is the ongoing methodology: how to operate an LLM wiki once it exists.
  Use when: "build an LLM wiki on", "ingest this source into my wiki", "query my wiki about",
  "lint my wiki", "set up a wiki for [topic]", "add this to my wiki", "file this answer",
  "wiki is getting stale", "expand my wiki", "start a knowledge base that compounds".
author: Daniel Kaesmayr
metadata:
  version: "1.0.0"
  inspired-by: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
  category: knowledge-management
---

# LLM Wiki

A **persistent, compounding knowledge base** maintained by the LLM. Unlike RAG (which re-derives
answers from raw documents on every query), the wiki is built once and kept current —
cross-references already in place, contradictions already flagged, synthesis already written.

> "Obsidian is the IDE; the LLM is the programmer; the wiki is the codebase." — Karpathy

## When to Use vs. Related Skills

| Need | Use |
|------|-----|
| Start a new wiki on a topic | This skill (`bootstrap`) |
| Ingest a paper / article / meeting | This skill (`ingest`) |
| Query the wiki and save the answer | This skill (`query-and-file`) |
| Health check + repair | This skill (`lint`) |
| Topic-scoped single-use research | `wiki-builder` skill |
| Atomic cross-domain notes only | `zettelkasten-management` skill |
| Deep multi-source research session | `dk.v2.deep-research` skill |

## Architecture: Three Layers

```
raw/           ← IMMUTABLE source documents. LLM reads but never modifies.
               ← Also includes inbox/ items, downloaded PDFs, clipped web pages.
wiki/          ← LLM-OWNED markdown pages: summaries, entities, concepts, Q&A.
               ← You read; the LLM writes and maintains.
wiki.toml      ← SCHEMA: conventions, page types, scope, ZK settings, log path.
               ← You and the LLM co-evolve this over time.
```

## Bootstrap a New Wiki

When the user asks to start a wiki on a topic:

1. **Agree on scope** — what topic, what question, what sources are in scope?
2. **Create the folder structure**:

```
notes/research/<topic-slug>/        (or notes/projects/<slug>/ or notes/wiki/<slug>/)
├── wiki.toml                       ← machine config (see references/wiki-toml-schema.md)
├── wiki.config.md                  ← human narrative: purpose, audience, scope
├── raw/                            ← symlink or copy raw sources here
├── wiki/
│   ├── index.md                    ← navigation catalog, updated on every ingest
│   └── questions/                  ← filed Q&A answers
└── log.md                          ← APPEND-ONLY operations log for this wiki
```

3. **Write `wiki.config.md`** — one paragraph: what this wiki is for, what's in scope, what's out.
4. **Write `wiki.toml`** — see [references/wiki-toml-schema.md](references/wiki-toml-schema.md).
5. **Write `wiki/index.md`** — empty catalog with headers for each page category.
6. **Append to workspace `notes/log.md`**: `## [date] create | <topic> wiki bootstrapped`

## Operation 1: INGEST

Add a new source into the wiki. A single source may touch 10–15 pages.

```
Ingest [source] into my [topic] wiki.
```

**Steps:**
1. **Read the source** — full text. If PDF/DOCX, use appropriate skill first.
2. **Discuss key takeaways** — briefly surface 3–5 core ideas with the user before writing.
3. **Write a source summary page** `wiki/source-<slug>.md` — see [references/page-types.md](references/page-types.md).
4. **Update entity and concept pages** — for every named entity or concept mentioned, find or create its page and integrate the new information (add, update, flag contradiction).
5. **Update `wiki/index.md`** — add the new source page; update any concept entries whose summary changed.
6. **Create ZK notes** — for each *atomic, cross-domain* insight, create a Zettelkasten note (see [references/zk-integration.md](references/zk-integration.md)). Do NOT ZK-ify every wiki page — only universally reusable concepts.
7. **Append log entry** to this wiki's `log.md`:
   ```
   ## [YYYY-MM-DD HH:MM] ingest | <Source Title>
   - Pages touched: source-<slug>.md, entity-X.md, concept-Y.md
   - New pages: source-<slug>.md
   - ZK notes created: N
   ```
8. **Append to workspace `notes/log.md`** (brief, one line).

**Contradiction handling:** If new content contradicts an existing page, do NOT silently overwrite.
Add a `> ⚠️ Contradiction` blockquote with both claims and sources. Raise it with the user.

## Operation 2: QUERY + FILE

Answer a question from the wiki, then file the answer back so it compounds.

```
Query my [topic] wiki: [question]
```

**Steps:**
1. **Read `wiki/index.md`** — identify the 3–5 most relevant pages.
2. **Load relevant pages** — read them in full.
3. **Synthesize answer** — cite page names, not raw sources. If something is unknown, say so.
4. **Ask the user**: "Should I file this answer as a wiki page?"
5. **If yes**: create `wiki/questions/<slug>.md`, update `wiki/index.md`, log it.
6. **If the answer reveals a gap** — note it in the wiki under `wiki/gaps.md` (create if missing).

**Answer formats** the wiki can produce:
- Markdown page (default)
- Comparison table
- Timeline
- Slide deck outline (Marp)
- Action items list

## Operation 3: LINT

Periodic health check. Run when the wiki feels stale or has grown significantly.

```
Lint my [topic] wiki.
```

**Check for:**
| Issue | Action |
|-------|--------|
| Orphan pages — no inbound links | Add links or flag for removal |
| Stale claims — newer sources contradict | Add `⚠️ Contradiction` block |
| Concepts mentioned but no own page | Create stub or add to gaps.md |
| Missing cross-references | Add `[[links]]` between related pages |
| Index out of sync | Update `wiki/index.md` |
| Source pages with no concept pages | Extract key concepts |
| ZK notes not linked back to wiki | Update ZK notes with wiki reference |

**Output:** A lint report in `wiki/lint-<YYYY-MM-DD>.md`. Ask user which issues to fix now.

**Append to log.md:**
```
## [YYYY-MM-DD HH:MM] lint | <topic> wiki
- Issues found: N orphans, M stale claims, K missing pages
- Fixed: ...
- Deferred: ...
```

## Wiki Page Conventions

See [references/page-types.md](references/page-types.md) for full templates.

**Quick reference:**

| Page type | Filename pattern | Contains |
|-----------|-----------------|----------|
| Source summary | `wiki/source-<slug>.md` | Title, URL/path, date, key claims, my take |
| Entity | `wiki/entity-<name>.md` | Who/what it is, appearances, relationships |
| Concept | `wiki/concept-<name>.md` | Definition, evidence, applications, links |
| Comparison | `wiki/compare-<a>-vs-<b>.md` | Side-by-side table, verdict |
| Q&A | `wiki/questions/<slug>.md` | Question, answer, sources used, date |
| Gaps | `wiki/gaps.md` | Questions without answers, missing sources |
| Overview | `wiki/overview.md` | Running synthesis — the wiki's thesis so far |

**All pages must have YAML frontmatter:**
```yaml
---
title: "<page title>"
type: source | entity | concept | comparison | qa | overview
wiki: "<topic-slug>"
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: ["source-slug-1", "source-slug-2"]
---
```

## Index and Log Conventions

**`wiki/index.md`** — content-oriented catalog, updated on every ingest:
```markdown
# [Topic] Wiki Index
_Last updated: YYYY-MM-DD — N pages, M sources_

## Sources
- [Source Title](source-<slug>.md) — one-line summary

## Entities
- [Entity Name](entity-<name>.md) — one-line summary

## Concepts
- [Concept Name](concept-<name>.md) — one-line summary

## Q&A
- [Question](questions/<slug>.md) — date answered
```

**`log.md`** — chronological, append-only, parseable:
```markdown
## [YYYY-MM-DD HH:MM] ingest | Source Title
## [YYYY-MM-DD HH:MM] query | Question asked
## [YYYY-MM-DD HH:MM] lint | Health check
```

Parse with: `grep "^## " log.md | tail -10`

## Zettelkasten Integration

See [references/zk-integration.md](references/zk-integration.md) for the full protocol.

**Decision rule — when to create a ZK note from a wiki page:**

| Condition | ZK note? |
|-----------|----------|
| Atomic, reusable insight applicable outside this topic | ✅ Yes |
| Contradicts or extends an existing ZK note | ✅ Yes |
| Only relevant within this wiki's topic scope | ❌ No — wiki page only |
| Raw source summary | ❌ No — wiki source page only |

**ZK tagging convention:** `wiki:<topic-slug>` — every ZK note created during a wiki session gets this tag so you can find all ZK notes from this wiki.

**Bidirectional linking:** ZK note → wiki page (via `reference` link in ZK `## Links`); wiki page → ZK note ID in frontmatter `zk_notes: [...]`.

## Sources Beyond the Wiki

The wiki does not replace external search — it *accumulates* from it.

When a query reveals a gap:
1. Search with Tavily or Semantic Scholar (use `deep-web-research` or `dk.v2.deep-research` skills)
2. Download/save the source to `raw/`
3. Run INGEST

When the wiki is stale on a topic:
1. Run a web search for recent developments
2. Compare against existing wiki claims
3. INGEST the new sources

## Schema Evolution

The `wiki.toml` (and `wiki.config.md`) should evolve as the wiki grows:

- Add new page types as patterns emerge
- Narrow or expand scope based on what you're actually using
- Record schema changes in `log.md` as `schema | <what changed>`
- Update `wiki.config.md` to reflect the current purpose

The schema is not fixed at bootstrap — you and the LLM co-evolve it.

## Tips

- **Ingest one source at a time** when staying involved. Batch-ingest only for catch-up.
- **File every useful answer back** — don't let insights disappear into chat history.
- **The overview page is the thesis** — update it after every 5–10 ingests to reflect the current synthesis.
- **Gaps are as valuable as pages** — a well-maintained `gaps.md` tells you what to research next.
- **Use the workspace inbox** — drop files into `inbox/` and ingest from there.
- **Lint before adding a 10th source** — catch structural issues early.
