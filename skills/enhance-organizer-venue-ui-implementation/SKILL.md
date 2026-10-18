---
name: "enhance-organizer-venue-ui-implementation"
description: "Complete implementation workflow for enhancing organizer and venue UI systems using SvelteKit design tokens, base components, and enhanced data models. Handles complex TypeScript integration, CSS design systems, and component composition patterns."
version: 1
created: "2026-05-12"
updated: "2026-05-12"
---
## When to Use
Use this skill when implementing comprehensive UI enhancements for organizer and venue systems in SvelteKit applications, particularly when working with design tokens, component libraries, and enhanced WordPress API data models.

## Procedure

### Phase 1: Design Token System Setup
1. **Enhance CSS custom properties** in `src/app.css`:
   - Add comprehensive color tokens (primary, secondary, accent, semantic, neutral)
   - Implement typography tokens (sizes, weights, line heights)
   - Create spacing and layout tokens (scales, padding, margins, borders)
   - Add component-specific tokens (buttons, cards, forms)

2. **Create design token utility functions** in `src/lib/utils/design-tokens.ts`:
   - Implement color utilities and theme functions
   - Create responsive helpers and breakpoint utilities
   - Add token validation and fallback mechanisms

### Phase 2: Base Component Implementation
1. **Create base components using design tokens**:
   - `Card.svelte` with variants (default, elevated, outlined) and responsive support
   - `Button.svelte` with multiple variants (primary, secondary, accent, outline, ghost)
   - `Heading.svelte` (h1-h6) with responsive sizing
   - `Text.svelte` with color and size variants
   - `Badge.svelte`, `Avatar.svelte`, `Divider.svelte` for additional UI elements

2. **Add accessibility attributes**:
   - Include proper ARIA labels and roles
   - Add keyboard navigation support
   - Implement focus management and visual feedback

3. **Implement responsive behavior**:
   - Add responsive props for padding, spacing, sizing
   - Use CSS media queries with token-based breakpoints
   - Ensure mobile-first design patterns

4. **Write comprehensive unit tests**:
   - Use Vitest for component testing
   - Test rendering, props, events, and accessibility
   - Include snapshot tests for visual consistency

### Phase 3: Enhanced Data Models
1. **Extend TypeScript interfaces**:
   - Create `EnhancedOrganizer` interface with social media, contact info, and metadata
   - Define `EnhancedVenue` interface with location details, accessibility info, and media assets
   - Create `EnhancedEvent` interface linking enhanced organizers and venues

2. **Update API functions** (`src/lib/api/tribe.ts`):
   - Add `fetchEnhancedOrganizers()` with metadata fetching
   - Implement `fetchEnhancedVenues()` with detailed venue data
   - Include error handling and validation

3. **Create supporting utilities**:
   - Data validation and sanitization functions (`src/lib/utils/data-validation.ts`)
   - Error handling mechanisms (`src/lib/utils/error-handling.ts`)
   - Caching strategies (`src/lib/utils/caching.ts`)

### Phase 4: Component Integration
1. **Create specialized components**:
   - `OrganizerCard.svelte` using all design tokens and base components
   - Integrate with enhanced organizer data models
   - Include profile images, bio, social links, and consistent styling

2. **Update existing components**:
   - Migrate hardcoded styles to design tokens
   - Ensure consistent button styling and sizing
   - Update color schemes and typography

3. **Implement accessibility features**:
   - Add proper ARIA attributes and roles
   - Ensure keyboard navigation and screen reader support
   - Test with accessibility tools

### Phase 5: Testing and Validation
1. **Write comprehensive tests**:
   - Unit tests for all components and utilities
   - Integration tests for API functions
   - End-to-end tests for user flows

2. **Validate implementation**:
   - Run TypeScript checks and fix type errors
   - Test responsive behavior across breakpoints
   - Verify accessibility compliance

## Pitfalls to Avoid

1. **TypeScript Type Mismatches**:
   - Always verify component prop types match expected values
   - Use proper TypeScript interfaces for data models
   - Handle null/undefined values gracefully

2. **CSS Selector Issues**:
   - Avoid unused CSS selectors that trigger linting errors
   - Use proper Svelte slot syntax when needed
   - Ensure class names match component prop expectations

3. **Component Integration**:
   - Check component exports are properly defined
   - Verify import paths and default exports
   - Test component composition and props passing

4. **Performance Considerations**:
   - Implement proper caching strategies for API data
   - Use lazy loading for heavy components
   - Optimize image loading and rendering

## Verification

1. **Technical Verification**:
   - Run `npm run check` for TypeScript validation
   - Execute test suite with `npm test`
   - Build project to verify no compilation errors

2. **Functional Verification**:
   - Test all UI components in browser
   - Verify responsive design on different screen sizes
   - Test accessibility with screen readers

3. **Code Quality**:
   - Ensure consistent code formatting and style
   - Verify all linting rules pass
   - Check for proper TypeScript usage throughout

This skill provides a comprehensive approach to implementing enhanced UI systems while maintaining code quality, accessibility, and performance standards.