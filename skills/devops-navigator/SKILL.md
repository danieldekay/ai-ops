---
name: devops-navigator
description: Route to the right infrastructure, security, or operations skill. Use when working with Ansible, Debian Linux, VPS hardening, Authentik SSO, Cloudflare DNS, Home Assistant, CI/CD, or security tooling.
---

# DevOps Navigator

Routes to devops/security/ops skills in `~/.skills-longtail/devops-security/`. Install for the session, uninstall after.

> Note: Ansible-specific skills (ansible-1password, g12-ops, g12-server, home-assistant-manager, zigbee2mqtt) live in the ansible repo's `apm.yml` and are already loaded when working in that repo.
> ctx-* operational tools (ctx-doctor, ctx-stats, etc.) are also in this long-tail category — install when diagnosing context-mode issues.

## Available Skills

| Skill | Use When | Install |
|-------|----------|---------|
| `ansible-automation` | Ansible playbook/role templates, configuration management | `apm install -g danieldekay/ai-ops/skills/ansible-automation/` |
| `ansible-expert` | Expert-level Ansible patterns and best practices | `apm install -g danieldekay/ai-ops/skills/ansible-expert/` |
| `debian-linux-triage` | Triage Debian issues with apt, systemd, AppArmor | `apm install -g danieldekay/ai-ops/skills/debian-linux-triage/` |
| `secure-vps-setup` | Harden a Linux VPS (Hardening, Tailscale, Traefik, Crowdsec) | `apm install -g danieldekay/ai-ops/skills/secure-vps-setup/` |
| `vps-checkup` | Read-only VPS health/security/update audit | `apm install -g danieldekay/ai-ops/skills/vps-checkup/` |
| `authentik-management` | Self-hosted Authentik via Docker Compose, Traefik, backups | `apm install -g danieldekay/ai-ops/skills/authentik-management/` |
| `authentik-open-source` | Authentik OSS blueprints, `.env` settings, upstream docs | `apm install -g danieldekay/ai-ops/skills/authentik-open-source/` |
| `cloudflare-dns` | Cloudflare DNS management, API tokens, External-DNS | `apm install -g danieldekay/ai-ops/skills/cloudflare-dns/` |
| `github-project-automation` | GitHub Actions CI/CD, Dependabot, CodeQL, branch protection | `apm install -g danieldekay/ai-ops/skills/github-project-automation/` |
| `ci-cd-pipeline-patterns` | GitHub Actions workflows, deployment strategies, release management | `apm install -g danieldekay/ai-ops/skills/ci-cd-pipeline-patterns/` |
| `security-best-practices` | HTTPS, CORS, XSS, SQLi, CSRF, OWASP Top 10 | `apm install -g danieldekay/ai-ops/skills/security-best-practices/` |
| `mcp-builder` | Build MCP servers in Python (FastMCP) or TypeScript | `apm install -g danieldekay/ai-ops/skills/mcp-builder/` |
| `ctx-doctor` | Diagnose context-mode plugin issues | `apm install -g danieldekay/ai-ops/skills/ctx-doctor/` |
| `ctx-stats` | Show context window token savings for this session | `apm install -g danieldekay/ai-ops/skills/ctx-stats/` |
| `ctx-upgrade` | Update context-mode from GitHub | `apm install -g danieldekay/ai-ops/skills/ctx-upgrade/` |

## Quick Decision

- Ansible infrastructure work (non-G12) → `ansible-expert` or `ansible-automation`
- Harden or diagnose a VPS → `secure-vps-setup` or `vps-checkup`
- Authentik SSO setup → `authentik-management` or `authentik-open-source`
- GitHub Actions pipeline → `github-project-automation` or `ci-cd-pipeline-patterns`
- context-mode broken → `ctx-doctor` then `ctx-upgrade`
