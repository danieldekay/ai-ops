---
name: end-session-hygiene
description: >
  Use when the user says end session, session hygiene, wrap up, close out,
  before we finish, or otherwise signals they are ending a work session.
  Runs a retro with behavior/thinking-flaw analysis that turns recurring
  flaws into permanent prevention (failure memory, skill patch, rule), not
  just a handoff note.
author: Daniel Kaesmayr
metadata:
  version: "1.3.0"
  category: meta
---

# End Session Hygiene

Six passes, in order. Never skip Pass 1 — even a short session produces
something worth keeping, or an explicit "nothing to keep".

Harness note: This skill runs on Pi, GitHub Copilot, Cursor, and OpenAI Codex.
Identify the active harness from the current environment. In Codex, you are
Codex, not Cursor; do not apply Cursor or Pi memory restrictions to Codex.

For Codex, a durable learning approved for retention is stored in two
complementary places: the canonical LLM Wiki holds evidence and detail; one
concise Codex memory note holds the actionable takeaway and wiki path. Create
Codex notes only after explicit user authorization, under
`~/.codex/memories/extensions/ad_hoc/notes/<timestamp>-<short-slug>.md`.
Never edit Codex registry, summary, raw-memory, rollout-summary, or skill files
directly. Do not duplicate narratives, retain transcripts, or store secrets.
For Pi, Copilot, or Cursor, follow that harness's own memory policy; Codex
keeps those stores read-only.

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

## Pass 2 — Retro + behavior analysis (2-4 minutes, no ceremony)

### Layer 1 — Retro light

Run a one-person sprint retro on how the session *went* — distinct from
Pass 1, which collects durable facts. Four boxes, answered from what the
agent actually observed and kept tight to a couple of entries each:

- 🟢 **Kept** — what felt smooth, productive, worth repeating (tool flows, pacing, context setup)
- 🔧 **Recalibrate** — friction that cost time: tooling, commands, context, process
- ✂️ **Stopped** — anything that plainly wasted time and should not repeat
- 🚀 **Next time** — one or two concrete adjustments to attempt in the next session

Keep it light: no separate retro document, no ceremony, timeboxed. If the
session was routine, "nothing worth noting" is a valid retro (skip to the
recurrence check with an explicit "no flaws observed").

### Layer 2 — Behavior & thinking-flaw analysis

For every 🔧 Recalibrate and ✂️ Stopped item (and any Pass 1 failure),
root-cause the agent's own behavior before proposing fixes. Ask three
questions per item:

1. **What thinking pattern produced this?** Name the flaw specifically, not
   the symptom. Common patterns: workaround-over-root-fix (patched around
   instead of fixing the source), assumed-environment (acted on an unverified
   assumption about tools/paths/auth), skipped-reading (edited or concluded
   without reading the thing first), premature-success (claimed done before
   evidence), one-attempt-then-workaround (didn't retry/re-read after an
   unexpected result), over-eager-tooling (reached for heavy tools where a
   plain one sufficed).
2. **Is it recurring?** Search the active harness's failure store
   (`memory_search` target=failure, plus project scope) for the flaw's
   keywords. A flaw the user already corrected once is a repeat offender —
   it MUST get a permanent mechanism, not a handoff note.
3. **What would have prevented it?** Match the flaw to one prevention
   mechanism:
   - **Failure memory** (category=correction/failure, with root cause) — makes
     the next session's memory search surface the lesson at trigger time.
   - **Skill patch** — add a pitfall, a procedure step, or a verification
     step to the skill that should have prevented the behavior.
   - **Rule in AGENTS.md / project instructions** — only for repo-wide
     conventions and only with explicit user approval (shared control plane,
     all harnesses read it).
   - **Handoff `Gotchas` line** — one-off, environment-specific; NOT for
     recurring flaws.

Be honest and specific — analyze the agent's own behavior, not Daniel's.
Don't invent flaws to fill the section: "no flaws observed" after a clean
session is a valid result, same as the light retro. Findings are PROPOSALS —
they go into the Pass 4 confirmation round, never auto-written.

### Routing rule

Retro items are no longer transient by default. Route each item:

- **Transient** (default for 🟢 and 🚀): handoff block `Retro (light)` section
  + session state only.
- **Permanent** (default for any flaw analysis finding, and for 🔧/✂️ items
  that are recurring or reveal a durable preference/procedure): propose the
  matching prevention mechanism above in Pass 4. When in doubt between
  transient and permanent, propose it as permanent and let the user strike
  it — losing a repeated lesson costs more than one extra memory entry.

Present the four boxes, the behavior-analysis findings, and the Pass 3
skill-health proposals inline with the Pass 4 proposal in the same
confirmation round and let the user edit them.

## Pass 3 — Skill health check

Did this session reveal that the skill library itself needs work? Check three things:

1. **New skill needed?** If a reusable procedure took repeated attempts, had non-obvious
   steps, or will recur, propose a skill at the canonical source; use global scope for
   portable practices and project scope for repo-bound ones.
2. **Existing skill to improve?** For every skill used—or missed when it should have
   applied—check whether it misled, missed a step, had stale facts, or failed to trigger.
   Propose a targeted patch to the canonical authored source, and update installed copies
   through `skill-management`.
3. **Overlay needed?** For a third-party/APM-installed skill, do not edit the dependency
   as authored IP. Propose an owned overlay that references it and adds Daniel's conventions.

If none apply, say "skill library is fine as-is." Propose each change as
`Skill | Action (new / patch / overlay) | Why` with the Pass 4 learning proposal. For large
authoring work, route to `skill-creator` / `compound-learnings`; this pass only proposes.

## Pass 4 — Learning routing (propose, then confirm)

For Codex, each durable learning approved for retention gets a detailed Wiki record and
one concise Codex memory note. Keep evidence and context in the Wiki; put only the
actionable takeaway and Wiki path in the note. Do not ask again if the user already
explicitly authorized these destinations in the active session.

Route each candidate learning with this table:

| Learning type | Destination |
| --- | --- |
| User preference / correction / profile fact | Active harness's own user-memory route. In Codex, Wiki context plus one concise approved Codex note. |
| Durable project fact / decision / convention | Project source-of-truth or project memory; in Codex, pair useful Wiki detail with a concise note pointer. |
| Global tool quirk / environment fact | Wiki detail plus a concise Codex note when it should shape future Codex work; other harnesses follow their owner policy. |
| Failure lesson | Active harness's approved failure store; in Codex, Wiki lesson plus concise note when reusable or actionable. |
| Reusable multi-step procedure | Author at the canonical skill source; deploy installed copies through `skill-management`. |
| Wiki-worthy insight / observation | `wiki_retro` (atomic insight) or `wiki_observe` (session observation). |
| Planning status change | The repo's live status doc (e.g. `plan/PROJECT-STATUS.md`). |
| Transient session state | Session layer only (`ctx_session` task/finding/decision) — never permanent memory. |
| Retro process note (transient) | Handoff block `Retro (light)` section + session state only. |
| Retro item revealing a durable preference/procedure | The matching row above. |
| Behavior/thinking flaw, first offense | Failure store of the active harness (`memory_add` target=failure, category=correction, root cause + prevention in the entry). |
| Behavior/thinking flaw, RECURRING (corrected before) | Failure store AND the stronger mechanism — skill patch at the canonical source or rule in AGENTS.md/project instructions (explicit approval required); say plainly that this is a repeat offense. |
| Prevention mechanism for a flaw | Skill patch (Pitfalls/Procedure/Verification) or AGENTS.md rule — never auto-write. |
| Nothing durable | Explicitly say "nothing to keep from this session". |

**Protocol (mandatory):**

1. Present the proposal as a table: `Learning | Destination | Why (one line)`.
   Include the Pass 2 retro boxes, the behavior-analysis findings with their
   prevention mechanisms, and Pass 3 skill-health proposals in the same round.
2. Wait for confirmation unless the user has already explicitly authorized the exact
   write and destinations in the active session. Preserve that authorization; do not ask again.
3. Apply all confirmed or already-authorized writes in one batch.
4. Route carefully, but do not repeat a confirmation round the user has already completed.

## Pass 5 — Open-work check

Determine whether work is still open:

- `git status --porcelain` — dirty tree or unpushed commits?
- Unfinished tasks: goal state, plan/TODO items, `bd ready --json` when beads are in play
- The user said the work continues in another session

If everything is clean and done → do the final checklist below and finish.
If work is open → continue to Pass 6.

## Pass 6 — Handoff (only when work is open)

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
4. ~~`ctx_handoff` `export`~~ — N/A.
5. Output the markdown block in chat. Only write it to a repo path when the user explicitly asks for a handoff file.

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

When no handoff is produced (work fully closed or nothing durable to write), the
retro's `🚀 Next time` items still belong in session state (`ctx_session` `save`)
or — if the user wants them for next time — as a chat note; nothing more.

Where to put a handoff: **default = output it in chat only.** Present the
structured block inline so the user can paste or read it. Do **not** create a
handoff file by default. Only write it to a repo path (e.g. `docs/handoffs/`
or the project's planning notes) when the user explicitly asks — then say
where it went and how the next session finds it.

Handoff rules (from `handoff`, kept because they are always right):

- Reference commits and file paths, not code — the receiver reads the diffs.
- "What remains" must be actionable NOW: no conditional timing ("only after X
  merges" is forbidden — give a path/SHA that works immediately or defer).
- Flag decisions made and pre-existing issues so they don't get re-litigated.
- Structured, not narrative. No walls of prose.

## Final checklist

- [ ] Durable Codex learning, when authorized, saved as Wiki evidence plus a concise Codex note with its Wiki path
- [ ] Retro light run; durable items routed, `🚀 Next time` items landed in handoff / session state
- [ ] Behavior analysis run: flaws root-caused, recurrence checked against failure memory, prevention mechanisms proposed and confirmed (or explicit "no flaws observed")
- [ ] Skill health check run and proposals resolved
- [ ] Handoff output in chat if work was open; written to a repo path only if the user asked
- [ ] Session state persisted (`ctx_session` `save` where available)
- [ ] No uncommitted changes you didn't tell the user about
- [ ] Closing report, one paragraph max: what was kept and where, plus how the
      next session resumes (ledger path / handoff block location / "nothing open")

## Pitfalls

- **Retro is a light, not a ceremony** — timebox it and don't invent items to
  fill the boxes; "nothing worth noting" is a valid retro.
- **Codex is not Cursor** — use the Codex note policy; keep other harness memories read-only.
- **Behavior analysis is honest, not theatrical** — name real flaws from what
  happened; no virtue-signaling self-critique, no inventing flaws, no dwelling.
  One specific named pattern beats a paragraph of remorse.
- **Recurring flaws must get permanent mechanisms** — if the failure store
  shows the same correction landed before, a handoff note is not enough;
  propose the skill patch or rule in the same round.
- **Don't write task progress, transcripts, or secrets into permanent memory** — session state belongs in the handoff/session layer.
- **Don't ask twice** — preserve explicit user authorization for the same write and destinations.
- **Skill-health proposals are proposals too** — write only after approval, and don't edit third-party skills in place; use an overlay.
- **Handoff is not a diary** — keep it structured and coordinates-first.
- **Import is additive** — when resuming a lean-ctx handoff, reconcile rather
  than replace (detail lives in `lean-ctx-handoff`).