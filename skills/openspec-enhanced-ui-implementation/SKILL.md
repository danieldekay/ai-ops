---
name: "openspec-enhanced-ui-implementation"
description: "Implement complex OpenSpec changes for enhanced UI components with design tokens, TypeScript interfaces, and API extensions. Use for implementing multi-step UI enhancement tasks that involve design systems, data modeling, and component development."
version: 1
created: "2026-05-11"
updated: "2026-05-11"
---
## When to Use
Use this skill when implementing complex OpenSpec changes that involve:
- Enhanced UI component systems with design tokens
- TypeScript interface extensions for complex data models
- API function enhancements for additional metadata
- Data validation and error handling utilities
- Unit testing for new components
- Multi-step implementation tasks requiring careful sequencing

## Procedure
1. **Analyze OpenSpec Requirements**
   - Read all context files (design.md, proposal.md, specs/, tasks.md)
   - Understand current state and existing implementations
   - Identify dependencies between tasks

2. **Design Token System Implementation**
   - Enhance CSS custom properties with comprehensive design tokens
   - Implement color scales (primary, secondary, accent, semantic, neutral)
   - Add typography tokens (sizes, weights, line heights, spacing)
   - Create spacing and layout tokens
   - Add component-specific tokens (buttons, cards, forms)

3. **Base Component Development**
   - Create reusable base components using design tokens
   - Implement accessibility attributes (role, aria-label, id)
   - Add responsive behavior with CSS classes
   - Include proper TypeScript typing
   - Create unit tests with Vitest

4. **TypeScript Interface Enhancement**
   - Extend existing interfaces for enhanced data models
   - Add optional fields for new metadata
   - Create proper type definitions for API responses
   - Handle null values and optional properties correctly

5. **API Function Extensions**
   - Enhance existing API functions to fetch additional metadata
   - Add data transformation functions
   - Implement proper error handling and fallback mechanisms
   - Use validation functions to ensure data integrity

6. **Testing and Validation**
   - Write comprehensive unit tests for all new components
   - Test edge cases and error scenarios
   - Verify TypeScript compilation passes
   - Ensure accessibility attributes work correctly

## Pitfalls to Avoid
- **TypeScript Null Handling**: Always handle null values from API responses properly
- **Svelte Event Handling**: Use proper Svelte event patterns, avoid illegal variable names like $$dispatch
- **Component Property Exports**: Either use exported properties in templates or convert to const exports
- **Sequential Dependencies**: Some tasks depend on others being completed first
- **Testing Framework**: Use Vitest patterns consistent with existing project structure

## Verification
- Run `npm run check` for TypeScript compilation
- Run `npm run test` for unit tests
- Verify all components render correctly in browser
- Check accessibility with screen readers
- Test responsive behavior on different screen sizes