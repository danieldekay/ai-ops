# diagnose.ps1 — Dev environment diagnostic for Windows
# Usage: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; ./scripts/diagnose.ps1
# Output: structured text report of OS, user privileges, package managers, and installed tools

function ok   { param($name, $val) Write-Host ("  + {0,-22} {1}" -f $name, $val) -ForegroundColor Green }
function miss { param($name)       Write-Host ("  x {0,-22} NOT FOUND" -f $name) -ForegroundColor Red }
function info { param($name, $val) Write-Host ("  · {0,-22} {1}" -f $name, $val) }
$SEP = "─" * 50

Write-Host ""
Write-Host "DEV ENVIRONMENT DIAGNOSTIC"
Write-Host $SEP

# ── OS ───────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "OS"
$osInfo = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
if ($osInfo) {
    info "platform" "$($osInfo.Caption) (Build $($osInfo.BuildNumber))"
    info "architecture" $env:PROCESSOR_ARCHITECTURE
} else {
    info "platform" "Windows (version unknown)"
}

# ── USER & PRIVILEGES ────────────────────────────────────────────────────────
Write-Host ""
Write-Host "USER & PRIVILEGES"
info "user" $env:USERNAME

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
)
if ($isAdmin) {
    info "privileges" "Administrator (elevated session)"
} else {
    info "privileges" "Standard user (not elevated)"
}

# ── PACKAGE MANAGERS ─────────────────────────────────────────────────────────
Write-Host ""
Write-Host "PACKAGE MANAGERS"

function Check-Cmd {
    param([string]$cmd, [string]$verArg = "--version")
    try {
        $ver = & $cmd $verArg 2>&1 | Select-Object -First 1
        ok $cmd $ver
        return $true
    } catch {
        miss $cmd
        return $false
    }
}

Check-Cmd "winget" "--version" | Out-Null
Check-Cmd "choco"  "--version" | Out-Null
Check-Cmd "scoop"  "--version" | Out-Null

# ── INSTALLED TOOLS ──────────────────────────────────────────────────────────
Write-Host ""
Write-Host "INSTALLED TOOLS"

Check-Cmd "git"     "--version" | Out-Null
Check-Cmd "node"    "--version" | Out-Null
Check-Cmd "npm"     "--version" | Out-Null
Check-Cmd "python"  "--version" | Out-Null
Check-Cmd "python3" "--version" | Out-Null
Check-Cmd "pip"     "--version" | Out-Null
Check-Cmd "pip3"    "--version" | Out-Null
Check-Cmd "code"    "--version" | Out-Null

# ── VS CODE EXTENSIONS ───────────────────────────────────────────────────────
Write-Host ""
Write-Host "VS CODE EXTENSIONS"

$codeAvailable = $null -ne (Get-Command "code" -ErrorAction SilentlyContinue)
if ($codeAvailable) {
    $exts = & code --list-extensions 2>&1
    foreach ($ext in @("GitHub.copilot", "GitHub.copilot-chat")) {
        if ($exts -match [regex]::Escape($ext)) {
            ok $ext "installed"
        } else {
            miss $ext
        }
    }
} else {
    info "skipped" "VS Code not on PATH"
}

# ── SUMMARY ──────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host $SEP
Write-Host "Diagnostic complete. Review 'x' lines for missing tools."
Write-Host ""
