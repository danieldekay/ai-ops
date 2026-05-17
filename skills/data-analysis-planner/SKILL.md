---
name: data-analysis-planner
description: 'Planning-only skill for data analysis projects. Use when starting any data analysis project to plan environment setup, software requirements, and the full analysis workflow before writing a single line of analysis code. Triggers: "plan my data analysis", "set up a data analysis project", "I have data and want to analyze it", "help me structure my analysis", "what do I need to install for this analysis", "plan my R analysis", "plan my Python analysis", "data analysis project setup", "analysis workflow plan", "analysis planning", "plan a study". Produces a PLAN.md with 5 phases — plan, setup, validate, bootstrap, analysis handoff — plus idempotent setup scripts. Best practice enforced: no shell one-liners, all actions in scripts, Python uses venv, R uses renv.'
argument-hint: '[description of analysis goal, data format/source, language preference (Python/R)]'
---

# Data Analysis Planner

A **planning-only** skill. Its job is to produce a structured `PLAN.md` and a set of **idempotent setup scripts** before any analysis begins. No analysis code is written here — that is delegated to a specialist skill in Phase 5.

---

## Core Principles

These apply to every artifact this skill produces:

- **Scripts, not one-liners**: Every action that needs to be repeated (setup, validation, bootstrap) lives in a named script file. Never produce raw shell commands to be pasted into a terminal.
- **Idempotent by default**: Every script checks its preconditions before acting. Re-running is always safe — it should say "already done" and exit cleanly.
- **Locked environments**: Python uses `venv` + `pyproject.toml`/`requirements.txt`. R uses `renv` + `renv.lock`. Exact versions are pinned.
- **Plan before code**: The `PLAN.md` is the contract. Pause and confirm with the user before producing any scripts.

---

## The 5-Phase Workflow

### Phase 1 — Plan

**Goal**: Understand the project and produce `analysis-plan/PLAN.md`.

Interview the user (or extract from context) to gather:

| Question | Why it matters |
|----------|---------------|
| What is the research / analysis question? | Determines the analysis type and methods |
| What is the data format, size, and source? | Determines I/O libraries and memory strategy |
| Language preference: Python or R? | Determines the full toolchain |
| Target output: report, figure, model, table? | Determines which packages are needed |
| Is reproducibility critical? | Determines lockfile strictness |

Produce `analysis-plan/PLAN.md` using the template below.

---

### Phase 2 — Setup

**Goal**: Create an idempotent environment setup script.

#### Python setup

Create `analysis-plan/scripts/setup_env.py`:

```python
#!/usr/bin/env python3
"""
Idempotent Python environment setup.
Run with: python analysis-plan/scripts/setup_env.py
Re-running is always safe.
"""
from __future__ import annotations
import subprocess
import sys
from pathlib import Path

VENV_DIR = Path(".venv")
REQUIREMENTS = Path("requirements.txt")


def _pip() -> Path:
    """Return the pip executable inside the venv."""
    return VENV_DIR / ("Scripts" if sys.platform == "win32" else "bin") / "pip"


def setup_venv() -> None:
    if VENV_DIR.exists():
        print(f"[ok] Virtual environment already exists at {VENV_DIR}")
        return
    print(f"[setup] Creating virtual environment at {VENV_DIR} ...")
    subprocess.run([sys.executable, "-m", "venv", str(VENV_DIR)], check=True)
    print("[ok] Virtual environment created.")


def install_packages() -> None:
    if not REQUIREMENTS.exists():
        print(f"[skip] No {REQUIREMENTS} found — create it first.")
        return
    print("[setup] Installing packages from requirements.txt ...")
    subprocess.run([str(_pip()), "install", "--upgrade", "pip"], check=True)
    subprocess.run([str(_pip()), "install", "-r", str(REQUIREMENTS)], check=True)
    print("[ok] Packages installed.")


if __name__ == "__main__":
    setup_venv()
    install_packages()
    print("\n[done] Activate with: source .venv/bin/activate")
```

Include a `requirements.txt` stub populated with the packages identified in Phase 1.

**Best-practice notes for Python:**
- Use `.venv/` (not `env/` or `venv/`) — consistent, gitignore-able.
- Pin versions in `requirements.txt` after the first successful install via `pip freeze > requirements.txt`.
- For more reproducible setups, recommend `uv` as a drop-in for `pip`/`venv`. Use `uv venv .venv` and `uv pip install -r requirements.txt`.

#### R setup

Create `analysis-plan/scripts/setup_env.R`:

```r
# Idempotent R environment setup via renv.
# Run with: Rscript analysis-plan/scripts/setup_env.R
# Re-running is always safe.

# --- 1. Ensure renv is available ---
if (!requireNamespace("renv", quietly = TRUE)) {
  message("[setup] Installing renv ...")
  install.packages("renv", repos = "https://cloud.r-project.org")
}

# --- 2. Initialise or restore ---
if (file.exists("renv.lock")) {
  message("[ok] renv.lock found. Restoring packages ...")
  renv::restore()
} else {
  message("[setup] No renv.lock found. Initialising renv ...")
  renv::init(bare = TRUE)   # bare = TRUE: don't auto-discover; we install explicitly
  message("[setup] Installing project packages ...")
  # Add project-specific packages here:
  # renv::install(c("tidyverse", "fixest", "modelsummary"))
  renv::snapshot()
  message("[ok] renv initialised and lock file written.")
}

message("\n[done] Activate in R with: renv::activate()")
```

**Best-practice notes for R:**
- `renv::init(bare = TRUE)` is safer than the default — prevents renv from guessing dependencies from scripts before they're ready.
- After adding packages manually, run `renv::snapshot()` to update `renv.lock`.
- Commit `renv.lock` but not the `renv/library/` folder (it's in `.gitignore` by default).

---

### Phase 3 — Validate

**Goal**: Confirm the environment is usable before touching the data.

#### Python validation script

Create `analysis-plan/scripts/validate_env.py`:

```python
#!/usr/bin/env python3
"""
Validate that the Python environment is correctly set up.
Run with: python analysis-plan/scripts/validate_env.py
"""
import importlib
import sys

# List packages required for this project (fill from Phase 1 plan)
REQUIRED_PACKAGES: list[str] = [
    # e.g. "pandas", "numpy", "statsmodels", "matplotlib"
]


def check_python_version(min_major: int = 3, min_minor: int = 10) -> None:
    major, minor = sys.version_info[:2]
    if (major, minor) < (min_major, min_minor):
        raise RuntimeError(
            f"Python {min_major}.{min_minor}+ required; found {major}.{minor}"
        )
    print(f"[ok] Python {major}.{minor}")


def check_packages(packages: list[str]) -> None:
    failed: list[str] = []
    for pkg in packages:
        try:
            importlib.import_module(pkg)
            print(f"[ok] {pkg}")
        except ImportError:
            print(f"[FAIL] {pkg} — not importable")
            failed.append(pkg)
    if failed:
        raise RuntimeError(f"Missing packages: {failed}")


if __name__ == "__main__":
    check_python_version()
    check_packages(REQUIRED_PACKAGES)
    print("\n[ok] Environment validated.")
```

#### R validation script

Create `analysis-plan/scripts/validate_env.R`:

```r
# Validate that the R environment is correctly set up.
# Run with: Rscript analysis-plan/scripts/validate_env.R

# Fill in from Phase 1 plan:
required_packages <- c(
  # e.g. "tidyverse", "fixest", "modelsummary"
)

failed <- c()
for (pkg in required_packages) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    message(sprintf("[ok] %s  %s", pkg, as.character(packageVersion(pkg))))
  } else {
    message(sprintf("[FAIL] %s — not installed", pkg))
    failed <- c(failed, pkg)
  }
}

if (length(failed) > 0) {
  stop(sprintf("Missing packages: %s", paste(failed, collapse = ", ")))
}

message("\n[ok] Environment validated.")
```

---

### Phase 4 — Bootstrap

**Goal**: Quick, non-destructive data inspection to confirm that data loads and the environment works end-to-end. Produces a short printed summary (shape, dtypes, missing values, basic stats). **Does not modify the data.**

#### Python bootstrap script

Create `analysis-plan/scripts/bootstrap.py`:

```python
#!/usr/bin/env python3
"""
Bootstrap data check — quick, non-destructive inspection.
Run with: python analysis-plan/scripts/bootstrap.py <path/to/data>
"""
import sys
from pathlib import Path


def load_data(path: Path):
    import pandas as pd

    suffix = path.suffix.lower()
    loaders = {
        ".csv": pd.read_csv,
        ".tsv": lambda p: pd.read_csv(p, sep="\t"),
        ".parquet": pd.read_parquet,
        ".xlsx": pd.read_excel,
        ".xls": pd.read_excel,
        ".dta": pd.read_stata,
        ".feather": pd.read_feather,
    }
    if suffix not in loaders:
        raise ValueError(f"Unsupported file type: {suffix}")
    return loaders[suffix](path)


def inspect(df) -> None:
    import pandas as pd

    print(f"\n--- Shape ---\n{df.shape[0]:,} rows × {df.shape[1]} columns")
    print(f"\n--- Column types ---\n{df.dtypes.to_string()}")
    print(f"\n--- Missing values ---\n{df.isnull().sum()[df.isnull().sum() > 0].to_string() or 'None'}")
    print(f"\n--- Numeric summary ---")
    print(df.describe().to_string())
    print(f"\n--- First 3 rows ---\n{df.head(3).to_string()}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python bootstrap.py <path/to/data>")
        sys.exit(1)
    path = Path(sys.argv[1])
    df = load_data(path)
    inspect(df)
    print("\n[ok] Bootstrap complete — data and environment are ready.")
```

#### R bootstrap script

Create `analysis-plan/scripts/bootstrap.R`:

```r
# Bootstrap data check — quick, non-destructive inspection.
# Usage: Rscript analysis-plan/scripts/bootstrap.R path/to/data.csv
# (Adjust the loader below for your file type.)

args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) stop("Usage: Rscript bootstrap.R <path/to/data>")

data_path <- args[1]
ext <- tolower(tools::file_ext(data_path))

# Idempotent package check
load_pkg <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop(sprintf("Package '%s' required but not installed. Run setup_env.R first.", pkg))
  }
  invisible(library(pkg, character.only = TRUE))
}

# Load based on extension
df <- switch(ext,
  "csv"     = { load_pkg("readr");  readr::read_csv(data_path, show_col_types = FALSE) },
  "tsv"     = { load_pkg("readr");  readr::read_tsv(data_path, show_col_types = FALSE) },
  "dta"     = { load_pkg("haven");  haven::read_dta(data_path) },
  "xlsx"    = { load_pkg("readxl"); readxl::read_excel(data_path) },
  "parquet" = { load_pkg("arrow");  arrow::read_parquet(data_path) },
  stop(sprintf("Unsupported file type: .%s", ext))
)

cat("\n--- Shape ---\n")
cat(sprintf("%s rows × %s columns\n", format(nrow(df), big.mark=","), ncol(df)))

cat("\n--- Column types ---\n")
print(dplyr::glimpse(df))

cat("\n--- Missing values ---\n")
missing <- colSums(is.na(df))
print(missing[missing > 0])

cat("\n--- Numeric summary ---\n")
print(summary(df))

cat("\n[ok] Bootstrap complete — data and environment are ready.\n")
```

---

### Phase 5 — Analysis Skill Handoff

**Goal**: Identify and recommend the right specialist skill for the actual analysis, rather than writing analysis code here.

Use the table below to recommend a skill from [brycewang-stanford/Awesome-Agent-Skills-for-Empirical-Research](https://github.com/brycewang-stanford/Awesome-Agent-Skills-for-Empirical-Research):

| Analysis type | Language | Recommended skill | Notes |
|---------------|----------|-------------------|-------|
| Econometrics / causal inference | Python | `00.1-Full-empirical-analysis-skill_Python` | OLS, IV, DID, RD, PSM, DML |
| Econometrics / causal inference | R | `00.3-Full-empirical-analysis-skill_R` | fixest + tidyverse 8-step pipeline |
| Econometrics / causal inference | Stata | `00.2-Full-empirical-analysis-skill_Stata` | reghdfe / ivreg2 / csdid |
| Agent-native one-import DSL | Python | `00-Full-empirical-analysis-skill_StatsPAI` | `import statspai as sp` |
| End-to-end R workflow (research starter) | R | from `skills/14-luischanci-claude-code-research-starter` | Good starting point |
| End-to-end R workflow (social science) | R | from `skills/15-Felpix-Studios-social-science-research` | R + Python tracks |
| Bayesian analysis | R | `23-Learning-Bayesian-Statistics-baygent-skills` | brms / rstan / cmdstanr |

If the user's analysis type is not covered by an existing skill from that repo, ask whether to:
1. Adapt the closest skill listed above, or
2. Build a new skill using the `skill-creator` skill.

---

## PLAN.md Template

When producing Phase 1 output, always use this exact template saved at `analysis-plan/PLAN.md`:

```markdown
# Analysis Plan: [Project Name]

**Date**: [YYYY-MM-DD]
**Language**: [Python / R / Stata]
**Status**: Planning

---

## 1. Research Question

_What question is this analysis trying to answer?_

## 2. Data

| Property | Value |
|----------|-------|
| Source | |
| Format | |
| Size (estimated) | |
| Key variables | |
| Unit of observation | |
| Time period | |

## 3. Analysis Type

_e.g., EDA, OLS regression, DID, RDD, classification, clustering_

## 4. Expected Outputs

_e.g., summary table, regression table, figure, model object_

---

## Phase 2 — Environment Setup

- **Script**: `analysis-plan/scripts/setup_env.[py|R]`
- **Package manager**: [pip/uv | renv]
- **Environment location**: [.venv/ | renv/]
- **Key packages**:
  - [package 1 — purpose]
  - [package 2 — purpose]
- **How to run**: `python analysis-plan/scripts/setup_env.py` _or_ `Rscript analysis-plan/scripts/setup_env.R`

## Phase 3 — Validation

- **Script**: `analysis-plan/scripts/validate_env.[py|R]`
- **Checks**:
  - [ ] Runtime version (Python X.Y+ / R X.Y+)
  - [ ] All required packages importable
- **How to run**: `python analysis-plan/scripts/validate_env.py` _or_ `Rscript analysis-plan/scripts/validate_env.R`

## Phase 4 — Bootstrap

- **Script**: `analysis-plan/scripts/bootstrap.[py|R]`
- **Data path**: [path/to/data]
- **Expected shape**: [rows × columns]
- **How to run**: `python analysis-plan/scripts/bootstrap.py path/to/data` _or_ `Rscript analysis-plan/scripts/bootstrap.R path/to/data`

## Phase 5 — Analysis Skill

- **Recommended skill**: [skill name and repo link]
- **Rationale**: [why this skill fits the analysis type]
- **Next step**: Load this skill and invoke it with the cleaned, validated data.

---

## Checklist

- [ ] Phase 2: `setup_env` script created
- [ ] Phase 2: Packages listed in requirements.txt / renv
- [ ] Phase 3: `validate_env` script created and passing
- [ ] Phase 4: `bootstrap` script created and passing
- [ ] Phase 5: Analysis skill identified and confirmed with user
```

---

## What This Skill Does NOT Do

- **Does not run analysis**: No regressions, no ML models, no statistics. That is Phase 5.
- **Does not install packages**: The setup script is produced here; the user runs it.
- **Does not modify data**: The bootstrap script is read-only.
- **Does not write analysis scripts**: Those are produced by the specialist skill in Phase 5.

The output of this skill is always: `PLAN.md` + three idempotent scripts + a recommendation for the Phase 5 skill.
