---
name: "openspec-repository-audit-workflow"
description: "End-to-end repository architecture audit workflow using OpenSpec changes: route catalog discovery, DRF viewset analysis, Clean Architecture layer validation, bridge file auditing, and spec-drift checks. Works with lean-ctx compressed token contexts across Django/Svelte (or similar layered) projects. Consolidates the former openspec-audit-repository-architecture skill."
author: Daniel Kaesmayr
metadata:
  version: "2.0.0"
  category: workflow
---

# OpenSpec Repository Audit Workflow

Consolidates the former `openspec-audit-repository-architecture` (identical
description, drifted body). One audit workflow.

## When to Use

Comprehensive repository architecture audits, analyzing OpenSpec changes,
validating Clean Architecture boundaries, or systematically auditing layered
Django/Svelte projects.

## Procedure

### 1. Setup and Context
- Identify target repository and scope (modules or entire codebase).
- Check `openspec/changes/` structure; read the change's context files
  (design.md, proposal.md, specs/, tasks/).
- Load lean-ctx compressed token contexts for large codebases
  (`lean-ctx compose "<task>"`, token-efficient directory exploration).

### 2. Route Catalog Discovery
- Start discovery with `orient "<task>"`.
- Inventory: schema, routes, env vars, UI components, middleware.
- Locate the root URL config and all `include()` sub-routers and DRF
  `DefaultRouter` registrations.
- Extract supported HTTP methods (metadata endpoints first; fall back to
  class-level `http_method_names` inspection when absent).
- Build a Markdown route catalog: method, URL pattern, view class/function,
  owning spec domain. Flag routes with missing method classifications.

### 3. DRF Viewset Analysis
- Proper inheritance (APIView/ViewSet), serializer usage and validation,
  permission classes and authentication, queryset optimization, response
  formatting consistency.

### 4. Clean Architecture Validation
- Dependency rule: Domain ← Application ← Infrastructure/Presentation,
  never reversed.
- Domain layer has zero framework imports; protocols in application layer;
  repository implementations in infrastructure layer.

### 5. Bridge File Auditing
- Examine high-connectivity files crossing layer boundaries.
- Verify proper abstractions/interfaces; check circular dependencies;
  confirm infrastructure doesn't leak into domain.
- Distinguish NECESSARY coupling from problematic coupling — bridge files
  may serve legitimate purposes.

### 6. Spec-Gen Integration and Drift
- Review `.spec-gen/analysis/SUMMARY.md` for architectural findings.
- Validate spec inventory against the actual implementation; identify gaps.
- Run `check_spec_drift` before finalizing the audit.

### 7. Documentation and Reporting
- Generate architecture violation reports and layer-boundary crossing docs.
- Produce a Clean Architecture compliance report with refactoring
  recommendations and migration plans for problem areas.
- Update the OpenSpec change's task progress and remaining counts.

## Pitfalls

- Context switching between Django and Svelte project contexts.
- Token compression: use lean-ctx modes appropriately to avoid information loss.
- DRF viewsets without metadata endpoints — fall back to class inspection.
- Missing OpenSpec changes directory structure; unvalidated API endpoints;
  domain layer with framework imports; circular module dependencies.

## Verification

- `check_spec_drift` run before finalizing.
- All route mappings validated; no architecture violations unresolved.
- All imports follow the dependency rule.
