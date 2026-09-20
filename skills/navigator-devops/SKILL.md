---
name: navigator-devops
description: Route to the right infrastructure, security, or operations skill. Use when working with Ansible, Debian Linux, VPS hardening, Authentik SSO, Cloudflare DNS, Home Assistant, CI/CD, or security tooling.
---

# Navigator: DevOps

Routes to DevOps/security/ops skills in the `devops-security` long-tail category.

> Ansible-specific skills (`g12-ops`, `g12-server`, `home-assistant-manager`, `zigbee2mqtt`, `ansible-1password`) live in the ansible repo's `apm.yml` and are already loaded in that context.
> ctx-* operational tools (`ctx-doctor`, `ctx-stats`, etc.) are also in this category — install only when diagnosing context-mode issues.

## Install for a session

```bash
# Install all devops-security skills (uninstall after session)
cd ~/.skills-longtail/devops-security && apm install

# Uninstall when done
cd ~/.skills-longtail/devops-security && apm uninstall
```

## Available Skills

| Skill | Use When |
|-------|----------|
| `ansible-automation` | Ansible playbook/role templates, configuration management |
| `ansible-expert` | Expert-level Ansible patterns and best practices |
| `debian-linux-triage` | Triage Debian issues with apt, systemd, AppArmor |
| `secure-vps-setup` | Harden a Linux VPS (Hardening, Tailscale, Traefik, Crowdsec) |
| `vps-checkup` | Read-only VPS health/security/update audit |
| `authentik-management` | Self-hosted Authentik via Docker Compose, Traefik, backups |
| `authentik-open-source` | Authentik OSS blueprints, `.env` settings, upstream docs |
| `cloudflare-dns` | Cloudflare DNS management, API tokens, External-DNS |
| `github-project-automation` | GitHub Actions CI/CD, Dependabot, CodeQL, branch protection |
| `ci-cd-pipeline-patterns` | GitHub Actions workflows, deployment strategies, release management |
| `security-best-practices` | HTTPS, CORS, XSS, SQLi, CSRF, OWASP Top 10 |
| `mcp-builder` | Build MCP servers in Python (FastMCP) or TypeScript |
| `ctx-doctor` | Diagnose context-mode plugin issues |
| `ctx-stats` | Show context window token savings for this session |
| `ctx-upgrade` | Update context-mode from GitHub |

## Quick Decision

- Ansible infra work (non-G12) → `ansible-expert` or `ansible-automation`
- Harden or diagnose a VPS → `secure-vps-setup` or `vps-checkup`
- Authentik SSO setup → `authentik-management` or `authentik-open-source`
- GitHub Actions pipeline → `github-project-automation` or `ci-cd-pipeline-patterns`
- context-mode broken → `ctx-doctor` then `ctx-upgrade`
