---
name: "svelte-const-tag-placement"
description: "Handle Svelte 5 {@const} tag placement compilation errors - {@const} tags must be immediate children of {#snippet}, {#if}, {:else if}, {:else}, {#each}, {:then}, {:catch}, <svelte:fragment>, <svelte:boundary> or <Component>"
version: 1
created: "2026-05-11"
updated: "2026-05-11"
---
## When to Use
When encountering Svelte 5 compilation errors related to {@const} tag placement, or when planning Svelte component structure with const declarations.

## Procedure
1. **Identify the error**: Look for compilation errors indicating {@const} is not in valid position
2. **Check parent container**: {@const} must be immediate child of:
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
3. **Move or wrap**: Either:
   - Move {@const} to be direct child of valid parent
   - Wrap problematic code in a valid parent container
4. **Test compilation**: Run build/dev server to verify fix

## Pitfalls
- {@const} cannot be nested inside other blocks without proper parent container
- Moving {@const} may affect variable scope in the component
- Complex component structures may require restructuring multiple elements

## Verification
- `npm run build` or `npm run dev` should compile without errors
- Check that const variables are accessible where needed
- Verify runtime behavior matches expectations