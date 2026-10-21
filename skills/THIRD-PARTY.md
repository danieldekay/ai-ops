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
| awesome-copilot instructions | `github/awesome-copilot/` | community instruction pack | agent-skills target |

## Project-scoped (declared in repo `apm.yml`, e.g. the ansible repo)

| Skill | Source | What it does |
|---|---|---|
| home-assistant-best-practices | `homeassistant-ai/skills/` | HA automation patterns, entity hygiene |
| home-assistant-manager | `komal-SkyNET/claude-skill-homeassistant/` | HA config ops over SSH/MCP |
| ansible-automation | `aj-geddes/useful-ai-prompts/skills/` | playbook/role templates |
| zigbee2mqtt | `szkocot/skills/` | Z2M converters, device pairing |
| avoid-ai-writing | `conorbronsdon/avoid-ai-writing/` | AI-ism detection/rewriting (vendored copy excluded from pre-commit) |

## Manually managed (liked, but source not yet APM-declared)

Tracked in the "Manually managed" section at the bottom of `~/.apm/apm.yml`:

| Skill | Source (probable) | Notes |
|---|---|---|
| skill-creator | `anthropics/skills` | heavy skill authoring/evals |
| agent-development | `anthropics/claude-code` | subagent frontmatter guidance |
| lean-ctx-handoff | local (machinery aspirational) | signed handoff — see end-session-hygiene note |
| find-skills, lesson-learned, compound-learnings, self-learning | TBD | source unconfirmed |
| clean-code, clean-architecture | TBD | Robert C. Martin derived |
| zettelkasten, zettelkasten-mcp | local/TBD | ZK knowledge management |

## Superseded / retired

| Skill | Source | Status |
|---|---|---|
| context-mode | `mksglu/context-mode/` | evaluated as superseded by lean-ctx (2026-10-18); archive copy in ansible repo only |

---

Rules recap: pull from source, pin in `apm.lock.yaml`, never hand-edit lockfiles,
audit new third-party skills with `skill-auditor` before first install.
