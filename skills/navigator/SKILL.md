---
name: navigator
description: >
  Route to the right skill for thinking/reasoning, testing, writing, research,
  devops/infrastructure, frontend/UI, or data analysis tasks. Use when a task
  needs a domain framework beyond default ability: structured analysis,
  first-principles or systems reasoning; Python/JS test suites, coverage, or
  flaky tests; blog, marketing copy, newsletters, taxonomy, or documentation;
  literature review, citation management, or systematic web research; Ansible,
  Authentik, Cloudflare, Home Assistant, VPS hardening, CI/CD, or security;
  React, Svelte, SvelteKit, shadcn, design tokens, or Stitch design work;
  statistical tests, scientific data, or publication-quality visualization.
  Triggers: any task that matches one of the seven routing domains below.
author: Daniel Kaesmayr
metadata:
  version: "2.0.0"
  category: meta
---

# Navigator

Single routing table for the seven skill domains. Identify the domain, install
its category for the session, load the matching skill, uninstall when done.

## When to Use

- **Thinking/reasoning** — structured analysis, first-principles decomposition,
  causal reasoning, systems thinking, design thinking, or critical evaluation;
  especially when default brainstorming isn't deep enough.
- **Testing** — Python/JS test suites, coverage, quality, or performance
  analysis; structuring tests, improving coverage, fixing flaky tests, or
  reviewing test code quality.
- **Writing** — blogs, marketing copy, internal communications, social content,
  newsletters, or documentation; when built-in writing ability isn't enough and
  you need domain-specific frameworks, tone, or structure.
- **Research** — structured literature review, systematic web research,
  citation management, academic paper analysis, or data pipeline setup; beyond
  a simple web search.
- **DevOps/infrastructure** — Ansible, Debian Linux, VPS hardening, Authentik
  SSO, Cloudflare DNS, Home Assistant, CI/CD, or security tooling.
- **Frontend/UI** — design systems, component frameworks, Stitch, or visual
  tooling; React/Svelte/shadcn UIs, design tokens, or UX work.
- **Data analysis** — quantitative analysis projects, scientific data formats,
  statistical tests, or publication-quality visualizations.

## How to Route

1. **Identify the domain** — match the task to one of the seven sections in the
   Routing Table below.
2. **Install the category** for the session:
   ```bash
   # Install all skills in the domain's long-tail category (uninstall after session)
   cd ~/.skills-longtail/$CATEGORY && apm install   # e.g. CATEGORY=thinking for the Thinking domain

   # Uninstall when done
   cd ~/.skills-longtail/$CATEGORY && apm uninstall
   ```
   The category per domain: thinking → `thinking`, testing → `testing`,
   writing → `writing`, research → `research`, devops → `devops-security`,
   frontend → `frontend`, data → `academia-science`.
3. **Load the matching skill** from that domain's table below.
4. **Uninstall** the category when the session is done.

Category-specific routing notes:

> Ansible-specific skills (`g12-ops`, `g12-server`, `home-assistant-manager`,
> `zigbee2mqtt`, `ansible-1password`) live in the ansible repo's `apm.yml` and
> are already loaded in that context.
> ctx-* operational tools (`ctx-doctor`, `ctx-stats`, etc.) are in the
> `devops-security` category — install only when diagnosing context-mode issues.
> `dk.v2.deep-research` is already in the global set and always available.

## Routing Table

### Thinking

Routes to reasoning framework skills in the `thinking` long-tail category.

| Skill | Use When |
|-------|----------|
| `first-principles-thinking` | Challenge assumptions, break to fundamentals, find non-obvious solutions |
| `systems-thinking` | Multi-stakeholder dynamics, second-order effects, complex org problems |
| `causal-inference` | Interventions with observable outcomes, debugging failures, "what happens if X" |
| `hypothesis-generation` | Formulate testable hypotheses, design experiments, explore competing explanations |
| `design-thinking` | Human-centered innovation, IDEO d.school 5-phase, workshop facilitation |
| `critical-thinking-logical-reasoning` | Critically analyze written content (articles, blogs) — NOT for code |
| `scientific-brainstorming` | Research ideation, interdisciplinary connections, methodology exploration |
| `thinking-tools` | Agent self-reflection: validate collected info, stay on task, check completion |

Quick Decision:

- Break a problem to fundamentals → `first-principles-thinking`
- Why is this system behaving unexpectedly → `systems-thinking` or `causal-inference`
- Design an experiment → `hypothesis-generation`
- Evaluate an argument's soundness → `critical-thinking-logical-reasoning`
- Innovate for users → `design-thinking`

### Testing

Routes to testing skills in the `testing` long-tail category.

| Skill | Use When |
|-------|----------|
| `pytest-testing` | TDD workflow, pytest fundamentals, CI integration |
| `pytest-patterns` | Fixtures, parametrization, mocking, test organization |
| `pytest-advanced` | Parallel execution, complex fixtures, markers |
| `pytest-coverage` | Coverage analysis, finding uncovered lines, reaching 100% |
| `pytest-optimizer` | Speed improvements, identifying flaky tests, suite health |
| `pytest-code-review` | Review test code: async patterns, fixtures, mocking |
| `playwright-best-practices` | E2E, component, API, accessibility, security browser tests |
| `agentic-eval` | LLM-as-judge, rubric-based eval, iterative improvement loops |
| `code-quality-review` | SvelteKit code smells, complexity audit, tech debt |

Quick Decision:

- Writing new Python tests → `pytest-patterns` or `pytest-testing`
- Improving an existing suite → `pytest-optimizer` or `pytest-coverage`
- E2E browser tests → `playwright-best-practices`
- Evaluating AI output quality → `agentic-eval`

### Writing

Routes to writing skills in the `writing` long-tail category.

| Skill | Use When |
|-------|----------|
| `blog-post` | Long-form blogs, tutorials, educational articles with SEO |
| `copywriting` | Homepage, landing pages, pricing, feature copy — persuasive and converting |
| `internal-comms` | Status reports, leadership updates, incident reports, FAQs |
| `professional-communication` | Developer email/messaging for technical vs. non-technical audiences |
| `communication-storytelling` | Turning analysis/data into narratives for executives or customers |
| `social-content` | LinkedIn posts, Twitter threads, content calendars, platform optimization |
| `newsletter-generation` | Curated digests, weekly roundups, editorial newsletters |
| `doc-coauthoring` | Collaborative workflow for specs, proposals, decision docs |
| `docx` | Create/edit Word documents with tracked changes and comments |
| `markdown-documentation` | READMEs, GitHub Flavored Markdown, documentation formatting |

Quick Decision:

- Marketing website copy → `copywriting`
- Blog or educational content → `blog-post`
- Email to stakeholders → `internal-comms` or `professional-communication`
- Social posts → `social-content`
- Technical spec document → `doc-coauthoring`

### Research

Routes to research skills in the `research` long-tail category.

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

Quick Decision:

- Broad topic research with sources → `deep-research` (already global)
- Academic paper search → `literature-review` + `citation-management`
- Real-time web search → `perplexity-search`
- Extract content from URLs → `web-scraper`
- Convert a PDF/doc → `markitdown`
- Plan a data project → `data-analysis-planner`

### DevOps

Routes to DevOps/security/ops skills in the `devops-security` long-tail category.

| Skill | Use When |
|-------|----------|
| `ansible-automation` | Ansible playbook/role templates, configuration management |
| `ansible-expert` | Expert-level Ansible patterns and best practices |
| `debian-linux-triage` | Triage Debian issues with apt, systemd, AppArmor |
| `secure-vps-setup` | Harden a Linux VPS (Hardening, Tailscale, Traefik, Crowdsec) |
| `vps-checkup` | Read-only VPS health/security/update audit |
| `authentik-management` | Self-hosted Authentik via Docker Compose, Traefik, backups |
| `authentik-open-source` | Authentik OSS blueprints, `.env` settings, upstream docs |
| `cloudflare-dns` | Cloudflare DNS management, API tokens, External-DNS |
| `github-project-automation` | GitHub Actions CI/CD, Dependabot, CodeQL, branch protection |
| `ci-cd-pipeline-patterns` | GitHub Actions workflows, deployment strategies, release management |
| `security-best-practices` | HTTPS, CORS, XSS, SQLi, CSRF, OWASP Top 10 |
| `mcp-builder` | Build MCP servers in Python (FastMCP) or TypeScript |
| `ctx-doctor` | Diagnose context-mode plugin issues |
| `ctx-stats` | Show context window token savings for this session |
| `ctx-upgrade` | Update context-mode from GitHub |

Quick Decision:

- Ansible infra work (non-G12) → `ansible-expert` or `ansible-automation`
- Harden or diagnose a VPS → `secure-vps-setup` or `vps-checkup`
- Authentik SSO setup → `authentik-management` or `authentik-open-source`
- GitHub Actions pipeline → `github-project-automation` or `ci-cd-pipeline-patterns`
- context-mode broken → `ctx-doctor` then `ctx-upgrade`

### Frontend

Routes to frontend skills in the `frontend` long-tail category.

#### Design process

| Skill | Use When |
|-------|----------|
| `frontend-design` | High-quality production UI with named aesthetic philosophies |
| `design-brief` | Create a UI design brief via interview + codebase exploration |
| `design-review` | Structured design critique against brief |
| `design-tokens` | CSS variables / Tailwind config with light+dark palettes |
| `bencium-innovative-ux-designer` | Creative, production-grade UIs avoiding generic AI aesthetics |

#### React / shadcn

| Skill | Use When |
|-------|----------|
| `react-components` | Convert Stitch designs → modular Vite + React components |
| `shadcn` | shadcn/ui component registry, presets, component search |
| `tailwind-v4-shadcn` | Tailwind CSS v4 + shadcn/ui setup, dark mode, @theme inline |

#### Svelte

| Skill | Use When |
|-------|----------|
| `svelte5-best-practices` | Runes, snippets, SvelteKit, Svelte 4→5 migration |
| `svelte-components` | Writing Svelte 5 components with runes and shadcn-svelte |

#### Stitch (Google Labs design tool)

| Skill | Use When |
|-------|----------|
| `stitch-design` | Unified entry for Stitch: prompt enhancement + screen generation |
| `generate-design` | Generate/edit screens with Stitch MCP |
| `extract-design-md` | Reverse-engineer design system from frontend source |

Quick Decision:

- Build new UI components → `frontend-design` + component framework skill
- React + shadcn project → `shadcn` + `tailwind-v4-shadcn`
- Svelte project → `svelte5-best-practices`
- Design system work → `design-tokens` + `design-system-patterns`
- Stitch design tool → `stitch-design`

### Data

Routes to data/science skills in the `academia-science` long-tail category.

| Skill | Use When |
|-------|----------|
| `data-analysis-planner` | Plan full data analysis: environment, phases, scripts — before writing code |
| `exploratory-data-analysis` | EDA on scientific files (200+ formats): structure, quality, metrics |
| `statistical-analysis` | Hypothesis tests, ANOVA, regression, Bayesian, power analysis |
| `statsmodels` | OLS, GLM, logistic, ARIMA, time series, AIC/BIC diagnostics |
| `scientific-visualization` | Publication figures with matplotlib/seaborn/plotly, colorblind-safe, PDF/EPS |
| `get-available-resources` | Detect CPU/GPU/memory before computationally intensive tasks |
| `scientific-writing` | IMRAD manuscripts, citations, CONSORT/STROBE/PRISMA reporting |
| `scientific-brainstorming` | Research ideation, interdisciplinary connections, methodology exploration |
| `research-grants` | NSF/NIH/DOE/DARPA proposals: significance, innovation, budget |
| `latex-posters` | Conference posters with beamerposter/tikzposter |

Quick Decision:

- Start a data project → `data-analysis-planner` first
- Inspect an unknown data file → `exploratory-data-analysis`
- Run stats tests → `statistical-analysis` (quick) or `statsmodels` (regression/time series)
- Plot results → `scientific-visualization`
- Write up results → `scientific-writing`
- Before intensive compute → `get-available-resources`
