---
name: skill-publish-flow
description: >
  The agent flow for publishing, patching, and installing skills through the
  ai-ops canonical registry + APM. Use when a skill is changed, a skill needs
  to reach the installed layer, or installed and canonical copies have
  drifted. Triggers: "publish a skill", "install skill via apm", "skill drift",
  "canonical skill", "overlay skill", "patch a third-party skill",
  "installed skill is missing my change", "apm install".
author: Daniel Kaesmayr
metadata:
  version: "1.0.0"
  category: meta
---

# Skill Publish Flow

## The three layers

| Layer | Location | Versioned? |
|---|---|---|
| Canonical (source of truth) | `~/coding/ai-ops/skills/<name>/SKILL.md` | yes — git |
| APM registry/manifest | `~/.apm/apm.yml` (global, `targets: agent-skills`) sets the global allowlist; the ai-ops repo `apm.yml` + `apm.lock.yaml` govern project deploys | yes — git (lockfile pins resolved SHAs) |
| Installed | `~/.agents/skills/<name>/SKILL.md` | **no** — plain directory, not under git |

Publishing is **two-layer**, not one: the skill must (a) exist in the canonical
repo AND (b) be DECLARED in the global manifest `~/.apm/apm.yml`
(`dependencies: apm:` list, one line `- danieldekay/ai-ops/skills/<name>/`,
targets `agent-skills`). Undeclared skills never deploy — `apm install -g
--force` still reports success (measured 2026-10-24: two new skills silently
failed to appear for exactly this reason).

## The binding rule

**Never edit the installed layer.** Author or patch in canonical, commit, push,
then install. `~/.agents/skills` is a generated deployment target; anything
written there directly is lost on the next reinstall and invisible to anyone
else. If a fix only exists in an installed copy, the correct move is *port it
to canonical first*, then reinstall — never leave the change in the installed
copy alone.

## Publish procedure (canonical → APM → installed)

**One-command path (preferred):** after editing a skill in ai-ops, run

```bash
bash ~/coding/ai-ops/scripts/publish-skill.sh SKILL [SKILL...]
```

It stages exactly `skills/<name>`, commits, pushes, checks the global
manifest declaration, then runs `apm update --global --yes` + `apm install
-g --force` in the **background** (2–3 min) with content-based verification
afterwards. Check the result with `publish-skill.sh --status` (or
`--verify <name>` at any time). Flags: `--sync` (foreground), `--dry-run`,
`--no-push`, `--declare` (auto-add missing manifest line), `-m "msg"`.
The script encodes every rule below — use it instead of re-deriving steps.

## Manual procedure (when the script is unavailable)

1. Edit the canonical file: `~/coding/ai-ops/skills/<name>/SKILL.md`.
2. Stage exactly the paths you changed (never `git add -A` — ai-ops always
   holds unrelated work):
   ```bash
   git -C ~/coding/ai-ops add skills/<name>
   git -C ~/coding/ai-ops commit -m "skills: <what changed>"
   git -C ~/coding/ai-ops push
   ```
3. **Declare the skill in the global manifest** if it is not already declared:
   add `- danieldekay/ai-ops/skills/<name>/` to the `dependencies: apm:` list
   of `~/.apm/apm.yml` (the global `agent-skills` allowlist). A brand-new
   skill always needs this step; a skill already declared only needs the
   commit + push. Validate after editing:
   ```bash
   apm deps list        # or `apm doctor` — must parse the modified manifest
   ```
4. Refresh the APM index from the origin (this fetches the new commit; it can
take several minutes — use a timeout of at least 120 s, prefer 300–600 s):
   ```bash
   apm update --global --yes
   ```
5. Reinstall the global target. `install --force` alone does nothing against
the old lockfile SHAs, so update always precedes install:
   ```bash
   apm install -g --force
   ```
6. Verify installed == canonical for every skill you touched (see below). Do
   not trust the install's "Installed N dependencies" line — check the
   specific directory exists and matches canonical.

## Drift triage

When `diff -q ~/coding/ai-ops/skills/<name> ~/.agents/skills/<name>` reports a
difference, classify it:

| Symptom | Root cause | Action |
|---|---|---|
| Canonical newer than installed | change committed+pushed but never installed | commit + push (if not already) → `apm update --global --yes` → `apm install -g --force` |
| Installed newer than canonical | someone edited the installed layer directly (or a session patched in place) | **merge the installed change into the canonical file FIRST**, then commit + push + reinstall — otherwise the next install silently downgrades the installed copy and the work is lost |
| Installed differs, no canonical equivalent | third-party/vendored skill patched in place | not canonical — do not commit the third-party content; move the conventions into an overlay (below) and reinstall to restore the vendor copy |
| Installed copy broken / missing section | failed or partial install, stale lockfile | `apm update --global --yes` then `apm install -g --force` to re-sync |

## Overlay policy for third-party skills

Third-party skills (pulled by APM as dependencies, e.g. `obra/superpowers`)
never get in-place edits:

- **Why in-place edits are lost:** reinstall/update rewrites the installed
  directory from the vendor commit; any hand-patch evaporates and, worse,
  diverges the installed copy from its pinned source with no record.
- **How overlays work:** author an *owned* skill in ai-ops (frontmatter
  `metadata.overlay_of: "<vendor-skill>"`), state in its body which third-party
  skill it overlays and why (we may not edit installed third-party copies), and
  carry only the hardened conventions that are ours. The overlay triggers
  alongside the base skill.
- **Who owns them:** you do. Overlays live in ai-ops, are versioned, and apply
  the same publish procedure as any authored skill.

## Verification

Compare every published skill against the installed layer:

```bash
for d in ~/coding/ai-ops/skills/*/; do
  n=$(basename "$d")
  [ -d ~/.agents/skills/"$n" ] || { echo "MISSING INSTALLED: $n"; continue; }
  diff -q "$d"SKILL.md ~/.agents/skills/"$n"/SKILL.md >/dev/null \
    && echo "OK: $n" || echo "DIFF: $n"
done
```

Residual frontmatter provenance diffs of the form `metadata: github-*` are
benign — APM stamps the installed frontmatter with the source package/repo,
so the installed copy can differ from canonical in the `metadata` block alone.

## Pitfalls

- **Just edited a skill? Run `publish-skill.sh <name>` — do not walk the
  steps by hand.** The manual procedure below is the fallback, not the
  default. Hand-walking is where drift incidents come from (measured:
  2026-10-21 six-skill patch incident; 2026-10-24 silent undeclared deploy).

- **`apm --skill <NAME>` filtering is broken with mixed manifests.** With a
  manifest that mixes skills and other asset types, the `--skill` filter can
  silently select the wrong entry or nothing. Prefer the manifest-wide update +
  force install and verify the specific directory afterwards.
- **The lockfile pins SHAs, so `apm install -g --force` alone does nothing.**
  `apm.lock.yaml` records the resolved commit of every dependency; install
  re-deploys what the lockfile pins. You must run `apm update` first to move
  the resolution to the new commit, then install.
- **Undeclared in `~/.apm/apm.yml` → `apm install -g --force` reports
  success, nothing appears.** The global deploy is an explicit allowlist, not
  an auto-discover scan of ai-ops. If a canonical skill silently fails to
  appear in `~/.agents/skills`, first check the manifest, and use
  `ls ~/.agents/skills | wc -l` + a direct `diff -q` on the skill name as the
  real signal, not the install banner.
- **`~/.agents` is not versioned.** Direct edits there are unreviewable,
  unmergeable, and silently destroyed by the next install. It also means
  "uncommitted work" never appears in `git status` — only `diff` against
  canonical reveals it.
- **`apm update --global --yes` can time out mid-flight — run it alone, with a ≥300 s timeout.** Observed 2026-10-25: an update combined with install in one step timed out; an install run afterwards deployed the stale lockfile. A timed-out update may leave the lockfile behind the pushed state, so always re-run `apm update --global --yes` (alone) before the install — never `install --force` as recovery.
- **`apm install -g --force` takes no path argument.** Passing a partial repo-relative path (`coding/ai-ops/skills/<name>`) fails validation with "not accessible or doesn't exist — run with --verbose for auth details" regardless of `--force` (measured 2026-10-25). Run the manifest-wide `apm install -g --force` from any cwd, then verify the specific directory with `diff -q`.
- **Drift incident 2026-10-21 (cautionary case):** six skills were patched
  directly in the installed layer; three ai-ops-owned skills carried the
  patches in canonical and three did not (one new own skill, two third-party
  skills). The fix was to canonicalise all six (port to canonical / overlay /
  new skill), commit + push, then reinstall — which reverted the two
  third-party copies to vendor content, as intended.