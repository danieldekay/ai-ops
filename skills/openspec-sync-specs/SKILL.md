---
name: "openspec-sync-specs"
description: "Merge OpenSpec delta specs into main specs with intelligent updates"
version: 1
created: "2026-05-13"
updated: "2026-05-13"
---
## When to Use
When syncing delta specs from a completed change to main OpenSpec specs. This handles creating new specs and intelligently updating existing ones without wholesale replacement.

## Procedure
1. **List available changes**: `openspec list --json` to see completed changes
2. **Identify delta specs**: Check `openspec/changes/{change-name}/specs/` for spec files
3. **Compare with main specs**: Read both delta and main spec files side-by-side
4. **For NEW specs**: Create the spec directory and file under `openspec/specs/{capability}/spec.md`
5. **For EXISTING specs**: 
   - Use ctx_read (full file read) before editing to ensure exact content match
   - Use ast-grep or precise edits to add new requirements/scenarios
   - Preserve existing content - only append/merge new items
6. **Verify**: Re-read both files to confirm the sync completed successfully

## Pitfalls
- Don't use grep output for edit old_string - always read full file first with ctx_read
- Edit tool format requires `edits: [{oldText, newText}]` structure
- Delta specs may modify existing capabilities (check for overlapping paths)
- Watch for typos in generated spec content that need manual fixes

## Verification
- `openspec validate` on affected specs
- Manual spot-check that new requirements are present and formatted correctly
- Verify no duplicate requirements were created