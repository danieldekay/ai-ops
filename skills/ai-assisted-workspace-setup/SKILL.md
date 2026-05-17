---
name: ai-assisted-workspace-setup
description: "Diagnose a machine and set up a developer environment with VS Code, GitHub Copilot, Node.js, and Python. Supports use-case-specific tracks: data science (Python/R), AI-assisted development, web development, and general programming. Installs packages per use case with reporting from Markdown to Quarto. Use when: setting up a new machine, onboarding a developer, bootstrapping a dev environment, data science environment, R setup, Python data science, Quarto, Jupyter, AI dev environment, checking what is installed, detecting package managers, checking user permissions, OS detection, Windows/Mac/Linux setup, environment audit."
argument-hint: "Optional: target use case or tool list (e.g. 'data science with Python' or 'only node and python')"
---

# AI-Assisted Workspace Setup

Sets up a developer environment on any OS, tailored to the user's **use case**. Covers base tooling (VS Code + GitHub Copilot, Node.js, Python), then branches into use-case-specific packages: data science (Python or R), AI-assisted development, web development, or general programming. Reporting capability starts with **Markdown** and upgrades to **Quarto** where supported.

> **Agent instruction**: Use `vscode_askQuestions` at every decision point listed in this skill. Never assume a use case, language, or package preference — always ask first. Gather answers in batches (one `vscode_askQuestions` call per logical group) to minimise interruptions.

## When to Use

- Setting up a brand-new machine or onboarding a developer
- Configuring a data science or AI development environment
- Adding a reporting pipeline (Markdown / Quarto)
- Auditing what is installed before adding tools
- Checking permissions before attempting installs

---

## Phase 0 — Gather Use Case Intent

**Before running any diagnostics**, interview the user with `vscode_askQuestions`.

### 0.1 — Primary Use Case

```
vscode_askQuestions([
  {
    header: "Primary use case",
    question: "What will you primarily use this workspace for?",
    options: [
      { label: "Data Science / Analysis", description: "Python or R, notebooks, reporting" },
      { label: "AI-Assisted Development", description: "LLMs, embeddings, agent frameworks" },
      { label: "Web Development", description: "Node.js, TypeScript, React / Next.js / Svelte" },
      { label: "General Programming", description: "Scripts, automation, multiple languages" },
      { label: "DevOps / Infrastructure", description: "Docker, Ansible, Terraform, CI/CD" },
      { label: "Multiple / Not sure yet", description: "Install a broad base set" }
    ],
    allowFreeformInput: true
  }
])
```

Store the answer as `USE_CASE`. Then ask the follow-up batch that matches the chosen use case (see sections 0.2–0.6 below). Skip irrelevant sections.

---

### 0.2 — Data Science Track (if `USE_CASE = Data Science`)

```
vscode_askQuestions([
  {
    header: "DS language",
    question: "Which language(s) do you want for data science?",
    options: [
      { label: "Python only", recommended: true },
      { label: "R only" },
      { label: "Both Python and R" }
    ],
    allowFreeformInput: false
  },
  {
    header: "Reporting level",
    question: "What level of reporting / document output do you need?",
    options: [
      { label: "Markdown only", description: "Simple .md files, GitHub-renderable", recommended: true },
      { label: "Jupyter Notebooks", description: "Interactive notebooks (.ipynb)" },
      { label: "Quarto", description: "Reproducible reports, HTML/PDF/slides from .qmd" },
      { label: "R Markdown / knitr", description: "Classic R-native reporting" },
      { label: "All of the above" }
    ],
    allowFreeformInput: false,
    multiSelect: true
  },
  {
    header: "DS packages scope",
    question: "How much do you want installed now?",
    options: [
      { label: "Minimal core only", description: "numpy, pandas, matplotlib (Python) / tidyverse (R)" },
      { label: "Standard data science", description: "Core + scipy, seaborn, statsmodels, scikit-learn", recommended: true },
      { label: "Full ML / deep learning", description: "Standard + PyTorch or TensorFlow, XGBoost, LightGBM" },
      { label: "Let me choose per package" }
    ],
    allowFreeformInput: false
  }
])
```

---

### 0.3 — AI Development Track (if `USE_CASE = AI-Assisted Development`)

```
vscode_askQuestions([
  {
    header: "AI dev stack",
    question: "Which AI / LLM tools do you need?",
    options: [
      { label: "OpenAI SDK (openai)", recommended: true },
      { label: "Anthropic SDK (anthropic)" },
      { label: "LangChain" },
      { label: "LlamaIndex" },
      { label: "Hugging Face (transformers, diffusers)" },
      { label: "Local models (Ollama)" },
      { label: "Agent frameworks (AutoGen, CrewAI)" }
    ],
    multiSelect: true,
    allowFreeformInput: true
  },
  {
    header: "AI dev language",
    question: "Primary language for AI development?",
    options: [
      { label: "Python", recommended: true },
      { label: "TypeScript / JavaScript" },
      { label: "Both" }
    ],
    allowFreeformInput: false
  },
  {
    header: "AI reporting",
    question: "Do you need reporting / documentation output?",
    options: [
      { label: "No — just code", recommended: true },
      { label: "Markdown only" },
      { label: "Jupyter Notebooks" },
      { label: "Quarto" }
    ],
    allowFreeformInput: false
  }
])
```

---

### 0.4 — Web Development Track (if `USE_CASE = Web Development`)

```
vscode_askQuestions([
  {
    header: "Web framework",
    question: "Which web framework(s) will you use?",
    options: [
      { label: "React / Next.js" },
      { label: "Vue / Nuxt" },
      { label: "Svelte / SvelteKit", recommended: true },
      { label: "Plain Node.js / Express" },
      { label: "Full-stack (any of the above + API)" },
      { label: "Not sure yet" }
    ],
    multiSelect: true,
    allowFreeformInput: true
  },
  {
    header: "Web language",
    question: "TypeScript or JavaScript?",
    options: [
      { label: "TypeScript", recommended: true },
      { label: "JavaScript" },
      { label: "Both / doesn't matter" }
    ],
    allowFreeformInput: false
  }
])
```

---

### 0.5 — General Programming / DevOps Track

```
vscode_askQuestions([
  {
    header: "Languages",
    question: "Which programming languages do you need configured?",
    options: [
      { label: "Python" },
      { label: "JavaScript / TypeScript" },
      { label: "Go" },
      { label: "Rust" },
      { label: "Java / Kotlin" },
      { label: "C / C++" },
      { label: "Ruby" },
      { label: "PHP" },
      { label: "Shell scripting (bash/zsh)" }
    ],
    multiSelect: true,
    allowFreeformInput: true
  }
])
```

---

### 0.6 — Installation Scope (all tracks)

Always ask this at the end of the use-case interview:

```
vscode_askQuestions([
  {
    header: "Install scope",
    question: "How should packages be installed when possible?",
    options: [
      { label: "User-level only (no sudo required)", description: "pip --user, nvm, local R library", recommended: true },
      { label: "System-level (requires sudo/admin)", description: "Faster, shared across users" },
      { label: "Virtual environments / isolated", description: "venv, conda, renv per project" }
    ],
    allowFreeformInput: false
  },
  {
    header: "Confirm before each install",
    question: "Do you want to confirm before each group of packages is installed?",
    options: [
      { label: "Yes — show me what will be installed first", recommended: true },
      { label: "No — install everything automatically" }
    ],
    allowFreeformInput: false
  }
])
```

Store as `INSTALL_SCOPE` and `CONFIRM_INSTALLS`. Reference these throughout all later phases.

---

## Phase 1 — Diagnose

Run the appropriate diagnostic script for the OS. If the OS is already known, skip to Phase 2.

### Detect OS

```bash
# In any terminal — output is one of: macos, linux, windows
uname -s 2>/dev/null || echo "windows"
```

| Output | OS |
|--------|----|
| `Darwin` | macOS |
| `Linux` | Linux |
| command missing / error | Windows (PowerShell) |

### Run Full Diagnostic

**macOS / Linux** — run [diagnose.sh](./scripts/diagnose.sh):

```bash
bash ./scripts/diagnose.sh
```

**Windows (PowerShell)** — run [diagnose.ps1](./scripts/diagnose.ps1):

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
./scripts/diagnose.ps1
```

The diagnostic script reports:

- OS name and version
- Current user and privilege level (admin / standard)
- Available package managers
- Installed versions of: `code`, `node`, `npm`, `python`, `python3`, `pip`, `pip3`
- Git status

Read the output and build a **gap list**: which tools are missing or outdated.

---

## Phase 2 — Check Permissions

Before installing, confirm the user has sufficient rights.

| OS | Admin check |
|----|-------------|
| macOS / Linux | `sudo -n true 2>/dev/null && echo admin || echo standard` |
| Windows | `([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)` |

**If not admin:** warn the user. Offer user-scoped install paths where possible (e.g. `--user` flag for pip, `nvm` for Node, VS Code user installer on Windows). Never silently fail on permission errors.

---

## Phase 3 — Detect Package Manager

Check what is available before choosing an install method. Prefer in this order:

### macOS

1. `brew` (Homebrew) — `brew --version`
2. Manual `.dmg` / `.pkg` download (fallback)

### Linux

1. `apt` / `apt-get` (Debian/Ubuntu) — `apt --version`
2. `dnf` / `yum` (Fedora/RHEL) — `dnf --version`
3. `pacman` (Arch) — `pacman --version`
4. `snap` — `snap --version`
5. Manual `.tar.gz` / binary (fallback)

### Windows

1. `winget` — `winget --version`
2. `choco` (Chocolatey) — `choco --version`
3. `scoop` — `scoop --version`
4. Manual installer download (fallback)

See [package-managers.md](./references/package-managers.md) for install commands for each manager.

---

## Phase 4 — Install Missing Tools

Work through the gap list. Install in this order to respect dependencies:

1. **Git** (prerequisite for everything else)
2. **Node.js + npm**
3. **Python + pip**
4. **VS Code**
5. **GitHub Copilot extension**

### Install Commands by Platform

#### Git

| Platform | Command |
|----------|---------|
| macOS (brew) | `brew install git` |
| Ubuntu/Debian | `sudo apt install -y git` |
| Fedora/RHEL | `sudo dnf install -y git` |
| Windows (winget) | `winget install --id Git.Git -e` |
| Windows (choco) | `choco install git -y` |

#### Node.js

Prefer a version manager for flexibility:

| Method | Command |
|--------|---------|
| macOS (brew) | `brew install node` |
| nvm (macOS/Linux) | `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh \| bash && nvm install --lts` |
| Ubuntu/Debian | `sudo apt install -y nodejs npm` |
| Windows (winget) | `winget install --id OpenJS.NodeJS.LTS -e` |
| Windows (choco) | `choco install nodejs-lts -y` |
| Windows (nvm-windows) | `choco install nvm -y && nvm install lts && nvm use lts` |

#### Python

| Method | Command |
|--------|---------|
| macOS (brew) | `brew install python` |
| Ubuntu/Debian | `sudo apt install -y python3 python3-pip` |
| Fedora/RHEL | `sudo dnf install -y python3 python3-pip` |
| Windows (winget) | `winget install --id Python.Python.3 -e` |
| Windows (choco) | `choco install python -y` |

#### VS Code

| Method | Command |
|--------|---------|
| macOS (brew) | `brew install --cask visual-studio-code` |
| Ubuntu/Debian (snap) | `sudo snap install code --classic` |
| Ubuntu/Debian (apt) | See [VS Code Linux install](https://code.visualstudio.com/docs/setup/linux) |
| Fedora/RHEL (snap) | `sudo snap install code --classic` |
| Windows (winget) | `winget install --id Microsoft.VisualStudioCode -e` |
| Windows (choco) | `choco install vscode -y` |

#### GitHub Copilot Extension

Once VS Code is installed, install via CLI:

```bash
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
```

This works on all platforms where `code` is on the PATH. On Windows, restart the terminal after VS Code install if `code` is not found.

---

## Phase 4b — APM (Agent Package Manager)

APM ([microsoft.github.io/apm](https://microsoft.github.io/apm)) manages GitHub Copilot agent skills, instructions, and prompt files — the same way npm manages Node packages. Install it so the user can extend their AI tooling with curated skill packs.

### Prerequisite Check

APM requires Node.js / npm. Verify before proceeding:

```bash
node --version && npm --version
```

If Node is missing, complete Phase 4 (Node install) first.

### Ask the User

```
vscode_askQuestions([
  {
    header: "Install APM",
    question: "Do you want to install APM (Agent Package Manager) to manage AI skills and agents?",
    message: "APM lets you add curated skill packs, agents, and prompt files to your workspace with a single command. Requires Node.js (already checked). See: https://microsoft.github.io/apm",
    options: [
      { label: "Yes — install APM now", recommended: true },
      { label: "No — skip for now" }
    ],
    allowFreeformInput: false
  }
])
```

Skip the rest of this phase if the user declines.

### Install APM

```bash
# User-global install (no sudo — recommended)
npm install -g @microsoft/apm

# Verify
apm --version
```

> **If `npm install -g` fails with permission errors** (common on macOS/Linux without nvm):
>
> ```bash
> # Fix npm prefix to user dir (one-time setup)
> mkdir -p ~/.npm-global
> npm config set prefix ~/.npm-global
> echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
> npm install -g @microsoft/apm
>
> # Or run without global install via npx
> npx @microsoft/apm --version
> ```

### Initialise APM in the Workspace

```bash
cd <project-directory>
apm init
```

This creates an `apm.yml` manifest:

```yaml
name: my-workspace
version: 1.0.0
targets:
  - copilot
dependencies:
  apm: []
  mcp: []
includes: auto
```

### Discover and Add Skills

Ask the user how they want to find skills:

```
vscode_askQuestions([
  {
    header: "Skill discovery",
    question: "How do you want to find AI skills and agents to install?",
    options: [
      { label: "Browse awesome-copilot (official)", description: "github.com/microsoft/awesome-copilot", recommended: true },
      { label: "skills.sh registry", description: "Community skill registry at https://skills.sh" },
      { label: "GitHub search", description: "Search 'apm.yml copilot skills' on GitHub" },
      { label: "Google search", description: "site:github.com apm.yml copilot agent skills" },
      { label: "Skip — I'll add them manually later" }
    ],
    allowFreeformInput: false
  }
])
```

Present these sources to the user:

| Source | URL / query |
|--------|-------------|
| **awesome-copilot** | `github.com/microsoft/awesome-copilot` — official curated agents, skills, instructions |
| **skills.sh** | `https://skills.sh` — community registry |
| **GitHub** | Search `"apm.yml" copilot skills` |
| **Google** | `site:github.com "apm.yml" copilot agent skills` |

> **Fallback**: If skills.sh is unavailable or returns no results, direct the user to `github.com/microsoft/awesome-copilot` or search GitHub for public `apm.yml` files.

#### Install a skill

```bash
# Add from GitHub
apm add github/<owner>/<repo>/skills/<skill-name>/SKILL.md

# Example — janitor agent from awesome-copilot
apm add github/awesome-copilot/agents/janitor.agent.md

# Install all declared dependencies
apm install
```

### Use-Case Skill Suggestions

Suggest relevant APM search terms based on `USE_CASE` from Phase 0:

| Use Case | Suggested search terms |
|----------|------------------------|
| Data Science | `data-science`, `jupyter`, `quarto`, `pandas`, `r-analysis`, `statistical-analysis` |
| AI Development | `llm`, `openai`, `langchain`, `agent-framework`, `embeddings`, `agentic-eval` |
| Web Development | `react`, `svelte`, `typescript`, `nextjs`, `playwright`, `shadcn` |
| DevOps | `ansible`, `docker`, `terraform`, `ci-cd`, `github-actions` |
| General | `clean-code`, `debugging-strategies`, `pytest`, `design-patterns` |

---

## Phase 5 — Verify

After all installs, run the diagnostic script again to confirm all tools are present and on the expected versions:

```bash
# macOS / Linux
bash ./scripts/diagnose.sh

# Windows
./scripts/diagnose.ps1
```

Expected passing state:

| Tool | Minimum version |
|------|----------------|
| git | 2.x |
| node | 18.x LTS or higher |
| npm | 9.x or higher |
| python / python3 | 3.10 or higher |
| pip / pip3 | 22.x or higher |
| code | any — confirms VS Code on PATH |

---

## Decision Tree (Quick Reference)

```
Start
 └─ Phase 0: Interview user (use case, languages, reporting, install scope)
     └─ Phase 1: Detect OS + run diagnostic
         └─ Phase 2: Check permissions → user-scoped install if not admin
             └─ Phase 3: Detect package manager
                 └─ Phase 4: Install base tools (git → Node → Python → VS Code → Copilot)
                     ├─ macOS?  brew present? → brew for all; else install brew first
                     ├─ Linux?  apt/dnf/pacman → system pkg; snap for VS Code
                     └─ Windows? winget (built-in Win11) → choco → scoop → manual
                         └─ Phase 4b: Install APM (npm install -g @microsoft/apm)
                             └─ Guide user to awesome-copilot / skills.sh for skill packs
                                 └─ Phase 5: Verify all tools + run use-case package install
```

---

## Notes

- **Never mix package managers** for the same tool — pick one and stay consistent.
- **macOS system Python** (`/usr/bin/python3`) is managed by Apple; always install a separate Python via brew (preferred) or pyenv.
- **Windows PATH**: After installs via winget/choco, open a new terminal session before verifying — PATH updates do not apply to the current session.
- **Copilot sign-in**: After installing the Copilot extension, the user must sign in with a GitHub account that has Copilot access. This cannot be automated.
- **APM vs Atom APM**: Microsoft's `@microsoft/apm` may conflict with the legacy Atom editor `apm` binary. Use `npx @microsoft/apm` or alias `mapm` if needed.
- **R user library**: R automatically creates `~/Library/R/x.y/library` (macOS) or `~/R/x86_64-pc-linux-gnu-library/x.y` (Linux) for user installs — no `sudo` required.
- **Quarto user install on Linux**: Extract to `~/.local/bin/quarto` and add `~/.local/bin` to `PATH` in `.zshrc` / `.bashrc`.
- **skills.sh**: If the skills.sh registry is unavailable, fall back to searching GitHub for `apm.yml` files or the `awesome-copilot` repository.
