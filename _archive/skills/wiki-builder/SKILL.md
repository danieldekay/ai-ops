---
name: wiki-builder
description: >
  Build and maintain topic-scoped "LLM knowledge bases" — structured agent-maintained wikis
  for deep-diving a single topic (paper, framework, person, project, domain). Scaffolds a
  folder with wiki.config.md, raw/, prompts, and sources.md in one command. Compiles raw
  source material into organized wiki pages, files Q&A answers back into the wiki, and runs
  maintenance passes to find thin pages and missing links. Works standalone (flat markdown)
  or integrated with zettelkasten-mcp (compiled pages become ZK notes tagged with the wiki
  topic). Inspired by DAIR.AI's Wiki Builder plugin, adapted for VS Code + GitHub Copilot.
  Triggers: "start a wiki on", "build a knowledge base about", "create topic wiki",
  "wiki for this paper", "deep dive into X", "research wiki", "compile this into a wiki",
  "knowledge base for project", "file this answer", "lint my wiki", "wiki-builder".
author: Daniel Kaesmayr
metadata:
  version: "1.4.0"
  category: knowledge-management
  inspired-by: https://academy.dair.ai/blog/wiki-builder-claude-code-plugin
  also-inspired-by: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
---

# Wiki Builder

Scaffold and maintain a **topic-scoped knowledge base** — a structured, agent-maintained wiki for a single topic. Designed for "dozens of sources" scale where a full vector pipeline is overkill.

## When to Use

| Use case                                      | This skill                       | zettelkasten-mcp |
| --------------------------------------------- | -------------------------------- | ---------------- |
| Deep single-topic research                    | ✅                               | Too broad        |
| Cross-domain knowledge graph                  | Use zettelkasten-mcp             | ✅               |
| Paper deep-dive                               | ✅ (paper flavor)                | Use for linking  |
| Meeting knowledge capture                     | Use meeting-transcript-processor | ✅               |
| "What does X say about Y?" on a specific wiki | ✅ query-and-file                | —                |

Use this skill **in addition to** zettelkasten-mcp, not instead of it. Best practice: compile pages as ZK notes tagged with the wiki topic so the two systems stay in sync.

## Quick Start

```
Start a new wiki on [topic] using the [flavor] flavor.
```

Flavors: `research`, `paper`, `domain`, `product`, `person`, `organization`, `project`

The agent will run `init_wiki.sh` (or scaffold manually if unavailable) and create the folder layout. See [references/flavors.md](references/flavors.md) for flavor-specific page types.

## Folder Layout

The layout below is the **default** created by `init_wiki.sh`. When adopting an existing folder, the `[structure.paths]` section in `wiki.toml` remaps each concept to whatever paths already exist — the agent follows the paths, not the names.

```
<wiki-slug>/
├── wiki.toml             ← READ FIRST: machine-readable config (structure, thresholds, ZK options)
├── wiki.config.md        ← Human-readable narrative: purpose, audience, scope
├── raw/                  ← unprocessed inputs (PDFs, notes, URLs, pastes)
├── wiki/
│   ├── index.md          ← navigation; maintain after every compile
│   └── questions/        ← filed Q&A answers
├── derived/              ← agent-generated summaries, tables, timelines
├── prompts/              ← per-wiki prompt templates (edit freely)
│   ├── compile-index.md
│   ├── compile-source-page.md
│   ├── compile-concept-page.md
│   ├── query-and-file.md
│   └── lint-wiki.md
├── logs/
│   ├── log.md                ← APPEND-ONLY: every ingest, query, and lint pass recorded here
│   └── maintenance-log.md
└── sources.md            ← PROVENANCE: every claim must link back here
```

## Core Workflow

### 0. Adopt an Existing Folder (alternative to Scaffold)

If you have an existing folder you want to treat as a wiki — a research folder, a project folder, a set of notes — without restructuring it:

```
Adopt [path/to/folder] as a wiki.
```

Agent will:
1. Check for an existing `wiki.toml` in the folder — if found, load it and proceed immediately
2. If no `wiki.toml`, **survey** the folder: list all files and subfolders, identify which serve as raw inputs, compiled pages, sources/references, and operations log
3. Propose a `wiki.toml` with a `[structure.paths]` section that maps those existing paths to the standard concepts
4. Wait for human confirmation or edits before proceeding
5. Once `wiki.toml` is accepted, operate exactly as if the folder was created by `init_wiki.sh`

This is a **read-then-propose** operation: the agent never creates or moves files during adoption, only proposes the mapping.

**Example** — adopting a `dk.v2.deep-research` output folder:
```toml
# wiki.toml placed in the research folder root
[meta]
title   = "How AI Agents Can Be Token Efficient"
slug    = "ai-agent-token-efficiency"
flavor  = "research"
created = "2026-05-06"

[structure]
page_types = ["findings", "synthesis", "questions"]

[structure.paths]
raw      = "tracks"                  # gather outputs are the raw inputs
wiki     = "synthesis"               # compiled synthesis artifacts
index    = "report.md"               # report.md acts as the index
sources  = "synthesis/references.md"
logs     = "."
log_file = "state.md"                # state.md acts as the operations log

[zk]
enabled    = true
tag_prefix = "wiki-token-efficiency"
source_tags       = []   # not pulling from ZK for this wiki
source_note_types = ["permanent", "literature"]
```

### 1. Scaffold (new wikis)

```
Create a new wiki for [topic] with flavor [flavor].
```

Agent creates the folder layout, populates `wiki.toml` (structure/behavior config) and `wiki.config.md` (human narrative), and fills `prompts/` from the flavor template.

### 2. Ingest and Compile

Drop source material into `raw/` (copy-paste text, save PDFs, paste URLs). Then:

```
Compile the sources in raw/ into wiki pages.
```

Agent reads `wiki.toml` first (for page_types and ingest config), then `wiki.config.md` (for scope/purpose context), then for each raw item:

1. Writes a summary/source page to the appropriate `wiki/` subfolder
2. **Searches existing wiki pages for entity/concept pages that this source should update** — a single source may touch 10–15 pages
3. Flags contradictions where new data contradicts existing claims (marks with `> ⚠️ Contradiction: [source]`)
4. Updates `wiki/index.md`
5. Appends an entry to `logs/log.md`: `## [YYYY-MM-DD] ingest | Source Title`

All claims are attributed to `sources.md`.

### 3. Query and File

```
[Ask a question about the topic]
```

Agent answers using wiki content + raw sources, then **files the answer** into `wiki/questions/<slug>.md` before responding, and appends to `logs/log.md`: `## [YYYY-MM-DD] query | Question slug`. Future questions on the same topic are answered from the filing.

### 4. Maintain

```
Run a maintenance pass on the wiki.
```

Agent uses `lint-wiki.md` to find: thin pages (< 3 claims), missing backlinks, uncompiled raw items, orphaned question files, **contradiction markers that need human resolution**, and stale claims where newer sources have superseded them. Appends to `logs/log.md`: `## [YYYY-MM-DD] lint | issues found`. Detailed report in `logs/maintenance-log.md`.

**Session start**: At the beginning of any new session, the agent reads `logs/log.md` tail to orient itself — what was last ingested, last queried, when lint was last run.

## Provenance Rule (Non-Negotiable)

**Every compiled page and every filed answer must attribute claims to `sources.md`.**

- Direct quotes: cite with line/section reference
- Paraphrased claims: cite with source slug
- Speculation or inference: mark explicitly as `[inferred]`
- Unverifiable claims: do not include

This prevents the wiki from drifting into ungrounded AI summaries over time.

## ZK Integration (Recommended)

When working alongside zettelkasten-mcp, compile pages as ZK notes:

```
Compile this wiki page as a ZK permanent note tagged with [wiki-slug].
```

- Each wiki page → `zk_create_note(note_type="permanent", tags=[wiki-slug, ...])`
- Each Q&A answer → `zk_create_note(note_type="fleeting", tags=[wiki-slug, "q-and-a"])`
- `sources.md` entries → `zk_create_note(note_type="literature", tags=[wiki-slug])`
- Link wiki notes to relevant existing ZK notes using typed links

### Pull from ZK (ZK → Wiki)

When `[zk].source_tags` is non-empty, the agent uses the ZK graph as its raw input source instead of (or alongside) the `raw/` folder:

```
Compile the ZK notes tagged [tag] into wiki pages.
```

Agent will:
1. Run `zk_search_notes` for each tag in `source_tags`, filtered to `source_note_types` if set
2. Deduplicate results (a note matching multiple tags is ingested once)
3. Treat each ZK note as a raw input: compile it into the appropriate wiki page type based on the note's `note_type` and tags
4. Attribute claims to the ZK note ID in `sources.md` (format: `zk:[note_id]`)
5. Append to `logs/log.md`: `## [YYYY-MM-DD] ingest | ZK pull: [tags] (N notes)`

This is the **ZK → Wiki** direction: turning an accumulated tag cluster into a human-readable compiled view. The wiki becomes a synthesis document over a ZK sub-graph; the ZK graph remains the primary store.

Example `wiki.toml` for a ZK-sourced wiki:
```toml
[zk]
enabled           = true
tag_prefix        = "wiki-agentic-dev"
source_tags       = ["agentic-dev", "multi-agent", "agent-architecture"]
source_note_types = ["permanent", "literature"]  # skip fleeting notes
```

Then:
```
Compile the ZK source tags into the agentic-dev wiki.
```

See [references/zk-integration.md](references/zk-integration.md) for the full integration workflow.

## Configuration (wiki.toml)

`wiki.toml` is the machine-readable config. Agent reads it first. Edit it to override the skill's built-in defaults; missing keys fall back to defaults.

Key sections:

| Section            | What it controls                                                     |
| ------------------ | -------------------------------------------------------------------- |
| `[meta]`           | Title, slug, flavor, created date                                    |
| `[structure]`      | `page_types` list (maps to `wiki/` subfolders), `index_grouping`     |
| `[structure.paths]`| **Path remapping for existing folders** — maps concepts to real paths |
| `[ingest]`         | `max_integration_pages`, `contradiction_detection`, `append_to_log`  |
| `[lint]`           | `min_claims_per_page`, `maintenance_interval`, enabled `checks` list |
| `[provenance]`     | `inference_marker`, `contradiction_marker` strings                   |
| `[zk]`             | `enabled`, `tag_prefix`, `source_tags` (pull from ZK), `source_note_types` |

### Path resolution

When the agent encounters any wiki operation, it resolves file paths in this order:

1. Read `wiki.toml` in the current folder (or the folder passed to the operation)
2. For each standard concept (`raw`, `wiki`, `index`, `questions`, `derived`, `sources`, `logs`, `log_file`): use the value from `[structure.paths]` if present, otherwise use the built-in default
3. If a mapped path does not exist yet and the operation requires it, create it (never create unmapped paths the user didn’t request)

**Any existing folder + a `wiki.toml` with `[structure.paths]` = a fully functional wiki**, regardless of how the folder was originally structured.

See [references/wiki.toml.template](references/wiki.toml.template) for the full annotated template including the commented `[structure.paths]` block.

To disable a lint check, remove its name from `[lint].checks`. To add a custom page type, append it to `[structure].page_types` — the agent will create `wiki/<type>/` and group the index accordingly.

## Not a wiki-builder target

Flat ID-based note stores (e.g. a folder of `20260506T083441643587000.md` timestamp files) managed by zettelkasten-mcp are **not** wiki-builder targets. Those are Zettelkasten databases operated by the MCP server. Use `zk_search_notes`, `zk_create_note`, and related MCP tools instead. Wiki-builder operates on human-authored folder structures where a page = a meaningful topic document, not an atomic note ID.

## wiki.config.md Template

```markdown
# Wiki: [Topic Title]

## Purpose

[One sentence: what question does this wiki answer?]

## Audience

[Who reads this? Agent + human researcher, team members, etc.]

## Flavor

[research | paper | domain | product | person | organization | project]

## Page Types

[List the categories of pages: concepts/, papers/, tools/, people/, etc.]

## Update Rules

- Compile new raw/ items before answering questions
- File every answer before responding
- Run maintenance pass after every 10 new pages
- All claims must cite sources.md

## Scope Boundaries

[What is explicitly out of scope for this wiki?]
```
