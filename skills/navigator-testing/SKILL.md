---
name: navigator-testing
description: Route to the right testing skill for Python/JS test suites, coverage, quality, or performance analysis. Use when deciding how to structure tests, improve coverage, fix flaky tests, or review test code quality.
---

# Navigator: Testing

Routes to testing skills in the `testing` long-tail category.

## Install for a session

```bash
# Install all testing skills (uninstall after session)
cd ~/.skills-longtail/testing && apm install

# Uninstall when done
cd ~/.skills-longtail/testing && apm uninstall
```

## Available Skills

| Skill | Use When |
|-------|----------|
| `pytest-testing` | TDD workflow, pytest fundamentals, CI integration |
| `pytest-patterns` | Fixtures, parametrization, mocking, test organization |
| `pytest-advanced` | Parallel execution, complex fixtures, markers |
| `pytest-coverage` | Coverage analysis, finding uncovered lines, reaching 100% |
| `pytest-optimizer` | Speed improvements, identifying flaky tests, suite health |
| `pytest-code-review` | Review test code: async patterns, fixtures, mocking |
| `playwright-best-practices` | E2E, component, API, accessibility, security browser tests |
| `agentic-eval` | LLM-as-judge, rubric-based eval, iterative improvement loops |
| `code-quality-review` | SvelteKit code smells, complexity audit, tech debt |

## Quick Decision

- Writing new Python tests → `pytest-patterns` or `pytest-testing`
- Improving an existing suite → `pytest-optimizer` or `pytest-coverage`
- E2E browser tests → `playwright-best-practices`
- Evaluating AI output quality → `agentic-eval`
