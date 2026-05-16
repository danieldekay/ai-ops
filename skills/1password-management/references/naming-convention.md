# 1Password Naming Convention

**Version**: 1.0  
**Date**: March 27, 2026  
**Vault**: Infrastructure

## Executive Summary

This document defines a standardized naming convention for 1Password items in the Infrastructure vault to improve:
- **Searchability**: Quick filtering by prefix
- **Organization**: Hierarchical structure
- **Consistency**: Predictable patterns
- **Scalability**: Easy to add new items

## Current Issues Identified

1. **Duplicates**: "Cloudflare RNT" (2x), "VServer 2025 Netcup" (3x)
2. **Inconsistent casing**: "authentik-db" vs "Authentik Admin"
3. **Mixed separators**: Spaces, hyphens, colons, parentheses
4. **Ambiguous scope**: "TMD api key (DEV)" vs "TMD API token"
5. **No clear hierarchy**: Services mixed with servers mixed with credentials

## Proposed Naming Convention

### Format

```
[TYPE] [PROVIDER/SERVICE] - [RESOURCE] - [ENVIRONMENT]
```

**Components**:
- `[TYPE]` — Credential type (uppercase, 2-4 chars)
- `[PROVIDER/SERVICE]` — Provider or service name (Title Case)
- `[RESOURCE]` — Specific resource or purpose (lowercase-with-hyphens)
- `[ENVIRONMENT]` — Environment tag (lowercase: prod/dev/staging)

### Type Prefixes

| Prefix | Type | Example |
|--------|------|---------|
| `API` | API keys, tokens | `API Cloudflare - dns-management` |
| `DB` | Database credentials | `DB PostgreSQL - tangoatlas-prod` |
| `SSH` | SSH keys, certificates | `SSH Hetzner - storage-box-prod` |
| `SMTP` | Email credentials | `SMTP Netcup - admin@tangoatlas.org` |
| `OAUTH` | OAuth2/OIDC credentials | `OAUTH Authentik - tangoatlas-dev` |
| `ADMIN` | Admin panels/dashboards | `ADMIN Traefik - g12-prod` |
| `SVC` | Service accounts | `SVC AWS-IAM - rnt-mailer` |
| `SRV` | Server/infrastructure login | `SRV Debbie - root-access` |
| `APP` | Application credentials | `APP TangoAtlas - django-dev` |
| `VAULT` | Vault/secret manager | `VAULT Ansible - encryption-key` |

### Naming Rules

1. **Use Title Case** for provider/service names: `Cloudflare`, `Hetzner`, `TangoAtlas`
2. **Use lowercase-with-hyphens** for resource names: `dns-management`, `storage-box`
3. **Environment suffix** (when applicable):
   - `prod` — Production
   - `dev` — Development
   - `staging` — Staging
   - `test` — Testing
4. **Avoid**:
   - Parentheses: `(PROD)` → use `-prod`
   - ALL CAPS in resource names: `ALL DNS` → `all-dns`
   - Email addresses in title (put in username field instead)
5. **Projects/brands**: Use consistent naming
   - `TangoAtlas` (not `tangoatlas` or `Tangoatlas`)
   - `RNT` (Rhein-Neckar-Tango)
   - `TMD` (TangoMarathons.com Directory)

## Migration Examples

### Before → After

| Before | After | Rationale |
|--------|-------|-----------|
| `Cloudflare API - ALL DNS Zones` | `API Cloudflare - all-dns-zones` | Type prefix, lowercase resource |
| `authentik-db` | `DB PostgreSQL - authentik-prod` | Type prefix, DB engine, environment |
| `AWS IAM - svc-rnt-mailer` | `SVC AWS-IAM - rnt-mailer` | SVC prefix for service accounts |
| `TMD api key (PROD)` | `API TMD - backend-prod` | Consistent format, hyphen separator |
| `TMD API token` | `API TMD - api-token-prod` | Disambiguate from "api key" |
| `SMTP Netcup - admin@tangoatlas.org` | `SMTP Netcup - admin-tangoatlas` | Remove @ from title |
| `Debbie Zigbee2MQTT` | `APP Debbie - zigbee2mqtt` | APP prefix for application |
| `Hetzner Storage Box u506313` | `SSH Hetzner - storage-box-u506313-prod` | SSH type, consistent format |
| `Private Key for G12>StorageBox` | `SSH Hetzner - g12-storage-box-prod` | Clear hierarchy |
| `TangoAtlas Development` | `APP TangoAtlas - django-dev` | Specific purpose |
| `tangoatlas-authentik` | `OAUTH Authentik - tangoatlas-prod` | Type prefix, environment |
| `SSO RNT ` | `OAUTH Authentik - rnt-prod` | Type prefix, provider, no trailing space |
| `Ansible Vault` | `VAULT Ansible - encryption-key` | Type prefix |
| `Debbie Server` | `SRV Debbie - root-access` | Server type prefix |
| `G12 Cron Service - HTTP Basic Auth` | `ADMIN G12 - cron-http-auth` | Admin credential |
| `Traefik Admin - RS1000 G12` | `ADMIN Traefik - g12-dashboard` | Consistent format |
| `OpenRouter TMD` | `API OpenRouter - tmd-extraction` | Purpose clarification |
| `Context7 MCP` | `API Context7 - mcp-docs` | Purpose clarification |
| `Brave API` | `API Brave - search-api` | Purpose clarification |

### Server/Infrastructure Credentials

| Before | After |
|--------|-------|
| `Debbie Server` | `SRV Debbie - root-access` |
| `VServer 2025 Netcup` | `SRV Netcup - vserver-2025-prod` |
| `Friendica G12` | `APP G12 - friendica-prod` |
| `Monitoring G12` | `APP G12 - monitoring-prod` |
| `CrowdSec Console - RS1000 G12` | `ADMIN CrowdSec - g12-console` |

### AWS Credentials

All AWS IAM service accounts follow consistent pattern:

| Before | After |
|--------|-------|
| `AWS IAM - svc-rnt-mailer` | `SVC AWS-IAM - rnt-mailer` |
| `AWS IAM - svc-tmd-mailer` | `SVC AWS-IAM - tmd-mailer` |
| `AWS IAM - svc-admin-cli` | `SVC AWS-IAM - admin-cli` |
| `AWS IAM - svc-arq-backup` | `SVC AWS-IAM - arq-backup` |
| `AWS SES - directory@tangomarathons.com` | `SMTP AWS-SES - directory-tangomarathons` |

### Database Credentials

| Before | After |
|--------|-------|
| `authentik-db` | `DB PostgreSQL - authentik-prod` |
| `tangoatlas-db` | `DB PostgreSQL - tangoatlas-prod` |
| `TMD MariaDB` | `DB MariaDB - tmd-prod` |
| `PostgreSQL Keycloak - RS1000 G12` | `DB PostgreSQL - keycloak-g12` |

### OAuth/SSO Credentials

| Before | After |
|--------|-------|
| `tangoatlas-authentik` | `OAUTH Authentik - tangoatlas-prod` |
| `SSO RNT ` | `OAUTH Authentik - rnt-prod` |
| `SSO TMD ` | `OAUTH Authentik - tmd-prod` |
| `OpenWebUI OAuth2 - Production` | `OAUTH Authentik - openwebui-prod` |
| `Authentik Admin - RNT (id.tangoatlas.org)` | `ADMIN Authentik - rnt-panel` |
| `Keycloak Admin - RS1000 G12` | `ADMIN Keycloak - g12-panel` |

### Container Registry Credentials

| Before | After |
|--------|-------|
| `ghcr-tangoatlas` | `SVC GitHub - tangoatlas-registry` |
| `tangoatlas-github-cd` | `SVC GitHub - tangoatlas-cd-deploy` |

## Migration Checklist

### Phase 1: Audit (Current)
- [x] List all items in Infrastructure vault (70 items)
- [x] Identify duplicates and issues
- [x] Draft naming convention

### Phase 2: Planning
- [ ] Review proposed convention with team
- [ ] Identify critical dependencies (scripts, automation)
- [ ] Create rename mapping spreadsheet

### Phase 3: Execution
- [ ] Remove duplicate items (merge if needed)
- [ ] Rename items following new convention
- [ ] Update automation scripts referencing old names
- [ ] Update documentation

### Phase 4: Validation
- [ ] Test all automated processes
- [ ] Verify no broken references
- [ ] Update team documentation

## Scripts/Automation Impact

Items referenced in code that will need updates:

1. **`load-secrets-from-op.sh`** → References "TangoAtlas Development"
   - Update to: `APP TangoAtlas - django-dev`

2. **`setup-1password-secrets.sh`** → Creates "TangoAtlas Development"
   - Update to: `APP TangoAtlas - django-dev`

3. **Ansible playbooks** → May reference:
   - `id.tangoatlas.org - token for ansible` → `SVC Authentik - ansible-automation-token`
   - `Ansible Vault` → `VAULT Ansible - encryption-key`

4. **GitHub Actions** → May reference:
   - `tangoatlas-github-cd` → `SVC GitHub - tangoatlas-cd-deploy`
   - `ghcr-tangoatlas` → `SVC GitHub - tangoatlas-registry`

## Benefits of New Convention

1. **Quick Filtering**: `op item list --vault Infrastructure | grep "^API"` shows all API keys
2. **Visual Hierarchy**: Type prefix creates natural grouping in sorted lists
3. **Searchability**: Consistent patterns make finding items predictable
4. **Scalability**: Easy to add new items following same pattern
5. **Documentation**: Self-documenting names reduce need for notes
6. **Migration**: Clear before/after makes bulk renaming tractable

## Future Considerations

### Multi-Environment Strategy

For teams with many environments, consider:

```
[TYPE] [PROJECT] - [RESOURCE] - [ENV]
```

Examples:
- `API TangoAtlas - openrouter - dev`
- `API TangoAtlas - openrouter - staging`
- `API TangoAtlas - openrouter - prod`

### Team-Specific Conventions

Consider separate vaults for:
- **Infrastructure** → Server/network/DNS credentials (current)
- **Applications** → App-specific API keys, OAuth clients
- **Development** → Dev-only credentials, test accounts
- **Personal** → Individual developer credentials

## Implementation Notes

### Safe Renaming Process

1Password CLI doesn't support direct rename. Options:

**Option A: Manual Rename in 1Password App**
- Safest for critical credentials
- Preserves item history
- Click item → Edit → Change title

**Option B: CLI Copy + Delete**
```bash
# Get item content
op item get "Old Name" --vault Infrastructure --format json > /tmp/item.json

# Create with new name (manual field mapping)
op item create --vault Infrastructure --title "New Name" ...

# Verify new item works
# Delete old item
op item delete "Old Name" --vault Infrastructure
```

**Option C: Edit Title Field Directly**
```bash
# Edit item title
op item edit "Old Name" --vault Infrastructure --title "New Name"
```

### Testing Renames

Before renaming production credentials:
1. Document all references (scripts, automation)
2. Rename in test vault first
3. Update and test automation
4. Schedule maintenance window for production rename
5. Keep old name in notes field for 30 days

## Questions & Decisions

1. **Should we separate dev/prod into different vaults?**
   - Pro: Better access control
   - Con: More complex management
   - **Decision**: Keep in one vault, use environment suffix

2. **How to handle personal credentials in shared vault?**
   - Example: "daniel de kay - tmd (id.tangoatlas.org)"
   - **Decision**: Move to Personal vault or use `USER` prefix

3. **How to handle legacy/deprecated credentials?**
   - **Decision**: Add `[DEPRECATED]` suffix, delete after 90 days

## Next Steps

1. **Review**: Share this document with team
2. **Decide**: Approve convention or suggest changes
3. **Plan**: Create detailed migration plan
4. **Execute**: Rename items in batches
5. **Verify**: Test all automation
6. **Document**: Update team docs

---

**Author**: GitHub Copilot  
**Reviewers**: (TBD)  
**Status**: DRAFT
