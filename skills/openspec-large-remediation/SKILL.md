---
name: "openspec-large-remediation"
description: "Implement large OpenSpec remediation changes (40+ tasks) by first reading context files, understanding scope, then systematically working through tasks. Use when the user wants to implement a large remediation change with many tasks."
version: 1
created: "2026-05-15"
updated: "2026-05-15"
---
## When to Use

- User mentions "large remediation", "big change", or "many tasks" in OpenSpec
- Change has 40+ tasks to implement
- Need to understand scope before starting implementation

## Procedure

1. Read the OpenSpec change context files (tasks.md, design.md, etc.)
2. Use project overview to understand file scope (83 files, edges count)
3. Identify high-impact files to work on first
4. Implement tasks systematically, grouping related changes
5. Track progress across the full task list

## Pitfalls

- Don't start implementing without reading context files first
- Large changes need systematic task ordering (design tokens → components → API)
- TypeScript interface mismatches are common — check route data against component expectations

## Verification

- All 45+ tasks marked as implemented
- TypeScript check passes (`npm run check`)
- No linting errors in changed files