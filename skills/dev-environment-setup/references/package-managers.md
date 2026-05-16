# Package Manager Reference

Quick-install commands for all supported package managers, grouped by tool.

---

## Install a Package Manager First

### macOS — Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Windows — Install winget
winget ships with Windows 11 and Windows 10 (1709+). If missing:
- Open Microsoft Store → search "App Installer" → Install

### Windows — Install Chocolatey
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### Windows — Install Scoop
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

---

## Git

| Manager | Command |
|---------|---------|
| brew | `brew install git` |
| apt | `sudo apt install -y git` |
| dnf | `sudo dnf install -y git` |
| pacman | `sudo pacman -S --noconfirm git` |
| winget | `winget install --id Git.Git -e --source winget` |
| choco | `choco install git -y` |
| scoop | `scoop install git` |

---

## Node.js (LTS)

Prefer a version manager (nvm / nvm-windows) for developer machines so Node version can be switched per project.

### Via version manager (recommended)

**nvm (macOS/Linux)**
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# restart terminal, then:
nvm install --lts
nvm use --lts
```

**nvm-windows (Windows)**
```powershell
choco install nvm -y
# restart terminal, then:
nvm install lts
nvm use lts
```

### Via package manager

| Manager | Command |
|---------|---------|
| brew | `brew install node` |
| apt | `sudo apt install -y nodejs npm` |
| dnf | `sudo dnf install -y nodejs npm` |
| pacman | `sudo pacman -S --noconfirm nodejs npm` |
| snap | `sudo snap install node --classic` |
| winget | `winget install --id OpenJS.NodeJS.LTS -e` |
| choco | `choco install nodejs-lts -y` |
| scoop | `scoop install nodejs-lts` |

---

## Python (3.x)

> macOS: do **not** rely on `/usr/bin/python3` (Apple-managed). Always install separately.

| Manager | Command |
|---------|---------|
| brew | `brew install python` |
| apt | `sudo apt install -y python3 python3-pip python3-venv` |
| dnf | `sudo dnf install -y python3 python3-pip` |
| pacman | `sudo pacman -S --noconfirm python python-pip` |
| winget | `winget install --id Python.Python.3 -e` |
| choco | `choco install python -y` |
| scoop | `scoop install python` |

---

## VS Code

| Manager | Command |
|---------|---------|
| brew | `brew install --cask visual-studio-code` |
| snap | `sudo snap install code --classic` |
| apt (manual) | See https://code.visualstudio.com/docs/setup/linux |
| dnf (manual) | See https://code.visualstudio.com/docs/setup/linux |
| winget | `winget install --id Microsoft.VisualStudioCode -e` |
| choco | `choco install vscode -y` |
| scoop | `scoop bucket add extras && scoop install vscode` |

---

## GitHub Copilot Extensions

Run after VS Code is installed and `code` is on the PATH:

```bash
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
```

> Windows note: if `code` is not found after install, close and reopen the terminal to reload PATH.

---

## Verify All Installs

```bash
# macOS / Linux
git --version && node --version && npm --version && python3 --version && pip3 --version && code --version

# Windows (PowerShell)
git --version; node --version; npm --version; python --version; pip --version; code --version
```
