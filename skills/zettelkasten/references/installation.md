# Zettelkasten MCP — Installation Reference

## Repository

| | |
|---|---|
| GitHub repo | `https://github.com/entanglr/zettelkasten-mcp` |
| Package name | `zettelkasten-mcp` |
| Entry point | `zettelkasten-mcp` (console script) |
| Requires | Python ≥ 3.10, `uv` ≥ 0.4 |

---

## Method 1: `uvx` (run without persistent install)

Best for MCP server usage — `uvx` fetches, caches, and runs in an isolated environment.

### SSH (recommended)

Requires your SSH key to have access to the repo:

```bash
uvx --from "git+ssh://git@github.com/entanglr/zettelkasten-mcp" zettelkasten-mcp \
  --notes-dir /path/to/notes \
  --database-path /path/to/db/zettelkasten.db
```

### HTTPS with GitHub CLI token

```bash
uvx --from "git+https://$(gh auth token)@github.com/entanglr/zettelkasten-mcp" \
  zettelkasten-mcp
```

### HTTPS with a Personal Access Token (PAT)

Create a PAT at `https://github.com/settings/tokens` with `repo` scope:

```bash
export GH_PAT=ghp_xxxxxxxxxxxxxxxxxxxx

uvx --from "git+https://${GH_PAT}@github.com/entanglr/zettelkasten-mcp" \
  zettelkasten-mcp
```

### Pinned version

```bash
uvx --from "git+ssh://git@github.com/entanglr/zettelkasten-mcp@v1.3.0" \
  zettelkasten-mcp
```

---

## Method 2: `uv pip install` (persistent install in a venv)

```bash
# Create and activate a venv
uv venv ~/.venvs/zettelkasten
source ~/.venvs/zettelkasten/bin/activate

# Install from SSH
uv pip install "git+ssh://git@github.com/entanglr/zettelkasten-mcp"

# Run
zettelkasten-mcp --notes-dir ~/notes --database-path ~/notes/zettelkasten.db
```

---

## SSL Certificate Issues

On some corporate machines, Python and `uv` may fail to verify GitHub's TLS certificate through a corporate proxy.

**Fix — use native OS TLS (trusts system CA automatically):**

```bash
export UV_NATIVE_TLS=1
uvx --from "git+ssh://git@github.com/entanglr/zettelkasten-mcp" zettelkasten-mcp
```

Or add to `~/.bashrc` / `~/.zshrc`:

```bash
export UV_NATIVE_TLS=1
```

---

## MCP Server Configuration

### VS Code / Copilot (`mcp.json`)

```json
{
  "mcpServers": {
    "zettelkasten": {
      "command": "uvx",
      "args": [
        "--from", "git+ssh://git@github.com/entanglr/zettelkasten-mcp",
        "zettelkasten-mcp",
        "--notes-dir", "/home/<user>/notes/zettelkasten",
        "--database-path", "/home/<user>/notes/db/zettelkasten.db"
      ]
    }
  }
}
```

### With environment variables instead of CLI args

```json
{
  "mcpServers": {
    "zettelkasten": {
      "command": "uvx",
      "args": [
        "--from", "git+ssh://git@github.com/entanglr/zettelkasten-mcp",
        "zettelkasten-mcp"
      ],
      "env": {
        "ZETTELKASTEN_NOTES_DIR": "/home/<user>/notes/zettelkasten",
        "ZETTELKASTEN_DATABASE_PATH": "/home/<user>/notes/db/zettelkasten.db",
        "ZETTELKASTEN_LOG_LEVEL": "INFO"
      }
    }
  }
}
```

### With a PAT via env variable (avoids embedding token in config)

```json
{
  "mcpServers": {
    "zettelkasten": {
      "command": "uvx",
      "args": [
        "--from", "git+https://x-access-token:${GH_PAT}@github.com/entanglr/zettelkasten-mcp",
        "zettelkasten-mcp"
      ],
      "env": {
        "GH_PAT": "<your-personal-access-token>",
        "ZETTELKASTEN_NOTES_DIR": "/home/<user>/notes/zettelkasten",
        "ZETTELKASTEN_DATABASE_PATH": "/home/<user>/notes/db/zettelkasten.db"
      }
    }
  }
}
```

> **Security note**: Prefer SSH key auth or the GitHub CLI token flow over embedding PATs in config files.

---

## Rebuild the Index

If you edit Markdown note files directly (outside the MCP server), the SQLite index may be stale. Rebuild it:

```
# In chat with MCP enabled:
"Rebuild the Zettelkasten index"
→ calls zk_rebuild_index()
```

Or the database can be deleted entirely — the server rebuilds from Markdown on next start.

---

## Verify Installation

```bash
# Check the binary is found
which zettelkasten-mcp  # (after pip install)
uvx --from "git+ssh://git@github.com/entanglr/zettelkasten-mcp" zettelkasten-mcp --help
```

Expected output includes `--notes-dir` and `--database-path` flags.
