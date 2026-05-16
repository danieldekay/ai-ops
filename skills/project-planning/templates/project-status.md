# {{PROJECT_NAME}} Project Status

**Last Updated**: {{DATE}}
**Branch**: `{{CURRENT_BRANCH}}`
**Overall Health**: {{One phrase: e.g., "Building — foundation solid, expansion underway"}}

---

## How To Use This File

This is the **single source of truth** for project status. Read this first.

- **Feeling lost?** Read [Recommended Next Actions](#recommended-next-actions).
- **Want the big picture?** Read [Epic Status Map](#epic-status-map).
- **Want to implement something?** Pick from [Ready To Build](#ready-to-build).
- **Want to understand dependencies?** Read [Dependency Graph](#dependency-graph).

---

## Recommended Next Actions

| Priority | Action | Spec | Why Now |
|----------|--------|------|---------|
| **1** | {{Action}} | `specs/{{NNN}}/` | {{Reason}} |
| **2** | {{Action}} | `specs/{{NNN}}/` | {{Reason}} |
| **3** | {{Action}} | `specs/{{NNN}}/` | {{Reason}} |

---

## Epic Status Map

### EPIC-{{NN}}: {{Name}} — {{STATUS}}

> {{One-line epic description.}}

| Spec | Name | Status | Notes |
|------|------|--------|-------|
| {{NNN}} | {{Name}} | {{%}} | {{Notes}} |

<!-- Repeat for each epic -->

---

## Dependency Graph

```
{{ASCII art showing epic and spec dependencies}}

Example:
  EPIC-01 (Foundation)
    ↓
  EPIC-03 (Auth) ──→ EPIC-04 (Moderation)
    ↓                      ↓
  EPIC-05 (Entities) → EPIC-06 (Taxonomy)
```

---

## Ready To Build

Items with dependencies met, spec written, can start implementation:

| Spec | What | Level |
|------|------|-------|
| {{NNN}} | {{Description}} | L1 |

## Needs Specification First

Items that need a spec written before implementation:

| Spec | What | Missing |
|------|------|---------|
| {{NNN}} | {{Description}} | {{What's needed}} |

## Blocked

Items blocked by external dependencies:

| Spec | What | Blocked By |
|------|------|------------|
| {{NNN}} | {{Description}} | {{Blocker}} |

---

## Stats Snapshot

- **Total specs**: {{N}}
- **Complete**: {{N}} ({{%}})
- **In Progress**: {{N}}
- **Not Started**: {{N}}
- **Test count**: {{N}}
