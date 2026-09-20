# ZK Integration Reference

How to run wiki-builder alongside `zettelkasten-mcp` so topic-wiki knowledge feeds into the global knowledge graph.

## Why Integrate

| Standalone wiki | ZK-integrated wiki |
|----------------|-------------------|
| Flat backlinks, no semantic weight | Typed links (extends, supports, contradicts) |
| Topic-local search only | Global ZK graph traversal |
| No cross-topic discovery | Similarity search across all wikis |
| Pages drift from ZK graph | Pages are ZK nodes — fully connected |

## Core Principle

Use Wiki Builder's scaffold as the **entry point** into ZK. Raw → compiled page → ZK note → linked to graph. The wiki folder stays as the human-readable view; ZK is the searchable, linked view.

## Note Mapping

| Wiki artifact | ZK note type | Tags |
|--------------|-------------|------|
| Compiled concept/topic page | `permanent` | `[wiki-slug]`, topic tags |
| Paper summary page | `literature` | `[wiki-slug]`, `[author-year]` |
| Filed Q&A answer | `fleeting` (→ promote if significant) | `[wiki-slug]`, `q-and-a` |
| `sources.md` entry | `literature` | `[wiki-slug]`, `source` |
| `wiki/index.md` | `structure` (MOC) | `[wiki-slug]`, `moc` |

## Workflow

### Step 1: Scaffold + Create MOC

After `init_wiki.sh`, immediately create a ZK structure note:

```
Create a ZK structure note as the MOC for this wiki.
Title: "MOC: [Wiki Title]"
Tags: [wiki-slug], moc, [flavor]
Link it to any existing ZK notes related to [topic].
```

### Step 2: Compile → ZK Note

For each compiled wiki page:

```
Compile [source] into a wiki page AND create a ZK [note-type] note tagged with [wiki-slug].
Link the ZK note to [existing related ZK notes].
```

The agent:
1. Writes `wiki/[page].md`
2. Calls `zk_create_note(title, content, note_type, tags=[wiki-slug, ...])`
3. Calls `zk_find_similar_notes(new_note_id)` to find linking candidates
4. Creates typed ZK links to related existing notes

### Step 3: Query and File → ZK

For Q&A filing:

```
[Question about topic]
```

Agent:
1. Answers using wiki content
2. Files answer to `wiki/questions/<slug>.md`
3. If answer is significant: `zk_create_note(note_type="fleeting", tags=[wiki-slug, "q-and-a"])`
4. Promotes fleeting → permanent if answer contains a standalone insight

### Step 4: Maintenance → ZK Orphan Check

During lint pass, also run:
```
Find ZK notes tagged with [wiki-slug] that have fewer than 2 links. Suggest connections.
```

## Example Tag Scheme

For a wiki on "agent memory" (`slug: agent-memory`, `flavor: research`):

- All ZK notes: `agent-memory`
- Paper notes: `agent-memory`, `literature`, `[author-year]`
- Concept notes: `agent-memory`, `permanent`
- MOC: `agent-memory`, `moc`, `structure`
- Q&A answers: `agent-memory`, `q-and-a`

This lets you search `tags: agent-memory` in ZK to retrieve all knowledge from this wiki.

## Typed Link Guidance

When creating ZK links from wiki pages to existing notes:

| Relationship | Link type |
|---|---|
| Wiki concept builds on existing ZK concept | `extends` |
| Wiki finding supports existing ZK claim | `supports` |
| Wiki finding contradicts existing ZK claim | `contradicts` |
| Wiki note refines an existing ZK note | `refines` |
| Wiki paper references an existing ZK note | `reference` |
| Wiki topic overlaps with existing topic | `related` |

Always use `bidirectional=true` when creating links.
