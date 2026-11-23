---
name: frontend-navigator
description: Route to the right frontend/UI skill for design systems, component frameworks, Stitch, or visual tooling. Use when building React/Svelte/shadcn UIs, working with Stitch design tool, setting up design tokens, or doing UX work.
---

# Frontend Navigator

Routes to frontend skills in `~/.skills-longtail/frontend/`. Install for the session, uninstall after.

## Skill Clusters

### Design process
| Skill | Use When | Install |
|-------|----------|---------|
| `frontend-design` | High-quality production UI with named aesthetic philosophies | `apm install -g julianoczkowski/designer-skills/skills/frontend-design/` |
| `design-brief` | Create a UI design brief via interview + codebase exploration | `apm install -g julianoczkowski/designer-skills/skills/design-brief/` |
| `design-review` | Structured design critique against brief | `apm install -g julianoczkowski/designer-skills/skills/design-review/` |
| `design-tokens` | CSS variables / Tailwind config with light+dark palettes | `apm install -g julianoczkowski/designer-skills/skills/design-tokens/` |
| `bencium-innovative-ux-designer` | Creative, production-grade UIs avoiding generic AI aesthetics | `apm install -g danieldekay/ai-ops/skills/bencium-innovative-ux-designer/` |

### React / shadcn
| Skill | Use When | Install |
|-------|----------|---------|
| `react-components` | Convert Stitch designs → modular Vite + React components | `apm install -g danieldekay/ai-ops/skills/react-components/` |
| `shadcn` | shadcn/ui component registry, presets, component search | `apm install -g shadcn-ui/ui/skills/shadcn/` |
| `tailwind-v4-shadcn` | Tailwind CSS v4 + shadcn/ui setup, dark mode, @theme inline | `apm install -g secondsky/claude-skills/plugins/tailwind-v4-shadcn/` |

### Svelte
| Skill | Use When | Install |
|-------|----------|---------|
| `svelte5-best-practices` | Runes, snippets, SvelteKit, Svelte 4→5 migration | `apm install -g danieldekay/ai-ops/skills/svelte5-best-practices/` |
| `svelte-components` | Writing Svelte 5 components with runes and shadcn-svelte | `apm install -g danieldekay/ai-ops/skills/svelte-components/` |

### Stitch (Google Labs design tool) — installed via `apm install -g google-labs-code/stitch-skills/plugins/stitch-design/#<sha>`

| Skill | Use When |
|-------|----------|
| `generate-design` | Generate/edit screens with Stitch MCP (prompt enhancement pipeline included) |
| `code-to-design` | Turn running frontend code into Stitch designs |
| `extract-design-md` | Reverse-engineer design system from frontend source |
| `extract-static-html` | Extract static HTML from Stitch screens |
| `manage-design-system` | Manage Stitch design system tokens |
| `upload-to-stitch` | Upload designs/assets to Stitch |

Note (2026-10): the old catalog's single `stitch-design` skill does not exist upstream. Installed the whole `plugins/stitch-design/` package, pinned by SHA in `~/.apm/apm.yml`. `enhance-prompt` and related live in `plugins/stitch-utilities/` (not installed).

## Quick Decision

- Build new UI components → `frontend-design` + component framework skill
- React + shadcn project → `shadcn` + `tailwind-v4-shadcn`
- Svelte project → `svelte5-best-practices`
- Design system work → `design-tokens` + `design-system-patterns`
- Stitch design tool → `generate-design` (Stitch plugin, see frontend-navigator catalog)
