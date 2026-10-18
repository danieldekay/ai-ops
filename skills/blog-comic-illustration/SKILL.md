---
name: "blog-comic-illustration"
description: "Create grounded comic/illustration images for blog posts: ground in the actual post text, brainstorm 5 concept proposals, then ask the user BOTH which images to render (multi-select over the 5) and which style (full style list from ~/Dokumente/webseiten/danieldekay.org/docs/STYLE.md), render with an expanded no-thinking prompt in the chosen style, then QA verbatim and wire into the post. Use when asked for \"an image/comic for this blog post\" or when referencing the blog image style workflow."
version: 12
created: "2026-09-27"
updated: "2026-10-04"
---
## When to Use
- User asks for an illustration/comic/image for a specific blog post (draft or published), for a named section of it, or for a section they are about to name.
- User references the XKCD blog-theme style (Style E) or the _lab-xkcd lab workflow.
- A post needs several images — run the loop once per section (locate → section → ground → brainstorm → ask style + images → render → wire), not once for the whole post.
- Do NOT use for generic image generation without a target post/section — grounding in section content is the core of this skill.
- MANDATORY USER DECISIONS before any render: (1) which images — always present exactly 5 concept proposals as a multi-select; (2) which style — always list ALL named style variants from ~/Dokumente/webseiten/danieldekay.org/docs/STYLE.md and let the user pick. Never assume either.
- Style registry homes: repo docs/STYLE.md (working) + wiki concepts/danieldekayorg-image-style-registry (pool/history).

**Pipeline position:** illustration phase — post content-gate, before assemble/verify — canonical flow: `~/Dokumente/webseiten/danieldekay.org/docs/lifecycle.md`. Sibling skills: ai-generated-images (generic image gen), blog-publish-scheduling (publish).

## Procedure
1. LOCATE THE ACTUAL POST: search both repos (~/Dokumente/2ndBrain/content/blog/personal-drafts/ and the blog repo ~/Dokumente/webseiten/danieldekay.org/src/content/blog/ plus facebook-archive/review/ for FB-origin drafts). Read it fully. Never design from the title alone.
2. IDENTIFY THE TARGET SECTION(S) — a blog post contains multiple distinct elements (paradox, mechanics, comparison table, recommendations, closing invitation) and may need MULTIPLE images, one per element. The unit of work is ONE SECTION, not the whole post. If the user named the section, use it. If not, map the post's sections and their candidate visual roles, then ask the user which section(s) the image(s) are for (ask_user_question) before brainstorming anything. Never assume the whole post is one image.
3. GROUND IN THE CHOSEN SECTION(S) ONLY: extract each section's own key lines, metaphors and its role in the post's argument. Prefer the sections' verbatim sentences for labels, dialogue and the caption. Confirm each concept proposal against the section's specific twist, not just the post's general theme.
4. BRAINSTORM EXACTLY 5 CONCEPT PROPOSALS across the chosen section(s): different structures (six-panel 2x3 narrative, single-panel metaphor like iceberg/lottery-ticket, split-panel contrast, mechanics/diagram comic, wordless sequence). Each proposal = concept + which section lines it uses.
5. ASK THE USER BOTH DECISIONS IN ONE ask_user_question CALL — never render without both answers:
   a) WHICH IMAGES: multiSelect: true, one option per proposal (all 5), each preview containing the concept sketch and its section-grounded text. User may select any number to render.
   b) WHICH STYLE: single-select listing ALL named style variants currently in ~/Dokumente/webseiten/danieldekay.org/docs/STYLE.md under 'Named Style Variants' — re-read that section every time instead of relying on memory, new styles get added there. As of 2026-09-28: A Swiss International Editorial, B Art Nouveau Infographic, C XKCD Comic/Infographic, D Swiss XKCD Hybrid, E XKCD on Live Blog Theme (Bauhaus primaries, paper #f4f1ea). Each option gets a one-line description; recommend the best fit for the target post first with '(Recommended)'. If several sections were chosen, one style per batch unless the user asks otherwise.
6. BUILD THE EXPANDED NO-THINKING PROMPT: use the USER-CHOSEN style's block from the repo docs/STYLE.md — do not hardcode Style E. Carry over that style's palette, heading treatment, figure style and layout rules, then spell out EVERY panel, every heading, every speech line verbatim, every prop, every accent shape and which panel it appears in. Never leave composition to the model. Save prompt as a .txt next to the renders in _lab-xkcd/ or the post's images folder.
7. RENDER via the images API using the ai-generated-images skill's images_api.py script (model first choice: openai/gpt-5.4-image-2, ~$0.20 at 4:3; API key retrieved via 1Password as in _lab-xkcd/run-round.sh — never store keys in files or memory; render independent images in parallel background jobs and wait). Model is swappable; the expanded prompt is the invariant.
8. QA VERBATIM: view the image; check every heading, speech line, label and caption character-for-character; check palette against the chosen style's rules. If a text error is model-caused, rerun once; if it is prompt-caused, fix the prompt first. Log rounds in _lab-xkcd/analysis.md.
9. WIRE INTO THE POST WITHIN THE TARGET SECTION: 2ndBrain drafts -> copy to content/blog/personal-drafts/images/<post>/<style>/ and reference relatively; blog-repo posts -> copy to public/media/<pubYear>/<pubMonth>/ and reference as /media/...; write descriptive alt text; place the image inside or immediately after the section it illustrates (often right after the line it literalizes). Record a wiki_observe. When a later image for another section is requested, resume at step 2 with the new section.

## Pitfalls
- Skipping the style question: the style is the user's call, not the agent's default. Always enumerate the full current style list from docs/STYLE.md in the ask_user_question call — the list changes as styles are added, so re-read docs/STYLE.md instead of hardcoding.
- Presenting fewer than 5 proposals: the brainstorm step always yields exactly 5; the user decides how many (and which) to render via multi-select.
- Treating the whole post as one image: posts contain multiple distinct elements (paradox, mechanics, comparisons, recommendations) and usually deserve separate visuals per section. Always establish the target section first — ask if the user has not named one.
- Designing from the post title or the post's generic theme instead of the section's specific twist — for 'Scene from a Marathon', four comics showed the generic 'hierarchy hurts people' tragedy and Daniel rejected all of them; the section's point was that a curated room where EVERYONE is spectacular still rebuilds the hierarchy. Test each variation against the section's specific twist before presenting.
- Prompt-authoring errors masquerade as model errors: duplicated sentences or wrong accents usually come from the prompt — fix the prompt before rerunning.
- Images-API models (gpt-5.4-image-2, mai, qwen, recraft, seedream) 404 on the chat endpoint — always use scripts/images_api.py from the ai-generated-images skill, not the chat-endpoint generate_image.py flow.
- Recraft garbles long text and Seedream drifts palette — do not route text-dense comics to them.
- FB-origin drafts may exist only in the blog repo's facebook-archive/review/ — search there when a title is not in src/content/blog/.
- Media paths in the blog repo follow the post's pubDate, not today's date: public/media/<pubYear>/<pubMonth>/ (a 2019-04 post goes to /media/2019/04/).

## Verification
1. Rendered image viewed and every text element verified character-for-character against the prompt.
2. Palette check against the user-chosen style's rules from docs/STYLE.md; no off-palette colors.
3. Image file exists in the post's images/media folder and the markdown reference resolves to it (HTTP 200 for blog-repo posts).
4. User confirmed BOTH decisions via ask_user_question before any render: which images (multi-select over 5 proposals) and which style (full list from docs/STYLE.md).