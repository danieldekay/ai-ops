---
name: codebase-health-audit
description: >-
  Audit a codebase for dead code, code smells, defactoring candidates,
  oversized files, and complexity hotspots using lean-ctx advanced tools
  (ctx_smells, ctx_quality, ctx_callgraph, ctx_impact, ctx_dedup,
  ctx_optimize) plus AST/LSP verification. Triggers: "find dead code",
  "code smells", "complexity audit", "defactor", "too large files",
  "codebase health", "what can we delete", "over-engineered",
  "audit this codebase".
author: Daniel Kaesmayr
metadata:
  version: "1.0.0"
  category: dev
---

# Codebase Health Audit

Read-only audit pass over a codebase: dead code, code smells, defactoring
candidates, oversized files, duplication, and complexity hotspots — every
finding evidence-backed, nothing executed. The output feeds a human decision
(or the `refactor-plan` skill for multi-file follow-up work).

## Mandatory Toolchain

All lean-ctx tool references below are **live-verified against lean-ctx 3.11.4**.
Use MCP ctx_* tools when available; otherwise use the CLI (`lean-ctx smells`,
`lean-ctx quality`, …) at full parity.

| Tool | Verified usage | Purpose |
|------|----------------|---------|
| `ctx_smells` | `action=rules` → `action=scan` | 8 detectors: `dead_code`, `long_function`, `long_file`, `god_file`, `fan_out_skew`, `duplicate_definitions`, `untested_function`, `cyclomatic_complexity` |
| `ctx_quality` | `action=report` | Project health score, cognitive-complexity hotspots, quality-tax estimate |
| `ctx_callgraph` | `action=callers\|callees`, `symbol=…` | Who calls what — the dead-code verification gate |
| `ctx_impact` | `file=…` | Change/deletion blast radius |
| `ctx_graph` | `action=related` | Reverse-dep / related-file walk |
| `ctx_dedup` | `action=analyze` | Cross-file duplicated blocks + semantic duplicates |
| `ctx_optimize` | `action=review` (valid: `review, suggest, report, ladder, resolve, decide, fingerprint, policy-check`) | Over-engineering / defactoring candidates |
| `ctx_repomap` | — | PageRank symbol importance — protects critical nodes from false dead-code flags |
| `ctx_overview` / `ctx_compose` / `ctx_tree` | — | Orientation first |
| `ctx_read` | `mode=map`, `mode=signatures`, `mode=lines:N-M` | Structure reads without full-file reads |
| `ctx_refactor` | LSP-backed analyses | **Only** for rs/ts/tsx/js/py/go; errors otherwise |
| pi-lens | `ast_grep_search`, `lens_diagnostics (source=lsp)` | Structural patterns + compiler-level unused-symbol warnings |

Per-language linters where installed (run via `ctx_shell` for compressed
output): ruff/vulture (Python), knip/ts-prune/eslint-unused-imports
(TS/JS), cargo-udeps (Rust). These complement, never replace, the
lean-ctx verification gate.

**Excluded**: SymDex — dropped from the retrieval flow (2026-09-27
evaluation); do not route this workflow through it.

## When to Use
- "Find dead code" / "what can we delete" in a repo
- "Audit this codebase" — smells, complexity, oversized files
- "Defactor" — collapse over-abstraction, indirection layers with one caller
- Pre-refactor triage: decide *what* is worth refactoring before planning *how*
- Not for executing refactors — use `refactor-plan` for that

## Procedure

### Phase 0 — Ground rules
READ-ONLY audit. Never delete or edit during analysis. Every "dead" finding
must be independently verified (Phase 4) before it is reported as deletable.

### Phase 1 — Orient
`ctx_overview` (or `ctx_tree` + `ctx_compose` with the task) for project
shape; `ctx_repomap` for the PageRank-ranked symbol map — the top symbols
there are critical nodes you must NOT flag as dead.

### Phase 2 — Project health baseline
`ctx_quality action=report`. Record the score, over-threshold function
count, and the top hotspot list — these anchor the rest of the audit and
let a follow-up pass measure the delta after fixes.

### Phase 3 — Smell scan
`ctx_smells action=rules` first (see available detectors), then
`action=scan`. Large repos truncate scan output — rerun per-rule or
per-directory rather than assuming the printed count is the full list.

### Phase 4 — Dead-code verification (the gate)
Per finding, batch in codemode with `Promise.allSettled`:
1. `ctx_callgraph action=callers` on the symbol — zero real call sites required.
2. `ctx_search` regex for **string-based references**: getattr/dynamic
   dispatch, route/handler/CLI command tables, DI containers, template
   names, re-exports in `__init__`/`index` files.
3. Test-only usage: still a deletion candidate, but report separately
   (deleting it means deleting its tests too).

Confidence per finding: **high** = 0 callers + no string refs;
**low** = anything else.

### Phase 5 — Large/complex files
From `long_file`/`god_file` findings and ctx_quality hotspots, read
structure with `ctx_read mode=map` (deps + exports) and `mode=signatures` —
not full reads. For the worst functions, `mode=lines:N-M` or
`read_enclosing` to confirm the complexity is real (nested conditionals,
duplicated branches), not generated or config code.

### Phase 6 — Duplication + defactoring
`ctx_dedup action=analyze` for cross-file duplicated blocks;
`duplicate_definitions` rule for same-name symbols in multiple files;
`ctx_optimize action=review` for over-engineering candidates. Defactoring =
collapsing indirection layers with a single caller; verify each layer with
`ctx_callgraph action=callees` before proposing to inline.

### Phase 7 — Blast radius
For each proposed deletion/inline: `ctx_impact` on the file and
`ctx_graph action=related` for reverse deps. Anything touching a top
repomap node or a public API gets flagged high-risk → "verify manually",
never "safe to delete".

### Phase 8 — Language-native cross-checks
pi-lens `ast_grep_search` for structural patterns (empty catch, TODO-heavy
areas, unused imports); `lens_diagnostics source=lsp` for compiler-level
unused-symbol warnings; the per-language linters listed above.

### Phase 9 — Report
Group findings by category with: `file:line`, rule/evidence, caller count,
confidence (high/medium/low), one-line recommendation. End with a
prioritized action list: quick wins (high-confidence dead code) →
duplication merges → complexity refactors (→ `refactor-plan`). Include the
ctx_quality baseline score. Never execute the deletions in this pass.

## Pitfalls
- `dead_code` is reference-count based: it misses dynamic dispatch,
  reflection, string-keyed registration, monkey-patching. Phase 4 is
  mandatory — the scan alone is never sufficient evidence.
- Framework entry points (Django management commands, FastAPI endpoints,
  pytest fixtures, Ansible modules, script entrypoints) look "unreferenced"
  by design — exclude well-known entry-point conventions.
- The scan is index/cache-based: after recent edits, refresh the index
  (`ctx_index`) or findings may be stale.
- Test-only symbols are not project-dead — report separately.
- Never audit generated code, vendored deps, or migration snapshots — scope
  to source directories, respect .gitignore.
- `ctx_refactor` requires an LSP server and a recognized file extension
  (rs/ts/tsx/js/py/go); otherwise fall back to `ctx_callgraph` + manual analysis.
- Weight findings by module importance (`ctx_repomap`), not raw count — a
  low quality score on a small scripts/ directory is noise.

## Verification
- [ ] Every "safe to delete" finding has 0 callers from `ctx_callgraph` AND
      no string-based reference hits from `ctx_search`.
- [ ] Each finding carries a confidence tag and a blast-radius note;
      high-risk items marked "verify manually".
- [ ] Report includes the ctx_quality baseline score (delta measurable later).
- [ ] No files were modified during the audit.
