---
name: "lean-ctx-agents-upgrade"
description: "Upgrade any repo's AGENTS.md (or equivalent agent instruction file) with the canonical lean-ctx block: ctx_* tool preference, explicit ctx_share push/pull usage, ctx_session value= (not content=) gotcha, signed handoff routing, and the subagent CLI/project-root caveat. Use when a repo lacks lean-ctx guidance or its AGENTS.md name-drops ctx_share/ctx_session without usage instructions."
version: 2
created: "2026-09-10"
updated: "2026-09-10"
---
## When to Use

Use when a repository's AGENTS.md / CLAUDE.md / instructions.md needs the lean-ctx block added or corrected: no lean-ctx section, a name-drop of `ctx_share`/`ctx_session` without usage, or a `ctx_session content=` bug.

## Canonical Block (insert verbatim into AGENTS.md)

```markdown
## lean-ctx

Prefer lean-ctx MCP tools over native equivalents for token savings (reads → `ctx_read`, search → `ctx_search`, shell → `ctx_shell`, memory → `ctx_knowledge`/`ctx_session`, subagents → `ctx_agent`/`ctx_handoff`/`ctx_share`).

When agents share cached file context mid-session, use `ctx_share(action="push", paths="<file1,file2>", to_agent="<id>", message="<why>")` on the sender and `ctx_share(action="pull")` on the receiver. `ctx_share` moves cache refs (path+hash), not file bytes, and has no freshness guarantee — re-`ctx_read` changed files. For durable facts use the LLM wiki (`wiki_recall` / `wiki_observe` / `wiki_retro`) — `ctx_knowledge` is short-term only (session/feature-scoped notes, parallel-agent exchange). For signed serialized transfer use `ctx_handoff`. `ctx_session` writes use `value=` (NOT `content=`).

Subagent caveat: Pi subagents do **not** get the `ctx_*` MCP tools — instruct them to use the `lean-ctx` CLI and `cd` into the project root first (CLI writes bind to the daemon session root, not `cwd`).

Full guidance: @LEAN-CTX.md → Canonical: `/Users/danieldekay/Dokumente/2ndBrain/.llm-wiki/wiki/skills/lean-ctx-context-engineering.md`
```

Adapt only the last line's canonical wiki path to the machine; leave the rest repo-agnostic.

## Procedure

1. Read the repo's existing AGENTS.md (and any LEAN-CTX.md / harness adapters) to find the lean-ctx section or confirm it's missing.
2. Insert or replace the lean-ctx section with the Canonical Block. Keep it repo-agnostic; do not fold repo-specific rules into it.
3. If a LEAN-CTX.md exists, make it a reference-only pointer to the canonical wiki skill — do not vendor rules there.
4. Verify no `ctx_session(action=..., content=)` remains (grep -rn 'ctx_session.*content=').
5. Optionally run `ctx_rules sync` in the repo root, then grep again to confirm the `value=` form survived.

## Pitfalls

- `ctx_session` writes use `value=`, NOT `content=` — `content=` is only a valid alias on `ctx_knowledge(action=remember)`.
- Never run `lean-ctx knowledge consolidate` (or `--all`) after cleaning the knowledge store — it re-imports the session diary as new facts (measured 2026-09-27: 0 facts → 7 immediately). Leave lifecycle to decay; drive bulk removals via python subprocess from the JSON export.
- `ctx_share` moves cache-entry refs (path+hash), not file bytes, and has no freshness guarantee — re-read changed files.
- Pi subagents do NOT get `ctx_*` MCP tools; they must use the `lean-ctx` CLI and `cd` into the project root first (CLI writes bind to the daemon session root, not cwd).
- Do not instruct subagents to call `ctx_share`/`ctx_session` as MCP tools — give the CLI spelling.
- `rules.toml` is lean-ctx-generated; `ctx_rules sync` may regenerate it from an upstream template, so re-grep after sync.
- Keep the block a pointer to the canonical wiki, not a full rule copy — avoid drift.

## Verification

1. `grep -rn 'ctx_session.*content=' <repo>` returns nothing.
2. AGENTS.md contains the explicit `ctx_share` push/pull example and the `value=` note.
3. The subagent caveat (CLI + cd project root) is present.
4. The canonical wiki pointer is intact in LEAN-CTX.md.