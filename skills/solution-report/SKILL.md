---
name: solution-report
description: Write a structured best-practice report after a task or problem has been solved, capturing it as long-term memory. Use when the user asks to "report on what we solved", "write a best practice report", "document this solution", "capture this as a lesson", "file this for long-term memory", or at the end of a non-trivial debugging, refactoring, or implementation session where the solution is worth preserving. The report covers why, what, how, method, alternatives, decisions, results, recommendations, and so-what, so future sessions (human or agent) can reuse the insight without re-deriving it.
---

# Solution Report

Produce a concise, evidence-based report of a solved task/problem. The report is written ONCE, filed for the long term, and must let a future reader act on it without re-reading the session.

## When to Write

- A non-trivial problem was solved (bug root-caused, design decision made, pipeline fixed, pattern discovered).
- The user explicitly asks for a report or long-term memory capture.
- NOT for: trivial one-liners, pure Q&A, work in progress.

## Process

1. **Gather evidence first.** Never write from memory of the conversation alone. Collect:
   - Actual diffs / commits (`git diff`, `git log -5`)
   - Failing → passing test output or verification command results
   - Exact error strings that were fixed
2. **Fill the template** in `assets/solution-report-template.md`. Every section is required unless genuinely empty (write `None.` — never delete a section).
3. **Keep it dense.** Target 1–2 pages. Facts over narrative. Code, commands, and error strings verbatim.
4. **File it** (see below), then report the file path to the user.

## Section Guide

| Section | Question it answers | Content rules |
| ------- | ------------------- | ------------- |
| Why | What problem/pain triggered this? | Symptoms, exact errors, business context. 2–5 lines. |
| What | What was changed/done, at a glance? | Bullet list of concrete changes (files, configs, commands). |
| How | How does the solution work? | Mechanism, not narration. Enough to re-apply on a similar case. |
| Method | How was it verified? | Exact commands run + observed result. "Tests pass" without output is not evidence. |
| Alternatives considered | What else could have worked? | Each rejected option + one-line reason for rejection. |
| Decisions | What was decided and why? | Key decision points, incl. trade-offs accepted. |
| Results | What is the measurable outcome? | Before/after numbers when available (timings, counts, coverage). |
| So what | Why does this matter beyond the immediate fix? | Impact, risk removed, who/what benefits. Skip grandstanding. |
| What else | What came along / what is still open? | Side effects, follow-ups, known limitations, ceiling of the fix. |
| Recommendations | What should be done next time / by others? | Actionable. Reference the pattern, not the person. |
| References | Where is the evidence? | Links/paths: commits, files, docs, logs, ADO items. |

## Filing (Long-Term Memory)

Choose exactly one home, by scope:

| Scope | Destination |
| ----- | ----------- |
| Reusable across workspaces | User memory note (`/memories/<topic>.md`) or user-global knowledge |
| Repo-specific | Repo docs folder that repo already uses for reports/analyses, or repo memory |
| Knowledge-base worthy | Zettelkasten permanent note (`zk_create_note`, type `permanent`, tagged) |
| Session-scoped only | Session memory — but prefer one of the above; the point of this skill is persistence |

Report file naming: `YYYY-MM-DD-<slug>-solution-report.md`.

## Quality Bar

- A reader who was not in the session can re-apply the solution from this report alone.
- Every claim is backed by a reference, a command, or a diff.
- No filler ("we worked hard", "it was challenging"). Cut adjectives.
