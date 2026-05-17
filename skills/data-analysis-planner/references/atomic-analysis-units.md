# Atomic Analysis Units

Read this when planning R Markdown, Quarto, Python notebooks, cached analyses, provenance, or AI-assisted revision workflows.

## Principle

Keep calculation and interpretation co-located in small, self-contained units, then aggregate upward.
This lets an agent read one file, compute or inspect one result, and revise the nearby prose
without scanning the whole project.

## Unit design

Each atomic unit should have:

- One analytical concern: cleaning, EDA, model fitting, robustness, or results synthesis.
- Declared inputs: raw data, cleaned data, cached model, or parameter set.
- Declared outputs: cache object, table, figure, metadata sidecar, or report section.
- Adjacent interpretation: prose immediately after the result-producing code.
- A freshness signal: inline hash, sidecar metadata, or pipeline metadata.

Split a unit when an agent needs unrelated files to answer a local question, or when the file becomes too large to read fully in one context.

## R Markdown pattern

Use result chunks followed immediately by interpretation prose:

````markdown
```{r model-fit}
fit <- lm(y ~ x1 + x2, data = df)
summary(fit)
```

**Interpretation**: The model explains `r round(summary(fit)$r.squared, 2)` of variance. The coefficient for `x1` is `r round(coef(fit)["x1"], 2)`, which suggests...
````

Inline R expressions prevent stale hardcoded values.

## Explicit cache with sidecar metadata

Use this when the project does not need a full pipeline framework:

```r
library(digest)
library(jsonlite)

cache_file <- "cache/step02_model.rds"
meta_file <- "cache/step02_model_meta.json"

fit <- lm(y ~ x1 + x2, data = df)

meta <- list(
  saved_at = as.character(Sys.time()),
  data_hash = digest(df, algo = "sha1"),
  model_hash = digest(fit, algo = "sha1"),
  code_hash = digest(readLines("analysis/03_model.Rmd"), algo = "sha1"),
  r_version = R.version.string
)

saveRDS(fit, cache_file)
write_json(meta, meta_file, pretty = TRUE, auto_unbox = TRUE)
```

Then load both object and metadata in downstream documents:

````markdown
```{r load-model}
fit <- readRDS("cache/step02_model.rds")
meta <- jsonlite::read_json("cache/step02_model_meta.json")
```

Model provenance: data `r substr(meta$data_hash, 1, 8)`, model `r substr(meta$model_hash, 1, 8)`, code `r substr(meta$code_hash, 1, 8)`.
````

## Lightweight inline hash stamps

Use `digest` when prose should visibly point to the result state:

```r
.hash_data <- digest::digest(df, algo = "sha1")
.hash_model <- digest::digest(fit, algo = "sha1")
```

Then write:

```markdown
**Interpretation** (data: `r substr(.hash_data, 1, 8)`, model: `r substr(.hash_model, 1, 8)`): ...
```

Short hashes are not a substitute for version control, but they make stale interpretation easier to spot.

## `{targets}` option

Recommend `{targets}` when the user needs robust dependency tracking, expensive computations, or many downstream reports.

Minimal `_targets.R` shape:

```r
library(targets)

tar_option_set(packages = c("readr", "dplyr", "rmarkdown"))

list(
  tar_target(raw_data, "data/raw/input.csv", format = "file"),
  tar_target(clean_data, clean_data(readr::read_csv(raw_data))),
  tar_target(fit, run_model(clean_data)),
  tar_render(report, "report.Rmd")
)
```

In reports, use `targets::tar_read(fit)` to load outputs. Use `targets::tar_meta()` when the report needs stored metadata or hashes.

## Aggregator documents

The final `report.Rmd` or `report.qmd` should stitch atomic units together or load cached outputs. It should not contain new heavy computation.

R Markdown child document pattern:

````markdown
```{r child="analysis/01_cleaning.Rmd"}
```

```{r child="analysis/02_eda.Rmd"}
```
````

Quarto projects can use includes and `freeze: auto` where appropriate. Prefer Quarto if the user wants cleaner project-level caching and publishing.

## Copilot-friendly briefing

For AI-assisted projects, add `.github/copilot-instructions.md` with:

- The analysis question and domain.
- The atomic unit map.
- The rule that calculation and interpretation stay adjacent.
- The cache/provenance convention.
- A warning not to edit cached outputs directly.
