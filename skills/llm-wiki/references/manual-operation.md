# Manual Operation

Use when the required wiki tools are absent, not to bypass an access denial.
Use the host's available read/search/edit tools (lean-ctx when configured).

## Detect the vault

1. Follow explicit user scope and host configuration. Resolve symlinks and inspect
   the target before writing. The local shared physical vault is
   `~/Dokumente/2ndBrain/wiki`; its `.llm-wiki` entry is an alias in the parent directory.
2. A vault with `config.json`, `raw/`, `wiki/`, and `meta/` is extension-managed.
   Inspect its schema/templates and representative pages. A temporary lack of
   tools does not convert it into a standalone manual wiki.
3. A standalone wiki may use `wiki.toml`, `wiki.config.md`, `raw/`, `wiki/`, and
   `log.md`. Preserve the conventions found there.
4. If the vault is missing, check configuration and compatibility paths before
   creating anything. Create a new vault only when the task calls for one.

## Recall and query (both formats)

- Search titles and bodies in `wiki/` with task-specific terms. A generated
  registry can help locate pages but may be stale after direct edits.
- Read the selected pages in full or focused sections, following source links
  where needed. Cite the actual pages; disclose that retrieval used filesystem
  search when relevant to coverage.
- For an authorized saved answer, create or update a page using the existing
  naming, frontmatter, and link conventions. Preserve `created`, update `updated`,
  and distinguish evidence from inference. Re-read just before editing.

## Extension-managed vault, tools unavailable

Allowed: edit or create pages in `wiki/` using the vault's existing templates
and supported page types (`source`, `entity`, `concept`, `synthesis`, `analysis`
as applicable). Search for duplicates first. Do not fabricate source packet IDs.

For a new URL/file/text source:

1. Save an unchanged copy and provenance in a separate task-local staging
   directory **outside the managed vault**. Record title, original URL/path,
   capture date, and a checksum when practical. Fetch only through available,
   permitted mechanisms; distinguish excerpts from a complete source.
2. You may draft knowledge pages under `wiki/`, citing the staged artifact or
   original URL and explicitly marking capture/ingestion as pending. Do not
   label a draft as a completed managed ingest.
3. Leave `raw/` and all of `meta/` untouched. Do not hand-assign `SRC-*` IDs,
   ingestion flags, events, registry entries, backlinks, or embedding state.
4. Report the staged source and changed pages. When tools return, capture the
   staged source, ingest it once, reconcile draft citations with the returned
   packet ID, and rebuild metadata/indexes through supported tools as needed.

If a vetted, supported maintenance CLI is already installed, inspect its help
and use its documented operation within the task's authority. Do not import
private package internals or invent maintenance commands.

For observations/lessons, write a normal knowledge page only when retention is
authorized. Preserve the same pending-metadata distinction. Warn that tool-based
recall may miss direct edits until its metadata/search projections are rebuilt.

## Standalone manual wiki

For an existing wiki, use its schema and layout. For a newly requested wiki,
infer a reasonable scope from the request or clarify material ambiguity, then
create `wiki.toml`, `wiki.config.md`, `raw/`, `wiki/index.md`, and `log.md` using
the linked standalone references. Do not create an extension `config.json` or
claim compatibility with the extension without an explicit supported migration.

Ingest:

1. Save a uniquely named, unchanged source under `raw/`; record provenance and
   capture date. Never overwrite an existing source. Cite external files directly
   if the source cannot be copied within the granted scope.
2. Write a source summary, integrate evidence into existing entity/concept pages,
   cross-link related pages, and document contradictions with both sources.
3. Maintain the standalone wiki's index and append its operations log. Do not
   rewrite historical log entries. Follow any configured discussion requirement;
   do not add approval steps solely because the operation is manual.

Lint by inspecting missing link targets, duplicate topics, unsupported claims,
contradictions, stale dates, and index drift. Present uncertain merges/deletions
for review; perform routine fixes already authorized by the task. This is a manual
inspection, not a successful run of the extension's lint or indexing pipeline.

## Completion checks

- Read back all changed pages; parse YAML/TOML where suitable tooling exists.
- Check relative and vault-root links against the vault's actual conventions.
- Confirm cited source copies exist and originals remain unchanged.
- Report drafts, unavailable captures, and stale generated metadata explicitly.
