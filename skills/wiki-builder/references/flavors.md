# Wiki Builder Flavor Reference

Each flavor defines default page types, a suggested `wiki.config.md` purpose statement, and the folder structure the agent should create under `wiki/`.

---

## `research`

**For**: Multi-paper literature reviews, technology landscapes, methodology surveys

**Default page types**:
- `wiki/concepts/` — core concepts and definitions
- `wiki/papers/` — one page per paper (AIC format or summary)
- `wiki/tools/` — tools, frameworks, libraries
- `wiki/people/` — key researchers/practitioners
- `wiki/timeline.md` — chronological developments
- `wiki/questions/` — filed Q&A

**Purpose template**: "A structured knowledge base covering the research landscape on [topic], organized for synthesis and gap identification."

---

## `paper`

**For**: Single-paper deep dives — methodology, claims, experiments, implications

**Default page types**:
- `wiki/abstract.md` — condensed abstract + key contribution
- `wiki/methodology.md` — methods, models, experimental setup
- `wiki/results.md` — findings, tables, figures interpretation
- `wiki/claims.md` — enumerated claims with evidence ratings
- `wiki/critiques.md` — limitations, open questions, counterarguments
- `wiki/questions/` — filed Q&A

**Purpose template**: "A deep analytical breakdown of [paper title] ([author], [year]), focused on reproducibility and critical evaluation."

---

## `domain`

**For**: Technology domains, methodologies, industry sectors

**Default page types**:
- `wiki/overview.md` — domain definition and scope
- `wiki/concepts/` — core terms and models
- `wiki/players/` — key organizations, tools, people
- `wiki/use-cases/` — applications and examples
- `wiki/landscape.md` — comparative overview of approaches
- `wiki/questions/` — filed Q&A

**Purpose template**: "A navigable reference on [domain], covering key concepts, players, and use cases."

---

## `product`

**For**: Software products, platforms, APIs

**Default page types**:
- `wiki/overview.md` — what it is, who made it
- `wiki/architecture.md` — technical structure
- `wiki/features/` — one page per key feature
- `wiki/integrations.md` — how it connects to other systems
- `wiki/tradeoffs.md` — strengths, limitations, alternatives
- `wiki/questions/` — filed Q&A

**Purpose template**: "A technical reference for [product], covering architecture, features, and integration patterns."

---

## `person`

**For**: Profiling researchers, practitioners, thought leaders

**Default page types**:
- `wiki/overview.md` — background, affiliation, focus areas
- `wiki/contributions/` — key works, papers, projects
- `wiki/ideas.md` — signature concepts and positions
- `wiki/interviews.md` — notable quotes and interview highlights
- `wiki/questions/` — filed Q&A

**Purpose template**: "A profile of [person]'s work, ideas, and contributions to [field]."

---

## `organization`

**For**: Companies, research labs, institutions

**Default page types**:
- `wiki/overview.md` — founding, mission, scale
- `wiki/products/` — key products and services
- `wiki/people/` — leadership, key researchers
- `wiki/research.md` — published research and open source
- `wiki/strategy.md` — inferred or stated strategic direction
- `wiki/questions/` — filed Q&A

**Purpose template**: "A knowledge base profiling [organization]'s activities, products, people, and strategic direction."

---

## `project`

**For**: Internal or external projects — decisions, architecture, history

**Default page types**:
- `wiki/overview.md` — goals, scope, stakeholders
- `wiki/decisions/` — ADR-style decision records
- `wiki/architecture.md` — technical design
- `wiki/meetings/` — key meeting summaries
- `wiki/open-issues.md` — unresolved questions and blockers
- `wiki/questions/` — filed Q&A

**Purpose template**: "A living reference for [project], capturing decisions, architecture, and open questions."

---

## Additional Flavors

Additional flavors for specialized use cases:

### `meeting-series`

**For**: Recurring meetings (board reviews, team standups, project syncs)

**Default page types**:
- `wiki/participants.md`
- `wiki/minutes/` — one page per session
- `wiki/decisions.md` — accumulated decision log
- `wiki/actions.md` — open action items
- `wiki/questions/` — filed Q&A

### `regulatory`

**For**: Compliance frameworks, standards, regulations

**Default page types**:
- `wiki/overview.md` — scope, applicability, enforcement
- `wiki/requirements/` — structured requirement breakdown
- `wiki/interpretations.md` — expert guidance and case law
- `wiki/checklist.md` — self-assessment checklist
- `wiki/questions/` — filed Q&A
