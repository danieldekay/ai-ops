---
name: project-planning
description: "Strategic project planning system for creating and maintaining planning artifacts. Use when creating or updating vision, roadmap, epics, backlog, project status dashboards, or milestone reviews. Use when breaking down large goals into actionable work. Use when triaging scope (L1 spec / L2 task-batch / L3 quick-fix). Templates live in this skill's templates/ directory. NOT for spec-kit artifacts (spec.md, plan.md, tasks.md) — those belong to speckit agents."
---

# Project Planning Skill

Strategic planning system that produces living planning documents. Covers everything ABOVE the spec level: vision, roadmap, epics, backlog, status dashboards, and milestone reviews.

## When To Use This Skill

- Creating a **new project's planning structure** from scratch
- Writing or updating a **vision**, **roadmap**, **epic**, **backlog**, or **status dashboard**
- Running a **milestone review** or checkpoint
- **Triaging work** into L1 (spec) / L2 (task-batch) / L3 (quick-fix)
- **Extracting deferred items** from specs into a centralized backlog

## When NOT To Use This Skill

- Writing spec.md, plan.md, tasks.md → use **speckit** agents
- Implementing code → use **spec-implementer** or direct coding
- Reviewing code → use **Code Review Agent**

## The Planning Hierarchy

```
VISION → EPICS → WORK ITEMS → EXECUTION
                    ↓ ↓ ↓
               L1  L2  L3
              Spec Batch Fix
```

Every piece of work enters the hierarchy and gets triaged by size before execution.

## Artifact Catalog

| Artifact | Template | When To Create | Update Frequency |
|----------|----------|----------------|------------------|
| **Planning Session** | `templates/planning-session.md` | **Every planner session** | Once (immutable snapshot) |
| Vision | `templates/vision.md` | Once per project | Rarely (strategy shifts) |
| Roadmap | `templates/roadmap.md` | Once per project | When priorities change |
| Epic | `templates/epic.md` | Per capability group (5–15 specs) | When epic scope changes |
| Project Status | `templates/project-status.md` | Once per project | After any spec work |
| Backlog | `templates/backlog.md` | Once per project | When completing or discovering items |
| Milestone Review | `templates/milestone-review.md` | At each milestone boundary | Once (snapshot) |

### Using Templates

1. Read the template from `templates/<name>.md`
2. Replace all `{{PLACEHOLDER}}` values with project-specific content
3. Write to the target location (see File Locations below)
4. Remove any template sections that don't apply

### Planning Session Artifacts (Mandatory)

Every planner session MUST produce a dated session artifact at:

```
plan/sessions/YYYY-MM-DD-<topic-slug>.md
```

Examples:

- `plan/sessions/2026-03-02-situation-assessment.md`
- `plan/sessions/2026-03-02-epic-05-breakdown.md`
- `plan/sessions/2026-03-02-backlog-extraction.md`

This creates a searchable history of planning decisions even when the main artifacts (ROADMAP, BACKLOG) are updated in-place.

## Work Item Triage (L1 / L2 / L3)

See `references/triage-rules.md` for the complete decision tree.

**Quick version**:

- **L1 Spec**: New domain entities, cross-layer changes, 3+ user stories → `speckit.specify`
- **L2 Task-Batch**: Clear scope, no new domain concepts, 1–3 sessions → entry in backlog
- **L3 Quick-Fix**: Single file, <30 min, near-zero risk → just do it

When uncertain, default to L2. You can promote to L1 if complexity emerges. L1 → L2 is rare and indicates overscoping.

## Backlog Management

### Extracting Deferred Items

To build or refresh a backlog:

1. Scan all `specs/*/future-improvements.md` files
2. Scan `plan/MVP-CHECKLIST.md` for open blockers
3. Check each spec for incomplete phases or user stories
4. Consolidate into `plan/BACKLOG.md` using the backlog template
5. Assign IDs: `BLK-NNN` (blocker), `RDY-NNN` (ready), `SCP-NNN` (needs scoping), `DEF-NNN` (deferred)
6. Assign effort level: L1, L2, or L3

### Prioritization Framework

1. **Blockers** — anything preventing other work
2. **Current branch** — finish before starting new
3. **Critical path** — items on the path to launch
4. **Multipliers** — features that unlock many others
5. **Quick wins** — high value, low effort
6. **Nice-to-haves** — someday/maybe

## Creating New Epics

Epics group 5–15 related specs into a coherent capability. Use `templates/epic.md`.

Rules:

- Every spec MUST belong to exactly one epic
- Epic names describe a **capability**, not a feature (e.g., "Entity Expansion" not "Add People")
- Include dependency links to other epics
- Track completion as aggregate of contained spec statuses

## Milestone Reviews

At milestone boundaries, create a review using `templates/milestone-review.md`:

1. What was planned vs. delivered
2. What slipped and why
3. Backlog items discovered during the milestone
4. Scope changes for the next milestone
5. Updated risk assessment

## File Locations

Planning artifacts live in `plan/`:

```
plan/
├── WORKFLOW.md              # How the planning system works (reference)
├── PROJECT-STATUS.md        # Spec-level dashboard
├── ROADMAP.md               # Milestones and execution lanes
├── BACKLOG.md               # Deferred work items
├── sessions/                # Dated per-session artifacts (one per planner run)
│   └── YYYY-MM-DD-*.md
├── northstar/
│   ├── VISION.md            # Strategic product truth
│   ├── TAXONOMY.md          # Domain model definitions
│   ├── epics/               # Epic definitions
│   │   ├── README.md        # Epic index
│   │   └── EPIC-NN-*.md     # Individual epics
│   ├── personas/            # User archetypes
│   └── references/          # Brand, migration docs
```
