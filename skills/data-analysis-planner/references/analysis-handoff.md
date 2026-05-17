# Analysis Handoff

Read this during Phase 5 to route the user from planning into the right implementation skill or workflow.

## Recommended specialist routing

| Analysis type | Language | Recommended skill/workflow | Notes |
| --- | --- | --- | --- |
| Econometrics or causal inference | Python | `00.1-Full-empirical-analysis-skill_Python` | OLS, IV, DID, RD, PSM, DML. |
| Econometrics or causal inference | R | `00.3-Full-empirical-analysis-skill_R` | `fixest` and tidyverse-style pipeline. |
| Econometrics or causal inference | Stata | `00.2-Full-empirical-analysis-skill_Stata` | `reghdfe`, `ivreg2`, `csdid`. |
| Agent-native empirical DSL | Python | `00-Full-empirical-analysis-skill_StatsPAI` | Uses `import statspai as sp`. |
| End-to-end R research starter | R | `14-luischanci-claude-code-research-starter` | Good for broad research workflows. |
| Social science research | R/Python | `15-Felpix-Studios-social-science-research` | Mixed R and Python tracks. |
| Bayesian analysis | R | `23-Learning-Bayesian-Statistics-baygent-skills` | `brms`, `rstan`, `cmdstanr`. |
| General statistical modeling | Python | `statsmodels` or local Python analysis skill | Regression, GLM, time series, diagnostics. |
| Scientific exploratory analysis | Python/R | `exploratory-data-analysis` | File characterization, quality checks, summary reports. |

If no specialist fits, ask whether to adapt the closest one or create a new skill with `skill-creator`.

## Handoff prompt shape

Give the specialist skill a compact prompt:

```text
Use the project plan at analysis-plan/PLAN.md.
Work only on atomic unit [unit name/path].
Inputs: [data/cache paths].
Outputs: [expected artifact paths].
Follow the cache/provenance convention in the plan.
Keep calculation and interpretation adjacent.
```

This avoids reloading the whole project and keeps each specialist invocation bounded.
