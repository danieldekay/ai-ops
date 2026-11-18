---
title: <short title of the solved problem>
date: YYYY-MM-DD
repo: <repository or workspace>
task: <ticket/spec/session reference, if any>
tags: [solution-report, <domain tags>]
status: final
---

# <Title>

## Why

<Problem and trigger: symptoms, exact error strings, business context. 2–5 lines.>

## What

- <Concrete change 1: file/config/command>
- <Concrete change 2>

## How

<Mechanism of the solution — how it works, not what happened chronologically. Enough detail to re-apply on a similar case. Code and commands verbatim.>

## Method (verification)

```bash
<exact command(s) run>
```

<Observed result: failing → passing output, timings, counts.>

## Alternatives Considered

| Alternative | Why rejected |
| ----------- | ------------ |
| <option A>  | <one line>   |

## Decisions

- **<decision>**: <rationale, trade-off accepted>

## Results

- Before: <metric/state>
- After: <metric/state>

## So What

<Why this matters beyond the immediate fix: risk removed, capability unlocked, recurring cost avoided.>

## What Else

- Side effects: <or `None.`>
- Follow-ups / known limitations: <or `None.`>

## Recommendations

1. <Actionable recommendation for next time / for others>

## References

- <commit SHA, file path, doc link, log, ADO/work item>
