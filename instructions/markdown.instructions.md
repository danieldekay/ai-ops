---
description: "YAML front matter requirements for all planning and documentation Markdown files in docs/ and plan/"
applyTo: "docs/**/*.md, plan/**/*.md"
---

# Markdown Front Matter Requirements — `docs/` and `plan/`

Every Markdown file created under `docs/` or `plan/` **MUST** begin with a YAML front matter block. No exceptions.

## Required Schema

```yaml
---
title: "Human-readable title matching the first # heading"
type: "epic" | "milestone" | "session" | "roadmap" | "backlog" | "vision" | "strategy" | "northstar" | "architecture" | "reference" | "status" | "review" | "spec" | "guide"
status: "active" | "in-progress" | "completed" | "superseded" | "archived"
created: "YYYY-MM-DD"
updated: "YYYY-MM-DD"
owner: "Content Quality" | "Platform" | "Product" | "Engineering"
---
```

### Optional Fields (add when relevant)

```yaml
supersedes: "plan/path/to/old-file.md"      # this file replaces another
superseded_by: "plan/path/to/new-file.md"   # this file has been replaced
epic: "EPIC-01"                             # for session/spec files linked to an epic
milestone: "M2"                             # for files scoped to a milestone
```

---

## Field Rules

### `title`

- Must match the `# H1` heading exactly (same wording)
- Use title case; include the document ID prefix where applicable (e.g. `"EPIC-01: AI-Powered Content Ingestion"`)

### `type`

Choose the closest match:

| Value | Use for |
|-------|---------|
| `epic` | Top-level feature groupings in `plan/epics/` |
| `milestone` | Milestone definition files in `plan/milestones/` |
| `session` | Work session logs, CEO feedback, planning sessions |
| `roadmap` | Roadmap documents |
| `backlog` | Backlog files |
| `vision` | Vision, northstar, long-term direction |
| `strategy` | Strategy canvases, product strategy documents |
| `northstar` | Northstar-specific files (TAXONOMY, personas, etc.) |
| `architecture` | Technical architecture documents |
| `reference` | Reference material, dependency lists, external docs |
| `status` | Point-in-time status snapshots (PROJECT-STATUS, checklists) |
| `review` | Audits, usability reviews, security reviews |
| `spec` | Feature specification files (in `docs/specs/` or `plan/`) |
| `guide` | How-to guides and workflows |

### `status`

- `active` — living document, updated regularly
- `in-progress` — work is underway; not yet complete
- `completed` — the work or session it describes is done; content is stable
- `superseded` — replaced by a newer document; add `superseded_by` field and a banner (see below)
- `archived` — moved to an archive folder; do not update

### `created`

- Use the date in the filename if present (e.g. `2026-04-04-session.md` → `2026-04-04`)
- Otherwise use the earliest date mentioned in the document body
- Fallback: the date you are creating the file

### `updated`

- Set to today's date whenever you edit the file
- Do not back-date; do not leave stale

### `owner`

- Use the team or area most responsible for the content
- Prefer: `Product`, `Engineering`, `Content Quality`, `Platform`

---

## Supersession Banners

When `status: superseded`, add this block immediately after the front matter (before the `# H1`):

```markdown
> ⚠️ **SUPERSEDED** — This document has been replaced by [Title](../path/to/new.md). Do not use for active planning.
```

When `status: completed` (session notes, one-time reviews), add:

```markdown
> ✅ **COMPLETED** — This session/review is done. See current status in [PROJECT-STATUS.md](../PROJECT-STATUS.md).
```

---

## Examples

### Epic file

```yaml
---
title: "EPIC-02: Content Archive & Full-Text Search"
type: "epic"
status: "active"
created: "2026-04-24"
updated: "2026-04-24"
owner: "Content Quality"
---
```

### Session file

```yaml
---
title: "Product Strategy Pivot — 2026-04-04"
type: "session"
status: "completed"
created: "2026-04-04"
updated: "2026-04-24"
owner: "Product"
---
```

### Superseded planning file

```yaml
---
title: "EPIC-03: User Identity (Northstar)"
type: "epic"
status: "superseded"
created: "2026-01-01"
updated: "2026-04-24"
owner: "Engineering"
superseded_by: "plan/epics/EPIC-XX.md"
---

> ⚠️ **SUPERSEDED** — This document has been replaced by [EPIC-XX](../../epics/EPIC-XX.md). Do not use for active planning.
```

---

## Anti-Patterns

- ❌ Creating a file in `docs/` or `plan/` without any front matter
- ❌ `title` that doesn't match the `# H1` heading
- ❌ Leaving `updated` at the creation date after subsequent edits
- ❌ Using `status: active` on a file that has been fully superseded
- ❌ Using arbitrary `type` values not in the allowed list above
- ❌ Omitting `superseded_by` when `status: superseded`
