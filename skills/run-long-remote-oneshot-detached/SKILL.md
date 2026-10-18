---
name: "run-long-remote-oneshot-detached"
description: "Run long remote one-shot commands (SSH/ansible targets) so client teardown cannot interrupt them."
version: 1
created: "2026-09-20"
updated: "2026-09-20"
---
## When to Use
Any time a command on a remote host (via ansible -m shell, ssh, or similar) may run longer than a couple of minutes — agent research runs, long hermes chat -q calls, big installs, migration scripts. Direct invocation of a long command can be cut by a client/harness wall (e.g. ~120s/8MB), whose connection teardown then delivers SIGHUP/SIGINT to the remote process and loses the work partway.

## Procedure
1. Detach on the target: setsid nohup <command> </dev/null >/tmp/out.log 2>&1 & echo $! — this makes the process immune to controlling-terminal signals and client disconnect.
2. Return immediately with just a status line (pid, initial file size) — never stream the command output.
3. Poll the target: check process liveness (pgrep/kill -0) and output file growth; wait for process exit and stable mtime.
4. Fetch the output file when done (ansible -m fetch / scp) and verify it ends cleanly (no traceback, expected banner).
5. For prompts: pass the prompt without shell-quoting leaks — base64-encode it, decode inside the remote command (printf %s 'B64' | base64 -d > /tmp/p.txt; cat /tmp/p.txt).

## Pitfalls
- Do NOT run the long command directly with a big timeout and hope — the harness/client may still cut it at an output or time wall, and teardown signals the remote.
- setsid/nohup with > redirect is not enough — also redirect stdin from /dev/null so the detached process never blocks on a tty.
- If the remote is Debian sh (dash), avoid bashisms like <<< in the remote command.
- Verify completion by the file CONTENT (clean end), not just process exit.
- Don't forget the base64 prompt trick when the arg contains quotes/backticks/$(...).

## Verification
1. Process exits on its own and the output file size is stable across two checks ~30s apart.
2. File tail shows the expected completion (final answer/banner), no KeyboardInterrupt/Traceback.
3. The full artifact was fetched byte-faithfully (ansible fetch reports checksum).