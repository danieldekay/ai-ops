---
name: data-analysis-planner
description: 'Planning-only skill for data analysis projects. Use when starting any data analysis project, notebook workflow, R Markdown/Quarto analysis, Python analysis, statistical study, or AI-assisted analysis repo before writing analysis code. Produces a token-efficient PLAN.md, atomic analysis-unit structure, reproducible environment plan, idempotent setup/validation/bootstrap scripts, caching/provenance strategy, and handoff to specialist analysis skills. Triggers on planning data analysis, setting up analysis projects, structuring notebooks/Rmd files, avoiding giant notebooks, keeping calculation and interpretation together, saveRDS/cache/targets/provenance, or Copilot-friendly analysis workflows.'
argument-hint: '[analysis goal, data format/source, language preference, output type, reproducibility needs]'
---

# Data Analysis Planner

Use this skill before analysis begins. Its job is to design the project structure,
`PLAN.md`, and repeatable setup/validation/bootstrap scripts so a later specialist
skill can do the actual analysis with minimal context waste.

Keep the main answer planning-only. Do not fit models, clean data, make final figures, or write substantive analysis code here.

## Core Output

Produce or update these artifacts:

- `analysis-plan/PLAN.md` - the project contract.
- `analysis-plan/scripts/setup_env.[py|R]` - idempotent environment setup.
- `analysis-plan/scripts/validate_env.[py|R]` - package/runtime validation.
- `analysis-plan/scripts/bootstrap.[py|R]` - read-only data inspection.
- Optional `.github/copilot-instructions.md` - project briefing for AI-assisted analysis repos.

For R Markdown, Quarto, or notebook projects, the plan must also define atomic
analysis units: small files where calculation and interpretation live together,
with persisted intermediate outputs and provenance metadata.

## Context Budget Rule

Read only what you need:

- Read [script templates](./references/script-templates.md) only when generating setup, validation, or bootstrap scripts.
- Read [atomic analysis units](./references/atomic-analysis-units.md) when the user is planning R Markdown,
  Quarto, notebooks, reports, cached results, provenance, or Copilot-friendly analysis structure.
- Read [analysis handoff](./references/analysis-handoff.md) when selecting the specialist skill for Phase 5.

This keeps the skill cheap during early planning and loads details only at the moment they become useful.

## Planning Principles

- **Atomic analysis units**: Split the work into small files that each answer one analytical concern. Each unit should be readable in full by an AI agent.
- **Calculation beside interpretation**: Place result-producing chunks immediately next to the prose that interprets them. Prefer inline computed values over hardcoded numbers.
- **Aggregate upward**: Final reports should assemble completed units and cached results. They should not recompute heavy upstream work.
- **Persist intermediate results**: Save expensive or important outputs to `cache/` or pipeline storage so interpretation can be revised without rerunning the full analysis.
- **Track provenance**: Plan short hash stamps or sidecar metadata so the agent and human can see which data/code state produced an interpretation.
- **Scripts, not one-liners**: Repeatable actions belong in named scripts. Avoid giving the user paste-only shell snippets.
- **Idempotent by default**: Scripts check preconditions and are safe to rerun.
- **Locked environments**: Python uses `.venv` plus pinned requirements or `uv`. R uses `renv` and `renv.lock`.

## The 5-Phase Workflow

### Phase 1 - Plan

Create `analysis-plan/PLAN.md` from the template below. Interview the user only for missing critical details; otherwise extract answers from context.

Gather:

| Question | Why it matters |
| --- | --- |
| What is the research or analysis question? | Determines methods and outputs. |
| What is the data format, size, and source? | Determines I/O, memory, and validation strategy. |
| Python, R, Stata, or mixed? | Determines environment and scripts. |
| Target output: report, figure, table, model, dashboard? | Determines package needs and file structure. |
| Is reproducibility or auditability critical? | Determines lockfile strictness, cache metadata, and provenance. |
| Will an AI agent revise code or interpretation later? | Determines atomic-unit size and `.github/copilot-instructions.md`. |

For notebook/Rmd/Quarto projects, create an **Atomic Unit Map** before proposing files:

| Unit | Analytical concern | Inputs | Output artifact | Cache/provenance | Interpretation location |
| --- | --- | --- | --- | --- | --- |
| `01_cleaning` | Validate and clean raw data | `data/raw/*` | `cache/step01_clean.*` | sidecar metadata/hash | same unit file |
| `02_eda` | Describe key variables | cleaned data | figures/tables | cached figures/table data | same unit file |
| `03_model` | Estimate model | cleaned data | model object/table | model/data/code hash | same unit file |
| `04_results` | Summarize findings | cached outputs | report-ready sections | loaded metadata | same unit file |

### Phase 2 - Setup

Generate the environment setup script only after the plan is accepted. Use the language-specific template in `references/script-templates.md`.

For R analysis with atomic documents, include likely packages in the plan where appropriate:
`renv`, `rmarkdown` or `quarto`, `digest`, `jsonlite`, and optionally `targets`
for full pipeline automation.

### Phase 3 - Validate

Generate the validation script from `references/script-templates.md`. It should verify runtime version and required packages before any data is touched.

### Phase 4 - Bootstrap

Generate the bootstrap script from `references/script-templates.md`. It should load the input read-only and print shape, types, missingness, basic summaries, and a few example rows.

### Phase 5 - Analysis Skill Handoff

Recommend the specialist analysis skill or workflow. Do not start analysis in this skill. If no existing specialist fits, ask whether to adapt the closest skill or create a new one.

## Recommended Repository Structures

### R Markdown / Quarto Analysis

Use this when the user needs reports, inline interpretation, reproducible statistical analysis, or Copilot-friendly R work:

```text
project/
|-- .github/copilot-instructions.md
|-- data/
|   |-- raw/
|   `-- processed/
|-- cache/
|   |-- step01_clean.rds
|   |-- step01_clean_meta.json
|   |-- step02_model.rds
|   `-- step02_model_meta.json
|-- analysis/
|   |-- 01_cleaning.Rmd
|   |-- 02_eda.Rmd
|   |-- 03_model.Rmd
|   `-- 04_results.Rmd
|-- report.Rmd
|-- renv.lock
`-- analysis-plan/
```

Prefer Quarto (`.qmd`) when the user wants `freeze: auto`, multi-format publishing, or a cleaner project-level execution model. Keep the same atomic structure.

### Python Notebook Analysis

Use this when the user prefers notebooks:

```text
project/
|-- .github/copilot-instructions.md
|-- data/raw/
|-- data/processed/
|-- cache/
|-- notebooks/
|   |-- 01_cleaning.ipynb
|   |-- 02_eda.ipynb
|   |-- 03_model.ipynb
|   `-- 04_results.ipynb
|-- src/
|   `-- project_name/
|-- reports/
|-- requirements.txt or pyproject.toml
`-- analysis-plan/
```

Keep heavy reusable logic in `src/`; keep notebooks as atomic calculation-plus-interpretation units.

## PLAN.md Template

When producing Phase 1 output, save this structure to `analysis-plan/PLAN.md` and fill it with project-specific details:

```markdown
# Analysis Plan: [Project Name]

**Date**: [YYYY-MM-DD]
**Language**: [Python / R / Stata / mixed]
**Status**: Planning

## 1. Research Question

[Question and decision/use context.]

## 2. Data

| Property | Value |
| --- | --- |
| Source | |
| Format | |
| Size estimate | |
| Key variables | |
| Unit of observation | |
| Time period | |

## 3. Repository Structure

[Proposed folders and why they exist.]

## 4. Atomic Analysis Units

| Unit file | Concern | Inputs | Outputs/cache | Interpretation rule |
| --- | --- | --- | --- | --- |
| `analysis/01_...` | | | | calculation and prose adjacent |

## 5. Caching and Provenance

- Intermediate results: [saveRDS/readRDS, parquet, pickle/joblib, targets, etc.]
- Metadata: [sidecar JSON, digest hashes, target metadata]
- Staleness check: [how prose is tied to data/model/code state]

## 6. Expected Outputs

[Report, table, figure, model object, dashboard, etc.]

## Phase 2 - Environment Setup

- Script: `analysis-plan/scripts/setup_env.[py|R]`
- Package manager: [pip/uv | renv]
- Environment location: [.venv/ | renv/]
- Key packages:
  - [package - purpose]
- How to run: [script command]

## Phase 3 - Validation

- Script: `analysis-plan/scripts/validate_env.[py|R]`
- Checks:
  - [ ] Runtime version
  - [ ] Required packages importable

## Phase 4 - Bootstrap

- Script: `analysis-plan/scripts/bootstrap.[py|R]`
- Data path: [path/to/data]
- Read-only checks: shape, types, missingness, summary, sample rows

## Phase 5 - Analysis Skill

- Recommended skill/workflow: [name]
- Rationale: [why it fits]
- Handoff prompt: [what to ask the specialist skill next]

## Checklist

- [ ] Atomic unit map reviewed
- [ ] Setup script created
- [ ] Validation script created and passing
- [ ] Bootstrap script created and passing
- [ ] Cache/provenance strategy confirmed
- [ ] Specialist analysis skill selected
```

## Copilot Instructions Scaffold

When AI-assisted editing is part of the workflow, create or propose `.github/copilot-instructions.md`:

```markdown
# Project Context

This is a data analysis project on [topic].

## Structure

- `analysis/` or `notebooks/` contains atomic analysis units.
- Each unit keeps calculation and interpretation together.
- Intermediate results live in `cache/` with metadata where relevant.
- Final reports aggregate completed units and cached outputs.

## Conventions

- Prefer inline computed values over hardcoded result numbers.
- Do not modify cache files directly unless regenerating the owning unit.
- Keep each analysis unit small enough to review in one agent context.
- When changing data transformations or model formulas, update provenance metadata and nearby interpretation.
```

## Gotchas

- **Do not plan one giant notebook or Rmd.** It forces the agent to scan unrelated context and makes interpretation drift more likely.
- **Do not separate all prose into a final report too early.** Interpretation belongs beside the computation first; aggregate later.
- **Do not let `report.Rmd` or a final notebook recompute upstream work.** Load completed artifacts and metadata instead.
- **Do not rely only on `knitr cache=TRUE` for auditability.** It is convenient, but explicit saved outputs plus metadata are easier for agents and humans to inspect.
- **Do not hardcode statistical values in prose.** Use inline expressions or generated summary tables so revisions cannot silently become stale.

## What This Skill Does Not Do

- It does not run the analysis.
- It does not install packages directly.
- It does not modify raw data.
- It does not write final analysis scripts beyond setup, validation, and bootstrap scaffolds.

The finished handoff should leave the user with a clear plan, a token-efficient project
structure, reproducible setup scripts, and enough provenance design that future AI work
can focus on one atomic unit at a time.
