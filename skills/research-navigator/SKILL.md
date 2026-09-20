---
name: research-navigator
description: Route to the right research or information-gathering skill. Use when you need structured literature review, systematic web research, citation management, academic paper analysis, or data pipeline setup — beyond a simple web search.
---

# Research Navigator

Routes to research skills in `~/.skills-longtail/research/`. Install for the session, uninstall after.

## Available Skills

| Skill | Use When | Install |
|-------|----------|---------|
| `deep-research` | Comprehensive multi-source research with citations and synthesis | `apm install -g danieldekay/ai-ops/skills/deep-research/` |
| `dk.v2.deep-research` | Modular research pipeline v2 with parallel gather + quality gates | `apm install -g danieldekay/ai-ops/skills/dk.v2.deep-research/` |
| `literature-review` | Systematic academic reading: AIC, Conceptual Synthesis Excel, memos | `apm install -g danieldekay/ai-ops/skills/literature-review/` |
| `citation-management` | BibTeX generation, Google Scholar/PubMed search, citation validation | `apm install -g danieldekay/ai-ops/skills/citation-management/` |
| `web-research` | Structured web research across multiple sources | `apm install -g danieldekay/ai-ops/skills/web-research/` |
| `web-scraper` | Fetch and extract content from web pages as markdown | `apm install -g zephyrwang6/myskill/skills/web-scraper/` |
| `perplexity-search` | AI-powered real-time web search via Perplexity/OpenRouter | `apm install -g danieldekay/ai-ops/skills/perplexity-search/` |
| `research-lookup` | Sonar Pro/Reasoning search for current papers and technical docs | `apm install -g danieldekay/ai-ops/skills/research-lookup/` |
| `rss-reader` | Fetch and filter RSS/Atom feeds and Substack newsletters | `apm install -g danieldekay/ai-ops/skills/rss-reader/` |
| `markitdown` | Convert PDF/DOCX/PPTX/audio/images to Markdown for analysis | `apm install -g danieldekay/ai-ops/skills/markitdown/` |
| `peer-review` | Systematic manuscript/grant peer review with methodology critique | `apm install -g danieldekay/ai-ops/skills/peer-review/` |
| `data-analysis-planner` | Plan full data analysis environment, phases, and scripts before coding | `apm install -g danieldekay/ai-ops/skills/data-analysis-planner/` |

## Quick Decision

- Broad topic research with sources → `deep-research` or `dk.v2.deep-research` (already global)
- Academic paper search → `literature-review` + `citation-management`
- Real-time web search → `perplexity-search`
- Extract content from URLs → `web-scraper`
- Convert a PDF/doc → `markitdown`
- Plan a data project → `data-analysis-planner`
