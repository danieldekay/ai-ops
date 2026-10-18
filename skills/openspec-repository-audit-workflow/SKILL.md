---
name: "openspec-repository-audit-workflow"
description: "End-to-end repository architecture audit workflow using OpenSpec changes. Includes route catalog discovery, DRF viewset analysis, Clean Architecture layer validation, and bridge file auditing. Handles compressed token contexts and directory navigation across different project types."
version: 1
created: "2026-05-12"
updated: "2026-05-12"
---
## When to Use
Use when conducting comprehensive repository architecture audits, analyzing OpenSpec changes, validating Clean Architecture boundaries, or when working with complex Django/Svelte projects that need systematic codebase analysis.

## Procedure

### 1. Initial Setup
- Identify the target repository and scope (specific modules or entire codebase)
- Check for OpenSpec changes directory structure (`openspec/changes/`)
- Verify Clean Architecture layers are properly defined

### 2. Route Catalog Discovery
- Use `orient "<task>"` to start discovery
- Inventory tools: `get_schema_inventory`, `get_route_inventory`, `get_env_vars`, `get_ui_components`, `get_middleware_inventory`
- Document all API endpoints and their corresponding views/viewsets

### 3. DRF Viewset Analysis
- Analyze Django REST Framework viewsets for:
  - Proper inheritance from APIView/ViewSet
  - Serializer usage and validation
  - Permission classes and authentication
  - Queryset optimization
  - Response formatting consistency

### 4. Clean Architecture Validation
- Verify dependency rule: Domain ← Application ← Infrastructure/Presentation (never reversed)
- Check domain layer has zero framework imports
- Validate protocol definitions in application layer
- Ensure repository implementations in infrastructure layer

### 5. Bridge File Auditing
- Examine files that cross layer boundaries
- Verify proper abstractions and interfaces
- Check for circular dependencies
- Validate that infrastructure doesn't leak into domain

### 6. Compression Handling
- Use lean-ctx compressed outputs for large codebases
- Handle token-efficient directory exploration
- Navigate compressed contexts effectively

### 7. Documentation and Reporting
- Generate architecture violation reports
- Document layer boundary crossings
- Provide recommendations for refactoring
- Create migration plans for problematic areas

## Pitfalls
- Missing OpenSpec changes directory structure
- Improper layer boundary violations
- Circular dependencies between modules
- Unvalidated API endpoints
- Domain layer containing framework imports

## Verification
- Run `check_spec_drift` before finalizing audit
- Validate all route mappings are correct
- Ensure no architecture violations remain
- Test that all imports follow dependency rule