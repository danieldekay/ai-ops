---
name: thinking-navigator
description: Route to the right thinking/reasoning skill for any problem-analysis task. Use when you need structured analysis, first-principles decomposition, causal reasoning, systems thinking, design thinking, or critical evaluation — especially when default brainstorming isn't deep enough.
---

# Thinking Navigator

Routes to reasoning framework skills in `~/.skills-longtail/thinking/`. These are NOT loaded by default — install for the session, uninstall after.

## Available Skills

| Skill | Use When | Install |
|-------|----------|---------|
| `first-principles-thinking` | Challenge assumptions, break problem to fundamentals, find non-obvious solutions | `apm install -g danieldekay/ai-ops/skills/first-principles-thinking/` |
| `systems-thinking` | Multi-stakeholder dynamics, second-order effects, platform ecosystems, complex org problems | `apm install -g danieldekay/ai-ops/skills/systems-thinking/` |
| `causal-inference` | Planning interventions with observable outcomes, debugging failures, predicting "what happens if X" | `apm install -g danieldekay/ai-ops/skills/causal-inference/` |
| `hypothesis-generation` | Formulate testable hypotheses from observations, design experiments, explore competing explanations | `apm install -g danieldekay/ai-ops/skills/hypothesis-generation/` |
| `design-thinking` | Human-centered innovation, IDEO d.school 5-phase approach, workshop facilitation | `apm install -g danieldekay/ai-ops/skills/design-thinking/` |
| `critical-thinking-logical-reasoning` | Critically analyze written content (articles, blogs, reports) — NOT for code | `apm install -g danieldekay/ai-ops/skills/critical-thinking-logical-reasoning/` |
| `scientific-brainstorming` | Research ideation, interdisciplinary connections, methodology exploration | `apm install -g danieldekay/ai-ops/skills/scientific-brainstorming/` |
| `thinking-tools` | Structured agent self-reflection: validate collected info, stay on track, check completion | `apm install -g danieldekay/ai-ops/skills/thinking-tools/` |

## Session Prep Ritual

```bash
# Install before session
apm install -g danieldekay/ai-ops/skills/first-principles-thinking/

# Work...

# Uninstall after
apm uninstall -g first-principles-thinking
```

## Quick Decision

- "Break this problem down from scratch" → `first-principles-thinking`
- "Why is this system behaving unexpectedly" → `systems-thinking` or `causal-inference`
- "I need to design an experiment" → `hypothesis-generation`
- "Is this article/argument logically sound" → `critical-thinking-logical-reasoning`
- "Help me innovate for users" → `design-thinking`
