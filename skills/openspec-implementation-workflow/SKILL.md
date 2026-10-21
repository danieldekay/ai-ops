---
name: "openspec-implementation-workflow"
description: "End-to-end OpenSpec change implementation workflow: status check, context reading, design-token systems, base components, TypeScript interfaces, API integration, testing, and quality gates. Use when implementing any OpenSpec change with UI/design-system work in a Svelte 5 / SvelteKit (or similar) project. This is THE consolidated OpenSpec implementation skill — do not create per-change variants."
author: Daniel Kaesmayr
metadata:
  version: "2.0.0"
  category: workflow
---

# OpenSpec Implementation Workflow

Consolidates the former per-change skills (comprehensive-implementation,
comprehensive-development-workflow, comprehensive-component-development,
spec-driven-development, svelte-component-implementation, component-migration,
enhanced-ui-implementation). One workflow, parameterized by the change's own
tasks.md — the change file IS the variant.

## When to Use

Implementing an OpenSpec change that involves any of:
- Design token systems (CSS custom properties, utility functions)
- Reusable component libraries (Card, Button, Heading, Text, Badge, Avatar, Divider)
- Accessibility attribute work (ARIA, keyboard, focus management)
- TypeScript interface extension and API integration
- Multi-phase, artifact-driven implementation

## Procedure

### Phase 1 — Setup and Discovery
1. `opsx status` → locate the change directory; never assume the path.
2. Read ALL context files: proposal.md, design.md, specs/\*.md, tasks.md.
3. Survey current project structure, existing components, and the existing
   token system before adding anything.

### Phase 2 — Design Token System (if the change touches design)
1. Enhance CSS custom properties (`src/app.css`): color, typography, spacing,
   component-specific tokens, responsive variants.
2. Extend token utilities (`src/lib/utils/design-tokens.*`): extraction,
   theme management, validation.
3. **Consistency rule**: use the existing token naming conventions; a
   conflicting parallel convention is a defect, not a style choice.

### Phase 3 — Base Components
1. Create/extend base components from design tokens (variants, slots).
2. Accessibility: ARIA attributes/roles, keyboard navigation, focus
   management, screen-reader labels — bind attributes to real elements.
3. Svelte 5: runes and reactive patterns; proper event handling (never
   `$$dispatch` / `$$props` legacy patterns); no `this` references.
4. Unit tests per component: rendering, events, a11y, responsive.

### Phase 4 — TypeScript Interfaces and API Integration
1. Extend TypeScript interfaces for the data the change introduces.
2. API layer: fetch functions with validation, sanitization, error fallbacks,
   caching where performance matters.
3. Supporting utilities (data-validation, error-handling, caching) before the
   components that need them.

### Phase 5 — Enhanced Components and Integration
1. Build the change's specific components from base components + tokens.
2. Migrate existing components to the token system (replace hardcoded CSS).
3. Integration tests: API data flows, user interaction, a11y compliance.

### Phase 6 — Verification
1. `npm run build` — zero compilation errors.
2. `npm run check` (or `tsc`) — type-clean.
3. Full test suites; a11y tooling pass.
4. Performance: bundle size, loading, cache effectiveness.
5. `--check --diff` replay of the change's verification steps.

## Pitfalls

- **Directory assumptions**: locate the change dir via CLI output every time.
- **Svelte 5 syntax**: modern runes; avoid `this` refs; correct export structure.
- **Type safety**: fully typed props and interfaces; no `any` escape hatches
  for API data — validate and sanitize instead.
- **Test typing**: simplified data structures in test fixtures to avoid type
  conflicts; mock external dependencies properly.
- **Token drift**: tokens before components, always; never hardcode what a
  token exists for.

## Verification

- Build + type-check green; all tests pass.
- Accessibility attributes functional (not just present).
- Design tokens applied consistently; no hardcoded values surviving.
- OpenSpec change tasks all marked complete; specs merged per
  `openspec-sync-specs` when archiving.
