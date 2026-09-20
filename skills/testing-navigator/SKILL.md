---
name: testing-navigator
description: Route to the right testing skill for Python/JS test suites, coverage, quality, or performance analysis. Use when deciding how to structure tests, improve coverage, fix flaky tests, or review test code quality.
---

# Testing Navigator

Routes to testing skills in `~/.skills-longtail/testing/`. Install for the session, uninstall after.

## Available Skills

| Skill | Use When | Install |
|-------|----------|---------|
| `pytest-testing` | TDD workflow, pytest fundamentals, CI integration | `apm install -g laurigates/claude-plugins/skills/pytest-testing/` |
| `pytest-patterns` | Fixtures, parametrization, mocking, test organization | `apm install -g laurigates/claude-plugins/skills/pytest-patterns/` |
| `pytest-advanced` | Parallel execution, complex fixtures, markers | `apm install -g laurigates/claude-plugins/skills/pytest-advanced/` |
| `pytest-coverage` | Coverage analysis, finding uncovered lines, reaching 100% | `apm install -g laurigates/claude-plugins/skills/pytest-coverage/` |
| `pytest-optimizer` | Speed improvements, identifying flaky tests, suite health | `apm install -g laurigates/claude-plugins/skills/pytest-optimizer/` |
| `pytest-code-review` | Review test code: async patterns, fixtures, mocking | `apm install -g laurigates/claude-plugins/skills/pytest-code-review/` |
| `playwright-best-practices` | E2E, component, API, accessibility, security browser tests | `apm install -g danieldekay/ai-ops/skills/playwright-best-practices/` |
| `agentic-eval` | LLM-as-judge, rubric-based eval, iterative improvement loops | `apm install -g danieldekay/ai-ops/skills/agentic-eval/` |
| `code-quality-review` | SvelteKit code smells, complexity audit, tech debt | `apm install -g danieldekay/ai-ops/skills/code-quality-review/` |

## Quick Decision

- Writing new Python tests → `pytest-patterns` or `pytest-testing`
- Improving an existing suite → `pytest-optimizer` or `pytest-coverage`
- E2E browser tests → `playwright-best-practices`
- Evaluating AI output quality → `agentic-eval`
