---
name: "implement-design-token-system"
description: "Implement comprehensive design token systems and component libraries for Svelte/SvelteKit projects. Includes CSS custom properties, TypeScript utility functions, and accessible base components."
version: 1
created: "2026-05-11"
updated: "2026-05-11"
---
## When to Use
When implementing design systems, UI libraries, or comprehensive styling solutions for Svelte/SvelteKit projects from scratch. Use when starting new projects or refactoring existing ones to establish consistent design tokens and reusable components.

## Procedure
1. **Analyze existing CSS structure** - Read current CSS files to understand existing token systems and patterns
2. **Design token specification** - Define comprehensive token categories (colors, typography, spacing, layout, components)
3. **Implement CSS custom properties** - Create :root and @theme sections with all necessary tokens
4. **Create utility functions** - Build TypeScript helpers for accessing and manipulating tokens
5. **Implement base components** - Create accessible, token-based components (Card, Button, Heading, Text)
6. **Add accessibility attributes** - Ensure all components have proper ARIA attributes and keyboard navigation
7. **Test integration** - Verify components work with existing codebase and build system

## Pitfalls
- **Svelte syntax errors**: Use proper Svelte 5 syntax and avoid deprecated patterns
- **TypeScript compilation**: Fix all TypeScript errors before proceeding to next components
- **Accessibility requirements**: Ensure proper ARIA attributes and keyboard navigation
- **Token naming conflicts**: Avoid conflicts with existing CSS variables
- **Component reusability**: Design components to be flexible and reusable across different contexts

## Verification
- Run `npm run check` to verify no TypeScript errors
- Test components in actual application contexts
- Verify design tokens apply correctly across different screen sizes
- Check accessibility with screen readers and keyboard navigation
- Ensure build completes without errors