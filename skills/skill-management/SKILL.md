---
name: skill-management
description: >
  Manage this user's AI agent skills across harnesses. Use when deciding where a
  skill lives (global vs project), installing/updating/removing a global skill,
  adding a newly authored skill to the danieldekay/ai-ops registry, or
  consolidating the ~/.agents/skills global directory. Active harnesses: pi,
  GitHub Copilot, Cursor, OpenAI Codex (NOT Claude Code, NOT OpenCode). Model:
  author once in ai-ops, then scope at install time (global user-scope vs
  per-project apm.yml).
author: Daniel Kaesmayr
metadata:
  version: "1.0.0"
  category: meta
---

# Skill Management

Operating model for authoring, global vs project placement, and installation of
agent skills across the active harnesses. Applies the model captured in the
wiki note `concepts/multi-harness-agent-config-management` (Sept 2026).

## When to Use
- Deciding whether a skill is **global** (user-scope) or **project**-scoped.
- Adding a newly **authored** skill to `danieldekay/ai-ops`.
- Installing / updating / removing a **global** skill.
- Consolidating `~/.agents/skills` (dedup and curate the global library).
- Auditing which skills are installed, where, and from which source.

## Active harnesses (scope of this skill)
- **IN**: pi, GitHub Copilot, Cursor, OpenAI Codex.
- **OUT**: Claude Code, OpenCode — do **not** create `.claude/skills` or
  `.opencode` bridges for them.

## The three buckets (author once, scope at install)
1. **Authored IP** → ONE canonical origin: `danieldekay/ai-ops`
   (`skills/`, `agents/`, `instructions/`, `prompts/`).
2. **Global vs project** → a **deployment** decision at install time, not an
   authorship decision.
3. **Third-party (APM-pulled)** → **dependencies**: installed into
   `apm_modules/`, pinned by `apm.lock.yaml` + content hashes, provenance
   attached. Never commit third-party skills into ai-ops as authored IP.

## Canonical paths
- **GLOBAL origin**: `danieldekay/ai-ops/skills/<name>/SKILL.md`
- **GLOBAL canonical (installed)**: `~/.agents/skills/<name>/SKILL.md` — read
  by pi, Copilot/VS Code, Cursor, Codex (no Claude/OpenCode bridge needed).
- **PROJECT**: `<repo>/.agents/skills/<name>/SKILL.md`, declared in
  `<repo>/apm.yml` (version-pinned).

## Decision rules
- **Always-want everywhere** (voice, general writing, thinking tools) → GLOBAL
  (user-scope APM install).
- **Domain / project-specific** (tango, limesurvey, django, wordpress) →
  PROJECT (declare in that repo's `apm.yml`, pinned).
- **Keep the global set SMALL and curated** — every installed skill adds
  session-start trigger-selection cost (per the Agent Skills progressive
  disclosure model).
- **Never copy a skill into a project** — install it from the registry.

## Manage global skills (APM, user scope)
- **Preview**: `apm install -g -t copilot,codex,cursor --skill <name> danieldekay/ai-ops --dry-run`
- **Install**: `apm install -g -t copilot,codex,cursor --skill <name> danieldekay/ai-ops`
  (writes `~/.agents/skills/<name>/`). Confirm pi sees it there.
- **Inspect**: `apm targets --global`, `apm list --global`, `apm view <pkg>`.
- **Update**: `apm update --global` (CLI itself: `brew upgrade apm`).
- **Audit / drift / security**: `apm audit` (hidden-Unicode scan, drift replay);
  `apm audit --ci` (lockfile-consistency + SARIF for CI gates).
- **Fallback** (if an APM global target is unavailable): `gh skill install
  danieldekay/ai-ops <name> --scope user`.

## Add a new authored skill
1. Write it at `danieldekay/ai-ops/skills/<slug>/SKILL.md` (open Agent Skills
   format: `name` + `description` frontmatter, progressive disclosure).
2. Decide **global** vs **project**.
3. **Global** → `apm install -g ...` (above). **Project** → add to that repo's
   `apm.yml` + `apm install`.

## Consolidating ~/.agents/skills (sprawl → curated)

**Automated script (Option B):** `skill_management/scripts/consolidate-skills.sh` in the ai-ops skill dir — dedupes redundant real copies in `~/.pi/agent/skills`, moves stray non-skill files out, and (opt-in) archives an explicit `--archive-file` list. Always dry-run first, always backs up to `~/.agents/.skill-mgmt-backup-<stamp>/`.

Background (Sept 2026): npx multi-agent installs triplicate skills into
`~/.agents/skills`, `~/.pi/agent/skills`, `~/.claude/skills` (real copies, no
symlinks). Goal: ONE canonical copy in `~/.agents/skills`, redundant copies
removed, a small curated global set.

Consolidation ALWAYS follows this protocol:
1. **Dry-run** — show the map, change nothing.
2. **Backup** — move removals to a backup dir first, never delete outright.
3. **Classify** — each entry is canonical | redundant-in-other-agent-dir |
   stray (non-skill file) | project-scoped (should not be global).
4. **Apply** — symlink away other agent dirs (not copies); stage bulk globals
   into `_archive`; install only the curated global subset from ai-ops.
5. **Report** — what changed, where; record provenance.

Strategy options for the script (pick one):
- **A. APM-managed migration** — move authored skills into ai-ops, pin
  third-party deps in apm.yml, deploy from the registry. Cleanest, most work.
- **B. Single-canonical-dir** — keep `~/.agents/skills` as the one real copy;
  symlink the pi/other agent dirs to it; move non-curated skills into
  `_archive`; install curated globals from ai-ops. Simplest to operate.
- **C. Dedupe-only** — remove redundant real copies across agent dirs, leave
  curation for later. Least effort; still leaves a 100+ global set.

## Pitfalls
- **APM only manages DECLARED targets** — verify with `apm targets` before
  relying on a deploy path.
- **Two lockfiles** (`apm.lock.yaml` + `skills-lock.json`) drift — consolidate
  on APM.
- **Stray files** (`.md` not in a dir, `.DS_Store`) inside `~/.agents/skills`
  are not valid skills — remove them.
- **Never hand-edit `apm.lock.yaml`**; edit `apm.yml` and re-install.
