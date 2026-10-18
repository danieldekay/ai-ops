---
name: "openspec-svelte-component-implementation"
description: "Implement OpenSpec changes for Svelte 5 projects with design systems, TypeScript interfaces, and comprehensive testing"
version: 1
created: "2026-05-11"
updated: "2026-05-11"
---
## When to Use
Use this skill when implementing OpenSpec changes for Svelte 5 projects, especially when working with design systems, TypeScript interfaces, and comprehensive testing frameworks.

## Procedure

### 1. **Initial Setup**
- Read the OpenSpec change directory structure (openspec/changes/[change-name]/)
- Understand the schema (usually spec-driven)
- Check current artifacts (proposal, design, specs, tasks)
- Verify all artifacts are complete before starting implementation

### 2. **Design Token Implementation**
- Enhance CSS custom properties in src/app.css with comprehensive tokens:
  - Color tokens (primary, secondary, accent, semantic, neutral scales)
  - Typography tokens (sizes, weights, line heights, spacing)
  - Spacing tokens (padding, margins, borders, radius)
  - Component-specific tokens (buttons, cards, forms)
- Create utility functions in src/lib/utils/design-tokens.ts
- Ensure responsive design support through CSS media queries

### 3. **Base Component Creation**
- Create components using design tokens:
  - Card.svelte with variants (default, elevated, outlined)
  - Button.svelte with variants and accessibility
  - Heading.svelte (h1-h6) with responsive behavior
  - Text.svelte with typography variants
- Implement accessibility attributes: role, aria-label, id
- Add responsive behavior through CSS classes

### 4. **TypeScript Interface Enhancement**
- Extend existing interfaces with enhanced data structures
- Add organizer metadata, venue details, and event relationships
- Ensure proper typing for new properties
- Maintain backward compatibility with existing types

### 5. **Testing Implementation**
- Create unit tests using Vitest
- Test component variants and accessibility
- Use proper test setup and assertions
- Avoid syntax errors in test files

### 6. **Additional UI Components**
- Create supporting components: Badge, Avatar, Divider
- Ensure consistent design language
- Implement responsive behavior
- Add comprehensive tests

## Pitfalls to Avoid

### TypeScript and Svelte Compilation Errors
- **Issue**: `$$dispatch` is an illegal variable name
- **Fix**: Use standard event dispatch instead of `$$dispatch`
- **Issue**: `'this' implicitly has type 'any'` errors
- **Fix**: Remove `this` references and use proper Svelte event handling
- **Issue**: Unused export property warnings
- **Fix**: Remove unused exports or prefix with underscore

### Variable Naming Issues
- **Issue**: Variable name conflicts in test files
- **Fix**: Use unique variable names and proper destructuring
- **Issue**: Syntax errors in test files
- **Fix**: Ensure proper TypeScript syntax and variable declarations

### Accessibility Implementation
- **Issue**: Missing accessibility attributes
- **Fix**: Add role, aria-label, id attributes where appropriate
- **Issue**: Poor keyboard navigation
- **Fix**: Ensure proper focus management and keyboard interactions

### Responsive Design
- **Issue**: Components not responsive on different screen sizes
- **Fix**: Use CSS media queries and responsive classes in design tokens
- **Issue**: Inconsistent spacing across devices
- **Fix**: Implement responsive padding and margin tokens

## Verification

### Build and Type Checking
- Run `npm run check` to verify TypeScript compilation
- Run `npm run build` to ensure build compatibility
- Check for any linting errors

### Testing
- Run unit tests to verify component functionality
- Test accessibility features with screen readers
- Verify responsive behavior on different devices
- Ensure all variants work as expected

### Design System Verification
- Verify design tokens are properly applied across components
- Check for consistent styling and spacing
- Ensure accessibility standards are met
- Test component variants in different contexts

## Best Practices
- Always read files before editing to avoid blind writes
- Use proper TypeScript typing for Svelte components
- Implement accessibility from the start
- Test thoroughly after each component implementation
- Maintain consistent design language throughout
- Ensure backward compatibility with existing code