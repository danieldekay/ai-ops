---
name: "svelte-const-tag-placement-debugging"
description: "Debug and fix Svelte 5 {@const} tag placement compilation errors. Use when encountering Svelte compilation errors related to {@const} tags that must be immediate children of specific parent elements."
version: 2
created: "2026-05-11"
updated: "2026-05-12"
---
## When to Use
- When encountering Svelte 5 {@const} tag compilation errors
- When {@const} tags are not properly positioned within parent elements
- When fixing placement issues in Svelte components

## Procedure
## Procedure
1. **Identify the compilation error** - Look for errors indicating {@const} tag placement issues
2. **Check parent element** - Verify the {@const} tag is an immediate child of one of these allowed parents:
   - {#snippet}
   - {#if}
   - {:else if}
   - {:else}
   - {#each}
   - {:then}
   - {:catch}
   - <svelte:fragment>
   - <svelte:boundary>
   - <Component>
3. **Move the {@const} tag** - Ensure it's positioned as an immediate child, not nested deeper
4. **Test compilation** - Run the build to verify the fix

## Pitfalls
- {@const} tags cannot be nested inside other blocks like {#if} conditions or {#each} loops as non-immediate children
- Moving {@const} tags may require restructuring the component logic
- Some parent elements may need to be wrapped in appropriate block structures

## Verification
- Run `npm run build` or your Svelte build command
- Confirm no compilation errors related to {@const} placement
- Test component functionality remains intact
## Pitfalls
- {@const} tags cannot be nested arbitrarily - they must be direct children of specific elements
- Moving {@const} tags may require restructuring the component logic
- Some parent elements may need to be restructured to accommodate {@const} tags

## Verification
- Component should compile without errors
- {@const} tags are properly positioned as immediate children
- Component functionality remains intact after placement fixes