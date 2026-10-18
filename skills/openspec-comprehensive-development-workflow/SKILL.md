---
name: "openspec-comprehensive-development-workflow"
description: "Comprehensive end-to-end OpenSpec development workflow for SvelteKit projects. Handles design token implementation, component development, API integration, testing, and complex multi-phase changes. Includes systematic approaches for TypeScript interface management, design system integration, and component composition patterns."
version: 1
created: "2026-05-13"
updated: "2026-05-13"
---
# OpenSpec Comprehensive Development Workflow

## When to Use
Use for complex multi-step OpenSpec implementation involving design systems, component development, API enhancements, and comprehensive testing. Ideal for SvelteKit projects with TypeScript integration requirements.

## Workflow Steps

### Phase 1: Analysis and Planning
1. **Explore OpenSpec Changes Directory**
   - Use `openspec-exploration` to find and analyze changes
   - Identify changes with missing tasks or incomplete implementations
   - Understand the task dependencies and scope

2. **Change Status Assessment**
   - Check if change proposal/design/specs/tasks are complete
   - Verify artifacts are ready for implementation
   - Identify any blocking dependencies

### Phase 2: Design Token Implementation
1. **Design Token System Setup**
   - Implement comprehensive design token system using CSS custom properties
   - Create TypeScript utility functions for token access
   - Include color, typography, spacing, and component-specific tokens
   - Ensure accessibility considerations and responsive design support

2. **Base Components Development**
   - Create base components (Card, Button, Heading, Text, Badge, Avatar, Divider)
   - Implement proper TypeScript typing and prop validation
   - Ensure CSS selectors are used within component scope to avoid linting errors

### Phase 3: Specific Component Implementation
1. **Complex Component Development**
   - Implement OrganizerCard and VenueCard components
   - Handle nested object property access with proper TypeScript typing
   - Apply design tokens throughout component hierarchy
   - Implement responsive design patterns

2. **Component Integration**
   - Use Svelte 5 runes ($state, $derived, $effect, $props)
   - Implement proper event handling (avoid $$dispatch syntax)
   - Handle Svelte 5 {@const} tag placement constraints
   - Ensure proper snippet usage for component composition

### Phase 4: API and Data Layer
1. **API Enhancements**
   - Extend TypeScript interfaces for route data
   - Implement proper validation and error handling
   - Add caching mechanisms for performance optimization
   - Handle nested object property access with type assertions

2. **Data Model Integration**
   - Update interfaces to match component expectations
   - Handle property access for nested objects like social media links
   - Implement proper TypeScript typing for enhanced data structures

### Phase 5: Testing and Validation
1. **Component Testing**
   - Write comprehensive tests for all components
   - Test accessibility features and responsive behavior
   - Validate TypeScript interfaces and prop validation
   - Test design token application throughout hierarchy

2. **Integration Testing**
   - Test component interactions and composition
   - Validate API integration and data flow
   - Test edge cases and error handling
   - Ensure CSS custom property application works correctly

## Common Challenges and Solutions

### Svelte 5 Constraints
- **{@const} tag placement**: Must be immediate children of {#snippet}, {#if}, {:else if}, {:else}, {#each}, {:then}, {:catch}, <svelte:fragment>, <svelte:boundary> or <Component>
- **Event handling**: Use standard event dispatch instead of $$dispatch syntax
- **Template syntax**: Use standard HTML comments <!-- --> instead of JSX-style {/* */}

### TypeScript Interface Management
- **Property access**: Use proper TypeScript typing for nested objects like social media links
- **Type assertions**: Apply type assertions for nested object properties
- **Interface mismatches**: Systematically resolve mismatches between component expectations and route data

### CSS and Design System
- **CSS selectors**: Must be used within component scope to avoid linting errors
- **Design tokens**: Comprehensive implementation with CSS custom properties and TypeScript utilities
- **Responsive design**: Support through CSS media queries in token definitions

### Performance Optimization
- **Caching mechanisms**: Implement for API data and computed values
- **Code splitting**: Use SvelteKit dynamic imports for large components
- **Bundle optimization**: Monitor and optimize final bundle size

## Best Practices

1. **Token Efficiency**: Keep token usage focused and avoid unnecessary context loading
2. **Component Composition**: Use Svelte 5 snippets ({@render}) for reusable component patterns
3. **Type Safety**: Maintain strict TypeScript typing throughout the development process
4. **Accessibility**: Ensure all components meet WCAG 2.2 standards
5. **Testing**: Implement comprehensive testing coverage including unit, integration, and accessibility tests
6. **Documentation**: Document design tokens, component APIs, and usage patterns

## Tools and Dependencies

- **OpenSpec CLI**: For artifact management and change tracking
- **Svelte 5**: Modern reactive framework with runes
- **TypeScript**: Strict mode for type safety
- **Tailwind CSS**: Utility-first styling framework
- **Vitest**: Testing framework for Svelte components
- **ESLint**: Code quality and linting
- **PostCSS**: CSS processing and optimization

## Success Criteria

1. All OpenSpec artifacts are implemented and tested
2. Design token system is comprehensive and accessible
3. Components are properly typed and validated
4. API integration is robust and performant
5. Testing coverage meets project requirements
6. No TypeScript compilation errors
7. CSS custom properties are properly applied
8. Svelte 5 best practices are followed