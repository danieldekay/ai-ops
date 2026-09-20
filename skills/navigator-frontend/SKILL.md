---
name: navigator-frontend
description: Route to the right frontend/UI skill for design systems, component frameworks, Stitch, or visual tooling. Use when building React/Svelte/shadcn UIs, working with Stitch design tool, setting up design tokens, or doing UX work.
---

# Navigator: Frontend

Routes to frontend skills in the `frontend` long-tail category.

## Install for a session

```bash
# Install all frontend skills (uninstall after session)
cd ~/.skills-longtail/frontend && apm install

# Uninstall when done
cd ~/.skills-longtail/frontend && apm uninstall
```

## Available Skill Clusters

### Design process
| Skill | Use When |
|-------|----------|
| `frontend-design` | High-quality production UI with named aesthetic philosophies |
| `design-brief` | Create a UI design brief via interview + codebase exploration |
| `design-review` | Structured design critique against brief |
| `design-tokens` | CSS variables / Tailwind config with light+dark palettes |
| `bencium-innovative-ux-designer` | Creative, production-grade UIs avoiding generic AI aesthetics |

### React / shadcn
| Skill | Use When |
|-------|----------|
| `react-components` | Convert Stitch designs → modular Vite + React components |
| `shadcn` | shadcn/ui component registry, presets, component search |
| `tailwind-v4-shadcn` | Tailwind CSS v4 + shadcn/ui setup, dark mode, @theme inline |

### Svelte
| Skill | Use When |
|-------|----------|
| `svelte5-best-practices` | Runes, snippets, SvelteKit, Svelte 4→5 migration |
| `svelte-components` | Writing Svelte 5 components with runes and shadcn-svelte |

### Stitch (Google Labs design tool)
| Skill | Use When |
|-------|----------|
| `stitch-design` | Unified entry for Stitch: prompt enhancement + screen generation |
| `generate-design` | Generate/edit screens with Stitch MCP |
| `extract-design-md` | Reverse-engineer design system from frontend source |

## Quick Decision

- Build new UI components → `frontend-design` + component framework skill
- React + shadcn project → `shadcn` + `tailwind-v4-shadcn`
- Svelte project → `svelte5-best-practices`
- Design system work → `design-tokens` + `design-system-patterns`
- Stitch design tool → `stitch-design`
