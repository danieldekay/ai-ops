---
name: context-map
description: 'Generate a map of all files relevant to a task before making changes using SymDex + LeanCTX call-graph and AST tools'
author: Daniel Kaesmayr
metadata:
  version: "1.1.0"
  category: dev
---

# Context Map

Before implementing any changes, analyze the codebase and create a context map using **efficient tools first**.

> **Repo parameter:** substitute `<alias>` below with your repository's SymDex index alias (e.g. the repo name). The MCP server prefix (`mcp_symdex-mcp_*`) may vary per harness — keep the tool family, adjust the prefix to what your environment exposes.

## Mandatory Toolchain

**DO NOT** use raw `read_file`/`grep_search` for exploration. Use these in order:

### Primary: SymDex (preferred)

| Step | Tool | Purpose |
|------|------|---------|
| 1 | `mcp_symdex-mcp_build_context_pack(repo="<alias>", query="...")` | Broad evidence bundle — symbols, routes, tests, docs |
| 2 | `mcp_symdex-mcp_get_callers(repo="<alias>", name="symbol")` | Who calls this? |
| 3 | `mcp_symdex-mcp_get_callees(repo="<alias>", name="symbol")` | What does this call? |
| 4 | `mcp_symdex-mcp_get_file_outline(repo="<alias>", file="path")` | File structure without full read |
| 5 | `mcp_symdex-mcp_search_symbols(repo="<alias>", query="name")` | Find symbol by name |
| 6 | `mcp_symdex-mcp_semantic_search(repo="<alias>", query="intent")` | Find code by meaning |
| 7 | `mcp_symdex-mcp_search_routes(repo="<alias>", path_contains="/api/")` | Find HTTP endpoints |
| 8 | `mcp_symdex-mcp_get_repo_stats(repo="<alias>")` | Repo-level metrics |

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
| 11 | `ctx_routes` | Extract HTTP routes from web frameworks |
| 12 | `ctx_overview task="..."` | Multi-resolution project map |

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

## Task

{{task_description}}

## Instructions

1. **Build context pack** — `build_context_pack(repo="<alias>", query="{{task_description}}")` for broad evidence
2. **Trace call graph** — For each primary symbol: `get_callers` + `get_callees` to find dependencies
3. **Get file outlines** — `get_file_outline` for each affected file (not full reads)
4. **Find tests** — `search_symbols(query="test_<feature>")` or `search_text(query="def test_")`
5. **Find patterns** — `semantic_search(query="similar pattern")` for existing conventions
6. **Check index freshness** — `get_index_status(repo="<alias>")` if stale, re-index with `index_folder`

## Output Format

```markdown
## Context Map

### Files to Modify
| File | Purpose | Changes Needed | Callers | Callees |
|------|---------|----------------|---------|---------|
| path/to/file | description | what changes | X calls it | it calls Y |

### Dependencies (may need updates)
| File | Relationship | Call Graph Evidence |
|------|--------------|---------------------|
| path/to/dep | imports X from modified file | `get_calees` → symbol |

### Test Files
| Test | Coverage | Found via |
|------|----------|-----------|
| path/to/test | tests affected functionality | `search_symbols` |

### Reference Patterns
| File | Pattern | Found via |
|------|---------|-----------|
| path/to/similar | example to follow | `semantic_search` |

### Risk Assessment
- [ ] Breaking changes to public API (check `get_callers` count)
- [ ] Database migrations needed
- [ ] Configuration changes required
- [ ] High caller count → high blast radius
```

Do not proceed with implementation until this map is reviewed.