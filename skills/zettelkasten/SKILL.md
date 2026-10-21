---
name: zettelkasten
description: "Build and manage a networked knowledge base (second brain) using Luhmann's Zettelkasten method with the zettelkasten-mcp MCP server. Use when creating atomic notes, linking ideas, searching the knowledge graph, building Maps of Content, capturing research, processing meeting/fleeting notes, verifying claims with sources, or running knowledge maintenance. Triggers: 'zettelkasten', 'second brain', 'atomic note', 'knowledge graph', 'zk_create_note', 'note taking', 'Luhmann', 'slip box', 'permanent note', 'literature note'."
author: Daniel Kaesmayr
metadata:
  version: "2.0.0"
  category: knowledge-management
  repo: https://github.com/entanglr/zettelkasten-mcp
---

# Zettelkasten Knowledge Management

Consolidates the former generic `zettelkasten` skill (method-only) and
`zettelkasten-mcp` (server/tooling). One skill: method + tools + workflows.
Notes are Markdown files with YAML frontmatter (source of truth), indexed in
SQLite by the `zettelkasten-mcp` server for fast graph traversal.

## Luhmann's Zettelkasten

Niklas Luhmann (1927–1998) authored 70+ books from a physical slip-box. The
core insight: a knowledge system should be a _communication partner_, not an
archive — you should be surprised by what you find. Deep method background:
[references/luhmann.md](references/luhmann.md).

**Four principles:**

| Principle | Meaning |
| --- | --- |
| **Atomicity** | One idea per note. Can't summarize in one sentence → split. |
| **Own words** | Never copy; reformulate. Understanding is the work. |
| **Radical linking** | Every note links to existing notes. Unlinked note = dead. |
| **Bottom-up structure** | Organization emerges from connections — never pre-define folders. |

## Server Setup (once)

Install and configure the `zettelkasten-mcp` server via `uvx`:

```bash
# SSH (recommended) — or HTTPS with: git+https://$(gh auth token)@github.com/entanglr/zettelkasten-mcp
uvx --from "git+ssh://git@github.com/entanglr/zettelkasten-mcp" zettelkasten-mcp
# Pinned: append @v1.3.0 — full guide: references/installation.md
```

`mcp.json` block:

```json
{
  "mcpServers": {
    "zettelkasten": {
      "command": "uvx",
      "args": ["--from", "git+ssh://git@github.com/entanglr/zettelkasten-mcp",
               "zettelkasten-mcp", "--notes-dir", "/path/to/notes",
               "--database-path", "/path/to/zettelkasten.db"]
    }
  }
}
```

Env alternative: `ZETTELKASTEN_NOTES_DIR`, `ZETTELKASTEN_DATABASE_PATH`,
`ZETTELKASTEN_LOG_LEVEL`. The SQLite index is derived — delete it anytime and
run `zk_rebuild_index`.

## Note Types

| Type | Purpose | Lifespan | Tool pattern |
| --- | --- | --- | --- |
| `fleeting` | Raw captures, quick ideas | Process within 1 week | `zk_create_note note_type="fleeting"` |
| `literature` | Extract ideas from a source, with citation | Permanent | Include full citation |
| `permanent` | Well-formulated, standalone, sourced ideas | Permanent | research-validated |
| `structure` | MOC — index of 7–15 related notes | Permanent | `note_type="structure"` |
| `hub` | Entry point for a major domain | Permanent | `note_type="hub"` |

**Quality gate for permanent notes**: single coherent idea · own words ·
self-contained · declarative title ("Active Recall Strengthens Memory", not
"Learning Note") · 3–7 tags · linked to 2+ notes with specific link types ·
citation if derived from a source.

## Semantic Link Types

Choose the most specific type; `related` is a last resort. Always set
`bidirectional: true` for mutual relationships and add a description
("X supports Y because…").

| Type | Use when | Inverse |
| --- | --- | --- |
| `supports` | Evidence for a claim | `supported_by` |
| `contradicts` | Opposing views/evidence | `contradicted_by` |
| `extends` | Builds upon a concept | `extended_by` |
| `refines` | Clarifies or improves | `refined_by` |
| `questions` | Raises doubt or challenge | `questioned_by` |
| `reference` | Simple citation | `reference` (symmetric) |
| `related` | Generic overlap — sparingly | `related` (symmetric) |

## MCP Tools Reference

**CRUD**: `zk_create_note` (`title`, `content`, `note_type`, `tags[]`) ·
`zk_get_note` · `zk_update_note` · `zk_delete_note` · `zk_list_notes` ·
`zk_list_notes_by_date`

**Search & discovery**: `zk_search_notes` (`query`, `tags[]`, `note_type`) ·
`zk_find_similar_notes` (`note_id`, `threshold`) · `zk_find_central_notes` ·
`zk_find_orphaned_notes` · `zk_get_all_tags`

**Graph/linking**: `zk_create_link` (`source_id`, `target_id`, `link_type`,
`description`, `bidirectional`) · `zk_remove_link` · `zk_get_linked_notes`
(`direction`: both/outgoing/incoming)

**Maintenance**: `zk_rebuild_index` (after manual file edits)

## Core Workflows

### 1. Create and Link a Note
1. `zk_search_notes(query="<concept>")` → avoid duplicates
2. `zk_create_note(...)` → atomic note
3. `zk_find_similar_notes(note_id)` → connection candidates
4. `zk_create_link(..., bidirectional=true)` → link immediately; never orphan

### 2. Research Integration (validate claims with sources)
1. **Concept identification**: search existing notes first.
2. **External research**: use the active harness's web-search/fetch tools
   (query patterns: "[concept] research evidence empirical", "[concept]
   critique limitations alternatives").
3. **Synthesis**: create the permanent note in own words, complete citations
   for every claim, evidence-strength marks, acknowledge limitations.
4. **Connection**: link with research-backed descriptions and appropriate
   link types; bidirectional for important relationships.

### 3. Capture Research (papers/books/talks)
Fleeting notes per key point → upgrade to `literature` with `[@citekey]` →
synthesize `permanent` note across sources → attach to relevant MOC.

### 4. Weekly Maintenance
Process fleeting notes → `zk_find_orphaned_notes` (link or cull) →
`zk_find_central_notes` (create `structure` notes for clusters of 7–15) →
`zk_get_all_tags` (merge duplicates).

## Citation Standards

**Required elements**: author(s), year, title (quotes for articles, italics
for books), source, URL/DOI, access date for web sources.

**Reliability indicators**: ✅ peer-reviewed research / official documentation ·
⚠️ authoritative source / expert opinion · ❌ anecdotal (use sparingly).

**Quality tiers**: 1 meta-analyses & official standards · 2 peer-reviewed
articles & official docs · 3 preprints, industry reports · 4 expert blogs,
news · 5 social media, marketing (avoid).

## Note Template

Use `templates/permanent.md` (also: fleeting, literature, structure, hub) —
skeleton: Core Concept → Supporting Evidence (with reliability indicators) →
Alternative Perspectives → Context and Limitations → Sources + Evidence
Strength + Research Date.

## Common Patterns

- **Processing fleeting notes**: `zk_search_notes note_type="fleeting"` →
  research/validate/transform → `zk_delete_note` the fleeting original.
- **Claim verification**: identify unsourced claims → web-search evidence →
  `zk_update_note` with verified data and citations.
- **Anti-patterns**: collector's fallacy · link spam · single-source permanent
  notes · orphan islands · copy-paste without synthesis · tag overload (>5) ·
  premature structure notes (<7 components).

## Tagging Strategy

Categories: domain (`ai`, `neuroscience`) · idea type (`method`, `principle`) ·
project (`project-rotf`) · status (`wip`, `evergreen`) · source type (`paper`,
`talk`). Rules: 3–7 tags, hyphens not spaces, check `zk_get_all_tags` before
coining new ones.

## Markdown Note Format

```markdown
---
id: 20251109T120530123456789   # timestamp-based, server-generated
title: Active Recall Strengthens Long-Term Memory
type: permanent
tags: [memory, learning, spaced-repetition]
created: 2025-11-09T12:05:30
updated: 2025-11-09T12:05:30
---
# Active Recall Strengthens Long-Term Memory
Retrieving information produces stronger retention than re-reading…
[@roediger2006]
## Links
- supports [[20251109T115500000000000]] Spaced repetition exploits this
```

## Integration

- **LLM wiki** (`llm-wiki` skill): the wiki holds evidence/sources; ZK notes
  hold distilled personal knowledge — link them, don't duplicate.
- **Research skills** (`navigator` → Research): source gathering flows into
  `literature` notes.
