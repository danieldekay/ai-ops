---
name: dotenv-credential-safety
description: Use when working with .env files, API keys, tokens, passwords, or any secrets — before reading, echoing, printing, or passing credentials to terminal commands, file reads, or agent tools. Also use when sourcing .env in shell scripts or when piping command output that may contain secret values.
---

# dotenv-credential-safety

## Overview

Credentials in `.env` files must never appear verbatim in session transcripts, tool outputs, or command stdout. This skill enforces safe patterns for reading, using, and referencing secrets so they remain opaque to the agent's context window.

## The Core Problem

When an agent reads a `.env` file or runs `echo $API_KEY`, the raw secret lands in the conversation transcript — permanently. Even if the session ends, that text exists in logs, history, and memory. This is a one-way door.

---

## Rules

### Rule 1 — Never read `.env` verbatim into context

```bash
# ❌ WRONG — raw secret enters transcript
cat .env
read_file(".env")          # tool call
ctx_read(".env")            # lean-ctx equivalent
```

```bash
# ✅ RIGHT — truncate, show only key names
grep -oP '^[A-Z_]+(?==)' .env          # prints only key names, no values
sed 's/=.*/=<redacted>/' .env          # shows keys with values masked
```

If you must confirm a file's structure, **always mask values** before returning output:
```bash
sed 's/=.*/=***/' .env
```

### Rule 2 — Never echo or print a secret variable

```bash
# ❌ WRONG
echo $GLAB_TOKEN
echo "token is $API_KEY"
printf '%s\n' "$SECRET"
```

```bash
# ✅ RIGHT — confirm presence without revealing value
[[ -n "$GLAB_TOKEN" ]] && echo "GLAB_TOKEN is set" || echo "GLAB_TOKEN is missing"
echo "${API_KEY:+<set>}${API_KEY:-<missing>}"
```

### Rule 3 — Source, don't print — pass secrets via environment only

```bash
# ✅ Source first, then use the variable directly in the command
source .env
curl -H "Authorization: Bearer $GLAB_TOKEN" https://api.example.com/endpoint
```

The secret travels as an environment variable — it never appears as a literal string in the shell command or transcript.

### Rule 4 — Never interpolate secrets into displayed strings

```bash
# ❌ WRONG — secret printed in the Authorization header debug output
curl -v -H "Authorization: Bearer $GLAB_TOKEN" ...
# curl -v prints the header verbatim
```

```bash
# ✅ RIGHT — suppress header output, or use --netrc / config file
curl -s -H "Authorization: Bearer $GLAB_TOKEN" ...    # no -v
```

### Rule 5 — Truncate tool output that may contain secrets

When running commands whose output might include an echoed token or a response that mirrors back the credential (e.g., some auth APIs echo the token in a 401 body):

```bash
# Pipe through a masker before capturing
source .env
result=$(curl -s ... | sed "s/$GLAB_TOKEN/<redacted>/g")
echo "$result"
```

### Rule 6 — Confirm .env is gitignored before any git operation

```bash
grep -q '\.env' .gitignore && echo "safe" || echo "WARNING: .env not in .gitignore"
```

Never commit, add, or stage `.env` or any file whose name matches `*.env`, `.env.*`, or `secrets.*`.

---

## Safe Inspection Patterns

| Goal | Safe command |
|------|-------------|
| List keys defined in `.env` | `grep -oP '^[A-Z_a-z0-9]+(?==)' .env` |
| Check a key is non-empty | `[[ -n "$KEY" ]] && echo set \|\| echo missing` |
| Confirm value length (debug) | `echo "${#KEY} chars"` |
| Diff two `.env` files (keys only) | `diff <(grep -oP '^[^=]+' a.env) <(grep -oP '^[^=]+' b.env)` |
| Mask and display for audit | `sed 's/=.*/=***/' .env` |

---

## Safe Usage Patterns

### Passing a token to a CLI tool

```bash
source .env
m365 login --authType secret --clientId "$CLIENT_ID" --clientSecret "$CLIENT_SECRET"
```

### Passing a token to curl

```bash
source .env
curl -s -H "X-Gitlab-Token: $GLAB_TOKEN" "https://example.com/api"
```

### Passing a token as a Python env var

```bash
source .env && uv run python main.py
# Python reads via os.environ["GLAB_TOKEN"] — never printed
```

### Using in a script without sourcing every time

```bash
set -a && source .env && set +a   # export all vars from .env into environment
# subsequent commands inherit the env vars silently
```

---

## What to Do When a Secret Is Accidentally Printed

1. **Do not repeat or quote it** — do not include it in any further message.
2. **Rotate immediately** — revoke and regenerate the credential in the issuing system.
3. **Note in `.env`** — update the file with the new value.
4. **Clear history if possible** — `history -c` in the terminal, close the session.

---

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| `read_file(".env")` to check config | Use `grep -oP '^[^=]+' .env` to list keys only |
| `echo $TOKEN` to verify it loaded | Use `[[ -n "$TOKEN" ]] && echo set` |
| `curl -v` with auth header | Remove `-v`, or pipe through sed masker |
| Storing token in a shell variable then `set` to inspect | Use `declare -p VAR \| sed 's/=.*/=***/'` |
| `cat .env \| grep KEY` | Shows value — use `grep -o '^KEY[^=]*' .env` instead |
