---
name: "tango-handbook-source-ingestion"
description: "Ingest sources (Facebook threads, YouTube videos, blog essays, podcasts, articles) into the tango-organizer-handbook knowledge graph: dedupe against register, first-hand capture via agent-browser, raw capture + SRC node + register entry, validate/build/commit. Triggers: \"ingest this\", \"register in the graph\", pasting source text/URL for the handbook, capture-pending re-fetches."
version: 1
created: "2026-10-06"
updated: "2026-10-06"
---
## When to Use
Use when ingesting any new source (Facebook post/thread, YouTube video, blog essay, article, podcast transcript) into the Tango Organizer Handbook knowledge graph at ~/Dokumente/tango-organizer-handbook — i.e., Daniel says "ingest", "register this in the graph", or pastes source text/URL for the handbook. Not for blog-post ingestion (danieldekay.org uses the OUT-post convention instead) and not for graph reads (kg_query.py is read-only, no skill needed).

## Procedure
1. Check for parallel writers first: cd ~/Dokumente/tango-organizer-handbook && git log --oneline -3 — if another session committed minutes ago, re-read shared files fresh before any edit and expect ID collisions.
2. Dedupe: grep the source domain in knowledge/nodes/sources/*.md and in sources/research/social-media-feedback/register.md; allocate the register ID against the LATEST COMMIT (register IDs F1.., B1.., Y1.., T1.. collide across sessions — e.g. 2026-10-06 had two F12s).
3. Capture the source: try page-side first-hand via agent-browser (Facebook permalinks: agent-browser eval "document.body.innerText" extracts the full post body logged-out; comments truncate logged-out — comments from Daniel's paste stay second-hand). A paste from Daniel = second-hand capture; if he participated in the thread, flag level-D signal (participant).
4. Write the raw capture to sources/research/social-media-feedback/_raw/<slug>.md — header frontmatter: source URL, author list, retrieved date + capture mode, integrity line (first-hand/second-hand/pending), related sources. Paste text verbatim, preserve original languages.
5. Write the SRC node knowledge/nodes/sources/SRC-<slug>.md per knowledge/templates/source.md: type source, layer evidence, source_type + transferability from knowledge/SCHEMA.md vocab, evidence_scope = what it can and cannot legitimately support, chapters from the repo's chapter set, links (relates-to) to the sources it counter-points or pairs with.
6. List candidate claims ONLY from actually-captured text, each with a locator (timestamp, section heading, comment author). Unfetchable source → still register the node with 'Full text NOT captured (reason)' in Reading notes, candidate claims marked '(provisional, pending full-text capture)' — never invent content.
7. Add the register.md entry in the platform bucket (### Facebook (n) / ### YouTube / podcast (n) / etc.), then update the count table at the top (Registered sources, Recency, Platforms).
8. Gate: python3 knowledge/scripts/kg_validate.py → 0 errors (37 warnings are pre-existing); python3 knowledge/scripts/kg_build.py → graph.json + zettelkasten.db rebuilt; verify node count delta matches the nodes added.
9. Before staging shared files (register.md, graph.json): git diff --cached must contain ONLY your content — re-grep the staged file for other-session additions; then commit (message lists each source + capture status).

## Pitfalls
- Never hand-edit knowledge/graph.json or the SQLite store — derived, regenerable
- Register IDs collide across concurrent sessions — check the latest commit, not your session's earlier snapshot
- Staging register.md can commit the other session's stale in-flight content under your message — verify the staged diff
- update_bookmark (Raindrop) cannot move collections; search_bookmarks_by_text silently misses known-existing URLs
- Logged-out FB fetch shows the post body but truncates comments — never claim full comment coverage from a logged-out fetch
- A 404/403/JS-shell source still gets a node (capture-pending pattern), but zero verified claims
- Bookmark the source URL in Raindrop with the structured excerpt format at the end (L1/L2/inbox/L3 tags, collection 40382707 for tango)

## Verification
1. kg_validate.py reports 0 errors
2. kg_build.py output node/edge count increased by exactly the nodes added
3. git diff --cached contains only content from this session
4. No register ID appears twice: grep -o '^\*\*[A-Z][0-9]*\.' register.md | sort | uniq -d returns nothing
5. Every claim in the node has a locator into actually-captured text