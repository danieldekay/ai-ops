---
name: "openspec-comprehensive-implementation"
description: "End-to-end OpenSpec implementation workflow for enhancing UI components with design tokens, API integrations, and comprehensive testing. Handles complex multi-phase changes with design systems, TypeScript interfaces, WordPress API enhancements, and component modernization."
version: 1
created: "2026-05-12"
updated: "2026-05-12"
---
## When to Use
Use this skill when implementing comprehensive OpenSpec changes that involve:
- Design token system creation and enhancement
- Base component development with TypeScript
- WordPress API integration with enhanced data structures
- Complex component refactoring and modernization
- Unit testing for enhanced components
- Multi-phase artifact-driven workflows

## Procedure

### Phase 1: Design Token System Implementation
1. **Enhance CSS custom properties** in `src/app.css`:
   - Add comprehensive color tokens (primary, secondary, accent, semantic, neutral)
   - Implement typography tokens (sizes, weights, line heights, spacing)
   - Create spacing and layout tokens (scale, padding, margins, borders)
   - Add component-specific tokens (buttons, cards, forms)
   - Implement responsive variants for all tokens

2. **Create design token utility functions** in `src/lib/utils/design-tokens.ts`:
   - Token extraction helpers
   - Theme management functions
   - Responsive utilities
   - Validation functions

### Phase 2: Base Component Development
1. **Create essential base components**:
   - `Card.svelte` - With variants (default, elevated, outlined)
   - `Button.svelte` - With multiple variants and accessibility
   - `Heading.svelte` - h1-h6 with responsive typography
   - `Text.svelte` - With size, weight, and color variants
   - `Badge.svelte` - With status and style variants
   - `Avatar.svelte` - With image fallback and status indicators
   - `Divider.svelte` - With orientation and spacing variants

2. **Implement accessibility features**:
   - ARIA attributes and roles
   - Keyboard navigation support
   - Screen reader friendly labels
   - Focus management

3. **Add responsive behavior**:
   - Mobile-first design approach
   - Breakpoint-based styling
   - Flexible layouts

4. **Write comprehensive unit tests**:
   - Component rendering tests
   - Event handling tests
   - Accessibility tests
   - Responsive behavior tests

### Phase 3: API Enhancement
1. **Extend TypeScript interfaces**:
   - Create enhanced organizer interfaces with social media, contact info
   - Enhance venue interfaces with location, accessibility, amenities
   - Implement event interfaces with enhanced organizer/venue data

2. **Update tribe.ts API functions**:
   - Add enhanced organizer and venue fetch functions
   - Implement data validation and sanitization
   - Add proper error handling and fallback mechanisms
   - Implement caching strategies for enhanced data

3. **Create supporting utilities**:
   - Data validation functions (`src/lib/utils/data-validation.ts`)
   - Error handling utilities (`src/lib/utils/error-handling.ts`)
   - Caching strategies (`src/lib/utils/caching.ts`)

### Phase 4: Enhanced Component Development
1. **Create specialized components**:
   - `OrganizerCard.svelte` - Using design tokens and base components
   - Venue cards with enhanced data display
   - Event cards with improved UX

2. **Integrate with existing components**:
   - Update existing components to use design tokens
   - Replace hardcoded CSS with token-based styling
   - Ensure accessibility compliance

3. **Write component-specific tests**:
   - Integration tests with API data
   - User interaction tests
   - Performance tests

### Phase 5: Testing and Quality Assurance
1. **Run comprehensive test suites**:
   - Unit tests for all components
   - Integration tests for API interactions
   - End-to-end tests for user flows
   - Accessibility tests

2. **Fix TypeScript and linting issues**:
   - Resolve type mismatches
   - Fix CSS validation warnings
   - Ensure code consistency

3. **Verify performance**:
   - Check bundle size impact
   - Test loading times
   - Validate caching effectiveness

## Pitfalls to Avoid

### Component Development Issues
- **Illegal variable names**: Avoid `$$dispatch` in Svelte components - use proper event handling
- **Import/export mismatches**: Always check component export structure before importing
- **TypeScript errors**: Use proper typing for component props and avoid `this` references in modern Svelte 5
- **CSS validation**: Ensure all CSS selectors match actual DOM structure

### API Enhancement Challenges
- **Type safety**: Properly define interfaces for enhanced data structures
- **Error handling**: Implement comprehensive fallback mechanisms for API failures
- **Data validation**: Sanitize and validate all incoming data from WordPress API
- **Caching strategies**: Use appropriate caching to balance performance and data freshness

### Testing Limitations
- **Test file syntax**: Use simplified data structures in tests to avoid type conflicts
- **Component mocking**: Mock external dependencies properly in test environments
- **Accessibility testing**: Use proper testing tools for accessibility compliance

## Verification Success

1. **Build verification**: Run `npm run build` to ensure no compilation errors
2. **Type checking**: Run `npm run check` for TypeScript validation
3. **Test execution**: Run test suites to verify all functionality
4. **Accessibility audit**: Use accessibility testing tools to verify compliance
5. **Performance testing**: Check loading times and bundle sizes
6. **Manual testing**: Test all user flows and interactions

## Integration Notes

- Always start with design token system before building components
- Use the existing WordPress API structure as foundation for enhancements
- Maintain backward compatibility with existing components
- Follow Svelte 5 best practices with runes and reactive patterns
- Ensure all components are responsive and accessible