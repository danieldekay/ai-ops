---
name: "comprehensive-svelte-component-development"
description: "End-to-end Svelte 5 component development with design tokens, TypeScript, and testing. Use when building complex UI components that need to integrate with design systems, handle multiple variants, include accessibility features, and have comprehensive test coverage."
version: 1
created: "2026-05-12"
updated: "2026-05-12"
---
# Comprehensive Svelte Component Development

## When to Use
Use this skill when developing complex Svelte 5 components that require:
- Integration with design token systems
- Multiple variants and responsive design
- Accessibility features and proper ARIA attributes
- TypeScript interface definitions
- Comprehensive unit testing with Vitest
- Error handling and fallback mechanisms
- Component integration with existing codebase

## Procedure

### 1. Component Planning and Design
1. **Define Component Interface**
   - Create TypeScript interfaces that match the expected data structure
   - Extend existing base types when possible
   - Include optional properties for flexibility

2. **Design Token Integration**
   - Reference existing CSS custom properties from `src/app.css`
   - Use token names like `color-primary`, `spacing-md`, `text-lg`
   - Ensure responsive variants are included

3. **Component Structure Planning**
   - Plan the component hierarchy and slots
   - Determine which base components to use (Card, Button, Text, etc.)
   - Plan accessibility features and ARIA attributes

### 2. Component Implementation
1. **Create Component File**
   ```typescript
   // src/lib/components/ComponentName.svelte
   <script lang="ts">
     export interface ComponentProps {
       // Define props with proper TypeScript types
       variant?: 'default' | 'primary' | 'secondary';
       disabled?: boolean;
       ariaLabel?: string;
     }
     
     export let variant: ComponentProps['variant'] = 'default';
     export let disabled: ComponentProps['disabled'] = false;
     export let ariaLabel: ComponentProps['ariaLabel'] = null;
   </script>
   ```

2. **Implement with Design Tokens**
   - Use CSS custom properties: `class="text-text-primary"`
   - Apply spacing tokens: `class="p-spacing-md"`
   - Use color tokens: `class="bg-primary-500"`

3. **Add Accessibility Features**
   - Include proper ARIA attributes: `aria-label`, `aria-labelledby`
   - Use semantic HTML elements
   - Ensure keyboard navigation works
   - Add role attributes when necessary

4. **Handle Responsive Design**
   - Use responsive variants in class names
   - Consider mobile-first approach
   - Test on different screen sizes

### 3. Error Handling and Fallbacks
1. **Implement Error Boundaries**
   - Handle missing data gracefully
   - Provide fallback UI for missing images
   - Show loading states when appropriate

2. **Type Safety**
   - Use proper TypeScript casting for uncertain data
   - Handle null/undefined values with optional chaining
   - Provide default values for required properties

### 4. Testing Implementation
1. **Create Test File**
   ```typescript
   // src/lib/components/ComponentName.test.svelte
   import { render, screen } from '@testing-library/svelte';
   import ComponentName from './ComponentName.svelte';
   
   describe('ComponentName', () => {
     test('renders with default props', () => {
       const { component } = render(ComponentName);
       // Test implementation
     });
   });
   ```

2. **Test Coverage Areas**
   - Component rendering with different props
   - Accessibility features
   - Event handling
   - Error states
   - Responsive behavior

### 5. Integration and Documentation
1. **Update Imports**
   - Ensure component is properly exported
   - Update importing files with correct syntax

2. **Add Documentation**
   - Include JSDoc comments for public APIs
   - Document prop types and default values
   - Provide usage examples

## Pitfalls to Avoid

### Interface Mismatches
- **Problem**: Component expects different interface than provided
- **Solution**: Always verify data structure matches interface definition
- **Prevention**: Use TypeScript `extends` to build on existing types

### CSS Selector Issues
- **Problem**: Unused CSS selectors causing linting errors
- **Solution**: Use consistent naming and remove unused selectors
- **Prevention**: Test component thoroughly in isolation

### Import/Export Issues
- **Problem**: Incorrect import/export syntax
- **Solution**: Match actual component export structure
- **Prevention**: Check existing components for reference

### TypeScript Errors
- **Problem**: Type mismatches and missing properties
- **Solution**: Use proper type casting and optional chaining
- **Prevention**: Define comprehensive interfaces upfront

## Verification

### Test Checklist
- [ ] Component renders correctly with default props
- [ ] All variants work as expected
- [ ] Accessibility features are functional
- [ ] Error states are handled gracefully
- [ ] Responsive design works on different screen sizes
- [ ] All tests pass without linting errors

### Integration Checklist
- [ ] Component imports correctly in target files
- [ ] Design tokens are properly applied
- [ ] No TypeScript compilation errors
- [ ] Component integrates seamlessly with existing UI
- [ ] Performance is acceptable (no unnecessary re-renders)

## Advanced Tips

1. **Component Composition**: Use base components (Card, Button, Text) as building blocks
2. **Design Token Consistency**: Always use existing tokens rather than hardcoded values
3. **Accessibility First**: Implement accessibility features from the start
4. **TypeScript Safety**: Leverage TypeScript for compile-time error checking
5. **Testing Coverage**: Aim for comprehensive test coverage including edge cases

## Related Patterns
- Design token integration patterns
- Svelte 5 runes and reactive programming
- TypeScript interface inheritance
- Component testing methodologies
- Accessibility best practices