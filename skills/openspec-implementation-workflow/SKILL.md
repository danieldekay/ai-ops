---
name: "openspec-implementation-workflow"
description: "End-to-end OpenSpec change implementation workflow focusing on design tokens, components, and accessibility. Use when implementing OpenSpec changes with design systems, creating reusable components, and applying accessibility best practices."
version: 1
created: "2026-05-11"
updated: "2026-05-11"
---
## When to Use
Use this skill when implementing OpenSpec changes that involve:
- Design token systems and CSS custom properties
- Reusable component libraries (Card, Button, Heading, Text)
- Accessibility attribute implementation
- Svelte 5 with TypeScript
- WordPress REST API integration
- UI/UX enhancement projects

## Procedure
1. **Setup and Discovery**
   - Use `opsx status` to check available changes and their status
   - Locate change directory using CLI output
   - Read all context files (design.md, proposal.md, specs/*.md, tasks.md)
   - Check current project structure and existing components

2. **Design Token Implementation**
   - Enhance CSS custom properties in `src/app.css`
   - Implement comprehensive color tokens (primary, secondary, accent, semantic, neutral)
   - Add typography tokens (sizes, weights, line heights, spacing)
   - Create spacing and layout tokens
   - Add component-specific tokens (buttons, cards, forms)
   - Create utility functions in `src/lib/utils/design-tokens.ts`

3. **Component Development**
   - Create base components using design tokens
   - Implement accessibility attributes (role, aria-label, tabindex)
   - Use TypeScript properly with Svelte 5 syntax
   - Handle events and props correctly
   - Test component functionality

4. **Integration and Testing**
   - Update existing components to use new design system
   - Ensure accessibility compliance
   - Test with different screen sizes and devices
   - Verify WordPress REST API integration

## Pitfalls to Avoid
- **Directory Navigation Issues**: Use CLI commands to find change directory, don't assume directory structure
- **TypeScript Errors**: Avoid `this` references in Svelte components, use proper event handling
- **Accessibility Props**: Bind all accessibility attributes to HTML elements to avoid unused export warnings
- **Design Token Consistency**: Use existing token system, don't create conflicting naming conventions
- **Svelte 5 Syntax**: Use proper runes and reactive declarations

## Verification
- Build project successfully with no TypeScript errors
- All components render correctly with proper styling
- Accessibility attributes are properly implemented and functional
- Design tokens are applied consistently across components
- WordPress REST API data displays correctly