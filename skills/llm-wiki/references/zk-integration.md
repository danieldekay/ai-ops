# Zettelkasten Integration Protocol

Reference document for the `llm-wiki` skill. Load when deciding whether and how to create ZK notes from wiki content.

## Decision Rule: Wiki Page vs. ZK Note vs. Both

The wiki and the Zettelkasten serve different purposes. Do not mirror everything.

| Content type | Wiki only | ZK note + wiki link | ZK note only |
|-------------|-----------|---------------------|--------------|
| Source summary | ✅ | ❌ | ❌ |
| Topic-specific entity | ✅ | If it appears in other contexts | ❌ |
| Atomic, universal concept | link to ZK | ✅ | ❌ |
| Cross-domain insight | link to ZK | ✅ | ❌ |
| Filed Q&A answer | ✅ | If insight is reusable | ❌ |
| Overview / synthesis | ✅ | Hub note if topic is mature | ❌ |

**Rule of thumb:** A ZK note is justified when the insight would be useful in a different context than this wiki topic.

## Creating a ZK Note from Wiki Content

Use `zk_create_note` (via the `#zettelkasten` MCP server):

```
note_type: permanent         # for refined, cross-domain insights
           literature        # for claims directly from a source
           fleeting          # for raw observations during ingest
tags:
  - wiki:<topic-slug>        # links back to the wiki
  - <domain-tag>             # e.g., "ai", "cognition", "chemistry"
```

**Atomic content:** One idea per ZK note. If you find yourself writing two paragraphs on different things, split into two notes.

**ZK note body template for wiki-sourced notes:**

```markdown
# <Atomic Claim or Concept>

<2–5 sentences: the insight in your own words>

## Evidence

From [[source-slug]] in the `<topic>` wiki: <specific claim or quote>.

## Implications

- …

## Links
- reference [[<other-zk-id>]] <description>
- extends [[<other-zk-id>]] <description>
```

## Bidirectional Linking

After creating a ZK note, link it back to the wiki and vice versa.

**In the ZK note `## Links` section:**
```
- reference [[<wiki-source-page-id>]] Source in <topic> wiki
```
Note: ZK `## Links` uses bare ZK IDs (e.g., `[[20260508T120000000000000]]`), not wiki page names.

**In the wiki page frontmatter:**
```yaml
zk_notes: ["20260508T120000000000000", "20260508T130000000000000"]
```

**In the wiki page body** (optional inline reference for Foam navigation):
> See also: ZK note `20260508T120000000000000` — [Concept Name in ZK]

## Tagging Convention

Every ZK note created during a wiki session gets the tag `wiki:<topic-slug>`.

Examples:
- `wiki:llm-agents` — notes from an LLM agents wiki
- `wiki:carbon-capture` — notes from a carbon capture wiki
- `wiki:project-x` — notes from a project wiki

This lets you search across ZK for all notes from a specific wiki:
```
zk_search_notes(tags=["wiki:carbon-capture"])
```

## ZK Note Types for Wiki Content

| Wiki content | ZK note type | Reasoning |
|-------------|-------------|-----------|
| Atomic insight from a paper | `literature` | Directly from a source |
| Synthesized understanding | `permanent` | Refined through multiple sources |
| Open question from lint | `fleeting` | Not yet resolved |
| Hub for a mature wiki topic | `hub` | Organizes ZK notes in the domain |
| Wiki structural overview | `structure` | Maps the knowledge domain |

## When to Create a Hub Note

When a wiki topic is mature (10+ sources ingested, stable overview), create a ZK **hub note** for the topic:

```markdown
# Hub: <Topic Name>

Overview and entry point for all ZK notes related to the `<topic-slug>` wiki.

## Core Concepts

- [[<concept-A-zk-title>]] — <one-line summary>
- [[<concept-B-zk-title>]] — <one-line summary>

## Key Claims

- [[<claim-X-zk-title>]]
- [[<claim-Y-zk-title>]]

## Open Questions

- [[<fleeting-note-title>]]

## Links
- reference [[<source-note-1-id>]]
- reference [[<source-note-2-id>]]
```

Tag: `wiki:<topic-slug>`, `hub`

## Using ZK to Extend the Wiki

ZK works both ways — not just wiki → ZK, but ZK → wiki:

1. **During INGEST**: search `zk_search_notes` for existing notes on the topic. If relevant notes exist, reference them in new wiki pages and add the `wiki:<topic-slug>` tag to those existing notes.

2. **During QUERY**: use `zk_get_linked_notes` to find ZK notes connected to concepts mentioned in the query. These may contain insights not yet in the wiki.

3. **During LINT**: run `zk_search_notes(tags=["wiki:<topic-slug>"])` — check that all tagged notes are referenced from wiki pages. Orphaned ZK notes may contain unfiled insights.

## Workspace Integration

This workspace uses the `#zettelkasten` MCP server connected to:
- Notes dir: configured in `config/workspace.toml` and `.env`
- Database: `data/db/zettelkasten.db`

The workspace `notes/log.md` operations log should record significant ZK operations:
```
## [YYYY-MM-DD HH:MM] create | ZK notes from <topic> wiki ingest
- N permanent notes created, tagged wiki:<topic-slug>
```
