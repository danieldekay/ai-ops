---
name: "pip-package-audit"
description: "Audit-before-install for pip packages Daniel pastes or requests (sdist inspection: network/exec/token/telemetry scan, maintainer signal, project-venv-only install). Use when installing any unfamiliar pip package or when Daniel pastes an install command."
version: 1
created: "2026-10-01"
updated: "2026-10-01"
---
## When to Use
Use whenever a pip/uv install command is pasted, an unfamiliar package is requested, or a one-off utility package is about to enter a project venv. Do NOT skip the audit for convenience packages that touch the network or read credentials (e.g. Graph-API metadata tools).

## Procedure
1. STOP on paste: never run a pasted install command unmodified — audit the package first, then install into the PROJECT venv (.venv), never the system Python.
2. FETCH SOURCE: download sdist/wheel without installing (e.g. `pip download --no-deps <pkg> -d /tmp/audit` or PyPI JSON API), then unpack the sdist (tar tzf / unzip) — inspect ALL of setup.py, setup.cfg, pyproject.toml build hooks, and package .py files.
3. GREP THE DANGERS: network calls (requests, urllib, socket, httpx, subprocess curl/wget), dynamic execution (exec, eval, compile, __import__, marshal/pickle.loads), credential access (os.environ reads of TOKEN/KEY/SECRET, keychain, .env), filesystem escapes (writing outside the project), install-time hooks (cmdclass, build-backend scripts), obfuscation (base64 blobs, hex strings, exec(decode(...))), telemetry/phone-home.
4. CHECK SIGNAL: PyPI page (maintainer, release history, first-release date), GitHub repo exists + recent commits + stars, compare package name character-by-character against the intended project (typosquat check: fbmetadata vs fb-metadata etc.), and whether the package actually matches the feature you need.
5. INSTALL + RECORD: if clean, `uv pip install -p .venv/bin/python <pkg>==<pinned-version>` into the project venv; record the audit verdict (what was scanned, what was found) in the project notes/bead; if findings are suspicious, report to Daniel with evidence instead of installing.
6. VERIFY: import the package in the project venv and run one smoke call; note version pin in the project docs.

## Pitfalls
- Network-capable data tools often download MORE at import time (model weights, Graph API SDKs) — audit the runtime paths, not just setup.py.
- A clean GitHub repo does not clear the sdist: audit the artifact that pip will actually install.
- Never audit-then-install into a global/system interpreter; project venv only.
- Partial install chains (--deps) can pull un-audited transitive packages — audit with --no-deps and install deps explicitly.

## Verification
1. Audit report exists with the grep results and maintainer-signal verdict before install.
2. Package imports cleanly in the project .venv with the recorded version pin.
3. No unexpected network activity on first import (offline smoke test where possible).