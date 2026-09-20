#!/usr/bin/env bash
# init_wiki.sh — scaffold a wiki-builder topic wiki
# Usage: bash init_wiki.sh <slug> --title "Title" --flavor research [--root ~/wikis]
# Flavors: research, paper, domain, product, person, organization, project, meeting-series, regulatory

set -euo pipefail

SLUG=""
TITLE=""
FLAVOR="research"
ROOT="${WIKI_ROOT:-$HOME/wikis}"

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --title) TITLE="$2"; shift 2 ;;
    --flavor) FLAVOR="$2"; shift 2 ;;
    --root) ROOT="$2"; shift 2 ;;
    -*) echo "Unknown option: $1" >&2; exit 1 ;;
    *) SLUG="$1"; shift ;;
  esac
done

if [[ -z "$SLUG" ]]; then
  echo "Usage: bash init_wiki.sh <slug> --title 'Title' --flavor research" >&2
  exit 1
fi

[[ -z "$TITLE" ]] && TITLE="$SLUG"

WIKI_DIR="$ROOT/$SLUG"

if [[ -d "$WIKI_DIR" ]]; then
  echo "Wiki already exists at $WIKI_DIR" >&2
  exit 1
fi

echo "Scaffolding wiki: $TITLE (flavor: $FLAVOR)"
echo "Location: $WIKI_DIR"

# Create folder layout
mkdir -p \
  "$WIKI_DIR/raw" \
  "$WIKI_DIR/wiki/questions" \
  "$WIKI_DIR/derived" \
  "$WIKI_DIR/prompts" \
  "$WIKI_DIR/logs"

# wiki.config.md
cat > "$WIKI_DIR/wiki.config.md" << EOF
# Wiki: $TITLE

## Purpose
[One sentence: what question does this wiki answer?]

## Audience
[Who reads this? e.g., Agent + researcher, team members, stakeholders]

## Flavor
$FLAVOR

## Page Types
[List the categories of pages this wiki contains, e.g., concepts/, papers/, tools/]

## Update Rules
- Compile new raw/ items before answering questions
- File every Q&A answer before responding
- Run maintenance pass after every 10 new pages
- All claims must cite sources.md

## Scope Boundaries
[What is explicitly out of scope for this wiki?]
EOF

# wiki.toml — machine-readable config (agent reads this first)
# Derive default page_types from flavor
case "$FLAVOR" in
  paper)         PAGE_TYPES='["papers", "concepts", "methods", "results"]' ;;
  domain)        PAGE_TYPES='["concepts", "tools", "people", "organizations"]' ;;
  product)       PAGE_TYPES='["features", "decisions", "users", "competitors"]' ;;
  person)        PAGE_TYPES='["biography", "works", "ideas", "collaborators"]' ;;
  organization)  PAGE_TYPES='["overview", "people", "products", "history"]' ;;
  project)       PAGE_TYPES='["goals", "decisions", "tasks", "retrospectives"]' ;;
  meeting-series) PAGE_TYPES='["meetings", "decisions", "actions", "topics"]' ;;
  regulatory)    PAGE_TYPES='["requirements", "controls", "evidence", "gaps"]' ;;
  *)             PAGE_TYPES='["concepts", "papers", "tools", "people"]' ;;  # research default
esac

cat > "$WIKI_DIR/wiki.toml" << EOF
# wiki.toml — machine-readable config for this wiki
# Agent reads this FIRST before any action.
# Edit to override wiki-builder skill defaults.

[meta]
title   = "$TITLE"
slug    = "$SLUG"
flavor  = "$FLAVOR"
created = "$(date +%Y-%m-%d)"

[structure]
page_types     = $PAGE_TYPES
index_grouping = "page_type"  # "page_type" | "date" | "alphabetical"

[ingest]
max_integration_pages   = 15
contradiction_detection = true
append_to_log           = true

[lint]
min_claims_per_page  = 3
maintenance_interval = 10

checks = [
  "thin_pages",
  "missing_backlinks",
  "uncompiled_raw",
  "orphaned_questions",
  "unsourced_claims",
  "unresolved_contradictions",
  "stale_claims",
]

[provenance]
require_attribution  = true
inference_marker     = "[inferred]"
contradiction_marker = "⚠️ Contradiction:"

[zk]
enabled    = false
tag_prefix = ""
EOF

# sources.md
cat > "$WIKI_DIR/sources.md" << EOF
# Sources

All sources referenced in this wiki. Every claim in compiled pages and filed answers must link back here.

## Format
\`\`\`
[slug]: Author, A. (Year). Title. Publisher/URL. Accessed: YYYY-MM-DD.
[description of relevance]
\`\`\`

## Sources

<!-- Add sources as you compile pages -->
EOF

# wiki/index.md
cat > "$WIKI_DIR/wiki/index.md" << EOF
# $TITLE — Wiki Index

**Flavor**: $FLAVOR
**Created**: $(date +%Y-%m-%d)
**Config**: [wiki.config.md](../wiki.config.md)
**Sources**: [sources.md](../sources.md)

## Pages

<!-- Agent maintains this index. Add links as pages are compiled. -->

## Questions

<!-- Filed Q&A answers live in questions/ -->

## Maintenance Log

See [logs/maintenance-log.md](../logs/maintenance-log.md)
EOF

# logs/log.md (append-only operations log)
cat > "$WIKI_DIR/logs/log.md" << EOF
# Operations Log — $TITLE

Append-only record of every ingest, query, and lint pass.
Format: `## [YYYY-MM-DD] operation | description`
Tip: `grep "^## \[" logs/log.md | tail -10` gives the last 10 entries.

## [$(date +%Y-%m-%d)] init | Wiki scaffolded
Flavor: $FLAVOR
EOF

# logs/maintenance-log.md
cat > "$WIKI_DIR/logs/maintenance-log.md" << EOF
# Maintenance Log — $TITLE

## $(date +%Y-%m-%d) — Initialized

Wiki scaffolded with flavor: $FLAVOR
EOF

# prompts/compile-source-page.md
cat > "$WIKI_DIR/prompts/compile-source-page.md" << EOF
# Prompt: Compile Source Page

Read wiki.toml (structure config) and wiki.config.md (purpose/scope), then compile the source material in raw/[FILE] into a structured wiki page.

Step 1 — Write the source/summary page:
- Title: Descriptive, matches the source content
- Every claim attributes to sources.md (cite by slug)
- Mark inferences as [inferred]
- Length: enough to stand alone as a reference page
- Add a ## Links section with cross-references to other wiki pages
- Output: wiki/[appropriate-subfolder]/[slug].md

Step 2 — Integration pass (check [ingest].max_integration_pages in wiki.toml):
- Search existing wiki pages for entity, concept, or topic pages that this source provides new evidence for
- Update those pages: add evidence, strengthen or challenge existing claims
- Flag contradictions: if new data contradicts an existing claim, mark the conflict with: > ⚠️ Contradiction: [new-source] says [X], but this page previously stated [Y]

Step 3 — Housekeeping:
- Update wiki/index.md with the new page
- Append to logs/log.md: ## [YYYY-MM-DD] ingest | [Source Title]
EOF

# prompts/compile-index.md
cat > "$WIKI_DIR/prompts/compile-index.md" << EOF
# Prompt: Compile Index

Read wiki.toml (for page_types and index_grouping) and all pages in wiki/. Rebuild wiki/index.md as a navigable table of contents.

Requirements:
- Group pages by page type (as defined in wiki.toml [structure].page_types)
- One line per page: link + one-sentence description
- List questions/ entries separately
- Note any gaps (page types with no pages yet)

Output: Overwrite wiki/index.md.
EOF

# prompts/compile-concept-page.md
cat > "$WIKI_DIR/prompts/compile-concept-page.md" << EOF
# Prompt: Compile Concept Page

Read wiki.toml. Synthesize the concept "[CONCEPT]" from all relevant sources in raw/ and existing wiki pages.

Requirements:
- Definition: precise, own words
- Key properties: bullet list
- Examples / instances
- Related concepts: links to other wiki pages
- Open questions: what is unclear or contested
- All claims attributed to sources.md

Output: Write to wiki/concepts/[concept-slug].md and update wiki/index.md.
EOF

# prompts/query-and-file.md
cat > "$WIKI_DIR/prompts/query-and-file.md" << EOF
# Prompt: Query and File

Read wiki.toml (for behavior config), then wiki.config.md (for scope), then wiki/index.md, then relevant wiki pages.

Answer the question: "[QUESTION]"

Requirements:
- Base the answer on wiki content and raw/ sources only
- Attribute every claim to sources.md
- Mark inferences as [inferred]
- If the answer requires information not in the wiki, say so explicitly

BEFORE responding to the user, file the answer:
- Write to wiki/questions/[question-slug].md
- Add an entry to wiki/index.md under ## Questions
- Append to logs/log.md: ## [YYYY-MM-DD] query | [question-slug]

Then provide the answer to the user.
EOF

# prompts/lint-wiki.md
cat > "$WIKI_DIR/prompts/lint-wiki.md" << EOF
# Prompt: Lint Wiki

First, read logs/log.md tail (last 20 entries) to orient on what has happened recently.
Read wiki.toml (for enabled checks and thresholds) and all wiki pages. Run a maintenance pass and report:

1. **Thin pages** — pages with fewer claims than [lint].min_claims_per_page in wiki.toml
2. **Missing backlinks** — pages that reference other pages but have no incoming links
3. **Uncompiled raw** — items in raw/ with no corresponding wiki page
4. **Orphaned questions** — question files not listed in wiki/index.md
5. **Unsourced claims** — claims that do not reference sources.md
6. **Unresolved contradictions** — pages with ⚠️ Contradiction markers that need human review
7. **Stale claims** — claims that newer-ingested sources may have superseded

For each issue: page path, issue type, suggested action.
Also suggest: new questions worth investigating, and new sources worth finding.

Output:
- Append to logs/log.md: ## [YYYY-MM-DD] lint | N issues found
- Append full findings to logs/maintenance-log.md with today's date
- Summarize for the user
EOF

echo ""
echo "✓ Wiki scaffolded at: $WIKI_DIR"
echo ""
echo "Next steps:"
echo "  1. Edit $WIKI_DIR/wiki.toml    — adjust page_types, lint thresholds, ZK settings"
echo "  2. Edit $WIKI_DIR/wiki.config.md — fill in purpose, audience, scope (narrative)"
echo "  3. Drop source material into $WIKI_DIR/raw/"
echo "  4. Ask the agent: 'Compile the sources in raw/ into wiki pages'"
