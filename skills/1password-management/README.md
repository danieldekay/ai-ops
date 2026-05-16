# 1Password Management Skill

Comprehensive workflows for managing secrets with 1Password CLI (`op`).

## What This Skill Provides

- **Naming Convention**: Standardized format for vault items (`[TYPE] [Provider] - [resource] - [env]`)
- **CLI Patterns**: Battle-tested commands for reading, creating, and updating secrets
- **Docker Integration**: Complete template for sourcing secrets in Docker Compose
- **Audit Scripts**: Tools to analyze vault structure and find issues
- **Batch Operations**: Rename multiple items following conventions

## Structure

```
1password-management/
├── SKILL.md                          # Main skill instructions
├── scripts/
│   ├── audit-vault-names.sh          # Audit naming compliance
│   └── batch-rename-items.sh         # Bulk rename with CSV mapping
└── references/
    └── naming-convention.md          # Complete naming standard (30+ examples)
```

## Quick Start

### Audit Your Vault

```bash
chmod +x .github/skills/1password-management/scripts/audit-vault-names.sh
./.github/skills/1password-management/scripts/audit-vault-names.sh Infrastructure
```

**Output**:
- Total item count
- Duplicate detection
- Naming compliance percentage
- Type distribution
- Special character warnings

### Batch Rename Items

1. Create CSV mapping file:
```csv
# mapping.csv
tangoatlas-authentik,OAUTH Authentik - tangoatlas-prod
TMD api key (PROD),API TMD - backend-prod
authentik-db,DB PostgreSQL - authentik-prod
```

2. Preview and execute:
```bash
chmod +x .github/skills/1password-management/scripts/batch-rename-items.sh
./.github/skills/1password-management/scripts/batch-rename-items.sh mapping.csv Infrastructure
```

## Naming Convention Quick Reference

| Prefix | Purpose | Example |
|--------|---------|---------|
| `API` | API keys/tokens | `API Cloudflare - dns-management` |
| `DB` | Database credentials | `DB PostgreSQL - tangoatlas-prod` |
| `SSH` | SSH keys | `SSH Hetzner - storage-box-prod` |
| `OAUTH` | OAuth2/OIDC | `OAUTH Authentik - tangoatlas-dev` |
| `ADMIN` | Admin dashboards | `ADMIN Traefik - g12-dashboard` |
| `SVC` | Service accounts | `SVC AWS-IAM - rnt-mailer` |
| `APP` | Applications | `APP TangoAtlas - django-dev` |

**Rules**:
- Title Case for providers
- lowercase-with-hyphens for resources
- Environment suffix: `-prod`, `-dev`, `-staging`

## Common Use Cases

### 1. Find Missing Secrets in Application

```bash
# List fields in item
op item get "APP TangoAtlas - django-dev" --vault Infrastructure --format json | \
  python3 -c "import sys,json; [print(f['label']) for f in json.load(sys.stdin)['fields']]"
```

### 2. Copy Secret Between Items

```bash
VALUE=$(op read "op://Infrastructure/Source Item/field_name")
op item edit "Dest Item" --vault Infrastructure "field_name[password]=$VALUE"
```

### 3. Docker Integration

```bash
# 1. Create load script (see SKILL.md template)
# 2. Source in docker-compose
source scripts/load-secrets-from-op.sh
docker compose up
```

## Documentation

- **SKILL.md**: Complete CLI reference and workflows
- **references/naming-convention.md**: Full naming standard with migration examples

## Requirements

- 1Password CLI (`op`) version 2.x+
- 1Password desktop app (for Touch ID authentication)
- Python 3.6+ (for audit scripts)

Install CLI: `brew install --cask 1password-cli`

## Related Documentation

- Project-specific: `docs/1PASSWORD-SECRETS.md` (TangoAtlas setup)
- Official: https://developer.1password.com/docs/cli
