---
name: self-learning
description: "Autonomous skill generator that learns new technologies from the web and from Daniel's wiki. Use when the user wants to learn about a new library/framework/tool, needs to create a skill for an unfamiliar technology, wants to research and document a technology's usage patterns, or invokes `/learn <topic>`. Harness-agnostic: works on pi, GitHub Copilot, Cursor, and Codex using whatever web-search, fetch, and browser tools the active harness provides."
author: Daniel Kaesmayr
metadata:
  version: "2.0.0"
  category: meta
---

# Self-Learning Skill Generator

Research and learn a new technology from the web, generate a reusable skill,
and file the learning so future sessions start knowing it.

## Usage

```
/learn <topic>
```

If `<topic>` is missing, show usage. If the topic is ambiguous, ask to clarify:

- "react" → "React for web, React Native, or a specific library like react-query?"
- "apollo" → "Apollo GraphQL client, Apollo Server, or Apollo Federation?"
- "aws" → "Which AWS service? (S3, Lambda, DynamoDB, etc.)"

Normalize to **kebab-case** for the skill folder name.

---

### 1. Recall Before Research (wiki first)

Before any web search, check what is already known:

- Query the LLM wiki (`wiki_recall "<topic>"` on pi; on other harnesses read the
  vault pages directly under the wiki root) for existing pages, observations,
  and insights about the topic.
- Search the active harness's memory/failure store for prior corrections or
  tool quirks about the topic.

If the wiki already covers the topic, build the skill from those pages and
cite them — don't re-research from scratch. The wiki is the long-term store;
the skill you generate should reference wiki pages for depth instead of
duplicating their content.

### 2. Discover Sources (web search)

Use the active harness's web-search tool to find authoritative documentation:

**Search queries to try:**
1. `<topic> official documentation`
2. `<topic> getting started guide`
3. `<topic> API reference`
4. `<topic> GitHub repository`

**Source prioritization:**
1. Official docs sites (e.g., docs.*, *.dev)
2. Official GitHub repositories (README, /docs)
3. Official blogs/announcements

Select **3–5 high-quality URLs** maximum. If no credible sources are found,
ask Daniel for a URL.

### 3. Extract Content (URL reading)

For each selected URL, read the content with the harness's fetch/read tool:

**Extract only relevant sections:**
- Installation / setup
- Core concepts
- API reference / key functions
- Common patterns / examples
- Version information

**Skip irrelevant content:**
- Navigation, ads, login prompts
- Unrelated sidebar content
- Comments, forums

If static reading fails (JavaScript-heavy sites), fall back to the harness's
browser-automation capability (pi: agent-browser skill; Codex/Cursor/Copilot:
their browser tools) with this brief:

```
Navigate to <URL> and extract the main content including:
- Installation instructions
- Core concepts and API reference
- Code examples
Return the extracted content as markdown.
```

Record the scrape timestamp for each source (YYYY-MM-DD).

### 4. Generate Skill

Skills are modular, self-contained packages. Every skill consists of a required
`SKILL.md` file and optional bundled resources:

```
skill-name/
├── SKILL.md (required)
│   ├── YAML frontmatter metadata (required)
│   │   ├── name: (required)
│   │   └── description: (required)   # trigger-focused, ≤1024 chars
│   └── Markdown instructions (required)
└── Bundled Resources (optional)
    ├── scripts/          - Executable code (Python/Bash/etc.)
    ├── references/       - Documentation loaded into context as needed
    └── assets/           - Files used in output (templates, icons, fonts, etc.)
```

1. Read `references/skill_creation_guide.md` if present, or follow the
   Agent Skills format: valid YAML frontmatter (`name` + `description` only in
   the index), progressive-disclosure body.
2. Synthesize the extracted information into a new skill:
   - **Trigger:** description clearly defines WHEN to use it (Daniel indexes
     skills by description alone — put the trigger signals there, not "what").
   - **Workflow:** step-by-step instructions.
   - **Wiki links:** reference related wiki pages with `[[wikilinks]]` for
     depth; keep the skill body operational, not encyclopedic.
   - **Harness-agnostic:** never hardcode one harness's tool names; say "the
     active harness's web-search/fetch/browser tools" and note per-harness
     mappings only where they genuinely differ.
3. Validate: description ≤ 1024 chars, valid YAML frontmatter, no duplicate
   map keys, no markdown/blockquotes inside the frontmatter block (pi rejects
   invalid skills at startup).

### 5. Save the Skill (author once, deploy via APM)

Follow the `skill-management` model:

1. **Write the canonical copy** to `danieldekay/ai-ops/skills/<skill-folder>/SKILL.md`
   (local checkout at `~/coding/ai-ops`), commit and push.
2. **Deploy:**
   - Global → add `- danieldekay/ai-ops/skills/<skill-folder>/` under the right
     section of `~/.apm/apm.yml` (if not already declared), then `apm install -g`.
   - Project-specific → declare in that repo's `apm.yml`, then `apm install`
     in the repo.
3. If APM is unavailable, fall back to copying into `~/.agents/skills/<skill-folder>/`
   (global) or `<repo>/.agents/skills/<skill-folder>/` (project) and note the
   drift for the next canonicalization pass.

Warn before overwriting an existing skill.

### 6. File the Learning (wiki)

Record the acquisition so future sessions surface it:

- `wiki_retro` with the topic as slug: what was learned, which sources proved
  authoritative, what the skill covers — atomic insight, not a session log.
- `wiki_observe` (relevance: medium) only if something surprising came up
  during research (wrong docs, version traps).

### 7. Confirm to User

Report:
```
✓ Created skill: <topic>
  Sources scraped: <N> (scraped <date>)
  Canonical: danieldekay/ai-ops/skills/<topic>/SKILL.md (pushed)
  Deployed: ~/.agents/skills/<topic>/ via apm (global)
  Wiki: insight filed via wiki_retro
  This skill will auto-trigger when working with <topic>.
```

---

## Critical Rules

1. **Never hallucinate documentation:** only include information from scraped sources.
2. **Never invent APIs:** if documentation is unclear, ask Daniel what to do.
3. **Ask for URLs:** if automated discovery fails, ask for specific URLs.
4. **Verify sources:** prefer official sources over third-party tutorials.
5. **Wiki before web:** always check the wiki and memory first; cite existing knowledge.
6. **Never print scraped secrets:** documentation pages sometimes contain example
   tokens — length-check, never quote into the skill.
