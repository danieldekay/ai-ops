---
name: "openspec-audit-repository-architecture"
description: "End-to-end repository architecture audit workflow using OpenSpec changes. Includes route catalog discovery, DRF viewset analysis, Clean Architecture layer validation, and bridge file auditing. Handles compressed token contexts and directory navigation across different project types."
version: 1
created: "2026-05-11"
updated: "2026-05-11"
---
## When to Use

Use this skill when implementing OpenSpec changes that involve repository architecture auditing, route catalog discovery, or Clean Architecture validation. Particularly useful when working with:
- OpenSpec changes in the `openspec/changes/` directory
- Repository architecture audits that require route discovery
- DRF viewset and API route analysis
- Clean Architecture layer boundary validation
- Projects with compressed token contexts and directory navigation needs

## Procedure

### Phase 1: Context Setup and Project Navigation
1. **Navigate to OpenSpec change directory**
   - Locate the specific change in `openspec/changes/[change-name]/`
   - Read the `changeDir` context to understand the project scope
   - Check if working in Django (TangoAtlas) or Svelte project context

2. **Load compressed token contexts**
   - Use `lean-ctx` tools for compressed directory exploration
   - Handle token-efficient navigation across project boundaries
   - Load necessary context files (design.md, proposal.md, specs/, tasks/)

### Phase 2: Route Catalog Discovery
1. **Locate Django URL configuration**
   - Find root Django URL config (`src/tangoatlas/asgi.py` or `urls.py`)
   - Identify all `include()` calls for sub-routers
   - Locate DRF `DefaultRouter` registrations

2. **Analyze DRF viewsets**
   - Extract supported HTTP methods from metadata endpoints
   - Use class-level `http_method_names` attribute
   - Map HTTP methods to URL patterns and view classes

3. **Build route catalog**
   - Create Markdown table mapping: HTTP method, URL pattern, view class/function, owning spec domain
   - Flag routes with missing method classifications
   - Validate against API spec requirements

### Phase 3: Architecture Layer Validation
1. **Clean Architecture boundary check**
   - Validate import rules: Domain ← Application ← Infrastructure/Presentation
   - Identify any reversed dependencies that violate the Dependency Rule

2. **Bridge file auditing**
   - Locate high-connectivity files that span across layers
   - Audit files like `user.py`, `user_map.py`, `user_search.py`
   - Assess cross-layer coupling and identify potential refactoring opportunities

3. **Spec-gen analysis integration**
   - Review `.spec-gen/analysis/SUMMARY.md` for architectural findings
   - Validate spec inventory against actual implementation
   - Identify gaps between spec and reality

### Phase 4: Documentation and Output
1. **Generate audit artifacts**
   - Create comprehensive route catalog documentation
   - Document architecture violations and recommendations
   - Produce Clean Architecture compliance report

2. **Update OpenSpec progress**
   - Mark completed tasks in progress tracking
   - Update remaining task counts
   - Ensure all audit findings are properly documented

## Pitfalls

- **Context switching**: Be careful when navigating between Django and Svelte project contexts
- **Token compression**: Handle compressed token contexts appropriately to avoid information loss
- **DRF metadata**: Some DRF viewsets may not have metadata endpoints requiring fallback to class inspection
- **Cross-layer files**: Bridge files may serve legitimate purposes despite spanning layers - distinguish between necessary and problematic coupling

## Verification

- Complete all tasks in the OpenSpec change's `tasks.md`
- Validate that all 260+ Django routes are properly classified with HTTP methods
- Ensure Clean Architecture boundaries are respected or documented violations
- Confirm bridge file audit identifies appropriate coupling issues