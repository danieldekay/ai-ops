# Wiki Page Types & Templates

Reference document for the `llm-wiki` skill. Load when creating or formatting wiki pages.

## Source Summary Page

One page per ingested source. Never edit raw sources — summarize them here.

```markdown
---
title: "<Source Title>"
type: source
wiki: "<topic-slug>"
created: YYYY-MM-DD
updated: YYYY-MM-DD
url: "https://..."          # or path: raw/filename.pdf
authors: ["Name"]
published: YYYY-MM-DD       # original publication date
sources: []
zk_notes: []               # ZK note IDs created during ingest
---

# <Source Title>

**Type:** Article / Paper / Video / Book / Podcast  
**Authors:** …  
**Published:** …  
**Link:** …

## Key Claims

- Claim 1 (direct or paraphrased, with page/timestamp if available)
- Claim 2
- …

## My Take

[2–4 sentences: what this adds to the wiki, what's surprising, what to question]

## Pages Updated

- [[Concept: X]] — added evidence for …
- [[Entity: Y]] — updated section on …

## Contradictions Flagged

- None / or: Contradicts [[Concept: Z]] on point …
```

---

## Entity Page

One page per named entity: person, organization, product, dataset, model, etc.

```markdown
---
title: "Entity: <Name>"
type: entity
wiki: "<topic-slug>"
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: ["source-slug-1"]
zk_notes: []
---

# <Name>

**Type:** Person / Organization / Product / Model / Dataset  
**Status:** Active / Historical / Unknown  
**First appeared in wiki:** [[source-<slug>]]

## What It Is

[1–3 sentences: definition and context]

## Key Facts

| Attribute | Value | Source |
|-----------|-------|--------|
| … | … | [[source-slug]] |

## Appearances in Sources

- [[source-slug-1]] — role or mention
- [[source-slug-2]] — …

## Relationships

- **Related to:** [[Entity: X]] (reason)
- **Opposes:** [[Entity: Y]] (reason)
- **Part of:** [[Concept: Z]]

## Open Questions

- [ ] …
```

---

## Concept Page

One page per idea, theme, method, or claim that recurs across sources.

```markdown
---
title: "Concept: <Name>"
type: concept
wiki: "<topic-slug>"
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: ["source-slug-1", "source-slug-2"]
zk_notes: []
confidence: low | medium | high
---

# <Concept Name>

## Definition

[1–3 sentences: what it means in the context of this wiki]

## Evidence

| Claim | Source | Strength |
|-------|--------|----------|
| … | [[source-slug]] | strong / moderate / weak |

> ⚠️ **Contradiction:** [[source-A]] says X; [[source-B]] says Y. Unresolved as of YYYY-MM-DD.

## Applications / Implications

- …

## Related Concepts

- [[Concept: X]] — extends this concept
- [[Concept: Y]] — contrasts

## Open Questions

- [ ] …
```

---

## Comparison Page

Side-by-side analysis of two or more entities or concepts.

```markdown
---
title: "Compare: <A> vs <B>"
type: comparison
wiki: "<topic-slug>"
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: ["source-slug-1"]
zk_notes: []
---

# <A> vs <B>

## Overview

[1–2 sentences: why compare these, what question this answers]

## Comparison Table

| Dimension | <A> | <B> |
|-----------|-----|-----|
| … | … | … |

## Verdict

[2–4 sentences: what the comparison reveals, caveats, confidence]

## Sources Used

- [[source-slug-1]]
- [[source-slug-2]]
```

---

## Q&A Page (Filed Answer)

Created when a query answer is worth preserving. Lives in `wiki/questions/`.

```markdown
---
title: "Q: <Question>"
type: qa
wiki: "<topic-slug>"
created: YYYY-MM-DD
sources: ["source-slug-1"]
zk_notes: []
---

# <Question>

**Asked:** YYYY-MM-DD  
**Confidence:** low | medium | high

## Answer

[Answer synthesized from wiki pages]

## Evidence Used

- [[source-slug-1]]: …
- [[Concept: X]]: …

## Gaps / Caveats

- …

## Related Questions

- [[Q: …]]
```

---

## Overview Page

The wiki's evolving thesis. Update after every 5–10 ingests.

```markdown
---
title: "Overview: <Topic>"
type: overview
wiki: "<topic-slug>"
created: YYYY-MM-DD
updated: YYYY-MM-DD
version: N
sources: []   # all sources are implicitly included
---

# <Topic> — Wiki Overview

**Version:** N | **Sources ingested:** N | **Last updated:** YYYY-MM-DD

## Current Thesis

[2–5 sentences: the synthesized position the wiki currently holds on the topic]

## Key Findings

1. …
2. …
3. …

## Key Entities

- [[Entity: X]] — …
- [[Entity: Y]] — …

## Key Concepts

- [[Concept: X]] — …
- [[Concept: Y]] — …

## Unresolved Contradictions

- …

## Open Questions

- [[Q: …]] — filed answer
- … — not yet answered (see `gaps.md`)

## Next Sources to Ingest

- …
```

---

## Gaps Page

Living record of what the wiki doesn't know yet.

```markdown
---
title: "Gaps"
type: gaps
wiki: "<topic-slug>"
updated: YYYY-MM-DD
---

# Knowledge Gaps

Questions the wiki cannot currently answer:

## Unanswered Questions

- [ ] … (added YYYY-MM-DD from [[source-slug]])

## Missing Sources

- [ ] … (suggested to fill gap: …)

## Thin Concepts

- [ ] [[Concept: X]] — only one source, needs more evidence

## Thin Entities

- [ ] [[Entity: Y]] — definition unclear
```
