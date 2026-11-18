---
name: improve-skill-instructions
description: >
  ALWAYS use when any skill instruction conflicts with observed behavior,
  another instruction, or current tooling; references missing files or tools;
  omits a required step; needs an undocumented workaround; or produces an
  incorrect or incomplete result. Applies to owned and third-party skills,
  including discrepancies discovered without a user complaint.
metadata:
  version: "1.0.0"
---

# Improve skill instructions

Load this skill whenever a discrepancy is noticed, even if a workaround lets
the original task succeed. Follow higher-priority instructions throughout.
Skill discovery guides activation; it is not a deterministic execution hook.

## Confirm the discrepancy

Read the affected instruction and compare it with one targeted check: tool
help, a test, the referenced file, or authoritative documentation. Report the
skill name, installed path, instruction, observed result, and task impact.
Keep secrets and confidential evidence out of proposals.

Distinguish a skill defect from agent error or an environment problem.
If the agent skipped a correct instruction, correct execution instead of
rewriting the skill. If evidence is inconclusive, label the discrepancy
unconfirmed and propose investigation, not a speculative fix.

## Discover ownership before choosing a change

Inspect relevant provenance: package manifests, lockfiles, repository
remotes, installation metadata, symlink targets, or the user's confirmation.
Identify the editable source, not just the installed copy.
Being local, writable, or installed by the user does not establish ownership.

- **Owned source:** evidence confirms we author or maintain the source skill.
  Propose the smallest source improvement. Generated or managed installations
  still require changing their source and refreshing through their installer.
- **Not owned:** third-party, vendored, or upstream-owned skill. Propose a
  separate companion overlay in an authored skill location. Never edit the
  dependency or its generated installation in place.
- **Unknown:** ask the user to confirm ownership. Do not edit the base skill;
  offer a separate overlay if ownership cannot be established.

For global companions, use `~/.agents/skills/<name>/SKILL.md`; for
repository-scoped companions, use its authored skill directory and naming
rules. Do not replace an existing skill or follow a symlink into a dependency.

## Ask before improving

For every distinct skill defect, proactively use the available ask-questions
tool; otherwise ask in chat. Include the evidence, ownership verdict and
source, proposed change or overlay, destination, and one verification check.

Ask: "Improve our source skill, or create an overlay for the skill we do not
own?" Present only the applicable action plus investigate, defer, and decline.
Unknown ownership must be resolved or routed to an overlay first.

Wait for explicit approval before editing skills or creating overlays.
Approval to complete the original task is not approval to change skills.
Do not publish issues, PRs, commits, or pushes without approval for that action.
Use `report-skill-drift` for BASF upstream reporting when applicable; loading
it does not authorize publication.

Ask once per distinct discrepancy per session. Respect defer or decline;
reopen only for new evidence or a user request. Do not recursively invoke
this skill to handle its own findings. Continue safe, authorized original
work; pause steps blocked by unresolved safety or instruction conflicts.

## Apply and verify the approved improvement

For owned skills, update only the approved source instruction and existing
version metadata as required by its conventions.

For overlays, name the companion distinctly and describe when it must load
alongside the base skill. Identify the base by name and provenance, state
the scoped correction, and retain unaffected base guidance. An overlay
cannot override higher-priority instructions or weaken safety controls.
If existing routing must change to load the companion, include that change
in the approval; do not assume creating an overlay guarantees activation.

Rerun the discriminating check and test the original failure scenario against
the revised guidance. Validate frontmatter and Markdown. Report changed
source or overlay, verification results, and remaining activation limits.
