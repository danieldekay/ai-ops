---
name: "openspec-spec-driven-development"
description: "End-to-end OpenSpec change implementation workflow for SvelteKit projects. Handles design token systems, component creation, API enhancements, testing, and integration with existing codebases."
version: 1
created: "2026-05-12"
updated: "2026-05-12"
---
## When to Use
Use this skill when implementing OpenSpec changes in SvelteKit projects, especially for UI/UX enhancements, component system overhauls, and API-driven feature implementations.

## Procedure

### 1. Setup and Discovery
- Use `opsx apply <change-name>` to start the implementation
- Check change status and understand the artifact structure
- Read all context files (design.md, proposal.md, specs/*.md, tasks.md)
- Verify the project structure matches the expected architecture

### 2. Design Token Implementation
- **CSS Custom Properties**: Create comprehensive design tokens in `src/app.css`
  - Color tokens (primary, secondary, accent, semantic, neutral scales)
  - Typography tokens (sizes, weights, line heights, spacing)
  - Layout tokens (padding, margins, borders, shadows)
  - Component-specific tokens (buttons, cards, forms)
- **Theme Integration**: Add corresponding `@theme` tokens for Svelte CSS variables
- **Utility Functions**: Create `src/lib/utils/design-tokens.ts` for token manipulation

### 3. Base Component Creation
- **Core Components**: Create reusable base components using design tokens
  - `Card.svelte` - Flexible container with variants (default, elevated, outlined)
  - `Button.svelte` - Multiple variants (primary, secondary, accent, outline, ghost)
  - `Heading.svelte` - H1-H6 with responsive typography
  - `Text.svelte` - Flexible text component with size, weight, color variants
  - `Badge.svelte` - Status and style indicators
  - `Avatar.svelte` - Profile picture display with fallbacks
  - `Divider.svelte` - Visual separators
- **Accessibility**: Add proper ARIA attributes and semantic HTML
- **Responsive Design**: Include responsive classes and mobile-first approach
- **Type Safety**: Ensure proper TypeScript interfaces and prop validation

### 4. Data Layer Enhancements
- **TypeScript Interfaces**: Extend existing interfaces with enhanced data structures
  - `EnhancedOrganizer` - Additional metadata (social media, contact, details, media)
  - `EnhancedVenue` - Extended venue information (location, accessibility, media)
  - `EnhancedEvent` - Events with enhanced organizer and venue references
- **API Functions**: Create enhanced API functions in `src/lib/api/tribe.ts`
  - `fetchEnhancedOrganizers()` - Fetch organizers with additional metadata
  - `fetchEnhancedVenues()` - Fetch venues with extended information
  - Include error handling and fallback mechanisms
- **Data Validation**: Implement sanitization and validation utilities
- **Caching Strategy**: Add intelligent caching for enhanced data

### 5. Advanced Component Development
- **Feature Components**: Create domain-specific components using base components
  - `OrganizerCard.svelte` - Comprehensive organizer profile display
  - Integrate with design tokens and base components
  - Include fallbacks for missing data
  - Add social media integration and contact information
- **Component Integration**: Update existing components to use new design tokens
  - Replace hardcoded CSS classes with design token classes
  - Ensure consistent styling across the application

### 6. Testing Implementation
- **Unit Tests**: Create comprehensive test suites for new components
  - Use Vitest with proper TypeScript setup
  - Test component rendering, props, and interactions
  - Include edge cases and error scenarios
- **Integration Tests**: Test API functions and data flow
- **Visual Testing**: Ensure consistent visual appearance across devices

### 7. Integration and Deployment
- **Route Updates**: Update existing routes to use new components
- **Backward Compatibility**: Ensure existing functionality remains intact
- **Performance Testing**: Verify no performance regressions
- **Build Verification**: Run `npm run build` and `npm run check`

## Pitfalls to Avoid

### Component Integration Issues
- **Problem**: Components don't support expected props like `class`
- **Solution**: Check component interfaces and use proper prop names
- **Prevention**: Review component documentation before implementation

### Type Safety Issues  
- **Problem**: TypeScript compilation errors during implementation
- **Solution**: Add proper type definitions and interface checks
- **Prevention**: Use strict TypeScript mode and validate interfaces

### CSS Selector Problems
- **Problem**: Unused CSS selectors flagged by Svelte
- **Solution**: Remove or rename unused selectors
- **Prevention**: Use CSS modules or proper scoping

### Test File Issues
- **Problem**: Syntax errors and missing imports in tests
- **Solution**: Fix imports and proper TypeScript syntax
- **Prevention**: Use existing test templates and patterns

### Performance Considerations
- **Problem**: Large component implementations affecting performance
- **Solution**: Code split and lazy load where appropriate
- **Prevention**: Monitor bundle size and runtime performance

## Verification

### Build Verification
```bash
npm run build    # Verify successful build
npm run check   # Verify TypeScript compilation
```

### Testing Verification
```bash
npm test        # Run all tests successfully
```

### Integration Verification
- Test all updated routes and components
- Verify backward compatibility
- Check visual consistency across devices

### Performance Verification
- Monitor page load times
- Check bundle size impact
- Verify no memory leaks