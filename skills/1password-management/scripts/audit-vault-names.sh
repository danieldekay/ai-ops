#!/bin/bash
# Audit 1Password Infrastructure vault for naming convention compliance
# Usage: ./audit-vault-names.sh [vault_name]

set -e

VAULT="${1:-Infrastructure}"

echo "=== 1Password Vault Audit: $VAULT ==="
echo ""

# Check authentication
if ! op whoami &> /dev/null; then
    echo "❌ Not authenticated. Run: eval \$(op signin)"
    exit 1
fi

echo "✓ Authenticated as: $(op whoami 2>/dev/null | head -1)"
echo ""

# Get all items and store in temp file
TEMP_FILE=$(mktemp)
trap "rm -f $TEMP_FILE" EXIT
op item list --vault="$VAULT" --format=json > "$TEMP_FILE"

# Total count
TOTAL=$(python3 -c "import sys,json; print(len(json.load(open('$TEMP_FILE'))))")
echo "📊 Total items: $TOTAL"
echo ""

# Find duplicates
echo "🔍 Checking for duplicates..."
python3 << EOF
from collections import Counter
import json
with open('$TEMP_FILE') as f:
    items = [i['title'] for i in json.load(f)]
dups = {t: c for t, c in Counter(items).items() if c > 1}
if dups:
    for title, count in sorted(dups.items()):
        print(f'  ❌ "{title}" ({count}x)')
else:
    print('  ✓ No duplicates found')
EOF
echo ""

# Check naming convention compliance
echo "📋 Naming Convention Compliance:"
python3 << EOF
import json
with open('$TEMP_FILE') as f:
    items = [i['title'] for i in json.load(f)]

valid_prefixes = ['API', 'DB', 'SSH', 'OAUTH', 'ADMIN', 'SVC', 'APP', 'SMTP', 'SRV', 'VAULT']
compliant = []
non_compliant = []

for title in items:
    parts = title.split()
    if parts and parts[0] in valid_prefixes:
        compliant.append(title)
    else:
        non_compliant.append(title)

print(f"  ✓ Compliant: {len(compliant)}/{len(items)} ({100*len(compliant)//len(items) if items else 0}%)")
print(f"  ⚠️  Non-compliant: {len(non_compliant)}")

if non_compliant:
    print("\n  Non-compliant items (first 10):")
    for item in non_compliant[:10]:
        print(f"    - {item}")
    if len(non_compliant) > 10:
        print(f"    ... and {len(non_compliant) - 10} more")
EOF
echo ""

# Category distribution
echo "📂 Type Distribution:"
python3 << EOF
import json
from collections import Counter
with open('$TEMP_FILE') as f:
    items = json.load(f)
prefixes = [i['title'].split()[0] for i in items if ' ' in i['title']]
counts = Counter(prefixes)
for prefix, count in sorted(counts.items(), key=lambda x: -x[1]):
    print(f"  {prefix}: {count}")
if not prefixes:
    print("  (No type prefixes found)")
EOF
echo ""

# Items with special characters
echo "⚠️  Items with Special Characters:"
python3 << EOF
import json
with open('$TEMP_FILE') as f:
    items = [i['title'] for i in json.load(f)]
special = [t for t in items if any(c in t for c in '@()[]{}')]
if special:
    for title in special[:5]:
        print(f'  - {title}')
    if len(special) > 5:
        print(f'  ... and {len(special) - 5} more')
else:
    print('  ✓ None found')
EOF
echo ""

echo "=== Audit Complete ==="
echo ""
echo "Next steps:"
echo "  1. Review non-compliant items above"
echo "  2. Check references/naming-convention.md for standards"
echo "  3. Use 'op item edit' to rename items"
echo "  4. Remove duplicate items after merging"
