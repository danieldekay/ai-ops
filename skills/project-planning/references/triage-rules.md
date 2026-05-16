# Work Item Triage Rules

Decision tree for classifying work into L1 (Spec), L2 (Task-Batch), or L3 (Quick-Fix).

## Decision Tree

```
Does the work introduce new domain entities or value objects?
  YES → L1 (Spec)
  NO  ↓

Does it change architecture boundaries or layer contracts?
  YES → L1 (Spec)
  NO  ↓

Does it require new database migrations with design decisions?
  YES → L1 (Spec)
  NO  ↓

Does it have 3+ user stories or complex acceptance criteria?
  YES → L1 (Spec)
  NO  ↓

Does it touch 3+ Clean Architecture layers?
  YES → L1 (Spec)
  NO  ↓

Does it need research or a technical spike first?
  YES → L1 (Spec)
  NO  ↓

Is it a single-file change with near-zero risk?
  YES → L3 (Quick-Fix)
  NO  ↓

Can it be done in < 30 minutes?
  YES → L3 (Quick-Fix)
  NO  ↓

Everything else → L2 (Task-Batch)
```

## L1: Full Spec

**Characteristics**:
- Multi-day effort spanning several sessions
- Cross-layer changes (domain + application + infrastructure + presentation)
- New domain concepts, entities, or value objects
- Complex acceptance criteria or edge cases
- Needs architectural research or technical spike

**Artifacts produced**: spec.md, plan.md, tasks.md (via speckit pipeline)

**Agent handoff**: `speckit.specify` → `speckit.plan` → `speckit.tasks` → `speckit.implement`

**Examples**:
- Adding organization profiles (new entity, new views, new tests)
- Implementing Authentik SSO (cross-cutting auth changes)
- Building a moderation queue (FSM, permissions, notifications)

## L2: Task-Batch

**Characteristics**:
- Clear, bounded scope describable in < 200 words
- No new domain concepts — builds on existing entities
- Fits in 1–3 coding sessions
- Tests can be added incrementally
- Changes are within 1–2 layers

**Artifacts produced**: Entry in `plan/BACKLOG.md` with acceptance criteria

**Agent handoff**: `spec-implementer` or direct coding

**Examples**:
- Adding rate limiting to registration endpoint
- Completing a missing phase of an existing spec
- Fixing a broken modal with Alpine.js
- Adding CI pipeline for integration tests
- Profile completion progress indicator

## L3: Quick-Fix

**Characteristics**:
- Single file change or config update
- Near-zero risk, no side effects
- < 30 minutes of work
- No new tests needed (or trivial one-liner test)

**Artifacts produced**: None. Just commit.

**Agent handoff**: Direct coding

**Examples**:
- Fixing a typo in a template
- Updating a Django setting (DEBUG, SECRET_KEY)
- Adding a missing CSS class
- Fixing a Pyright type annotation
- Bumping a dependency version

## Promotion and Demotion

**L2 → L1**: If complexity emerges during a task-batch (unexpected domain concepts, migration decisions), stop and create a spec. Move the item to "Needs Scoping" in BACKLOG.md.

**L1 → L2**: Rare. Indicates the spec was overscoped. Break the spec into smaller task-batches and close the spec as "superseded."

**L3 → L2**: If a "quick fix" turns out to need tests, multiple files, or design thinking, upgrade it to a task-batch with proper backlog entry.

## Backlog ID Conventions

| Prefix | Meaning | Priority |
|--------|---------|----------|
| `BLK-NNN` | Blocker — must fix before launch | Highest |
| `RDY-NNN` | Ready — dependencies met, can start | High |
| `SCP-NNN` | Needs scoping — requires planning first | Medium |
| `DEF-NNN` | Deferred — not now, future milestone | Low |
