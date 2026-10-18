---
name: "1password-service-account-auth"
description: "Mint, load, validate, and troubleshoot the 1Password service-account token flow used by Ansible control-plane repos (hermes-vps, g12 ansible) for community.general.onepassword lookups. Use when a playbook needs secrets from 1Password, the SA token is missing/expired/403ing, or secret-write tasks silently skip."
version: 2
created: "2026-09-20"
updated: "2026-09-27"
---
## When to Use
Ansible repo consumes secrets via the community.general.onepassword lookup backed by a Keychain-cached service-account token (pattern: setup-op-service-account.sh + load-op-token.sh + a run wrapper that sources the loader). Triggers: 'No valid 1Password service-account token', 403 on lookups, secret-write tasks skipped in the recap, minting/reminting the token, or debugging why a secret never reached the host.

## Procedure
1. Confirm the model: a personal op session and the SA token env var are MUTUALLY EXCLUSIVE. Automation uses the SA token only; minting tokens or editing vault items uses a personal session only.
2. Mint or refresh in ONE shell (op sessions do not survive across shell invocations — running eval and the setup script in two separate tool calls fails with 'No interactive 1Password session is available'): `unset OP_SERVICE_ACCOUNT_TOKEN && eval "$(op signin)" && bash scripts/setup-op-service-account.sh [--force]`. Touch ID from an agent shell works — the human only approves the biometric prompt; never handle the account unlock phrase.
3. Load: source scripts/load-op-token.sh — it validates the Keychain entry by an ITEM READ (op read redirected to null), never op whoami, then exports the SA token env var. The playbook wrapper sources it automatically.
4. Prove the lookup before the playbook: pipe the item field read through wc -c (expect a non-empty length; never print the value). For host-var resolution use a length-only debug probe style msg templated with pipe length.
5. When a secret-write task is skipped in the recap: check (a) the group_vars file actually loads — Ansible only loads group_vars/<name>.yml when an inventory group <name> exists; nest the host under that group, (b) the lookup's field name matches the item (Login items store the secret in their credential field), (c) the var is used so no default('') masks the skip.
6. Troubleshoot 403s: stale tokens still whoami then 403 on reads — remint with --force. A 403 from 'op vault list' is normal for SAs; probe item reads instead.
## Pitfalls
- op whoami is NOT proof for a service account — stale/ACL-broken tokens pass whoami then 403 every read mid-playbook.
- An all-ok play recap can still be silently broken: `when: (var | default('')) | length > 0` skips tasks when the var is undefined — a missing inventory group for the group_vars file is the classic cause.
- Never print or log the token or secret value: verify by length only (wc -c) and by owner/mode on the destination file.
- The token expires (default 1h) — remint before any later run in the same session.
- Agent shells have no interactive op session; the mint's op signin step needs a human to approve. Plan one human touch per mint.

## Verification
1. source scripts/load-op-token.sh exits 0 and reports loading from the macOS Keychain.
2. Piping the item field read through wc -c shows a non-empty length consistent with the stored secret.
3. The config playbook recap shows the secret task ran (not skipped) and the destination file is owned by the target user with mode 0600.
4. The host debug probe resolves the variable to a non-empty length (never print the value).