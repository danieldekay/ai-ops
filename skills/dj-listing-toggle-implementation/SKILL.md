---
name: "dj-listing-toggle-implementation"
description: "Implement a toggle switch for DJ listing pages to show/hide all DJs regardless of event count, with proper UI styling and state management"
version: 1
created: "2026-05-10"
updated: "2026-05-10"
---
## When to Use

When working on DJ listing pages or similar content listing pages that need to toggle between filtered (showing only items with upcoming events) and unfiltered (showing all items) views. Particularly useful for WordPress CPT-based listings where some items may have zero events.

## Procedure

### 1. Analysis Phase
- Identify the current filtering logic in the listing page (typically `items.filter(item => item.countsByDateFilter[activeDateFilter] > 0)`)
- Locate the parent component that manages the listing state and active filters
- Identify the DJ/item card component that needs to handle zero-event states

### 2. State Management
- Add a reactive state variable for the toggle (e.g., `showAllDJs = $state(false)`)
- Implement the toggle logic: when active, remove the filtering condition; when inactive, apply the original filtering
- Store the toggle state in localStorage for persistence across sessions

### 3. UI Implementation
- Add a toggle switch component to the toolbar/filter section
- Include appropriate tooltip text that updates based on toggle state:
  - Active: "Alle DJs" or "Alle [ContentType]"
  - Inactive: "DJs mit bekannten Termine" or "[ContentType] mit bekannten Terminen"
- Style the toggle switch consistently with existing UI components

### 4. Card Component Updates
- Modify the DJ/item card to handle zero-event states gracefully
- Apply visual styling for zero-event items:
  - Amber highlighting (background or border color)
  - Reduced opacity to indicate limited information
  - Optional: Add an icon or badge indicating "keine Termine"
- Ensure all card data fields handle undefined/null values safely

### 5. Data Flow Updates
- Update the data fetching/computation to respect the toggle state
- Ensure the filtered/unfiltered logic works with both local data and API responses
- Test with various data scenarios (zero events, one event, multiple events)

### 6. Testing & Validation
- Verify the toggle functionality works in both directions
- Test backward compatibility (existing behavior when toggle is inactive)
- Check build compatibility and type safety
- Verify localStorage persistence works correctly
- Test responsive behavior on different screen sizes

## Pitfalls

- **State Synchronization**: Ensure the toggle state stays in sync between components and localStorage
- **Performance**: Be cautious with large datasets when showing all items
- **Accessibility**: Ensure the toggle switch is keyboard accessible and properly labeled
- **Data Consistency**: Handle edge cases where event counts might be undefined or null
- **CSS Conflicts**: Test that zero-event styling doesn't interfere with existing card styling

## Verification

- Toggle switch changes text appropriately based on state
- All DJs/items display when toggle is active
- Only DJs/items with events display when toggle is inactive
- Zero-event items have distinct visual styling
- Build passes without errors
- Type checking passes
- localStorage persistence works
- Responsive design maintained