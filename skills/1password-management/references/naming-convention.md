# 1Password Naming Convention

> **Note**: Replace `[YourApp]`, `[Project2]`, `[Project3]`, `[server-alias]`, `[Provider]`, `[Provider2]` with your own project and provider names.

**Version**: 1.0  
**Vault**: Infrastructure

## Executive Summary

This document defines a standardized naming convention for 1Password items in the Infrastructure vault to improve:
- **Searchability**: Quick filtering by prefix
- **Organization**: Hierarchical structure
- **Consistency**: Predictable patterns
- **Scalability**: Easy to add new items

## Common Issues to Fix

1. **Duplicates**: Multiple items with similar names for the same resource
2. **Inconsistent casing**: `"service-db"` vs `"Service Admin"`
3. **Mixed separators**: Spaces, hyphens, colons, parentheses
4. **Ambiguous scope**: `"[App] api key (DEV)"` vs `"[App] API token"`
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
| `DB` | Database credentials | `DB PostgreSQL - [yourapp]-prod` |
| `SSH` | SSH keys, certificates | `SSH [Provider] - storage-box-prod` |
| `SMTP` | Email credentials | `SMTP [Provider] - admin-[yourapp]` |
| `OAUTH` | OAuth2/OIDC credentials | `OAUTH Authentik - [yourapp]-dev` |
| `ADMIN` | Admin panels/dashboards | `ADMIN Traefik - [server-alias]-prod` |
| `SVC` | Service accounts | `SVC AWS-IAM - [project]-mailer` |
| `SRV` | Server/infrastructure login | `SRV [server-alias] - root-access` |
| `APP` | Application credentials | `APP [YourApp] - backend-dev` |
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
   - `[YourApp]` — pick one canonical casing and stick to it
   - `[Project2]` — short code for a second project
   - `[Project3]` — short code for a third project

## Migration Examples

### Before → After

| Before | After | Rationale |
|--------|-------|-----------|
| `Cloudflare API - ALL DNS Zones` | `API Cloudflare - all-dns-zones` | Type prefix, lowercase resource |
| `[yourapp]-db` | `DB PostgreSQL - [yourapp]-prod` | Type prefix, DB engine, environment |
| `AWS IAM - svc-[project]-mailer` | `SVC AWS-IAM - [project]-mailer` | SVC prefix for service accounts |
| `[App] api key (PROD)` | `API [App] - backend-prod` | Consistent format, hyphen separator |
| `[App] API token` | `API [App] - api-token-prod` | Disambiguate from "api key" |
| `SMTP [Provider] - admin@[yourapp].org` | `SMTP [Provider] - admin-[yourapp]` | Remove @ from title |
| `[server] Zigbee2MQTT` | `APP [server] - zigbee2mqtt` | APP prefix for application |
| `[Provider] Storage Box u123456` | `SSH [Provider] - storage-box-u123456-prod` | SSH type, consistent format |
| `Private Key for [server]>StorageBox` | `SSH [Provider] - [server]-storage-box-prod` | Clear hierarchy |
| `[YourApp] Development` | `APP [YourApp] - backend-dev` | Specific purpose |
| `[yourapp]-authentik` | `OAUTH Authentik - [yourapp]-prod` | Type prefix, environment |
| `SSO [Project2] ` | `OAUTH Authentik - [project2]-prod` | Type prefix, provider, no trailing space |
| `Ansible Vault` | `VAULT Ansible - encryption-key` | Type prefix |
| `[server] Server` | `SRV [server] - root-access` | Server type prefix |
| `[server] Cron Service - HTTP Basic Auth` | `ADMIN [server] - cron-http-auth` | Admin credential |
| `Traefik Admin - [server]` | `ADMIN Traefik - [server]-dashboard` | Consistent format |
| `OpenRouter [App]` | `API OpenRouter - [app]-extraction` | Purpose clarification |
| `Context7 MCP` | `API Context7 - mcp-docs` | Purpose clarification |
| `Brave API` | `API Brave - search-api` | Purpose clarification |

### Server/Infrastructure Credentials

| Before | After |
|--------|-------|
| `[server] Server` | `SRV [server] - root-access` |
| `VServer 2025 [Provider]` | `SRV [Provider] - vserver-2025-prod` |
| `Friendica [server]` | `APP [server] - friendica-prod` |
| `Monitoring [server]` | `APP [server] - monitoring-prod` |
| `CrowdSec Console - [server]` | `ADMIN CrowdSec - [server]-console` |

### AWS Credentials

All AWS IAM service accounts follow consistent pattern:

| Before | After |
|--------|-------|
| `AWS IAM - svc-[project]-mailer` | `SVC AWS-IAM - [project]-mailer` |
| `AWS IAM - svc-[project2]-mailer` | `SVC AWS-IAM - [project2]-mailer` |
| `AWS IAM - svc-admin-cli` | `SVC AWS-IAM - admin-cli` |
| `AWS IAM - svc-arq-backup` | `SVC AWS-IAM - arq-backup` |
| `AWS SES - directory@[yourdomain].com` | `SMTP AWS-SES - directory-[yourapp]` |

### Database Credentials

| Before | After |
|--------|-------|
| `authentik-db` | `DB PostgreSQL - authentik-prod` |
| `[yourapp]-db` | `DB PostgreSQL - [yourapp]-prod` |
| `[App] MariaDB` | `DB MariaDB - [app]-prod` |
| `PostgreSQL Keycloak - [server]` | `DB PostgreSQL - keycloak-[server]` |

### OAuth/SSO Credentials

| Before | After |
|--------|-------|
| `[yourapp]-authentik` | `OAUTH Authentik - [yourapp]-prod` |
| `SSO [Project2] ` | `OAUTH Authentik - [project2]-prod` |
| `SSO [Project3] ` | `OAUTH Authentik - [project3]-prod` |
| `OpenWebUI OAuth2 - Production` | `OAUTH Authentik - openwebui-prod` |
| `Authentik Admin - [Project2] (id.[yourdomain].org)` | `ADMIN Authentik - [project2]-panel` |
| `Keycloak Admin - [server]` | `ADMIN Keycloak - [server]-panel` |

### Container Registry Credentials

| Before | After |
|--------|-------|
| `ghcr-[yourapp]` | `SVC GitHub - [yourapp]-registry` |
| `[yourapp]-github-cd` | `SVC GitHub - [yourapp]-cd-deploy` |

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

Items referenced in code that will need updates after renaming:

1. **Shell scripts** that load secrets by name (e.g., `load-secrets-from-op.sh`)
   - Update item name references to match the new convention

2. **Ansible playbooks** → May reference:
   - `<domain> - token for ansible` → `SVC Authentik - ansible-automation-token`
   - `Ansible Vault` → `VAULT Ansible - encryption-key`

3. **GitHub Actions** → May reference:
   - `[yourapp]-github-cd` → `SVC GitHub - [yourapp]-cd-deploy`
   - `ghcr-[yourapp]` → `SVC GitHub - [yourapp]-registry`

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
