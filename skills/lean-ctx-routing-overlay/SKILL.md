---
name: lean-ctx-routing-overlay
description: Companion correction for lean-ctx when native file search or read tools are denied instead of auto-routing.
metadata:
  version: "1.0.0"
  overlay_of: "lean-ctx"
  # Base skill is a local vendor copy (e.g. ~/.cursor/skills/lean-ctx); this
  # overlay carries only our routing corrections, applied alongside the base.
---

# lean-ctx routing overlay

Load alongside `lean-ctx` when a native file search or read reports that it
was denied and directs the agent to a `ctx_*` tool.

## Correction

1. Prefer an advertised `ctx_*` tool when it is available.
2. If no `ctx_*` tool is exposed, use the installed CLI:
   - Search: `lean-ctx grep '<pattern>' <path>`
   - List: `lean-ctx ls <path>`
   - Read: `lean-ctx read <path>`
3. Use `lean-ctx -c '<command>'` only for terminal commands, tests, and
   diagnostics; do not replace dedicated editing tools.
4. Treat this fallback as environment routing, not permission to bypass a
   security or authorization denial.

## Verification

Retry one representative lookup through the selected fallback and confirm it
returns scoped workspace results.
