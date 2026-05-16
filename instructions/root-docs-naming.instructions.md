---
description: "Naming conventions for root documentation: SCREAMING_CAPS.md for project-level reference docs"
applyTo: "*.md"
---

# Root Documentation Naming Conventions

**Scope**: `*.md` (root directory only)

## File Header (Required)

Root documentation MUST start with purpose statement:

```markdown
# Document Title

**Purpose**: Why this document exists
**Last Updated**: YYYY-MM-DD
**Audience**: Who should read this (developers, AI agents, users)
```

**Example**:

```markdown
# AGENTS.md

**Purpose**: AI coding assistant instructions for TangoAtlas
**Last Updated**: 2026-01-18
**Audience**: AI agents, human developers
```

## Project-Level Reference Docs: SCREAMING_CAPS.md

**Allowed in Root**:

- `README.md` - Project overview and quick start
- `AGENTS.md` - AI coding assistant instructions
- `COMMANDS.md` - Quick command reference
- `CHANGELOG.md` - Version history

**Must Move to Subdirectories**:

- `FORM_*.md` → `docs/incidents/YYYY-MM-DD-*.md`
- `LINK_*.md` → `docs/incidents/YYYY-MM-DD-*.md`
- `*_FIX.md` → `docs/incidents/YYYY-MM-DD-*.md`
- `*_IMPROVEMENTS.md` → `docs/incidents/YYYY-MM-DD-*.md`

**Examples**:

- ✅ Root: `README.md`, `AGENTS.md`, `CHANGELOG.md`
- ❌ Root: `FORM_VALIDATION_FIX.md` (incident → docs/incidents/)
- ❌ Root: `API_DOCUMENTATION.md` (detailed doc → docs/)
