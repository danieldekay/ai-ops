---
name: "openspec-comprehensive-component-development"
description: "End-to-end OpenSpec-driven component development workflow for complex UI enhancements. Systematic approach to implementing design tokens, base components, specific components, API enhancements, validation, caching, and testing with proper TypeScript interface management."
version: 1
created: "2026-05-12"
updated: "2026-05-12"
---
## When to Use
Use this skill when implementing comprehensive OpenSpec changes with multiple components, design tokens, API enhancements, and testing requirements. Ideal for complex UI refactoring projects with 20+ tasks.

## Procedure

### Phase 1: Design Token System Setup
1. **Create comprehensive CSS custom properties** in app.css:
   - Color tokens (primary, secondary, accent, semantic, neutral scales)
   - Typography tokens (sizes, weights, line heights)
   - Spacing tokens (padding, margins, borders)
   - Component-specific tokens (buttons, cards, forms)
   - Theme tokens for consistent styling

2. **Implement design token utility functions** in `src/lib/utils/design-tokens.ts`:
   - Token access functions
   - Validation helpers
   - Responsive design utilities

### Phase 2: Base Component Implementation
3. **Create base components** using design tokens:
   - Card component with variants (default, elevated, outlined)
   - Button component with multiple variants and accessibility
   - Heading components (h1-h6) with responsive sizing
   - Text component with color and size variants
   - Additional components (Badge, Avatar, Divider)

4. **Add accessibility attributes** to all base components:
   - Proper ARIA labels and roles
   - Keyboard navigation support
   - Screen reader compatibility

5. **Implement responsive behavior**:
   - Mobile-first approach
   - Responsive padding and sizing
   - Touch-friendly interactions

### Phase 3: Specific Component Development
6. **Create specialized components** (OrganizerCard, VenueCard):
   - Use base components and design tokens
   - Implement proper TypeScript interfaces
   - Add comprehensive error handling
   - Include fallback mechanisms for missing data

7. **Handle interface mismatches**:
   - Ensure component interfaces match data structures
   - Create proper type adapters if needed
   - Validate prop types thoroughly

### Phase 4: API Enhancements
8. **Extend TypeScript interfaces** for enhanced data:
   - Add organizer metadata (social media, contact, details)
   - Enhance venue data with location and accessibility info
   - Create comprehensive event interfaces

9. **Update API functions**:
   - Fetch additional metadata from WordPress REST API
   - Implement data validation and sanitization
   - Add proper error handling and fallback mechanisms

10. **Implement caching strategy**:
    - Cache enhanced data for performance
    - Implement cache invalidation
    - Add offline support capabilities

### Phase 5: Testing and Integration
11. **Write comprehensive unit tests**:
    - Test base components with various scenarios
    - Validate API functions with mock data
    - Test error handling and edge cases

12. **Update existing components** to use design tokens:
    - Replace hardcoded CSS with token references
    - Ensure consistent styling across the application
    - Verify responsive behavior

13. **Update routes** to use new components:
    - Replace existing component implementations
    - Ensure data compatibility
    - Test complete user flows

## Pitfalls to Avoid
- **Interface mismatches**: Always verify component interfaces match route data structures
- **Svelte syntax errors**: Avoid JSX comments in .svelte files, use proper Svelte syntax
- **CSS selector issues**: Use component-scoped selectors to avoid linting errors
- **Prop validation**: Components have strict prop validation requiring exact type matches
- **TypeScript errors**: Properly type all props and handle null/undefined values
- **Event handling**: Use standard Svelte events instead of $$dispatch

## Verification
- Run `npm run check` for TypeScript validation
- Check all components for linting errors
- Verify design tokens are applied consistently
- Test API functions with actual data
- Ensure responsive design works on all screen sizes
- Test accessibility features with screen readers