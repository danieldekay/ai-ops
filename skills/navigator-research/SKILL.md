---
name: navigator-research
description: Route to the right research or information-gathering skill. Use when you need structured literature review, systematic web research, citation management, academic paper analysis, or data pipeline setup — beyond a simple web search.
---

# Navigator: Research

Routes to research skills in the `research` long-tail category.

## Install for a session

```bash
# Install all research skills (uninstall after session)
cd ~/.skills-longtail/research && apm install

# Uninstall when done
cd ~/.skills-longtail/research && apm uninstall
```

## Available Skills

| Skill | Use When |
|-------|----------|
| `deep-research` | Comprehensive multi-source research with citations and synthesis |
| `literature-review` | Systematic academic reading: AIC, Conceptual Synthesis Excel, memos |
| `citation-management` | BibTeX generation, Google Scholar/PubMed search, citation validation |
| `web-research` | Structured web research across multiple sources |
| `web-scraper` | Fetch and extract content from web pages as markdown |
| `perplexity-search` | AI-powered real-time web search via Perplexity/OpenRouter |
| `research-lookup` | Sonar Pro/Reasoning search for current papers and technical docs |
| `rss-reader` | Fetch and filter RSS/Atom feeds and Substack newsletters |
| `markitdown` | Convert PDF/DOCX/PPTX/audio/images to Markdown for analysis |
| `peer-review` | Systematic manuscript/grant peer review with methodology critique |
| `data-analysis-planner` | Plan full data analysis environment, phases, and scripts before coding |

> Note: `dk.v2.deep-research` is already in the global set and always available.

## Quick Decision

- Broad topic research with sources → `deep-research` (already global)
- Academic paper search → `literature-review` + `citation-management`
- Real-time web search → `perplexity-search`
- Extract content from URLs → `web-scraper`
- Convert a PDF/doc → `markitdown`
- Plan a data project → `data-analysis-planner`
