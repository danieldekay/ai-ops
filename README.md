# ai-ops

A personal collection of AI agent skills, prompts, instructions, and agents for GitHub Copilot, Claude Code, and compatible agent runtimes.

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
