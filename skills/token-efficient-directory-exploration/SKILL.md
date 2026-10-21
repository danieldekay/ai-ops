---
name: "token-efficient-directory-exploration"
description: "Navigate and analyze directory structures with compressed token contexts. Use when working with lean-ctx compressed outputs, exploring large codebases, or handling directory navigation that involves token compression."
version: 1
created: "2026-05-11"
updated: "2026-05-11"
---
## When to Use
- When exploring directory structures with lean-ctx compressed contexts
- When working with large codebases where token efficiency is important
- When navigating complex directory trees with compressed outputs

## Procedure
1. **Use lean-ctx tools**: Prefer lean_ctx_ctx_tree and lean_ctx_ctx_shell over basic bash commands
2. **Set appropriate depth**: Use depth parameter to control output size (default: 3)
3. **Handle compression**: Be aware that outputs are compressed (~13 tokens when unchanged)
4. **Navigate efficiently**: Use path parameter to focus on specific directories
5. **Interpret compressed output**: Read compressed outputs carefully for file counts and structure

## Pitfalls
- Compressed outputs may hide some file details
- Directory navigation errors can occur with certain commands
- Large directories may require multiple exploration steps
- Some commands may return "Is a directory" errors when expecting files

## Verification
- Directory structure is clearly visible
- File counts are accurate
- Navigation between directories works correctly
- Token efficiency is maintained during exploration