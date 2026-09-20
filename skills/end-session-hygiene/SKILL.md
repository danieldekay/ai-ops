---
name: end-session-hygiene
description: >
  Daniel's personal end-of-session hygiene routine. Use when the user says
  "end session", "session hygiene", "wrap up", "close out the session",
  "end of session", "before we finish", or is clearly finishing a work
  session. Scans the session for learnings, proposes where each learning
  should live and gets confirmation before writing, and — when work is still
  open — creates a formalized handoff so the next session or agent can pick
  up cleanly. Also runs a lightweight retro (kept / recalibrate / stop /
  next time) so process learnings carry into the next session. References
  the existing `handoff` (structured block format) and `lean-ctx-handoff`
  (signed ledger machinery) skills for the handoff part.
author: Daniel Kaesmayr
metadata:
  version: "1.1.0"
  category: meta
---

# End Session Hygiene

Five passes, in order. Never skip Pass 1 — even a short session produces
something worth keeping, or an explicit "nothing to keep".

Harness note: this skill runs on pi, GitHub Copilot, Cursor, and Codex. Use
whichever memory/knowledge tools the active harness provides (pi:
`memory_add`/`memory_search`/`skill_manage`/wiki tools; lean-ctx-equipped
sessions: `ctx_knowledge`/`ctx_session`/`ctx_handoff`). The *routing logic*
below is harness-independent; only the tool names change.

## Pass 1 — Learning scan

Replay the session and collect candidate learnings:

- **Decisions** made and the rationale (especially "we chose A over B because…")
- **Corrections and preferences** the user revealed about themselves or how they work
- **Environment facts**: tool quirks, paths, versions, setup gotchas
- **Failures** and their root causes
- **Reusable procedures**: anything that needed more than one attempt or
  non-obvious steps to get working
- **Context the next session must not re-derive**: open questions, coordinates,
  fragile assumptions

Do not propose raw session logs or task progress as learnings — those belong
to the session/handoff layer, not permanent memory.

## Pass 2 — Retro light (2-3 minutes, no ceremony)

Run a one-person sprint retro on how the session *went* — distinct from
Pass 1, which collects durable facts. Four boxes, answered from what the
agent actually observed and kept tight to a couple of entries each:

- 🟢 **Kept** — what felt smooth, productive, worth repeating (tool flows, pacing, context setup)
- 🔧 **Recalibrate** — friction that cost time: tooling, commands, context, process
- ✂️ **Stopped** — anything that plainly wasted time and should not repeat
- 🚀 **Next time** — one or two concrete adjustments to attempt in the next session

Keep it light: no separate retro document, no ceremony, timeboxed. Present
the four boxes inline with the Pass 3 proposal in the same confirmation
round and let the user edit them. If the session was routine, "nothing worth
noting" is a valid retro.

Retro items are **transient by default** — they describe the process, not
durable facts. Only items that reveal a durable preference or reusable
procedure (e.g. "the browser-test harness keeps tripping me" → crib note or
project skill) cross over into Pass 3 routing; everything else lives in the
handoff block (`Retro (light)` section) and session state.

## Pass 3 — Learning routing (propose, then confirm)

Route each candidate learning with this table:

| Learning type | Destination |
| --- | --- |
| User preference / correction / profile fact | user memory (`memory_add` target=user) |
| Durable project fact / decision / convention | project memory (`memory_add` target=project) or `ctx_knowledge` remember |
| Global tool quirk / environment fact | global memory (`memory_add` target=memory) |
| Failure lesson | failure memory (`memory_add` target=failure, with category + reason) |
| Reusable multi-step procedure | new skill via `skill_manage` (global scope for portable, project scope for repo-bound) |
| Wiki-worthy insight / observation | `wiki_retro` (atomic insight) or `wiki_observe` (session observation) |
| Planning status change | the repo's live status doc (e.g. `plan/PROJECT-STATUS.md`) |
| Transient session state | session layer only (`ctx_session` task/finding/decision) — never permanent memory |
| Retro process note (transient) | handoff block `Retro (light)` section + session state only |
| Retro item revealing a durable preference/procedure | the matching row above (user/project/failure memory, or a skill) |
| Nothing durable | explicitly say "nothing to keep from this session" |

**Protocol (mandatory):**

1. Present the proposal as a table: `Learning | Destination | Why (one line)`.
   Include the Pass 2 retro boxes in the same confirmation round.
2. Wait for user confirmation or edits. Never auto-write without confirmation.
3. Apply all confirmed writes in one batch.
4. Wrong routing costs more later than a 30-second proposal round — do not skip
   the confirmation step "to save time".

## Pass 4 — Open-work check

Determine whether work is still open:

- `git status --porcelain` — dirty tree or unpushed commits?
- Unfinished tasks: goal state, plan/TODO items, `bd ready --json` when beads are in play
- The user said the work continues in another session

If everything is clean and done → do the final checklist below and finish.
If work is open → continue to Pass 5.

## Pass 5 — Handoff (only when work is open)

Two mechanisms are available. The lean-ctx signed-ledger machinery (`ctx_handoff`)
was documented by lean-ctx but is NOT INSTALLED: validated 2026-09-20 — the
`lean-ctx handoff` command does not exist (`lean-ctx --help` has no handoff
entry) and the MCP tool is absent. **Go straight to the markdown fallback.**
Session state still persists via tools that DO exist: `lean-ctx session
task|finding|decision` + `lean-ctx session save` (CLI, validated), and
durable facts via `ctx_knowledge` remember / `memory_add`.

~~Preferred — lean-ctx machinery~~ (NOT AVAILABLE — kept for reference; see the
`lean-ctx-handoff` skill, whose machinery is likewise aspirational):

1. `ctx_knowledge` `remember` the durable facts FIRST — they survive even if
   the bundle is lost.
2. `ctx_session` `task` / `decision` — current progress status + decision rationale.
3. ~~`ctx_read` + `ctx_handoff` `create`~~ — N/A, command does not exist.
4. ~~`ctx_handoff` `export`~~ — N/A; instead save the markdown block to a repo path.
5. Report the markdown handoff path so the next session can pick it up.

**Fallback — structured markdown block** (format from the `handoff` skill),
paste-ready for the next agent:

```
Branch: <branch-name>
Commits: <first-sha>..<last-sha>
Test Results:
- <targeted result>
- <expanded/full result>
What Was Done:
- <1-line summary per logical unit>
What Remains:
- <specific next steps — "finish the feature" is useless; name files, lines, patterns>
- <open questions or decisions needed>
Key Files (optional):
- <file>: <what changed and why>
Gotchas (optional):
- <anything non-obvious: test fixtures, env vars, patterns to follow>
Retro (light):
- 🟢 Kept: <what worked — worth repeating next session>
- 🔧 Recalibrate: <friction to reduce>
- ✂️ Stop: <waste to cut>
- 🚀 Next time: <concrete adjustments to try>
```

When no handoff is produced (work fully closed), the retro's `🚀 Next time`
items still belong in session state (`ctx_session` `save`) or — if the user
wants them for next time — as a chat note; nothing more.

Where to put a handoff: show it in the chat for the user to paste, and — when
the target is known — save it where the project keeps handoffs (e.g. a
`docs/handoffs/` or the project's planning notes), then say where it went.

Handoff rules (from `handoff`, kept because they are always right):

- Reference commits and file paths, not code — the receiver reads the diffs.
- "What remains" must be actionable NOW: no conditional timing ("only after X
  merges" is forbidden — give a path/SHA that works immediately or defer).
- Flag decisions made and pre-existing issues so they don't get re-litigated.
- Structured, not narrative. No walls of prose.

## Final checklist

- [ ] Learning proposal presented, confirmed, and written to destinations
- [ ] Retro light run; durable items routed, `🚀 Next time` items landed in handoff / session state
- [ ] Handoff created if work was open (markdown block saved to a repo path — `ctx_handoff` does NOT exist, validated 2026-09-20)
- [ ] Session state persisted (`ctx_session` `save` where available)
- [ ] No uncommitted changes you didn't tell the user about
- [ ] Closing report, one paragraph max: what was kept and where, plus how the
      next session resumes (ledger path / handoff block location / "nothing open")

## Pitfalls

- **Retro is a light, not a ceremony** — timebox it and don't invent items to
  fill the boxes; "nothing worth noting" is a valid retro.
- **Export before the session closes** — ~~`ctx_handoff` signing~~ N/A (machinery not installed); save the markdown block before finishing
- **Don't write task progress into permanent memory** — that is what the
  session and handoff layers are for.
- **Don't skip the proposal round** — confirmed routing beats fast wrong routing.
- **Handoff is not a diary** — keep it structured and coordinates-first.
- **Import is additive** — when resuming a lean-ctx handoff, reconcile rather
  than replace (detail lives in `lean-ctx-handoff`).