# Third-Party Skills — Curated List

Skills Daniel likes from other authors. These are **dependencies**, never vendored
here (see `skill-management`: never commit third-party skills into ai-ops as
authored IP). They are pulled at install time via APM from their upstream repos.

If a third-party skill needs Daniel-specific adjustments, write a small **overlay
skill** (owned, references the original) — existing examples in
`~/.pi/agent/pi-hermes-memory/skills/`.

## Global (user-scope, `~/.apm/apm.yml`)

| Skill | Source | What it does | Notes |
|---|---|---|---|
| systematic-debugging | `obra/superpowers/skills/` | root-cause debugging before fixing | workflow discipline |
| test-driven-development | `obra/superpowers/skills/` | red-green-refactor discipline | workflow discipline |
| verification-before-completion | `obra/superpowers/skills/` | evidence before success claims | workflow discipline |
| requesting-code-review | `obra/superpowers/skills/` | how to ask for review | workflow discipline |
| receiving-code-review | `obra/superpowers/skills/` | how to process review feedback | workflow discipline |
| writing-plans | `obra/superpowers/skills/` | multi-step task planning | workflow discipline |
| executing-plans | `obra/superpowers/skills/` | working through a plan batch-by-batch | workflow discipline |
| brainstorming | `obra/superpowers/skills/` | intent/requirements exploration before creative work | workflow discipline |
| using-superpowers | `obra/superpowers/skills/` | skill-first response ritual | workflow discipline |
| writing-skills | `obra/superpowers/skills/` | authoring/verifying skills themselves | meta |
| grill-me | `julianoczkowski/designer-skills/skills/` | adversarial questioning of assumptions | design |
| handoff | `marcusglee11/LifeOS/.claude/skills/` | structured handoff block format | used by end-session-hygiene |
| lean-ctx | `yvgude/lean-ctx/skills/` | context-engineering CLI/MCP usage | |
| skill-auditor | `useai-pro/openclaw-skills-security/skills/` | security audit before installing foreign skills | run before any new third-party install |
| agent-browser | `vercel-labs/agent-browser/` | browser automation CLI | cross-runtime |
| skill-creator | `anthropics/skills/skills/skill-creator/` | heavy skill authoring/evals/benchmarks | confirmed 2026-10-21, declared globally |
| clean-code | `jackjin1997/ClawForge/skills/clean-code/` | Robert C. Martin Clean Code principles | confirmed via frontmatter source line, declared globally |
| awesome-copilot instructions | `github/awesome-copilot/` | community instruction pack | agent-skills target |

## Project-scoped (declared in repo `apm.yml`, e.g. the ansible repo)

| Skill | Source | What it does |
|---|---|---|
| home-assistant-best-practices | `homeassistant-ai/skills/` | HA automation patterns, entity hygiene |
| home-assistant-manager | `komal-SkyNET/claude-skill-homeassistant/` | HA config ops over SSH/MCP |
| ansible-automation | `aj-geddes/useful-ai-prompts/skills/` | playbook/role templates |
| zigbee2mqtt | `szkocot/skills/` | Z2M converters, device pairing |
| avoid-ai-writing | `conorbronsdon/avoid-ai-writing/` | AI-ism detection/rewriting (vendored copy excluded from pre-commit) |

## Fleet-authored (no upstream found — GitHub search 2026-10-21)

These live only in `~/.agents/skills/` and were written by Daniel's agent fleet.
Source-confirmation pass found no matching upstream. **Next step: canonicalize
into `danieldekay/ai-ops/skills/`, then declare via APM** (same as the
navigators and end-session-hygiene were):

`agent-development` · `find-skills` · `lesson-learned` · `compound-learnings` ·
`self-learning` · `ontology` · `agentic-eval` · `debugging-strategies` ·
`uncle-bob-craft` · `lean-ctx-handoff` · `clean-architecture` (NOT in
ClawForge despite same pack style) · `zettelkasten` · `zettelkasten-mcp`
(documents the third-party `entanglr/zettelkasten-mcp` server, but the skill
itself is authored docs)

Also authored + already canonical in ai-ops: `zettelkasten-orchestrator`
(committed 2026-10, declared globally).

## Superseded / retired

| Skill | Source | Status |
|---|---|---|
| context-mode | `mksglu/context-mode/` | evaluated as superseded by lean-ctx (2026-10-18); archive copy in ansible repo only |

---

Rules recap: pull from source, pin in `apm.lock.yaml`, never hand-edit lockfiles,
audit new third-party skills with `skill-auditor` before first install.
