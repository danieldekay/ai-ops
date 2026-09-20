# ai-ops

A personal collection of AI agent skills, prompts, instructions, and agents for GitHub Copilot, Cursor, and OpenAI Codex.

> **Heads up:** This repo is primarily for my own use and experimentation.
> The skills here drive my personal agent workflows across all my projects — some are polished, some are rough drafts, and the structure evolves continuously.
>
> That said — if you stumble across something useful, you're very welcome to ⭐ star the repo, open an issue with thoughts, or raise a PR. Happy to hear what others find valuable.

## What's in here

Skills are on-demand workflow bundles — loaded when relevant, not always-on. Each skill lives in its own folder with a `SKILL.md` and optional `scripts/`, `references/`, or `templates/` assets.

The active skills here are part of a **global process/methodology layer** — things like `brainstorming` and the navigator skills (`thinking-navigator`, `research-navigator`, etc.) that route to domain-specific skills installed on-demand.

Domain skills (Django, WordPress, frontend, testing, marketing, science, etc.) live in a separate long-tail catalog and are installed per-session only. This keeps the always-loaded global footprint small.

## Structure

```
ai-ops/
├── _archive/       # Retired skills kept for revival — history preserved via git
│   └── skills/
├── agents/         # Custom agent definitions (.agent.md)
├── docs/           # Documentation and guides
├── instructions/   # Instruction files (.instructions.md)
├── prompts/        # Prompt files (.prompt.md)
├── refs/           # Reference documents
└── skills/         # Active agent skills (SKILL.md bundles)
```

## Active Skills

| Skill | Description |
|-------|-------------|
| [brainstorming](skills/brainstorming/) | Structured brainstorming before creative or feature work |
| [citation-management](skills/citation-management/) | Academic citation search, validation, and BibTeX generation |
| [cloudflare-dns](skills/cloudflare-dns/) | Cloudflare DNS management |
| [context-efficiency](skills/context-efficiency/) | Token-efficient context hygiene for AI sessions |
| [context-map](skills/context-map/) | Generate a relevant-file map before making changes |
| [copilot-control-plane-architecture](skills/copilot-control-plane-architecture/) | GitHub Copilot architecture guidance |
| [data-navigator](skills/data-navigator/) | Routes to data analysis and scientific computing skills |
| [deep-research](skills/deep-research/) | Comprehensive multi-source research with synthesis |
| [devops-navigator](skills/devops-navigator/) | Routes to DevOps, security, and infrastructure skills |
| [dk-flavored-spec-kit](skills/dk-flavored-spec-kit/) | Personalized spec-driven development workflow |
| [dk.v2.deep-research](skills/dk.v2.deep-research/) | Modular deep research pipeline v2 with parallel gather tracks |
| [frontend-navigator](skills/frontend-navigator/) | Routes to frontend, UI, and design system skills |
| [information-architecture](skills/information-architecture/) | IA design for clarity and discoverability |
| [lean-ctx-subagent](skills/lean-ctx-subagent/) | Dispatch subagents via lean-ctx coordination tools |
| [llm-wiki](skills/llm-wiki/) | Maintain an LLM-queryable project wiki |
| [project-planning](skills/project-planning/) | Project planning and task decomposition |
| [raindrop](skills/raindrop/) | Save and retrieve bookmarks via Raindrop.io |
| [refactor-plan](skills/refactor-plan/) | Plan multi-file refactors with impact analysis before coding |
| [research-navigator](skills/research-navigator/) | Routes to research and information-gathering skills |
| [skill-management](skills/skill-management/) | Manage AI agent skills across harnesses using APM |
| [testing-navigator](skills/testing-navigator/) | Routes to testing and quality assurance skills |
| [thinking-frameworks](skills/thinking-frameworks/) | Structured thinking patterns for agent self-reflection |
| [thinking-navigator](skills/thinking-navigator/) | Routes to reasoning and analytical thinking skills |
| [writing-navigator](skills/writing-navigator/) | Routes to writing and communication skills |
| [zettelkasten](skills/zettelkasten/) | Zettelkasten knowledge management workflow |
| [zettelkasten-mcp](skills/zettelkasten-mcp/) | Zettelkasten via MCP tools |
| [zettelkasten-orchestrator](skills/zettelkasten-orchestrator/) | Orchestrate Zettelkasten workflows at scale |

## Archived Skills

Skills in [`_archive/skills/`](_archive/skills/) are retired but preserved in git history for revival.

| Skill | Reason Archived |
|-------|----------------|
| [ai-assisted-workspace-setup](_archive/skills/ai-assisted-workspace-setup/) | One-time setup guide; now stale |
| [copilot-setup-coach](_archive/skills/copilot-setup-coach/) | One-time setup guide; now stale |
| [token-efficiency-audit](_archive/skills/token-efficiency-audit/) | Merged into `context-efficiency` |
| [wiki-builder](_archive/skills/wiki-builder/) | Superseded by `llm-wiki` |

## Installation via APM

```bash
# Install a skill globally
apm install -g danieldekay/ai-ops/skills/thinking-navigator/

# Install temporarily for a session, uninstall after
apm install -g danieldekay/ai-ops/skills/deep-research/
# ... work ...
apm uninstall -g deep-research
```

## License

MIT

## Structure

```
ai-ops/
├── agents/         # Custom agent definitions (.agent.md)
├── docs/           # Documentation and guides
├── instructions/   # Instruction files (.instructions.md)
├── prompts/        # Prompt files (.prompt.md)
├── refs/           # Reference documents
└── skills/         # Agent skills (SKILL.md bundles)
```

## Skills

Skills are on-demand workflow bundles — loaded when relevant, not always-on. Each skill lives in its own folder with a `SKILL.md` and optional `scripts/`, `references/`, or `templates/` assets.

| Skill | Description |
|-------|-------------|
| [1password-management](skills/1password-management/) | 1Password CLI and secrets management |
| [ai-assisted-workspace-setup](skills/ai-assisted-workspace-setup/) | AI-assisted workspace and project setup |
| [authentik-management](skills/authentik-management/) | Self-hosted Authentik deployment and operations via Ansible |
| [authentik-open-source](skills/authentik-open-source/) | Authentik OSS documentation-grounded configuration |
| [brainstorming](skills/brainstorming/) | Structured brainstorming before creative or feature work |
| [citation-management](skills/citation-management/) | Academic citation search, validation, and BibTeX generation |
| [cloudflare-dns](skills/cloudflare-dns/) | Cloudflare DNS management with Azure integration |
| [copilot-control-plane-architecture](skills/copilot-control-plane-architecture/) | GitHub Copilot control plane architecture guidance |
| [data-analysis-planner](skills/data-analysis-planner/) | Planning-only skill for data analysis projects — environment setup, software requirements, and 5-phase workflow plan before any analysis code is written |
| [deep-research](skills/deep-research/) | Multi-tiered deep research methodology from gathering to synthesis |
| [dk-flavored-spec-kit](skills/dk-flavored-spec-kit/) | Evidence-first spec-driven development philosophy and contracts |
| [limesurvey-survey-builder](skills/limesurvey-survey-builder/) | LimeSurvey markdown-first survey pipeline |
| [literature-review](skills/literature-review/) | Academic literature review using structured reading methods |
| [project-planning](skills/project-planning/) | Strategic project planning: vision, roadmap, epics, backlog |
| [raindrop](skills/raindrop/) | Bookmark management via Raindrop.io |
| [thinking-frameworks](skills/thinking-frameworks/) | Structured thinking patterns for agent self-reflection |
| [token-efficiency](skills/token-efficiency/) | Token-efficient patterns for context management |
| [using-superpowers](skills/using-superpowers/) | Entry point for discovering and using available skills |
| [writing-skills](skills/writing-skills/) | Creating and iterating on new SKILL.md files |
| [zettelkasten](skills/zettelkasten/) | Zettelkasten knowledge management workflow |
| [zettelkasten-orchestrator](skills/zettelkasten-orchestrator/) | Orchestration and maintenance for Zettelkasten systems |

## Installation

Skills are automatically discovered by compatible agent runtimes when this repository is cloned into a watched skills directory:

```bash
# For ~/.agents/skills (works with GitHub Copilot, Claude Code)
git clone https://github.com/danieldekay/ai-ops ~/.agents/skills/ai-ops

# Or clone directly and symlink individual skills
git clone https://github.com/danieldekay/ai-ops
```

## License

[MIT](LICENSE)
