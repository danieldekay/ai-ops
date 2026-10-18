---
name: "blog-publish-scheduling"
description: "Publish, schedule, and verify posts in the danieldekay.org Astro repo — scheduling semantics, footnote+citation coexistence, render verification, and pre-publish fact checks (TODO-DANIEL)."
version: 4
created: "2026-10-01"
updated: "2026-10-04"
---
## When to Use
Setting a publication date, publishing (draft:false), verifying how a draft/scheduled post renders, or preparing a scheduled post for publish day in ~/Dokumente/webseiten/danieldekay.org.

**Pipeline position:** scheduling + publish-day phase — gate checks and queue — canonical flow: `~/Dokumente/webseiten/danieldekay.org/docs/lifecycle.md`. Sibling skills: always-voice-humanize (voice), danieldekay-typography-formatting (typography), blog-crossref-related-posts (crosslinking), blog-comic-illustration (illustration).

## Procedure
1. Check the queue first (mandatory, Daniel 2026-10-04): before setting any date, list all other scheduled posts (draft:false + future pubDate) and APPEND the new post after the last one in the queue — never interleave or slot earlier. Quick queue scan: npm run queue (scripts/pipeline.mjs) — shows drafts, scheduled queue in order, next free slot, and overdue-unpublished flags; the append rule is enforced in output.
2. Schedule: set future pubDate + REMOVE draft:true → Scheduled bucket. Keep the queue's cadence in mind (series posts keep their slot pattern, e.g. Sunday 18:30). Verify with npm run build: post must be absent from dist/blog/index.html (still scheduled), not erroring.
3. RUN THE FULL LOCAL QA GATE BEFORE PUSH (mandatory, 2026-10-04 lesson): npm run qa (scripts/qa-gate.sh) mirrors deploy.yml exactly — astro check + pytest tests/fb in a pandas+pytest-only .qa-venv (auto-bootstrapped, gitignored — the project .venv has heavy deps and CANNOT reproduce CI collection errors) + npm run build. Do NOT rely on npm run build alone; the deploy gate red-lights otherwise. A push with a green local qa should deploy green on the first try.
4. Verify rendering of scheduled/draft posts: temporarily set a PAST pubDate (draft already false) → npm run build → check dist/blog/<slug>/index.html (footnote refs data-footnote-ref, backlinks data-footnote-backref, cite-link superscripts, sources section) → restore the future scheduled date and rebuild. (draft:false + future date is still excluded — the flip only works with a past date. Backref count runs 2× the ref count on this site; that ratio is normal, see part 1.) Drafts page is dev-only, so dist won't contain drafts. See docs/lifecycle.md in the repo for the canonical state table.
5. Footnotes: GFM [^label] defs may sit mid-document before their anchor; refs [^x] and defs [^x]: must pair 1:1 — after any delete, grep for dangling defs/refs. Footnotes section renders BEFORE the Sources section.
6. Citations: external [n](url) markers are auto-renumbered by plugins/rehype-citations.mjs in order of first appearance; internal /blog/ links stay plain. Never hand-maintain numbering.
7. Publish day: re-verify TODO-DANIEL facts (usually model routing) against ~/.pi/agent/settings.json via ctx_shell/sed (lean-ctx denies ~/.pi reads); set actual publish time if wanted; final npm run build must be clean. Run npm run verify:published <slug> after deploy.
8. Git: posts are frequently untracked while drafting — git add early to get history safety net. Originals can be backed up to /tmp (tmpfs, expires on reboot).
## Pitfalls
- draft:true + future date stays invisible in prod but ALSO on the drafts page in prod (drafts redirect to /). Verify rendering via the flip trick above.
- Don't hand-number citations — the build plugin renumbers; hard-coded numbers drift.
- TODO-DANIEL comments must be resolved or updated before publish — the writer subagent leaves them deliberately for unverifiable facts.
- Scheduled bucket = excluded from prod builds; if the cron rebuild doesn't fire, the post stays hidden past its date — a push triggers rebuild too.

## Verification
1. npm run build exits clean (grep -icE 'error|failed' = 0).
2. Scheduled: grep dist/blog/index.html for the post title → 0 matches; on publish day → 1+.
3. Rendered HTML: footnote ref count == footnote def count == backref count.
4. Sources section: li#ref-N count == external citation count.