# Optional Zettelkasten Integration

Use only when requested or already part of the active workflow. Wiki operation
does not require a Zettelkasten server and must remain usable without one.

Promote atomic, reusable cross-domain insights; keep topic-specific summaries in
the wiki. Search existing notes before creating duplicates. Discover the actual
Zettelkasten tools and their schemas rather than assuming tool names or a local
database path. If unavailable, leave a linked candidate in the wiki when saving
is authorized; do not claim a ZK note was created.

Keep evidence and provenance in the promoted note. Use the note system's real
IDs for internal links and a resolvable URL or file link for the wiki page;
wiki page names are not ZK IDs. Record returned note IDs in wiki frontmatter
(`zk_notes`) only if the vault's schema allows it. Add `wiki:<topic-slug>` tags
when consistent with existing conventions.

For standalone manual wikis, log significant promotion in their operations log.
For extension-managed vaults, use `wiki_log_event` if available and appropriate;
never append to generated `meta/log.md` or edit `meta/events.jsonl` manually.
