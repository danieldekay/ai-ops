---
name: "openspec-component-migration"
description: "Systematic approach to implementing OpenSpec changes with SvelteKit components, including design token integration, TypeScript interface management, and component migration patterns."
version: 1
created: "2026-05-13"
updated: "2026-05-13"
---
## When to Use

Use this skill when implementing OpenSpec changes that involve:
- Creating new components with design tokens
- Migrating existing components to use new UI systems
- Handling TypeScript interface mismatches between different data structures
- Integrating enhanced WordPress API data into Svelte components
- Managing complex component hierarchies and dependencies

## Procedure

### 1. Design Token Analysis and Enhancement
- **Examine existing design token system** in `src/app.css`
- **Identify gaps** in token coverage (colors, typography, spacing, components)
- **Enhance CSS custom properties** with comprehensive token system
- **Create utility functions** for programmatic access to tokens
- **Test token consistency** across existing components

### 2. Base Component Development
- **Create foundational components**: Card, Button, Heading, Text, Badge, Avatar, Divider
- **Implement design token integration** using CSS custom properties
- **Add accessibility attributes** (role, aria-labels, proper semantic HTML)
- **Include responsive design** with mobile-first approach
- **Write comprehensive unit tests** using Vitest

### 3. TypeScript Interface Management
- **Analyze existing interfaces** (TribeOrganizer, TribeVenue, etc.)
- **Create enhanced interfaces** (EnhancedOrganizer, EnhancedVenue) with additional metadata
- **Update API functions** to fetch enhanced data with validation
- **Implement data sanitization** and error handling
- **Add caching strategies** for enhanced data

### 4. Component Integration Strategy
- **Map existing components** to new base components
- **Handle interface mismatches** by creating adapters or updating data sources
- **Ensure backward compatibility** during migration
- **Test component integration** in actual routes

### 5. Migration Implementation
- **Replace existing components** with new enhanced versions
- **Update route pages** to use new components
- **Handle data structure differences** between interface types
- **Test thoroughly** with real data from WordPress API
- **Fix linting and TypeScript errors** systematically

## Pitfalls to Avoid

### Interface Mismatches
- **Problem**: Components expect different interface structures than what routes provide
- **Solution**: Create adapters or update data sources to match expected interfaces
- **Prevention**: Validate interface compatibility before implementation

### CSS Conditional Issues
- **Problem**: Using Svelte conditionals (`{#if}`) in CSS blocks causes syntax errors
- **Solution**: Use regular CSS media queries and classes instead
- **Prevention**: Keep CSS blocks clean and avoid Svelte directives

### Component Property Conflicts
- **Problem**: Components don't accept expected props like `class`
- **Solution**: Study component APIs and use appropriate props
- **Prevention**: Read component source code before implementation

### Event Handler Syntax Mixing
- **Problem**: Mixing `on:click` and `onclick` syntax causes errors
- **Solution**: Use consistent syntax throughout the component
- **Prevention**: Choose one syntax style and stick to it

## Verification

### Design Token System
- [ ] All tokens are properly defined in CSS custom properties
- [ ] Components use tokens consistently throughout
- [ ] Token utility functions work correctly
- [ ] Theme system supports light/dark mode variations

### Component Functionality
- [ ] All components render correctly with sample data
- [ ] Accessibility attributes are properly implemented
- [ ] Responsive design works across screen sizes
- [ ] Event handlers function correctly

### TypeScript Integration
- [ ] All TypeScript errors are resolved
- [ ] Interfaces match expected data structures
- [ ] API functions return correct data types
- [ ] Unit tests pass without errors

### Integration Testing
- [ ] Routes use new components successfully
- [ ] Real WordPress API data displays correctly
- [ ] No regressions in existing functionality
- [ ] Performance is maintained or improved

### Performance and Quality
- [ ] Component build completes without errors
- [ ] Linting passes all rules
- [ ] Bundle size impact is acceptable
- [ ] Memory usage is optimized