---
name: daniel-writer
description: Use when writing blog posts, articles, essays, or public-facing copy in Daniel's TangoVerse voice, especially for ghostwriting, “write like Daniel”, “use my voice”, community-platform analysis, federation topics, or files under content/blog/.
---

# Daniel Writer

## Overview

Ghostwrite in Daniel's voice: pragmatic, community-positioned, technically precise, and honest about trade-offs. The writing should sound like a community member explaining something to friends over coffee, not a vendor or outside expert.

Source note: `[[20251014T195836094257000.md]]`

## When to Use

- Writing TangoVerse blog posts or blog series.
- Drafting articles in Daniel's voice.
- Rewriting copy that sounds too corporate, abstract, or prescriptive.
- Explaining technical systems to a non-technical tango community.

Do not use this skill for generic marketing copy, corporate brand voice, or neutral documentation.

## Voice Rules

- Use `we` by default. Write from inside the community.
- Show authority through lived experience, concrete projects, and specific examples.
- Acknowledge at least one limitation, trade-off, or uncertainty before proposing a path.
- Use tentative language for experiments: `could`, `might`, `let's start with`, `we'll try`.
- Name real tools and systems when relevant: WordPress, Friendica, ActivityPub.
- Reference real time markers when useful: `2015-ish`, `since 2007`, `it's almost 2026`.

## Never Do This

- Do not claim authority through credentials.
- Do not use vendor language, hype, or triumphalist framing.
- Do not hide costs, losses, or uncertainty.
- Do not lecture with `you should` or prescribe a single correct answer.
- Do not use formal transitions like `Furthermore`, `Moreover`, or `In conclusion`.
- Do not use jargon without explanation.
- Do not present opinion, polemic, or emotion as fact without evidence.

## Emotional Architecture

- Paragraph level: empathy → evidence → empowerment.
- Article level: pain recognition → systemic evidence → mechanism explanation → collaborative action.
- Series level: validation → proof → understanding → agency.

Start with the reader's tension, validate it, explain the system, then give the reader some agency.

## Structure Rules

- Open with one of these moves: lived experience, historical context, community observation, or direct value plus honest obstacle.
- Include at least two structural devices in every substantial piece:
  - role-based breakdowns
  - comparison tables
  - numbered workflows
  - named walk-throughs
  - ASCII flow diagrams
  - evidence sandwiches
- Close with either `What would be a first starting point?` or an honest trade-offs section.
- Keep sections short. Break structure before a fourth dense paragraph.

For full post-type templates, use [structural-templates.md](./references/structural-templates.md).

## Sentence Craft

- Mix short and medium sentences. Do not stack long sentences.
- Use rhetorical pivots sparingly. In long-form or technical writing, prefer direct statements over repeated devices like `But is that the case?` or `Or so many think.`
- Use em dashes and parentheticals regularly but intentionally.
- Use bold sparingly for revelation, not decoration.
- Use question-based headers only when they genuinely clarify structure.
- Put the emotional payoff at the end of the section, not the start.

## Signature Moves

- Contextualize statistics in personal terms rather than leaving them abstract.
- A single rhetorical pivot can work in a short passage, but do not repeat signature moves across a long article.
- Frame calls to action as invitations, not demands.
- Humanize technical content in this order: analogy → specific example → technical detail → community benefit.

## Long-Form Technical Default

- In technical long-form pieces, clarity outranks voice tics.
- Prefer precise explanation, concrete architecture, and explicit trade-offs over stylistic repetition.
- If a rhetorical move does not improve understanding, cut it.
- Aim for one distinctive voice marker in a section, not one in every paragraph.

For deeper voice fingerprints, use [style-analysis.md](./references/style-analysis.md).

## Technical Essay Discipline

Rules for long-form technical pieces, distilled from a structured critique (2026-10-01) of "how-this-blog-gets-built":

- **Essay, not stack tour.** The reader cares about how the work is done, not every clever thing in the system. Aim for: principle → architectural choice → example. Tool → tool → principle is the failure mode.
- **A tool earns main text only if understanding it changes understanding of the system.** Everything else goes to a footnote, diagram, or its own post. Every proper noun is a cognitive tax.
- **Don't merely tell what the machine does — tell what decision was made and why.** Flat documentation is the flattest writing; choice plus argument is the distinctive mode.
- **State the durable principle before the names that implement it.** "The models keep changing. The architecture doesn't." Model names age; rules don't.
- **Don't feed the completion instinct.** Mention and move on; give readers credit. If a diagram just showed the sequence, don't narrate every node again.
- **State each point once.** Restating the thesis ("humans still decide") weakens it with repetition.
- **One metaphorical universe per piece.** workshop/foreman/crew/gate OR brains/elves — not both. Callbacks beat first-occurrence quirks; introduce a metaphor when it carries a point, not before.
- **No absolute claims about blast radius.** "The worst an agent can do is X" gets challenged. Say precisely what is configured: "Under this pipeline, an agent cannot publish without approval."
- **End on the intellectual question, not the stale engagement question.** "Does it read human?" is aging out; ask where authorship lies, or where the distinction breaks.
- **Respect asymmetry.** Neat explanatory sections in complete taxonomies read machine-produced; human essays tolerate lopsided sections. Over-optimizing texture is the danger, not roughness.

## Evidence Rules

- Every factual claim must be defensible with a source.
- Use `<!-- NEEDS SOURCE: ... -->` markers while drafting whenever a claim lacks evidence.
- Prefer inline attribution or a `## Sources` section over academic citation style.
- Reframe unsupported claims as personal experience or remove them.
- For articles with many factual claims, use the deep-research fact-check workflow before publishing.

## Quick Checklist

- Sounds like Daniel, not a marketer.
- Uses `we`, not outsider language.
- Includes at least one honest caveat.
- Uses concrete tools, examples, and community vocabulary.
- Has enough structure to stay readable.
- Ends with agency, invitation, or a realistic next step.
- Every factual claim is sourced or clearly framed as experience.
- Is this a guided tour of the stack or an essay about how the work is done? Cut until the principles are foreground.

## References

- [structural-templates.md](./references/structural-templates.md)
- [style-analysis.md](./references/style-analysis.md)
