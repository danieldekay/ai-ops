# wiki.toml Schema Reference

Reference document for the `llm-wiki` skill. Load when creating or interpreting `wiki.toml`.

## Minimal wiki.toml

```toml
[meta]
title   = "Topic Name"
slug    = "topic-slug"          # kebab-case, used for ZK tags and folder naming
flavor  = "research"            # research | domain | project | personal | book
created = "YYYY-MM-DD"

[scope]
in_scope  = "What topics are included"
out_scope = "What is explicitly excluded"
question  = "The central question this wiki answers"
```

## Full wiki.toml

```toml
[meta]
title    = "Topic Name"
slug     = "topic-slug"
flavor   = "research"           # research | domain | project | personal | book
created  = "YYYY-MM-DD"
updated  = "YYYY-MM-DD"
version  = 1                    # bump when schema changes significantly

[scope]
in_scope  = "…"
out_scope = "…"
question  = "…"

[structure]
# Override default path conventions when adopting an existing folder
raw    = "raw"                  # where source documents live
wiki   = "wiki"                 # where LLM-generated pages live
index  = "wiki/index.md"
log    = "log.md"
gaps   = "wiki/gaps.md"

[structure.page_types]
# List which page types are used in this wiki
types = ["source", "entity", "concept", "comparison", "qa", "overview", "gaps"]

[ingest]
discuss_before_writing = true   # pause and discuss takeaways before creating pages
update_overview_every  = 5      # update overview.md after this many ingests
batch_mode = false              # true = ingest many sources with less supervision

[zk]
enabled    = true               # false = skip ZK integration entirely
tag_prefix = "wiki"             # ZK tags will be wiki:<slug>
hub_note_after = 10             # create a hub note after this many sources
note_types = ["permanent", "literature"]  # which ZK types to create

[sources]
# Optional metadata about the source collection
primary_language = "en"
accepts = ["pdf", "html", "md", "docx", "youtube", "arxiv"]

[lint]
# Thresholds for lint warnings
max_orphan_pages    = 3         # warn if more than N pages have no inbound links
min_concept_sources = 2         # warn if a concept has fewer than N sources
stale_after_days    = 90        # warn if a page hasn't been updated in N days
```

## Flavor Defaults

Each flavor has a natural set of page types and conventions:

| Flavor | Typical page types | Central question |
|--------|--------------------|-----------------|
| `research` | source, concept, entity, comparison, qa | What does the evidence say about X? |
| `domain` | entity, concept, overview, comparison | How does domain X work? |
| `project` | entity (stakeholders), concept (requirements), qa (decisions) | How are we building X? |
| `personal` | source (journal/articles), concept (patterns), qa (reflections) | What am I learning about X? |
| `book` | source (chapters), entity (characters/places), concept (themes) | What does this book mean? |

## Schema Evolution Log

Record schema changes in the wiki's `log.md`:

```
## [YYYY-MM-DD] schema | Added 'comparison' page type
## [YYYY-MM-DD] schema | Narrowed scope to exclude topic Y
## [YYYY-MM-DD] schema | Enabled ZK integration
```
