---
name: "svelte-design-tokens-system"
description: "Implement comprehensive design token systems for SvelteKit projects using CSS custom properties and TypeScript utilities. Covers color, typography, spacing, and component tokens with accessibility considerations."
version: 1
created: "2026-05-11"
updated: "2026-05-11"
---
## When to Use
Use this skill when implementing or enhancing design token systems in SvelteKit projects. Ideal for:
- Setting up new design systems from scratch
- Enhancing existing CSS with comprehensive tokens
- Creating reusable component libraries
- Migrating from hardcoded values to token-based systems
- Implementing accessibility-compliant design systems

## Procedure
1. **Analyze existing design system**
   - Read current CSS files to understand existing tokens
   - Identify gaps in token coverage
   - Note existing component patterns

2. **Implement base design tokens in CSS**
   ```css
   :root {
     /* Color tokens */
     --color-primary: var(--color-emerald-500);
     --color-secondary: var(--color-blue-500);
     --color-accent: var(--color-purple-500);
     --color-success: var(--color-green-500);
     --color-warning: var(--color-amber-500);
     --color-error: var(--color-red-500);
     
     /* Typography tokens */
     --font-size-xs: 0.75rem;
     --font-size-sm: 0.875rem;
     --font-size-base: 1rem;
     --font-size-lg: 1.125rem;
     --font-size-xl: 1.25rem;
     --font-size-2xl: 1.5rem;
     --font-size-3xl: 1.875rem;
     
     /* Spacing tokens */
     --spacing-xs: 0.25rem;
     --spacing-sm: 0.5rem;
     --spacing-md: 1rem;
     --spacing-lg: 1.5rem;
     --spacing-xl: 2rem;
     --spacing-2xl: 3rem;
   }
   ```

3. **Create TypeScript utility functions**
   ```typescript
   // src/lib/utils/design-tokens.ts
   export const tokens = {
     colors: {
       primary: 'var(--color-primary)',
       secondary: 'var(--color-secondary)',
       // ... other colors
     },
     typography: {
       sizes: {
         xs: 'var(--font-size-xs)',
         // ... other sizes
       },
       weights: {
         normal: '400',
         medium: '500',
         semibold: '600',
         bold: '700',
       }
     },
     spacing: {
       xs: 'var(--spacing-xs)',
       // ... other spacing
     }
   };
   ```

4. **Create base components using tokens**
   - Card component with consistent padding, border, and shadow
   - Button component with variants (primary, secondary, accent)
   - Typography components (Heading, Text) with proper token usage
   - Ensure all components use design tokens instead of hardcoded values

5. **Implement accessibility attributes**
   - Add proper ARIA labels and roles
   - Ensure keyboard navigation support
   - Implement proper focus states
   - Add screen reader support

6. **Test and validate**
   - Check token consistency across components
   - Verify accessibility compliance
   - Test responsive behavior
   - Ensure theme switching capability

## Pitfalls to Avoid
- **Avoid hardcoded values**: Always use CSS custom properties instead of fixed values
- **TypeScript errors**: Don't use `$$dispatch` in Svelte components - use standard events instead
- **Accessibility**: Always include proper ARIA attributes and keyboard support
- **CSS specificity**: Use proper CSS selectors to avoid token override conflicts
- **Responsive design**: Ensure tokens work across different screen sizes
- **Performance**: Minimize CSS custom property usage where not needed for theming

## Verification
- All components use design tokens consistently
- No hardcoded values in components
- TypeScript compilation passes without errors
- Accessibility checks pass (WCAG compliant)
- Theme switching works correctly
- Responsive behavior tested across devices