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
