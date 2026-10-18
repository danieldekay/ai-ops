---
name: "svelte-design-system-implementation"
description: "Implement comprehensive Svelte design systems with CSS custom properties, base components, accessibility, and responsive design patterns. Use for creating design tokens, base components (Card, Button, Heading, Text, Badge, Avatar, Divider), and implementing responsive accessibility-first UI components."
version: 1
created: "2026-05-11"
updated: "2026-05-11"
---
## When to Use
When implementing a comprehensive Svelte design system from scratch, creating reusable UI components, or enhancing existing component libraries with accessibility and responsive design patterns.

## Procedure

### 1. Design Token Implementation
1. **Enhance CSS custom properties** in `src/app.css`:
   ```css
   :root {
     /* Color tokens */
     --color-primary: hsl(var(--primary));
     --color-secondary: hsl(var(--secondary));
     --color-accent: hsl(var(--accent));
     /* Typography tokens */
     --text-xs: var(--size-xs);
     --text-sm: var(--size-sm);
     /* Spacing tokens */
     --spacing-xs: var(--size-xs);
     --spacing-sm: var(--size-sm);
   }
   ```

2. **Add comprehensive color scales**:
   - Primary, secondary, accent colors
   - Semantic colors (success, warning, error)
   - Neutral color scale (50-950)
   - Color variants for different states

3. **Create design token utility functions**:
   ```typescript
   // src/lib/utils/design-tokens.ts
   export function getToken(name: string) {
     return getComputedStyle(document.documentElement).getPropertyValue(name);
   }
   ```

### 2. Base Component Creation
1. **Card Component**:
   - Create variants: default, elevated, outlined
   - Add responsive padding and shadow support
   - Include accessibility attributes

2. **Button Component**:
   - Create variants: primary, secondary, accent, outline, ghost
   - Add size variants: sm, md, lg
   - Include proper accessibility attributes

3. **Typography Components**:
   - Heading components (h1-h6)
   - Text component with size and weight variants
   - Include responsive behavior

### 3. Accessibility Implementation
1. **Add ARIA attributes**:
   - `aria-label` for interactive elements
   - `role` for semantic elements
   - `id` for screen reader references

2. **Keyboard navigation**:
   - Ensure buttons are focusable
   - Add proper event handlers

3. **Screen reader support**:
   - Use appropriate semantic HTML
   - Provide descriptive labels

### 4. Responsive Design
1. **Add responsive classes**:
   ```css
   .responsive-sm { @media (min-width: 640px) { /* styles */ } }
   .responsive-md { @media (min-width: 768px) { /* styles */ } }
   ```

2. **Update component props**:
   - Add `responsive` boolean prop
   - Include responsive size variants

### 5. Testing Implementation
1. **Create unit tests** with Vitest:
   ```typescript
   import { render, screen } from '@testing-library/svelte';
   import { describe, it, expect } from 'vitest';
   ```

2. **Test component variants**:
   - Test different props and their effects
   - Verify accessibility attributes
   - Check responsive behavior

3. **Test event handling**:
   - Button click events
   - Form submissions
   - Custom events

## Pitfalls to Avoid

1. **TypeScript Errors**:
   - Don't use `$$dispatch` in Svelte components
   - Avoid `this.dispatchEvent()` - use standard event handling
   - Properly type component props

2. **Accessibility Issues**:
   - Always include appropriate ARIA attributes
   - Ensure keyboard navigation works
   - Test with screen readers

3. **Responsive Design**:
   - Don't forget mobile-first approach
   - Test on different screen sizes
   - Use proper breakpoints

4. **Performance**:
   - Avoid unnecessary re-renders
   - Use Svelte's reactive statements properly
   - Minimize CSS specificity

## Verification Success

1. **Design Tokens**:
   - All CSS custom properties are defined
   - Tokens are used consistently across components
   - Theme switching works properly

2. **Component Functionality**:
   - All variants work as expected
   - Accessibility attributes are present
   - Responsive behavior works on different screen sizes

3. **Testing Coverage**:
   - Unit tests pass for all components
   - Accessibility tests pass
   - Responsive behavior is tested

4. **Integration**:
   - Components work together seamlessly
   - No CSS conflicts
   - Performance is acceptable