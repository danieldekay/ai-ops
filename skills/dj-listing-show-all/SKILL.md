---
name: "dj-listing-show-all"
description: "Update the DJ listing page to always show all DJs from the WordPress REST API CPT, removing event count filtering and adjusting UI accordingly."
version: 1
created: "2026-05-10"
updated: "2026-05-10"
---
## When to Use
- When the DJ listing page should display every DJ from the WP REST API regardless of upcoming events.

## Procedure
1. **Read the file** `src/routes/djs/+page.svelte` with the `read` tool to get hash anchors for the relevant section.
2. **Locate the derived filter** that currently filters DJs:
   ```svelte
   const dateFilteredDjs = $derived.by(() =>
       djs.filter(dj => dj.countsByDateFilter[activeDateFilter] > 0)
       .sort(...)
   );
   ```
3. **Edit the filter** using the `edit` tool with anchored `replace_lines` (or `set_line`) to remove the `filter` condition, leaving only the sort logic. Example edit:
   - `start_anchor`: the line with `.filter(`
   - `end_anchor`: the line before `.sort(`
   - `new_text`: *(empty – removes the filter)*
4. **Optional UI tweak**: Add a badge or style for DJs with zero upcoming events to indicate they have no events.
5. **Update any dependent derived values** (e.g., `visibleCount`) to reflect the new total DJ count.
6. **Run type checks**: execute `npm run check` (`svelte-kit sync && svelte-check`) to ensure no TypeScript or Svelte errors.
7. **Manual verification**: start the dev server (`npm run dev`) and confirm that the DJ listing shows all DJs, including those without events.

## Pitfalls
- Ensure you capture fresh hash anchors before editing; otherwise the edit may fail due to hash mismatches.
- Do not remove the entire `dateFilteredDjs` derived block – keep the sorting logic intact.
- If UI elements reference `dj.countsByDateFilter[activeDateFilter]`, update them to handle zero counts gracefully.
- After editing, verify that the Svelte compiler does not produce warnings about unused variables.

## Verification
- The page should list every DJ entry fetched from the WP REST API.
- DJs without events should still appear, optionally with a visual indicator.
- No TypeScript or Svelte errors should be reported.
- The total count displayed matches the number of CPT DJs.