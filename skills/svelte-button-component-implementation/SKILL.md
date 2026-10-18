---
name: "svelte-button-component-implementation"
description: "Implement Svelte button components with proper event handling, TypeScript typing, and accessibility. Use standard event dispatch instead of $$dispatch syntax to avoid compilation errors."
version: 1
created: "2026-05-12"
updated: "2026-05-12"
---
## When to Use
Use when implementing Svelte button components, particularly when encountering TypeScript errors with $$dispatch syntax or bind:this without proper typing.

## Procedure
1. **Create basic button component**:
   ```svelte
   <!-- src/components/ui/Button.svelte -->
   <script lang="ts">
     export let variant: 'primary' | 'secondary' | 'outline' = 'primary';
     export let size: 'sm' | 'md' | 'lg' = 'md';
     export let disabled = false;
     export let type = 'button';
     export let fullWidth = false;
     
     // Standard event instead of $$dispatch
     function handleClick(event: MouseEvent) {
       if (!disabled) {
         $dispatch('click', { event });
       }
     }
   </script>
   
   <button
     class="button"
     class:primary={variant === 'primary'}
     class:secondary={variant === 'secondary'}
     class:outline={variant === 'outline'}
     class:sm={size === 'sm'}
     class:md={size === 'md'}
     class:lg={size === 'lg'}
     class:disabled={disabled}
     class:full-width={fullWidth}
     {type}
     disabled={disabled}
     on:click={handleClick}
   >
     <slot />
   </button>
   
   <style>
     .button {
       font-family: var(--font-family-sans);
       font-weight: var(--font-weight-semibold);
       border: none;
       border-radius: 0.375rem;
       cursor: pointer;
       transition: all 0.2s ease;
       display: inline-flex;
       align-items: center;
       justify-content: center;
     }
     
     .button.primary {
       background-color: var(--color-primary);
       color: white;
     }
     
     .button.secondary {
       background-color: var(--color-secondary);
       color: white;
     }
     
     .button.outline {
       background-color: transparent;
       color: var(--color-primary);
       border: 1px solid var(--color-primary);
     }
     
     .button.sm { 
       padding: var(--spacing-xs) var(--spacing-sm); 
       font-size: var(--font-size-sm);
     }
     .button.md { 
       padding: var(--spacing-sm) var(--spacing-md); 
       font-size: var(--font-size-base);
     }
     .button.lg { 
       padding: var(--spacing-md) var(--spacing-lg); 
       font-size: var(--font-size-lg);
     }
     
     .button.disabled {
       opacity: 0.5;
       cursor: not-allowed;
     }
     
     .button.full-width {
       width: 100%;
     }
   </style>
   ```

2. **Add accessibility features**:
   ```svelte
   <!-- Update with proper ARIA attributes -->
   <button
     class="button"
     aria-label={ariaLabel}
     aria-disabled={disabled}
     {type}
     disabled={disabled}
     on:click={handleClick}
   >
     <slot />
   </button>
   ```

3. **Create TypeScript interface**:
   ```typescript
   // src/components/ui/Button.types.ts
   export interface ButtonProps {
     variant?: 'primary' | 'secondary' | 'outline';
     size?: 'sm' | 'md' | 'lg';
     disabled?: boolean;
     type?: 'button' | 'submit' | 'reset';
     fullWidth?: boolean;
     ariaLabel?: string;
   }
   ```

4. **Implement proper event handling**:
   ```svelte
   <script lang="ts">
     import { createEventDispatcher } from 'svelte';
     
     const dispatch = createEventDispatcher<{
       click: { event: MouseEvent };
     }>();
     
     function handleClick(event: MouseEvent) {
       if (!disabled) {
         dispatch('click', { event });
       }
     }
   </script>
   ```

## Pitfalls
- Avoid $$dispatch syntax - use createEventDispatcher instead
- Don't use bind:this without proper TypeScript typing
- Ensure accessibility attributes are properly set
- Test with different screen readers for accessibility

## Verification
- Build the project to ensure no TypeScript errors
- Test button click events work correctly
- Verify accessibility compliance
- Test with disabled states
- Check responsive behavior