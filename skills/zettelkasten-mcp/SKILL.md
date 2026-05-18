---
name: zettelkasten-mcp
description: >
  Build and manage a networked knowledge base (second brain) using the Zettelkasten method
  with the zettelkasten-mcp MCP server. Use when creating atomic notes, linking ideas,
  searching the knowledge graph, building Maps of Content (MOCs), capturing research,
  processing meeting notes, or running knowledge maintenance. Includes installation from
  the GitHub repo via uvx, mcp.json configuration, full MCP tool reference,
  note type taxonomy, semantic link types, and Luhmann's methodology.
  Triggers: "zettelkasten", "second brain", "atomic note", "knowledge graph", "create note",
  "link ideas", "zk_create_note", "install zettelkasten-mcp", "MCP config", "note taking",
  "Luhmann", "slip box", "build knowledge base", "literature note", "permanent note".
author: Daniel Kaesmayr
metadata:
  version: "1.0.0"
  category: knowledge-management
  repo: https://github.com/entanglr/zettelkasten-mcp
---

# Zettelkasten MCP

Build a networked knowledge base using Niklas Luhmann's **Zettelkasten** methodology, powered by the `zettelkasten-mcp` MCP server. Notes are stored as Markdown files with YAML frontmatter (source of truth) and indexed in SQLite for fast graph traversal.

## Luhmann's Zettelkasten

Niklas Luhmann (1927–1998), German sociologist, authored over 70 books and 400 articles using a physical slip-box (_Zettelkasten_). His method is the foundation of this system.

**Core insight**: A knowledge system should be a _communication partner_, not an archive. You should be surprised by what you find. Connections made across domains create emergent insights that no top-down hierarchy could anticipate.

**Luhmann's four principles:**

| Principle               | What it means                                                                |
| ----------------------- | ---------------------------------------------------------------------------- |
| **Atomicity**           | One idea per note. If you need to scroll, split the note.                    |
| **Own words**           | Never copy. Reformulate in your own language. Understanding is the work.     |
| **Radical linking**     | Every note must link to existing notes. A note without links is dead.        |
| **Bottom-up structure** | Organization _emerges_ from connections. Never pre-define folders or topics. |

> _"A Zettelkasten that has grown over years is able to confront its owner with considerations he did not foresee."_ — Luhmann

**Further reading**: [references/luhmann.md](references/luhmann.md)

---

## Installation

The `zettelkasten-mcp` server is distributed via GitHub.

### Quick install via `uvx`

```bash
# SSH (recommended)
uvx --from "git+ssh://git@github.com/entanglr/zettelkasten-mcp" zettelkasten-mcp

# HTTPS with GitHub CLI token
uvx --from "git+https://$(gh auth token)@github.com/entanglr/zettelkasten-mcp" zettelkasten-mcp
```

### Install as a pinned version

```bash
uvx --from "git+ssh://git@github.com/entanglr/zettelkasten-mcp@v1.3.0" zettelkasten-mcp
```

**Full installation guide**: [references/installation.md](references/installation.md)

---

## MCP Configuration (`mcp.json`)

Add this block to your `mcp.json` (or `settings.json` under `"mcp"`):

```json
{
  "mcpServers": {
    "zettelkasten": {
      "command": "uvx",
      "args": [
        "--from",
        "git+ssh://git@github.com/entanglr/zettelkasten-mcp",
        "zettelkasten-mcp",
        "--notes-dir",
        "/path/to/your/notes",
        "--database-path",
        "/path/to/your/db/zettelkasten.db"
      ]
    }
  }
}
```

**Required environment variables (alternative to CLI args)**:

| Variable                     | Purpose                                        |
| ---------------------------- | ---------------------------------------------- |
| `ZETTELKASTEN_NOTES_DIR`     | Directory where `.md` note files are stored    |
| `ZETTELKASTEN_DATABASE_PATH` | Path to the SQLite index database              |
| `ZETTELKASTEN_LOG_LEVEL`     | `DEBUG` / `INFO` / `WARNING` (default: `INFO`) |

> The database is derived from Markdown files — delete it at any time and run `zk_rebuild_index` to regenerate.

---

## Note Types

| Type         | Purpose                                       | When to use                                                      |
| ------------ | --------------------------------------------- | ---------------------------------------------------------------- |
| `fleeting`   | Raw captures, quick ideas                     | During reading, meetings, thinking — process within 1 week       |
| `literature` | Extraction from a source with citation        | After reading a paper, book, article                             |
| `permanent`  | Single refined concept in own words           | After processing literature notes; the core of your Zettelkasten |
| `structure`  | Map of Content (MOC) — index of related notes | When 7+ notes cluster around a theme                             |
| `hub`        | Entry point to a major domain                 | When multiple MOCs share a theme; top-level navigation           |

### Note quality gate (permanent notes)

- [ ] Single coherent idea — atomic
- [ ] Written in own words — not copied
- [ ] Self-contained — understandable without the source
- [ ] Declarative title: _"Active Recall Strengthens Memory"_ not _"Learning Note"_
- [ ] 3–7 relevant tags
- [ ] Linked to 2+ existing notes with specific link types
- [ ] Citation if derived from a source

---

## MCP Tools Reference

### CRUD

| Tool                    | Key Parameters                            | Use                            |
| ----------------------- | ----------------------------------------- | ------------------------------ |
| `zk_create_note`        | `title`, `content`, `note_type`, `tags[]` | Create a new note              |
| `zk_get_note`           | `note_id`                                 | Retrieve a note by ID          |
| `zk_update_note`        | `note_id`, `title?`, `content?`, `tags?`  | Modify an existing note        |
| `zk_delete_note`        | `note_id`                                 | Remove a note                  |
| `zk_list_notes`         | `limit`, `offset`                         | Paginate all notes             |
| `zk_list_notes_by_date` | `start_date`, `end_date`                  | Filter by created/updated date |

### Search & Discovery

| Tool                     | Key Parameters                 | Use                           |
| ------------------------ | ------------------------------ | ----------------------------- |
| `zk_search_notes`        | `query`, `tags[]`, `note_type` | Full-text + metadata search   |
| `zk_find_similar_notes`  | `note_id`, `threshold`         | Semantic similarity           |
| `zk_find_central_notes`  | `limit`                        | Highest connection-count hubs |
| `zk_find_orphaned_notes` | —                              | Notes with zero links         |
| `zk_get_all_tags`        | —                              | List all tags in use          |

### Graph / Linking

| Tool                  | Key Parameters                                                        | Use                  |
| --------------------- | --------------------------------------------------------------------- | -------------------- |
| `zk_create_link`      | `source_id`, `target_id`, `link_type`, `description`, `bidirectional` | Create semantic link |
| `zk_remove_link`      | `source_id`, `target_id`                                              | Delete a link        |
| `zk_get_linked_notes` | `note_id`, `direction` (`both`/`outgoing`/`incoming`)                 | Traverse graph       |

### Maintenance

| Tool               | Use                                                              |
| ------------------ | ---------------------------------------------------------------- |
| `zk_rebuild_index` | Rebuild SQLite from Markdown files (use after manual file edits) |

---

## Link Types

Choose the most specific type. `related` is a last resort.

| Type          | Inverse           | Symmetric | Semantic meaning          |
| ------------- | ----------------- | --------- | ------------------------- |
| `supports`    | `supported_by`    | No        | Evidence for a claim      |
| `contradicts` | `contradicted_by` | No        | Opposing claim            |
| `extends`     | `extended_by`     | No        | Builds on a concept       |
| `refines`     | `refined_by`      | No        | Clarifies or improves     |
| `questions`   | `questioned_by`   | No        | Raises doubt or challenge |
| `reference`   | `reference`       | Yes       | Simple citation           |
| `related`     | `related`         | Yes       | Generic — use sparingly   |

**Always set `bidirectional: true`** so both notes show the connection.

**Add a description**: _"X supports Y because..."_ — future-you will thank you.

---

## Core Workflows

### 1. Create and Link a Note

```
1. zk_search_notes(query="<concept>")          → avoid duplicates
2. zk_create_note(title, content, type, tags)  → atomic note
3. zk_find_similar_notes(note_id)              → find connection candidates
4. zk_create_link(source, target, type,        → link immediately; never orphan
                  description, bidirectional=true)
```

### 2. Capture Research

1. Read paper/article → create `fleeting` notes per key point (one idea each)
2. After session → upgrade each fleeting note to `literature` note with `[@citekey]`
3. After synthesis → create `permanent` note combining insights across sources
4. Add to relevant MOC (`structure` note)

### 3. Knowledge Discovery

```python
zk_find_central_notes(limit=10)          # What are your core concepts?
zk_find_orphaned_notes()                 # What needs linking or deleting?
zk_get_linked_notes(note_id, "both")     # What constellation surrounds idea X?
zk_find_similar_notes(note_id, 0.3)      # What is semantically adjacent?
```

### 4. Weekly Maintenance

1. Process `fleeting` notes → promote to `literature`/`permanent` or delete
2. Run `zk_find_orphaned_notes()` → link or cull
3. Run `zk_find_central_notes()` → create `structure` notes for emerging clusters
4. Run `zk_get_all_tags()` → merge duplicates (`ai`, `artificial-intelligence` → pick one)

---

## Tagging Strategy

| Category    | Examples                                              |
| ----------- | ----------------------------------------------------- |
| Domain      | `ai`, `chemistry`, `neuroscience`, `philosophy`       |
| Idea type   | `method`, `concept`, `principle`, `hypothesis`        |
| Project     | `project-rotf`, `thesis-ch3`, `my-project`             |
| Status      | `wip`, `needs-review`, `evergreen`                    |
| Source type | `book`, `paper`, `talk`, `conversation`, `experiment` |

**Rules**: 3–7 tags per note · use hyphens, not spaces · check `zk_get_all_tags()` before coining new tags.

---

## Markdown Note Format

Notes are stored with YAML frontmatter — human-readable and version-control friendly:

```markdown
---
id: 20251109T120530123456789
title: Active Recall Strengthens Long-Term Memory
type: permanent
tags: [memory, learning, spaced-repetition, cognitive-science]
created: 2025-11-09T12:05:30.123456
updated: 2025-11-09T12:05:30.123456
---

# Active Recall Strengthens Long-Term Memory

Retrieving information from memory (testing yourself) produces stronger
retention than re-reading the same material. Each retrieval act modifies
the memory trace, making future retrieval easier.

[@roediger2006]

## Links

- supports [[20251109T115500000000000]] Spaced repetition exploits this mechanism
- extends [[20251109T114000000000000]] Desirable difficulties framework
```

> Note IDs are timestamp-based (`YYYYMMDDTHHMMSSssssssccc`). The server generates these automatically.

---

## Quick Start

```bash
# 1. Install the server
uvx --from "git+ssh://git@github.com/entanglr/zettelkasten-mcp" zettelkasten-mcp \
  --notes-dir ~/notes/zettelkasten \
  --database-path ~/notes/db/zettelkasten.db

# 2. Verify connectivity (in chat with MCP enabled)
# "List my 5 most central notes"

# 3. Create your first permanent note
# "Create a permanent note titled 'X' with these key points: ..."

# 4. Find what connects to it
# "Find notes similar to <note_id> and suggest links"
```
