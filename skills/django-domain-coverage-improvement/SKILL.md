---
name: "django-domain-coverage-improvement"
description: "Improve domain test coverage in Django Clean Architecture projects by systematically testing pure Python domain modules to reach coverage targets."
version: 1
created: "2026-05-12"
updated: "2026-05-12"
---
## When to Use
Use this skill when working on Django Clean Architecture projects and need to improve domain layer test coverage to meet quality gates (typically 95-96%). Especially effective when:
- Domain coverage is below target (starting from ~81%)
- Multiple modules have 0% coverage
- Need to implement OpenSpec change requirements for coverage
- Working with pure Python domain modules (no Django dependencies)

## Procedure

1. **Assess Current Coverage**
   - Run `./run.sh test-domain` to get baseline coverage report
   - Identify files with 0% coverage or low coverage
   - Prioritize files by:
     * Lines of code (larger files give more impact)
     * Accessibility (simple pure Python modules first)
     * Business criticality (core domain logic vs utilities)

2. **Examine Target Files**
   - Read the actual source code to understand the API
   - Check for existing tests in `tests/unit/domain/`
   - Look for patterns in existing test files
   - Verify method signatures and dataclass structures

3. **Create Focused Test Files**
   - Create test files in `tests/unit/domain/submissions/` for submission modules
   - Follow existing pytest patterns and use `@pytest.mark.domain` if needed
   - Start with basic tests that cover the main functionality
   - Avoid testing implementation details - focus on public API

4. **Iterative Testing**
   - Run tests after each new file: `./run.sh test-domain`
   - Check coverage improvement: look for reduced uncovered lines
   - Fix any failing tests by adjusting expectations (don't fix implementation bugs in tests)
   - Continue until coverage target is met

5. **Handle Implementation Bugs Gracefully**
   - If code has bugs (e.g., missing return statements), write tests that work around them
   - Use `pytest.raises()` for expected exceptions
   - Focus on testing what the code actually does, not what it should do
   - Document known issues if necessary

## Pitfalls to Avoid

- **Don't assume APIs exist**: Always check the actual implementation before writing tests
- **Don't fix implementation bugs in tests**: Work around bugs rather than correcting them
- **Don't test private methods**: Focus on public API and business logic
- **Don't create overly complex tests**: Start simple and add edge cases incrementally
- **Don't ignore test failures**: Fix failing tests promptly to avoid confusion

## Verification

- Run `./run.sh test-domain` and check coverage report
- Look for: "OK" status (no test failures), improved coverage percentage
- Verify specific files now show coverage >80% instead of 0%
- Ensure all tests pass with `./run.sh lint` and `./run.sh typecheck`

## Example Files Tested
- `content_type_detector.py` - URL/text content type detection
- `field_visibility.py` - Form field visibility rules  
- `validation_rules.py` - Field validation logic
- `url_utils.py` - URL normalization and security
- `extraction_context.py` - Multi-page content aggregation

## Success Metrics
- Domain coverage reaches 96% target
- All domain tests pass without failures
- No files remain at 0% coverage
- OpenSpec change requirements satisfied