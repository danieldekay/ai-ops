---
name: "design-system-implementation"
description: "Comprehensive design system implementation from OpenSpec requirements. Covers design token systems, reusable components, accessibility, responsive behavior, and testing for Svelte 5 applications."
version: 1
created: "2026-05-11"
updated: "2026-05-11"
---
# Design System Implementation

## When to Use
Use this skill when implementing design systems from OpenSpec requirements, creating reusable component libraries, or enhancing existing design systems in Svelte 5 applications. Applies when you need to implement comprehensive design tokens, accessible components, responsive behavior, and testing.

## Procedure

### 1. Analyze Existing Design System
- Read current CSS files to understand existing design tokens and patterns
- Check for established color systems, typography scales, and spacing scales
- Identify existing components that can be enhanced or replaced
- Review project structure and conventions

### 2. Enhance Design Tokens
- Add comprehensive color tokens (primary, secondary, accent, semantic, neutral)
- Implement typography tokens (sizes, weights, line heights, spacing)
- Add spacing and layout tokens (scale, padding, margins, borders)
- Create component-specific tokens (buttons, cards, forms)
- Implement theme tokens for light/dark mode support

### 3. Create Base Components
- **Card Component**: Implement variants (default, elevated, outlined) with responsive padding and shadows
- **Button Component**: Create variants (primary, secondary, accent, outline, ghost, link) with size and state support
- **Heading Component**: Implement h1-h6 with proper semantic HTML and responsive typography
- **Text Component**: Create flexible text component with size, weight, color, and transform variants

### 4. Implement Accessibility
- Add proper ARIA attributes (aria-label, role, id, aria-describedby)
- Ensure keyboard navigation support
- Implement focus states and visual indicators
- Add proper semantic HTML structure
- Test with screen readers

### 5. Add Responsive Behavior
- Implement responsive padding and spacing using CSS custom properties
- Add responsive typography scales
- Ensure mobile-first design approach
- Test across different screen sizes

### 6. Write Comprehensive Tests
- Create unit tests for all base components using Vitest
- Test component variants and props
- Test accessibility attributes and keyboard navigation
- Test responsive behavior
- Test error states and edge cases

### 7. Integration and Documentation
- Update existing components to use new design system
- Create documentation for component usage
- Ensure backward compatibility
- Test build and functionality

## Pitfalls to Avoid

### TypeScript Issues
- Use proper TypeScript types for component props
- Avoid `this` references in Svelte components
- Handle optional props correctly with null checks
- Use proper event typing for custom events

### CSS Custom Property Management
- Don't overwrite existing custom properties without understanding their usage
- Use consistent naming conventions for new tokens
- Ensure proper CSS cascade and specificity
- Test tokens across different themes

### Component Architecture
- Don't over-engineer component variants
- Keep components focused and single-purpose
- Use proper Svelte 5 runes and patterns
- Avoid unnecessary complexity in prop handling

### Testing Challenges
- Don't skip accessibility testing
- Ensure tests cover all variants and states
- Test responsive behavior properly
- Use proper test setup and mocking

## Verification

### Design System Check
- Verify all design tokens are properly implemented
- Test color tokens across different themes
- Verify typography scales work correctly
- Check spacing consistency

### Component Testing
- Test all component variants render correctly
- Verify accessibility attributes are present
- Test responsive behavior on different screen sizes
- Ensure keyboard navigation works

### Build and Runtime Testing
- Run build commands to verify no errors
- Test application functionality
- Check performance impact
- Verify backward compatibility

### Accessibility Validation
- Test with screen readers
- Verify keyboard navigation
- Check color contrast ratios
- Ensure proper ARIA labels and roles

## Success Criteria
- All design tokens implemented and working
- Base components created with proper variants
- Accessibility attributes properly implemented
- Responsive behavior working across devices
- Comprehensive test coverage
- Build and runtime successful
- No TypeScript errors or warnings