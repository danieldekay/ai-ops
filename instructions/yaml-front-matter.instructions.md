---
description: "YAML front matter requirements for all instruction, prompt, agent, and chatmode files"
applyTo: ".github/**/*.md"
---

# YAML Front Matter Requirements

**Scope**: All files in `.github/instructions/`, `.github/prompts/`, `.github/agents/`, `.github/chatmodes/`

## Required Format

All files MUST start with YAML front matter enclosed in `---` delimiters:

```yaml
---
description: "Brief description of file purpose"
# Additional fields based on file type (see below)
---
```

## File Type Requirements

### Instruction Files (`.instructions.md`)

**Required fields**:

- `description`: Brief description of what this instruction file covers
- `applyTo`: Glob pattern(s) for files this instruction applies to

**Example**:

```yaml
---
description: "Clean Architecture guidelines for authentication domain and application layers"
applyTo: "src/tangoatlas/domain/auth/**, src/tangoatlas/application/auth/**"
---
```

### Prompt Files (`.prompt.md`)

**Required fields**:

- `description`: Brief description of the prompt's purpose

**Optional fields**:

- `agent`: Associated agent identifier (if applicable)

**Example**:

```yaml
---
description: "Generate specification documents for new or existing functionality"
agent: "speckit.specify"
---
```

### Agent Files (`.agent.md`)

**Required fields**:

- `description`: Brief description of the agent's purpose
- `tools`: Array of tool names the agent can use

**Example**:

```yaml
---
description: "Generate or update specification documents for new or existing functionality"
tools: ["changes", "search/codebase", "edit/editFiles", "extensions", "fetch"]
---
```

### Chatmode Files (`.chatmode.md`)

**Required fields**:

- `description`: Brief description of the chatmode's purpose
- `tools`: Array of tool names available in this mode

**Example**:

```yaml
---
description: "Expert prompt engineering and validation system for creating high-quality prompts"
tools:
  [
    "vscode",
    "read/readFile",
    "tavily/*",
    "edit/createFile",
    "search",
    "web",
    "todo",
  ]
---
```

## Common Mistakes

❌ **Missing front matter entirely**:

```markdown
# My Instructions

This file has no YAML front matter...
```

❌ **Missing closing delimiter**:

```yaml
---
description: "My description"
# Missing closing ---

# My Instructions
```

❌ **Wrong field names**:

```yaml
---
title: "My Instructions" # Should be 'description'
scope: "src/**" # Should be 'applyTo' for .instructions.md
---
```

✅ **Correct format**:

```yaml
---
description: "Domain layer purity and framework independence rules"
applyTo: "src/tangoatlas/domain/**"
---
# Domain Layer Instructions
```

## Validation

GitHub Copilot uses this front matter to:

- Index and categorize files
- Apply context-specific instructions
- Route prompts to appropriate agents
- Enable/disable tools based on mode

Missing or incorrect front matter may cause files to be ignored by GitHub Copilot.
