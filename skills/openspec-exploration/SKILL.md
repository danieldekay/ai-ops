---
name: "openspec-exploration"
description: "Explore OpenSpec changes directory to find and analyze changes with missing tasks or incomplete implementations. Use when investigating OpenSpec workflow issues, finding changes without tasks, or examining the openspec/changes directory structure."
version: 1
created: "2026-05-11"
updated: "2026-05-11"
---
## When to Use
- When user asks about OpenSpec changes, missing tasks, or incomplete implementations
- When investigating openspec/changes directory structure
- When finding changes that have "No tasks" status

## Procedure
1. **Navigate to changes directory**: `cd openspec/changes`
2. **List all changes**: Use `ls` to see available changes
3. **Examine specific changes**: Check directories that appear incomplete or have no tasks
4. **Look for patterns**: Identify changes that need task generation or implementation
5. **Document findings**: Note which changes are missing tasks vs fully implemented

## Pitfalls
- Some changes may legitimately have no tasks if they're just design specs
- Directory navigation errors with lean-ctx token compression
- Changes may be in different states (proposed, in-progress, completed)

## Verification
- Confirm changes can be accessed and examined
- Verify that directory structure matches expected OpenSpec format
- Check if tasks need to be generated for any changes