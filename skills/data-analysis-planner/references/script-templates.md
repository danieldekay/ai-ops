# Script Templates

Read this file only when creating `analysis-plan/scripts/*` files. Customize package lists, paths, and version checks from `PLAN.md`.

## Python setup: `analysis-plan/scripts/setup_env.py`

```python
#!/usr/bin/env python3
"""Idempotent Python environment setup."""
from __future__ import annotations

import subprocess
import sys
from pathlib import Path

VENV_DIR = Path(".venv")
REQUIREMENTS = Path("requirements.txt")


def pip_executable() -> Path:
    return VENV_DIR / ("Scripts" if sys.platform == "win32" else "bin") / "pip"


def setup_venv() -> None:
    if VENV_DIR.exists():
        print(f"[ok] Virtual environment already exists at {VENV_DIR}")
        return
    subprocess.run([sys.executable, "-m", "venv", str(VENV_DIR)], check=True)
    print(f"[ok] Created virtual environment at {VENV_DIR}")


def install_packages() -> None:
    if not REQUIREMENTS.exists():
        print(f"[skip] No {REQUIREMENTS}; create it from the plan first")
        return
    subprocess.run([str(pip_executable()), "install", "--upgrade", "pip"], check=True)
    subprocess.run([str(pip_executable()), "install", "-r", str(REQUIREMENTS)], check=True)
    print("[ok] Packages installed")


if __name__ == "__main__":
    setup_venv()
    install_packages()
    print("[done] Activate with: source .venv/bin/activate")
```

## Python validation: `analysis-plan/scripts/validate_env.py`

```python
#!/usr/bin/env python3
"""Validate runtime and required packages."""
import importlib
import sys

REQUIRED_PACKAGES: list[str] = [
    # Fill from PLAN.md, e.g. "pandas", "numpy", "statsmodels".
]


def check_python_version(min_major: int = 3, min_minor: int = 10) -> None:
    major, minor = sys.version_info[:2]
    if (major, minor) < (min_major, min_minor):
        raise RuntimeError(f"Python {min_major}.{min_minor}+ required; found {major}.{minor}")
    print(f"[ok] Python {major}.{minor}")


def check_packages(packages: list[str]) -> None:
    missing: list[str] = []
    for package in packages:
        try:
            importlib.import_module(package)
            print(f"[ok] {package}")
        except ImportError:
            print(f"[FAIL] {package} not importable")
            missing.append(package)
    if missing:
        raise RuntimeError(f"Missing packages: {missing}")


if __name__ == "__main__":
    check_python_version()
    check_packages(REQUIRED_PACKAGES)
    print("[ok] Environment validated")
```

## Python bootstrap: `analysis-plan/scripts/bootstrap.py`

```python
#!/usr/bin/env python3
"""Read-only data bootstrap inspection."""
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
    print(f"\n--- Shape ---\n{df.shape[0]:,} rows x {df.shape[1]} columns")
    print(f"\n--- Column types ---\n{df.dtypes.to_string()}")
    missing = df.isna().sum()
    missing = missing[missing > 0]
    print(f"\n--- Missing values ---\n{missing.to_string() if not missing.empty else 'None'}")
    print("\n--- Numeric summary ---")
    print(df.describe().to_string())
    print(f"\n--- First 3 rows ---\n{df.head(3).to_string()}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python analysis-plan/scripts/bootstrap.py <path/to/data>")
        sys.exit(1)
    inspect(load_data(Path(sys.argv[1])))
    print("[ok] Bootstrap complete")
```

## R setup: `analysis-plan/scripts/setup_env.R`

```r
# Idempotent R environment setup via renv.
# Run with: Rscript analysis-plan/scripts/setup_env.R

if (!requireNamespace("renv", quietly = TRUE)) {
  message("[setup] Installing renv ...")
  install.packages("renv", repos = "https://cloud.r-project.org")
}

if (file.exists("renv.lock")) {
  message("[ok] renv.lock found; restoring packages ...")
  renv::restore()
} else {
  message("[setup] Initialising renv ...")
  renv::init(bare = TRUE)
  # Add project packages from PLAN.md, for example:
  # renv::install(c("tidyverse", "rmarkdown", "digest", "jsonlite"))
  renv::snapshot()
  message("[ok] renv initialised and renv.lock written")
}
```

## R validation: `analysis-plan/scripts/validate_env.R`

```r
# Validate R runtime and required packages.
# Run with: Rscript analysis-plan/scripts/validate_env.R

required_packages <- c(
  # Fill from PLAN.md, e.g. "tidyverse", "digest", "jsonlite".
)

missing <- c()
for (pkg in required_packages) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    message(sprintf("[ok] %s %s", pkg, as.character(packageVersion(pkg))))
  } else {
    message(sprintf("[FAIL] %s not installed", pkg))
    missing <- c(missing, pkg)
  }
}

if (length(missing) > 0) {
  stop(sprintf("Missing packages: %s", paste(missing, collapse = ", ")))
}

message("[ok] Environment validated")
```

## R bootstrap: `analysis-plan/scripts/bootstrap.R`

```r
# Read-only data bootstrap inspection.
# Run with: Rscript analysis-plan/scripts/bootstrap.R path/to/data.csv

args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) stop("Usage: Rscript bootstrap.R <path/to/data>")

data_path <- args[1]
ext <- tolower(tools::file_ext(data_path))

load_pkg <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop(sprintf("Package '%s' required. Run setup_env.R first.", pkg))
  }
}

df <- switch(ext,
  "csv" = { load_pkg("readr"); readr::read_csv(data_path, show_col_types = FALSE) },
  "tsv" = { load_pkg("readr"); readr::read_tsv(data_path, show_col_types = FALSE) },
  "dta" = { load_pkg("haven"); haven::read_dta(data_path) },
  "xlsx" = { load_pkg("readxl"); readxl::read_excel(data_path) },
  "parquet" = { load_pkg("arrow"); arrow::read_parquet(data_path) },
  stop(sprintf("Unsupported file type: .%s", ext))
)

cat("\n--- Shape ---\n")
cat(sprintf("%s rows x %s columns\n", format(nrow(df), big.mark = ","), ncol(df)))
cat("\n--- Column types ---\n")
print(str(df))
cat("\n--- Missing values ---\n")
missing <- colSums(is.na(df))
print(missing[missing > 0])
cat("\n--- Numeric summary ---\n")
print(summary(df))
cat("\n[ok] Bootstrap complete\n")
```

## Script gotchas

- Keep scripts idempotent. Re-running should not corrupt outputs or reinstall needlessly.
- Keep bootstrap read-only. It may inspect raw data but must not clean, transform, or write processed data.
- Fill package lists from `PLAN.md`; do not leave empty lists if the user has already specified the analysis type.
