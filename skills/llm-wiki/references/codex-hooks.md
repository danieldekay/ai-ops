# Codex Wiki Hooks

Source: `scripts/codex_wiki_hook.py` in this skill. The local installation links
`~/.codex/hooks/llm-wiki.py` to that source and registers two additional groups in
`~/.codex/hooks.json`, preserving existing lean-ctx hooks.

- `SessionStart` (`startup|resume|clear|compact|fork`): expose vault location,
  this operating guide, recall guidance, ownership rules, and a retention reminder.
- `UserPromptSubmit`: select up to five existing pages by local registry
  title/tag/ID matches and provide links, plus a reminder to use `wiki_recall`
  for deeper retrieval. Candidate data is explicitly untrusted.

The script reads the user Codex configuration (`$CODEX_HOME/config.toml`, or
`~/.codex/config.toml`) and the `llm-wiki` MCP environment's `WIKI_ROOT` or
`WIKI_HOME`. It follows the `.llm-wiki` alias to the physical vault. It does not
resolve additional project/profile/managed configuration layers; an agent must
still verify its active tool vault before writing. A missing config/vault or
disabled server produces no context. Invalid registry data degrades to a recall
reminder. No prompts, transcripts, or wiki content are written; no network/model
calls occur. This hook does not perform semantic search or automatic ingestion.

Codex requires review of new/changed hook definitions through `/hooks` before
running them. Do not manufacture trusted hashes or bypass this review. Review
the two handlers, trust them, then start or resume a chat. CLI trust and desktop
execution should be checked on the actual surface; a direct script test alone
does not prove the lifecycle fired.

Disable either handler in `/hooks`, or set `LLM_WIKI_CODEX_HOOKS=0` in the
Codex process environment to silence both. Existing hooks remain independent.

Run the focused checks with:

```sh
python3 skills/llm-wiki/tests/test_codex_wiki_hook.py
```

Hook output uses the documented `hookSpecificOutput.hookEventName` and
`additionalContext` fields. See [OpenAI hook documentation](https://learn.chatgpt.com/docs/hooks).
