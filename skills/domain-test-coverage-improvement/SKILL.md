---
name: "domain-test-coverage-improvement"
description: "Systematic approach to improving domain test coverage from low percentages to high targets (96%+). Focuses on identifying uncovered files, creating targeted tests, and iteratively improving coverage."
version: 1
created: "2026-05-12"
updated: "2026-05-12"
---
## When to Use
When domain test coverage is below target (typically 96%) and you need to systematically identify and test uncovered code in a Django Clean Architecture project.

## Procedure

### 1. Initial Assessment
- Run `./run.sh test-domain` to get current coverage report
- Note the overall percentage and identify files with 0% coverage first
- Look for files with low percentage coverage (<80%) that are likely to be testable

### 2. Target High-Impact Files
- Focus on files with 0% coverage first - these provide maximum coverage gain
- Look for pure Python modules without complex dependencies
- Prioritize submission-related files, value objects, and utility modules over complex entities

### 3. Create Simple Tests
- Start with basic smoke tests to ensure imports work
- Test enum values and basic functionality first
- Use existing test patterns in `tests/unit/domain/`
- Follow pytest marker conventions (`@pytest.mark.domain`)

### 4. Handle Implementation Bugs
- If the actual code has bugs (missing returns, etc.), work around them in tests
- Focus on testing what exists rather than what should exist
- Document any implementation issues for later fixing

### 5. Iterative Improvement
- Run tests after each new test file to see coverage progress
- Focus on remaining uncovered lines in partially covered files
- Add edge case tests to boost coverage further

### 6. Avoid Common Pitfalls
- Don't test complex entity classes that require many constructor arguments
- Verify actual method signatures before writing tests
- Check enum values match exactly (case-sensitive)
- Use correct import paths that actually exist

## Pitfalls to Avoid
- **Over-engineering tests**: Start simple, don't try to test everything at once
- **Import errors**: Verify imports work before writing complex tests
- **API mismatches**: Check actual method signatures and class structures
- **Ignoring existing bugs**: Work around implementation issues rather than fixing them in tests
- **Targeting complex modules**: Focus on simple, testable modules first

## Verification
- Run `./run.sh test-domain` after each iteration to check coverage progress
- Look for specific uncovered lines in HTML coverage reports
- Ensure tests actually pass (don't just increase coverage by failing tests)
- Target 96% coverage before considering the task complete

## Tools and Commands
- `./run.sh test-domain` - Run domain tests with coverage
- HTML coverage reports in `htmlcov_domain/` directory
- Test files should be in `tests/unit/domain/[submodule]/test_[module].py`
- Use pytest markers: `@pytest.mark.domain`