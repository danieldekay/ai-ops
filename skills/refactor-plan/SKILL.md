---
name: refactor-plan
description: 'Create a concrete plan before starting a multi-file refactor using LeanCTX impact analysis + SymDex call-graph tracing. Use when the user asks to plan, sequence, scope, or safely execute a refactor across multiple files.'
author: Daniel Kaesmayr
metadata:
  version: "1.1.0"
  category: dev
---

# Refactor Plan

Create a detailed plan before making any code changes using **efficient tools first**.

> **Repo parameter:** substitute `<alias>` below with your repository's SymDex index alias (e.g. the repo name). The MCP server prefix (`mcp_symdex-mcp_*`) may vary per harness — keep the tool family, adjust the prefix to what your environment exposes.

## Mandatory Toolchain

**DO NOT** use raw `read_file`/`grep_search` for exploration. Use these in order:

### Primary: SymDex (preferred)

| Step | Tool | Purpose |
|------|------|---------|
| 1 | `mcp_symdex-mcp_build_context_pack(repo="<alias>", query="...")` | Broad evidence bundle |
| 2 | `mcp_symdex-mcp_get_callers(repo="<alias>", name="symbol")` | Who calls this? |
| 3 | `mcp_symdex-mcp_get_callees(repo="<alias>", name="symbol")` | What does this call? |
| 4 | `mcp_symdex-mcp_get_file_outline(repo="<alias>", file="path")` | File structure without full read |
| 5 | `mcp_symdex-mcp_search_symbols(repo="<alias>", query="name")` | Find symbol by name |
| 6 | `mcp_symdex-mcp_semantic_search(repo="<alias>", query="intent")` | Find code by meaning |
| 7 | `mcp_symdex-mcp_get_repo_stats(repo="<alias>")` | Repo-level metrics |
| 8 | `mcp_symdex-mcp_find_circular_deps(repo="<alias>")` | Detect circular dependencies |

### Alternative: LeanCTX (when SymDex unavailable or for AST-precise reads)

| Step | Tool | Purpose |
|------|------|---------|
| 1 | `ctx_compose task="..."` | Ranked files with inline symbols — replaces 3-5 tool calls |
| 2 | `ctx_read mode=signatures` | All fn/class/type sigs via tree-sitter AST |
| 3 | `ctx_read mode=map` | Deps + exports + API signatures (85-95% savings) |
| 4 | `ctx_callgraph action=callers` | Who calls this function (tree-sitter) |
| 5 | `ctx_callgraph action=callees` | What this function calls (tree-sitter) |
| 6 | `ctx_search action=symbol` | AST-precise symbol lookup |
| 7 | `ctx_search action=semantic` | BM25 search by meaning |
| 8 | `ctx_graph action=related` | BFS blast radius from a file |
| 9 | `ctx_graph action=impact` | Reverse dep analysis |
| 10 | `ctx_impact` | Deep change impact: trace dep chains + build graphs |
| 11 | `ctx_review action=review` | Full review: impact + callers + test discovery |
| 12 | `ctx_quality action=report` | Project health score + hotspots |

### Alternative: LeanCTX CLI (when MCP unavailable)

```bash
lean-ctx read <file> -m signatures    # AST signatures
lean-ctx read <file> -m map           # deps + exports
lean-ctx grep <pattern>               # compressed search
lean-ctx ls <dir>                     # compact tree
lean-ctx graph related <file>         # blast radius
lean-ctx graph impact <file>          # reverse deps
lean-ctx health                       # code health score
```

**Fallback**: If neither SymDex nor LeanCTX is available, use `grep_search` / `read_file` only for the specific files identified.

## Instructions

1. **Do not edit files while preparing the plan.**
2. **Build context pack** — `build_context_pack(repo="<alias>", query="{{task_description}}")` for broad evidence.
3. **Trace call graph** — For each symbol being refactored: `get_callers` + `get_callees` to find all affected code.
4. **Get file outlines** — `get_file_outline` for each affected file (not full reads).
5. **Check for circular deps** — `find_circular_deps(repo="<alias>")` to detect cycles.
6. **Identify affected files, ownership boundaries, dependencies, and likely hidden coupling** using call graph evidence.
7. **Plan changes in a safe sequence**: contracts/types first → implementations → callers → tests → cleanup.
8. **Include verification steps between phases** and a final validation command.
9. **Include rollback or recovery steps** for the riskiest phases.
10. **Output the complete plan** using the format below.
11. **Stop after the plan and ask for confirmation** before implementing.

If the request is too ambiguous to plan safely, ask concise clarifying questions instead of editing files.

## Output Format

```markdown
## Refactor Plan: [title]

### Current State
[Brief description of how things work now, with call graph evidence]

### Target State
[Brief description of how things will work after]

### Affected Files
| File | Change Type | Dependencies | Callers | Callees |
|------|-------------|--------------|---------|---------|
| path/to/file | modify/create/delete | blocks X, blocked by Y | N callers | calls M symbols |

### Blast Radius Analysis
- Total callers of primary symbols: [count from `get_callers`]
- Total callees of primary symbols: [count from `get_callees`]
- Circular dependencies: [from `find_circular_deps`]

### Execution Plan

#### Phase 1: Types and Interfaces
- [ ] Step 1.1: [action] in `path/to/file`
- [ ] Verify: [how to check it worked]

#### Phase 2: Implementation
- [ ] Step 2.1: [action] in `path/to/file`
- [ ] Verify: [how to check]

#### Phase 3: Callers
- [ ] Update all callers identified by `get_callers`
- [ ] Verify: run tests

#### Phase 4: Tests
- [ ] Step 4.1: Update tests in `path/to/test_file`
- [ ] Verify: run the project test suite (e.g. `pytest`)

#### Phase 5: Cleanup
- [ ] Remove deprecated code
- [ ] Update documentation

### Rollback Plan
If something fails:
1. [Step to undo]
2. [Step to undo]
```