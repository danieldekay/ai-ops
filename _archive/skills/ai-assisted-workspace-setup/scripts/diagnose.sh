#!/usr/bin/env bash
# diagnose.sh — Dev environment diagnostic for macOS and Linux
# Usage: bash diagnose.sh
# Output: structured text report of OS, user privileges, package managers, and installed tools

set -euo pipefail

SEP="─────────────────────────────────────"
ok()   { printf "  ✓ %-20s %s\n" "$1" "$2"; }
miss() { printf "  ✗ %-20s %s\n" "$1" "NOT FOUND"; }
info() { printf "  · %-20s %s\n" "$1" "$2"; }

echo ""
echo "DEV ENVIRONMENT DIAGNOSTIC"
echo "$SEP"

# ── OS ───────────────────────────────────────────────────────────────────────
echo ""
echo "OS"
OS_TYPE="$(uname -s)"
if [[ "$OS_TYPE" == "Darwin" ]]; then
  OS_NAME="macOS"
  OS_VER="$(sw_vers -productVersion 2>/dev/null || echo unknown)"
  ARCH="$(uname -m)"
  info "platform" "macOS $OS_VER ($ARCH)"
elif [[ "$OS_TYPE" == "Linux" ]]; then
  OS_NAME="Linux"
  if [[ -f /etc/os-release ]]; then
    # shellcheck disable=SC1091
    source /etc/os-release
    OS_VER="${PRETTY_NAME:-Linux}"
  else
    OS_VER="Linux (unknown distro)"
  fi
  ARCH="$(uname -m)"
  info "platform" "$OS_VER ($ARCH)"
else
  info "platform" "Unknown ($OS_TYPE)"
fi

# ── USER & PRIVILEGES ────────────────────────────────────────────────────────
echo ""
echo "USER & PRIVILEGES"
CURRENT_USER="$(whoami)"
info "user" "$CURRENT_USER"

if sudo -n true 2>/dev/null; then
  info "sudo" "admin (passwordless sudo available)"
elif groups | grep -qE '\b(sudo|wheel|admin)\b'; then
  info "sudo" "admin group (password required)"
else
  info "sudo" "standard user (no sudo)"
fi

# ── PACKAGE MANAGERS ─────────────────────────────────────────────────────────
echo ""
echo "PACKAGE MANAGERS"

check_cmd() {
  local cmd="$1"
  local ver_flag="${2:---version}"
  if command -v "$cmd" &>/dev/null; then
    local ver
    ver="$("$cmd" $ver_flag 2>&1 | head -1 || echo '?')"
    ok "$cmd" "$ver"
    return 0
  else
    miss "$cmd" ""
    return 1
  fi
}

if [[ "$OS_NAME" == "macOS" ]]; then
  check_cmd brew "--version" || true
fi

if [[ "$OS_NAME" == "Linux" ]]; then
  check_cmd apt "--version" || true
  check_cmd apt-get "--version" || true
  check_cmd dnf "--version" || true
  check_cmd yum "--version" || true
  check_cmd pacman "--version" || true
  check_cmd snap "--version" || true
  check_cmd flatpak "--version" || true
fi

check_cmd nvm "--version" 2>/dev/null || true

# ── INSTALLED TOOLS ──────────────────────────────────────────────────────────
echo ""
echo "INSTALLED TOOLS"

check_cmd git "--version"
check_cmd node "--version"
check_cmd npm "--version"
check_cmd python "--version" 2>/dev/null || true
check_cmd python3 "--version"
check_cmd pip "--version" 2>/dev/null || true
check_cmd pip3 "--version"
check_cmd code "--version"

# ── VS CODE EXTENSIONS ───────────────────────────────────────────────────────
echo ""
echo "VS CODE EXTENSIONS"
if command -v code &>/dev/null; then
  EXTS="$(code --list-extensions 2>/dev/null || echo '')"
  for ext in "GitHub.copilot" "GitHub.copilot-chat"; do
    if echo "$EXTS" | grep -qi "$ext"; then
      ok "$ext" "installed"
    else
      miss "$ext" ""
    fi
  done
else
  info "skipped" "VS Code not on PATH"
fi

# ── SUMMARY ──────────────────────────────────────────────────────────────────
echo ""
echo "$SEP"
echo "Diagnostic complete. Review ✗ lines for missing tools."
echo ""
