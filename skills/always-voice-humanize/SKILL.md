---
name: always-voice-humanize
description: >-
  MANDATORY for all public-facing prose: every write, rewrite, or edit of blog
  posts, articles, essays, pages, or drafts must run the daniel-writer voice
  pass and the humanizer tell pass — even when not requested. Triggers: any
  content/blog prose work, "write like Daniel", "use my voice", drafting or
  editing any post, voice review, "humanize this". Not for code, commit
  messages, or internal docs.
version: 1
created: "2026-10-05"
updated: "2026-10-05"
---

# Always Voice + Humanize

Two mandatory passes for Daniel's public-facing prose. Run on every write,
rewrite, or edit of blog posts, articles, essays, pages, or drafts — **even
when the user did not ask for a voice check**.

## When to Use

Every time public-facing prose is created or edited: blog posts, articles,
essays, pages, newsletter copy, post rewrites — including rewrites the user
did not ask to be voice-checked.

Exempts: code, commit messages, internal documentation, chat replies.

**Pipeline position:** drafting + editing phase — voice/tells passes on all public prose — canonical flow: `~/Dokumente/webseiten/danieldekay.org/docs/lifecycle.md`. Sibling skills: danieldekay-typography-formatting (typography), blog-crossref-related-posts (crosslinking), blog-publish-scheduling (publish).

## Procedure

1. Load both source skills before drafting: `daniel-writer`
   (`~/coding/ai-ops/skills/daniel-writer/SKILL.md` +
   `references/style-analysis.md`) and `humanizer`
   (`~/.agents/skills/humanizer/SKILL.md`).
2. Calibrate against the most recent PUBLISHED post in the same series — the
   voice sample overrides the humanizer's generic patterns (e.g. Daniel keeps
   an em-dash budget of 4–8 per article, spaced, plus payoff closers).
3. Draft in daniel-writer voice: first person, contractions, honest caveats,
   payoff line at section end, concrete tools and community vocabulary.
4. Run the humanizer pass on the draft: mark tells strongest-first
   (not-X-but-Y contrasts, one-line closers, staged openers, repeated words),
   then rewrite. Budget contrasts at ~4 max, one payoff closer per section,
   uneven rhythm.
5. Final tell sweep before gates: search the draft for the five survivors
   (dash, contrast, closer, triad, bold label).
6. danieldekay.org gates: `python3 scripts/fb/prose_check.py` must report
   zero-diff, then `npx astro build` must pass.

## Pitfalls

- Do not over-apply generic tells: Daniel's voice legitimately uses dashes,
  payoff closers and occasional contrasts — the published sample overrides
  the patterns.
- `humanizer` lives in `~/.agents/skills` as installed third-party IP — never
  edit it in place; layer conventions via this skill instead.
- danieldekay.org series files hand-type curly quotes and spaced em dashes in
  prose source (smartypants passes curly through) — do not "fix" them during
  voice passes; see the exception note in the danieldekay-typography-formatting
  skill.
- danieldekay.org slug renames touch three files: the blog file itself,
  `src/lib/series.ts`, and `scripts/fb/prose_check.py` POSTS paths. Add a
  redirect only if the slug was ever published.
- De-numbering contract (FB-archive part 3): prose keeps the pattern "near
  ten percent early, zero in 2018, half in 2026"; exact counts stay guarded by
  `links_corpus.py` asserts and appendix [^24].

## Verification

- danieldekay.org: `prose_check.py` zero-diff and `astro build` green.
- No surviving not-X-but-Y stacks, one-line-closer stacks, or repeated tell
  words ("disappear", "increasingly").
- Contractions present where the published sample uses them.

## Series-Level Lint (multi-post work)

Added 2026-10-18 from the Ecology-of-Tango review round (external GPT-6
coaching + fleet critic lane converging on the same findings). Applies when
two or more posts of one series are drafted or edited in the same pass.

1. **Shared scaffolding**: identical generic section headers across sibling
   posts ("## The observation", "## Where this might be wrong") are the
   strongest series-template tell. Re-voice at least one header per post;
   Part 1's voiced headers ("So: useful theory or tango bullshit?") are the
   register.
2. **Cross-post constructions**: same closer shape after sections in two
   posts, same joke skeleton, same pull-quote contrast template ("not X /
   proves abundance, not harm"). Vary per post; a motif may repeat ONCE as a
   deliberate callback, never by accident.
3. **Payoff-closer budget per post**: one two-sentence payoff closer per
   section max; fold the rest into the sentence before. Density of "Same X.
   Completely different Y." lines is a tell at paragraph scale even when each
   is fine alone.
4. **Dash register by sample, not rule**: count the published sample's actual
   spaced-dash usage (Part 1: ~12 per article) and match that register, not
   the generic 4–8 budget. Drafts ~10 under the sample read as flatter glue.
5. **Stock-word collision across posts** (e.g. "quietly" in both, "the mesh"
   vs "the web" inside one post): one word per tell-slot per series; one
   metaphorical universe per post.
6. **Closing question escalation**: the "floor is yours" handoffs must be
   distinct per post and escalate. Same formula with a swapped noun is a
   template tell. **But closers and Part-N bridges are cuttable furniture**
   (Daniel cut both in his Part 1 revision, 2026-10-18) — if the ending
   carries enough content, dropping the closer is a legitimate choice, not a
   defect. When a closer is cut in an earlier series post, later posts should
   follow the same convention; ask Daniel which way the series goes rather
   than re-adding reflexively.
7. **Frontmatter description echo**: check a new post's description against
   earlier posts' lines — near-verbatim reuse ("somehow nobody I want is at
   the one I chose") is either a marked callback or a fix.

## Feedback Rounds (fleet lanes + external coaching)

Added 2026-10-18. Protocol for review passes over drafted prose (subagent
fleet or external AI coaching such as GPT reviews).

Four layers, in this order, as separate lanes or separate reads:
1. **Reader experience** — where interest rises or drops, where the reader
   does conceptual work before feeling the problem (lane we historically
   lacked; see daniel-writer → Narrative Architecture).
2. **Argument & causality** — every causal claim has a defensible mechanism;
   observation / explanation / speculation are distinguishable.
3. **Craft** — voice, tells (this skill's passes), structure, pacing.
4. **Evidence** — citations verified against ground-truth captures (KG
   source nodes, raw captures), never vibes; verbatim quotes only if present
   in a verified capture, otherwise paraphrase; tier labels honest.

Rules for processing external coaching (GPT, Claude, etc.):
- **Contrast before adopting.** Check each claim against these skills and
  the actual drafts. Adopt mechanism fixes (e.g. causal corrections), reject
  misreadings (e.g. "same dancers" vs "same headcount"), and treat any advice
  that conflicts with a Daniel-locked decision as a QUESTION for Daniel, not
  a change.
- **External review complements the evidence lane; it never replaces it.**
  External coaches disclaim source verification and have missed real
  bibliographic errors our evidence audit caught.
- **Do not auto-rewrite into polished replacements.** A polished replacement
  fixes the text but not the writing habit. Produce a revision task (what
  changes and why), apply the structural pass (daniel-writer → Narrative
  Architecture: reverse outline, cut before adding) before line polish.
- **Authorship labels matter**: posts still marked ai-drafted carry the
  known failure mode "elegant complete explanations that outrun the shown
  reasoning" — the organizer's-voice test exists for exactly that.
