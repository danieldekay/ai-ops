---
name: dev-environment-setup
description: "Diagnose a machine and set up a developer environment with VS Code, GitHub Copilot, Node.js, and Python. Use when: setting up a new machine, onboarding a new developer, bootstrapping a dev environment, installing VS Code with Copilot, installing Node, installing Python, checking what is already installed, detecting package managers, checking user permissions, OS detection, Windows setup, Mac setup, Linux setup, environment audit."
argument-hint: "Optional: target software list (e.g. 'only node and python')"
---

# Dev Environment Setup

Sets up a standard developer environment on any OS. Installs **VS Code + GitHub Copilot**, **Node.js**, and **Python** — detecting what is already present and using the fastest available method for each platform.

## When to Use

- Setting up a brand-new machine
- Onboarding a developer to a team standard
- Auditing what is already installed before adding tools
- Checking user permissions before attempting installs

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
 └─ Run diagnose script
     ├─ macOS?
     │   ├─ brew present? → use brew for everything
     │   └─ no brew? → install brew first, then retry
     ├─ Linux?
     │   ├─ apt? → use apt (+ snap for VS Code)
     │   ├─ dnf? → use dnf (+ snap for VS Code)
     │   └─ other? → see package-managers.md
     └─ Windows?
         ├─ winget? → use winget (fastest, built-in Win11)
         ├─ choco? → use choco
         └─ neither? → install winget or choco first, then retry
```

---

## Notes

- **Never mix package managers** for the same tool — pick one and stay consistent.
- **macOS system Python** (`/usr/bin/python3`) is managed by Apple; always install a separate Python via brew or pyenv.
- **Windows PATH**: After installs via winget/choco, open a new terminal session before verifying — PATH updates do not apply to the current session.
- **Copilot sign-in**: After installing the Copilot extension, the user must sign in with a GitHub account that has Copilot access. This cannot be automated.
