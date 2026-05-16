#!/bin/bash
# Batch rename 1Password items following naming convention
# Usage: ./batch-rename-items.sh mapping.csv [vault_name]
#
# CSV Format: old_name,new_name
# Example:
#   tangoatlas-authentik,OAUTH Authentik - tangoatlas-prod
#   TMD api key (PROD),API TMD - backend-prod

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 mapping.csv [vault_name]"
    echo ""
    echo "CSV Format: old_name,new_name"
    echo "Example:"
    echo "  tangoatlas-authentik,OAUTH Authentik - tangoatlas-prod"
    echo "  TMD api key (PROD),API TMD - backend-prod"
    exit 1
fi

MAPPING_FILE="$1"
VAULT="${2:-Infrastructure}"

if [ ! -f "$MAPPING_FILE" ]; then
    echo "❌ File not found: $MAPPING_FILE"
    exit 1
fi

# Check authentication
if ! op whoami &> /dev/null; then
    echo "❌ Not authenticated. Run: eval \$(op signin)"
    exit 1
fi

echo "=== Batch Rename 1Password Items ==="
echo "Vault: $VAULT"
echo "Mapping: $MAPPING_FILE"
echo ""

# Preview changes
echo "📋 Preview (will NOT make changes yet):"
echo ""
while IFS=',' read -r old_name new_name; do
    # Skip empty lines and comments
    [[ -z "$old_name" || "$old_name" =~ ^# ]] && continue
    
    # Trim whitespace
    old_name=$(echo "$old_name" | xargs)
    new_name=$(echo "$new_name" | xargs)
    
    echo "  $old_name"
    echo "    → $new_name"
    echo ""
done < "$MAPPING_FILE"

# Confirmation
read -p "🔄 Proceed with renaming? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
    echo "❌ Cancelled"
    exit 0
fi

echo ""
echo "🔄 Renaming items..."
echo ""

SUCCESS=0
FAILED=0
SKIPPED=0

while IFS=',' read -r old_name new_name; do
    # Skip empty lines and comments
    [[ -z "$old_name" || "$old_name" =~ ^# ]] && continue
    
    # Trim whitespace
    old_name=$(echo "$old_name" | xargs)
    new_name=$(echo "$new_name" | xargs)
    
    # Check if old item exists
    if ! op item get "$old_name" --vault="$VAULT" &> /dev/null; then
        echo "⚠️  Skipped: \"$old_name\" not found"
        ((SKIPPED++))
        continue
    fi
    
    # Check if new name already exists
    if op item get "$new_name" --vault="$VAULT" &> /dev/null 2>&1; then
        echo "⚠️  Skipped: \"$new_name\" already exists"
        ((SKIPPED++))
        continue
    fi
    
    # Rename item
    if op item edit "$old_name" --vault="$VAULT" --title "$new_name" &> /dev/null; then
        echo "✓ Renamed: \"$old_name\" → \"$new_name\""
        ((SUCCESS++))
    else
        echo "❌ Failed: \"$old_name\""
        ((FAILED++))
    fi
done < "$MAPPING_FILE"

echo ""
echo "=== Summary ==="
echo "✓ Success: $SUCCESS"
echo "⚠️  Skipped: $SKIPPED"
echo "❌ Failed: $FAILED"
echo ""

if [ $FAILED -gt 0 ]; then
    echo "⚠️  Some items failed to rename. Check manually in 1Password app."
fi

echo "✓ Batch rename complete!"
