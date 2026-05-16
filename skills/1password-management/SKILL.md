---
name: 1password-management
description: Manage secrets with 1Password CLI - retrieve credentials, create items, enforce naming conventions, integrate with Docker/CI/CD. Use when user asks to "get secrets from 1Password", "create 1Password item", "standardize vault names", "integrate 1Password with Docker/scripts", or "query op vault".
---

# 1Password Management

Comprehensive workflows for managing secrets with 1Password CLI (`op`).

## When to Use This Skill

- Retrieving credentials from vaults
- Creating/updating 1Password items
- Standardizing vault naming conventions
- Integrating 1Password with Docker, scripts, or CI/CD
- Querying vault structure and finding duplicates
- Migrating from `.env` files to 1Password

## Core CLI Patterns

### Authentication

```bash
# Check if authenticated
op whoami

# Sign in (opens desktop app for Touch ID)
eval $(op signin)

# Service account (read-only, CI/CD)
export OP_SERVICE_ACCOUNT_TOKEN="<token>"
```

**Key Point**: Modern 1Password CLI uses desktop app integration. No password typing needed when using Touch ID.

### Reading Secrets

```bash
# Secret reference format (preferred)
op read "op://VaultName/ItemName/FieldName"

# Get full item (for inspection)
op item get "ItemName" --vault="VaultName"

# Get specific field
op item get "ItemName" --vault="VaultName" --fields FieldName
op item get "ItemName" --vault="VaultName" --fields label=field_label

# JSON output for scripting
op item get "ItemName" --vault="VaultName" --format json
```

**Escape Special Characters**: Use item IDs for names with `@`, spaces, or special chars:
```bash
# Won't work: op read "op://Infrastructure/SMTP Netcup - admin@tangoatlas.org/password"
# Works: op item get ITEM_ID --vault Infrastructure --fields password
```

### Creating/Updating Items

```bash
# Create new item
op item create --vault="Infrastructure" \
  --category=password \
  --title="API Example - service-name" \
  api_key[password]="secret_value"

# Add field to existing item
op item edit "ItemName" --vault="Infrastructure" \
  new_field[password]="value"

# Update field
op item edit "ItemName" --vault="Infrastructure" \
  existing_field[password]="new_value"

# Multiple fields at once
op item edit "ItemName" --vault="Infrastructure" \
  field1[text]="value1" \
  field2[password]="value2"
```

**Field Types**: `password` (concealed), `text` (visible), `email`, `url`, `date`, `phone`

### Listing and Searching

```bash
# List all items in vault
op item list --vault="Infrastructure"

# Search by pattern (JSON + Python)
op item list --vault="Infrastructure" --format=json | \
  python3 -c "import sys,json; [print(i['title']) for i in json.load(sys.stdin) if 'api' in i['title'].lower()]"

# Find duplicates
op item list --vault="Infrastructure" --format=json | \
  python3 -c "from collections import Counter; import sys,json; items=[i['title'] for i in json.load(sys.stdin)]; [print(f'{t} ({c}x)') for t,c in Counter(items).items() if c>1]"
```

## Naming Convention

**Format**: `[TYPE] [Provider] - [resource] - [environment]`

### Type Prefixes

| Prefix | Purpose | Example |
|--------|---------|---------|
| `API` | API keys/tokens | `API Cloudflare - dns-management` |
| `DB` | Database credentials | `DB PostgreSQL - tangoatlas-prod` |
| `SSH` | SSH keys | `SSH Hetzner - storage-box-prod` |
| `OAUTH` | OAuth2/OIDC | `OAUTH Authentik - tangoatlas-dev` |
| `ADMIN` | Admin dashboards | `ADMIN Traefik - g12-dashboard` |
| `SVC` | Service accounts | `SVC AWS-IAM - rnt-mailer` |
| `APP` | Applications | `APP TangoAtlas - django-dev` |
| `SMTP` | Email credentials | `SMTP Netcup - admin-tangoatlas` |
| `SRV` | Server access | `SRV Debbie - root-access` |
| `VAULT` | Secret vaults | `VAULT Ansible - encryption-key` |

### Rules

1. **Title Case** for providers: `Cloudflare`, `Hetzner`
2. **lowercase-with-hyphens** for resources: `dns-management`
3. **Environment suffix**: `-prod`, `-dev`, `-staging`, `-test`
4. **No email addresses in titles** (use username field)
5. **No parentheses or ALL CAPS** (except type prefix)

**Full Convention**: See `references/naming-convention.md`

## Docker Integration Pattern

### Script Structure (3 layers)

```
scripts/
├── load-secrets-from-op.sh    # Fetch secrets, export env vars
├── docker-dev.sh               # Wrapper with auto-loading
└── setup-1password-secrets.sh  # First-time setup wizard
```

### Load Script Template

```bash
#!/bin/bash
set -e

# Check auth
if ! op whoami &> /dev/null; then
    eval $(op signin)
fi

# Read secret helper
read_secret() {
    local field=$1
    op read "op://Infrastructure/APP TangoAtlas - django-dev/${field}" 2>/dev/null || echo ""
}

# Export secrets
export SECRET_KEY=$(read_secret "SECRET_KEY" || openssl rand -base64 32)
export DB_PASSWORD=$(read_secret "DB_PASSWORD" || openssl rand -hex 16)

# Source in wrapper: source scripts/load-secrets-from-op.sh
```

### Docker Compose Integration

```yaml
# docker-compose.dev.yml
services:
  app:
    environment:
      SECRET_KEY: ${SECRET_KEY}
      DB_PASSWORD: ${DB_PASSWORD}
      API_KEY: ${API_KEY}
```

```bash
# Usage
source scripts/load-secrets-from-op.sh
docker compose -f docker-compose.yml -f docker-compose.dev.yml up
```

## Common Workflows

### 1. Find Missing Secrets

```bash
# List what exists
op item get "APP TangoAtlas - django-dev" --vault Infrastructure --format json | \
  python3 -c "import sys,json; [print(f['label']) for f in json.load(sys.stdin)['fields']]"

# Required vs actual
python3 << 'EOF'
required = ["SECRET_KEY", "DB_PASSWORD", "API_KEY"]
actual = ["SECRET_KEY", "DB_PASSWORD"]  # from above
missing = set(required) - set(actual)
print(f"Missing: {missing}")
EOF
```

### 2. Copy Secrets Between Items

```bash
# Read from source
VALUE=$(op read "op://Infrastructure/Source Item/field_name")

# Write to destination
op item edit "Dest Item" --vault Infrastructure "field_name[password]=$VALUE"
```

### 3. Migrate from .env File

See `scripts/migrate-env-to-1password.sh` for automated migration.

**Manual Process**:
1. Read `.env` file
2. For each `KEY=VALUE`, create 1Password field
3. Update scripts to use `op read` instead of `.env`
4. Move `.env` to `.env.backup`

### 4. Audit Vault Structure

```bash
# Count by type prefix
op item list --vault Infrastructure --format json | \
  python3 -c "
import sys, json
from collections import Counter
items = [i['title'].split()[0] for i in json.load(sys.stdin) if ' ' in i['title']]
counts = Counter(items)
for prefix, count in sorted(counts.items()):
    print(f'{prefix}: {count}')
"
```

### 5. Standardize Item Names

**Before Batch Rename**:
1. Document all references (scripts, CI/CD)
2. Test rename process on non-critical item
3. Update automation first, then rename items
4. Keep old name in notes field for 30 days

**Rename Command**:
```bash
op item edit "Old Name" --vault Infrastructure --title "New Name"
```

## Security Best Practices

1. **Never log secrets**: Redirect `op` stderr to `/dev/null` in production
2. **Use `op read` in scripts**: More reliable than `op item get | jq`
3. **Service accounts for CI/CD**: Read-only, no interactive auth
4. **Rotate regularly**: Update high-value secrets quarterly
5. **Audit access**: Use 1Password activity log for compliance

## Troubleshooting

| Error | Cause | Fix |
|-------|-------|-----|
| `not signed in` | No auth session | `eval $(op signin)` |
| `invalid secret reference` | Special chars in name | Use item ID instead |
| `could not read secret` | Field doesn't exist | List fields first with `op item get` |
| `item not found` | Wrong vault or name | Check `op item list` |
| Touch ID not working | CLI not linked to app | Settings → Developer → CLI integration |

## Reference Files

- **Naming Convention**: `references/naming-convention.md` - Full standardization guide with 30+ examples
- **Migration Scripts**: `scripts/` - Automated workflows for common tasks

## Quick Reference Card

```bash
# Most common operations
op whoami                                           # Check auth
op read "op://Vault/Item/field"                   # Get secret (fastest)
op item get "Item" --vault="Vault" --fields field # Get field (troubleshooting)
op item edit "Item" --vault="Vault" field[type]=val # Update/add field
op item list --vault="Vault" --format json        # Search/audit
```

**Documentation**: Run `op --help` or visit https://developer.1password.com/docs/cli
