---
name: daniel-writer
description: MANDATORY for every write, rewrite, or edit of public-facing prose — blog posts, articles, essays, pages, drafts — even when not requested. Always pair with the humanizer tell pass (see the always-voice-humanize skill). Triggers: any content/blog prose work, ghostwriting, “write like Daniel”, “use my voice”, community-platform analysis, federation topics, voice review, “humanize this”.
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

## Narrative Architecture

From the Ecology-of-Tango coaching round (GPT-6 external review + fleet contrast, 2026-10-18). These sit ABOVE sentence craft: they are what a structural revision pass checks before any prose polish.

- **Experience before model.** The reader must experience the problem before theory names it. Opening paragraphs carry scene and tension only — zero framework words (maturity, density, network, curation, model). Theory enters later as the explanation of what the reader already felt, never as the subject of the opening. Test: can a reader with no theory vocabulary retell the opening as a story?
- **One controlling argument per essay.** One central claim, at most three supporting moves, one complication. Editing question: "If this paragraph disappeared, would the argument be less convincing — or would the piece just contain one fewer interesting idea?" Those are different outcomes; only the first justifies the paragraph. A second thesis is a second essay, not a section.
- **Metaphors need mechanisms.** For every load-bearing metaphor, state what changes, what stays constant, and what else could produce the same outcome. When the vivid line is causally wrong, fix the mechanism and keep the insight (real case: "the thirty possible dances move with them" — only the dancer moves; their compatible partners split across venues; the honest mechanism — split rooms destroy dances that would have happened — is stronger).
- **Organizer's voice beats analytical voice.** Where an argument rests on judgment, show the reasoning from inside ("When I look at an application, I am not only asking whether this person belongs — I am asking what their presence makes possible for others"), not the summarized conclusion. The summarized version is the failure mode of AI-drafted prose: elegantly connected conclusions that outrun the shown reasoning.
- **Research resolves one question at a time.** One theory, one specific question it answers, one implication for the scene. No citation trains; if two theories appear in one paragraph, a reader must infer why both matter — split them or cut one.
- **Endings return to the opening tension with what changed.** A narrower decisive claim beats a summarizing question. In a series, the closing reader-question must be distinct per post and escalate across the series — never the same "floor is yours" formula with a swapped noun.
- **Cut before adding.** Structural pass first: reverse-outline every paragraph in ~5 words, cut restated conclusions and reassurance qualifications, and only then polish lines. A piece mostly needs a better insight-to-exposition ratio, not more theory.

## Revision Fingerprint (learned from Daniel's Part 1 edits, 2026-10-18)

Distilled from Daniel's own revision pass over a writer-drafted post (the
 Ecology of Tango Part 1 rewrite). These are what he CHANGED, not what he
 praised — apply them as the default direction of any Daniel-voice revision.

**Structural:**
- **Dissolve the self-attack, don't compress it.** A dedicated objections/
  self-criticism section is writer furniture. Move each objection to where it
  improves a claim (subjectivity guard → right after the opening question;
  not-a-ranking caveats → the list after the model). Delete the section
  header. What survives as apparatus goes into a **PS:** section after the
  essay — evidence/claims tables are postscript material, and methodological
  prose ("the falsifiable version is...") gets cut entirely.
- **Series furniture is cuttable.** The Part N bridge and the floor-is-yours
  closer are optional. If the ending already carries content, Daniel may cut
  both — don't re-add them reflexively; ask if the series needs the thread.
- **Blocks over packed prose.** Convert dense multi-point paragraphs into a
  short lead line + bullets ("Three things these levels are not." → three
  bullets). Tables get an explicit number/level column. Levels/states get
  their own `###` subsection with a quotable name ("Level 4: Abundant
  choice").
- One move per paragraph; split paragraphs that carry two ideas.

**Voice moves:**
- **Hedge rituals → owned assertions.** "A hypothesis, not a measuring
  instrument." → "(My working model: yes, X matters)" — take the position,
  label it in parentheses, bold the load-bearing word.
- **Strip meta-discourse, keep the claim." "One guard before the ladder,
  because it would be easy to build the wrong thing: ..." → "Of course, this
  can be highly subjective: ...". No stage directions about what the reader
  is about to learn.
- **Name the model as personal construction**: "The model in my head tries
  to read ..." — plain speech about one's own thinking.
- **Metaphors → visible mechanisms.** "The room assembles itself from the
  thread" → "because some go, the others also come." Causality in plain
  sight beats personification.
- **Sharpen what a sentence counts.** "We count dancers." → "We count dancers
  we want to dance with." Make the object of the claim concrete.
- **Self-dialogue blockquotes** as a device: `> Yes: "Number of dancers" is
  the wrong variable` — answering the reader's implied objection before
  continuing.
- **Quotes around dramatized speech**: "a healthy evening", "the room was
  empty" — quotation marks mark positions being played.
- **Bold the numbers that carry the scene** ("**seventy** active dancers,
  **thirty-five** showed up, **four** of those seventy").
- **Casual parentheticals for asides and promissory notes**: "(and this is
  food for another blog post to come)", "Oh, we could go in more detail: ..."
  — thinking allowed to stay visible, unpolished.
- **Translate imported theory into tango-native phrasing**: not "looser ties
  bridge between clusters" but "the dancers who move between groups and
  carry the energy with them".
- **Typography**: `_underscores_` for italics (not `*asterisks*`), smart
  quotes, ` --- ` spaced dashes in body prose.
- **Bounded claims beat absolute ones** (2026-10-18, third coaching round):
  "something we tend to overlook" outperformed "every argument falls apart
  here" — the observation is already provocative, so the claim doesn't need
  the exaggeration. Same for false oppositions: "Two things MAY make that
  trust more reliable than headcount alone", not "neither is headcount".
  When a device is right but its instance is redundant (an owned assertion
  the essay already demonstrates), cut the instance, keep the device.
- **Stopping rule**: an essay is not an exhaustive model specification. Three
  central claims, everything else supporting material; the essay can stop
  when those are established. Perfection-chasing via qualifications,
  corrections and model refinement is the failure mode of a LATE revision —
  the opposite of the overload failure of an early one. Declare the draft
  finished rather than resolving every theoretical issue.

## Evidence Rules

- Every factual claim must be defensible with a source.
- **Named-quote rule (2026-10-18, Daniel):** never quote or paraphrase a person BY NAME unless the wording is verbatim in a published, verified source. Personal communications, remembered lines, and conversation material stay UNATTRIBUTED — use "a professional dancer once put it..." or describe the observation without the quote. This covers even well-known community figures Daniel knows personally (case: a Toumanova line remembered from conversation was nearly attributed to her in print; personal ≠ publishable attribution).
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
