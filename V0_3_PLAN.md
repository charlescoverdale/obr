# obr v0.3 — audit findings, demand analysis, build plan

Status: planning. Author: Charles Coverdale. Date: 2026-04-25.

This document consolidates an academic audit, a CRAN compliance audit, a
competitive scan, and a demand analysis for the `obr` R package, then
sets out a prioritised v0.3 specification and outreach plan. The trigger
is an inbound from Prof David Miles (Imperial, BRC) introducing Ben
Northcott at the OBR. v0.3 must be defensible to OBR researchers
themselves.

------------------------------------------------------------------------

## 1. Verdict

`obr` v0.2.5 is the only programmatic wrapper for OBR data in any
language ecosystem. The package is technically functional, broadly
CRAN-compliant, and well structured. It is **not** yet credible to OBR
researchers because returned objects carry no provenance metadata, the
dynamic URL resolver fails silently, and the Historical Forecasts
Database URL is hardcoded to March 2025. Two cosmetic CRAN issues
(em-dashes in roxygen, manual character validation instead of
`match.arg`) are easy fixes. The single highest-leverage build is a
vintage-aware provenance class plus a fiscal-rules calculator: that
combination unlocks every audience segment simultaneously and gives
Northcott something OBR press staff would actually use on Budget day.

------------------------------------------------------------------------

## 2. Critical issues (must fix before OBR engagement)

| \#  | <File:line>                                                  | Severity      | Problem                                                                                                                                                                                       | Fix                                                                                                                                                                                                                                                 |
|-----|--------------------------------------------------------------|---------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1   | R/forecasts.R:2                                              | CRITICAL      | `FORECASTS_URL` hardcoded to “march-2025” but March 2026 EFO has shipped. [`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md) returns stale vintage today. | Use the existing dynamic resolver pattern (mirror `efo_url_candidates()`); fall back only with explicit warning.                                                                                                                                    |
| 2   | R/efo.R:9-11; R/welfare.R:7-9; R/fiscal_sustainability.R:6-9 | CRITICAL      | `obr_resolve_url()` returns NULL on failure; functions silently fall through to a stale fallback URL. User has no way to know they got 2024 data.                                             | Replace silent `if (is.null(url)) url <- FALLBACK` with [`cli::cli_warn()`](https://cli.r-lib.org/reference/cli_abort.html) naming the fallback and the failed candidates. Better: raise `cli_abort()` and require explicit `vintage = "fallback"`. |
| 3   | All data-returning functions                                 | CRITICAL      | No provenance on returned data. Cannot tell whether a frame came from March 2025 or March 2026 EFO. Blocks all institutional use.                                                             | Wrap returns in an `obr_tbl` S3 class with attributes: `vintage`, `source_url`, `retrieved`, `obr_publication`, `package_version`, `sha256`. Print method shows provenance header. (Same pattern as `boe_tbl` and `fred_tbl`.)                      |
| 4   | R/forecasts.R:10-20                                          | HIGH          | Sheet-name lookup uses literal Pound symbol (`"\u00a3PSNB"`). Brittle to OBR encoding changes.                                                                                                | Add a tolerant resolver: try the literal sheet name, then a regex `^.PSNB$` fallback, then a name-based search of [`readxl::excel_sheets()`](https://readxl.tidyverse.org/reference/excel_sheets.html).                                             |
| 5   | R/public_finances.R:49                                       | HIGH          | Footnote-stripping regex `gsub("[0-9]+$", "", series_names)` will corrupt any series legitimately ending in a digit.                                                                          | Strip only superscript-style trailing digits when the *original* string contains a footnote marker, or maintain a hardcoded ignore-list of valid trailing digits.                                                                                   |
| 6   | R/efo.R:106-120                                              | HIGH          | Output-gap parser hardcodes `raw[, 3]`. Silently returns NAs if OBR moves the column.                                                                                                         | Resolve column positionally by header text (“Output gap (per cent of GDP)”) rather than fixed index.                                                                                                                                                |
| 7   | R/efo.R:151,186                                              | MEDIUM (CRAN) | Em-dashes (`—`) in roxygen `@title` lines. CRAN flags non-ASCII in Rd.                                                                                                                        | Replace with hyphens.                                                                                                                                                                                                                               |
| 8   | R/efo.R:220; R/forecasts.R:94                                | MEDIUM (CRAN) | Manual `if (!x %in% valid)` validation instead of [`match.arg()`](https://rdrr.io/r/base/match.arg.html).                                                                                     | Refactor to [`match.arg()`](https://rdrr.io/r/base/match.arg.html) pattern.                                                                                                                                                                         |
| 9   | R/fiscal_sustainability.R:22-23                              | MEDIUM        | Section detection by exact string match (`"Demographic scenarios"`, `"Triple lock scenarios"`); silent NULL on rename.                                                                        | Use `grepl("[Dd]emographic", ...)` style fuzzy match with explicit warning if no sections found.                                                                                                                                                    |
| 10  | inst/CITATION:6                                              | LOW           | Citation declares “R package version 0.2.2”; actual is 0.2.5.                                                                                                                                 | Bump and pin via `meta$Version` from DESCRIPTION.                                                                                                                                                                                                   |

A passing `R CMD check --as-cran` is not the bar. The bar is whether an
OBR analyst can audit which publication produced a number six months
later. Items 1, 2, and 3 are non-negotiable.

------------------------------------------------------------------------

## 3. Demand for OBR data

### 3a. Audience segments

| Segment                                             | UK size       | What they need                                              | Stickiness                     |
|-----------------------------------------------------|---------------|-------------------------------------------------------------|--------------------------------|
| OBR + GAD + HMT analysts                            | ~500          | Audit-trail provenance, vintage pinning, Excel parity       | Very high                      |
| IFS / Resolution Foundation / NIESR / IFG           | ~80           | Budget-day chart pipelines, scorecards, headroom math       | High                           |
| Academic forecast-evaluation researchers            | ~150 globally | Vintage matrices, real-time panels, forecast errors         | Citation-driving               |
| FT / Guardian / Bloomberg / Reuters journos         | ~40           | Tidy frames on Budget day in 30 minutes                     | Burst, high visibility         |
| Sell-side rates desks (gilts, macro funds)          | ~300          | Headroom monitor, fiscal-rule live state, vintage forecasts | Medium (Bloomberg substitutes) |
| Microsim shops (PolicyEngine, OpenFisca-UK, TAXBEN) | ~20 dev-shops | Programmatic uprating tables                                | Very high (embedded dep)       |
| PhD / postgrad UK macro                             | ~200          | Vignettes, textbook integration                             | Long-tail                      |

### 3b. Demand × feature heatmap (★ = unit demand; max ★★★ per cell)

| Feature                                                                                               | OBR/GAD | Think tanks | Academics | Journos | Sell-side | Microsim | Total  |
|-------------------------------------------------------------------------------------------------------|---------|-------------|-----------|---------|-----------|----------|--------|
| [`obr_as_of()`](https://charlescoverdale.github.io/obr/reference/obr_as_of.md) + `obr_tbl` provenance | ★★★     | ★★          | ★★★       | ★       | ★★★       | ★★★      | **15** |
| Fiscal rules + headroom calculator                                                                    | ★★★     | ★★★         | ★         | ★★★     | ★★★       | –        | **13** |
| Policy Measures Database wrapper                                                                      | ★★★     | ★★★         | ★         | ★★★     | ★         | ★★       | **13** |
| Forecast Revisions Database                                                                           | ★★      | ★★★         | ★★        | ★★★     | ★★        | ★        | **13** |
| Ready Reckoners (sensitivities)                                                                       | ★★★     | ★★★         | ★         | ★★      | ★         | ★★       | **12** |
| Forecast error helpers                                                                                | ★       | ★★          | ★★★       | ★       | ★★        | –        | 9      |
| Budget-day auto-update                                                                                | ★       | ★★★         | –         | ★★★     | ★★        | –        | 9      |
| FSR full coverage (health, care)                                                                      | ★★      | ★★          | ★★        | ★       | ★         | ★        | 9      |
| Devolved tax forecasts                                                                                | ★★      | ★           | –         | ★       | –         | ★        | 5      |
| Historical PFD (300 years)                                                                            | ★       | ★           | ★★        | –       | –         | –        | 4      |

Top five carry across at least four segments. Bottom three are deep but
narrow: park for v0.4.

------------------------------------------------------------------------

## 4. v0.3 feature specification (demand-ranked)

Working principle: every new export is an `obr_*` prefix; legacy `get_*`
exports kept and re-routed through the new internals so the API surface
remains backwards-compatible. Every returned frame is `obr_tbl`-classed.

### 4.1 `obr_tbl` provenance class (foundation)

``` r
# Internal constructor
new_obr_tbl(
  data,
  vintage,            # "March 2026 EFO"
  source_url,         # canonical OBR download URL
  retrieved,          # POSIXct
  publication,        # "EFO" | "FSR" | "WTR" | "PFD" | "HFD" | "PMD"
  sha256,             # hash of the underlying xlsx
  notes = NULL
)

# S3 methods
print.obr_tbl()       # one-line provenance header + first n rows
summary.obr_tbl()     # full provenance card + structure
as.data.frame.obr_tbl()
```

Header format on print:

    # obr_tbl: 32 rows x 5 cols
    # Source:       OBR EFO, March 2026
    # Vintage:      2026-03-26
    # URL:          https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
    # Retrieved:    2026-04-25 14:31:02 UTC
    # SHA-256:      a3f4...cd71
    # Package:      obr 0.3.0

All existing 15 exports refit to return `obr_tbl`. No public API change.

### 4.2 Vintage-aware queries

``` r
obr_efo_vintages()                          # df of all EFOs since June 2010 with date, slug, status
obr_as_of(date, publication = "EFO")        # the publication current on `date`
obr_pin(vintage = "October 2024 EFO")       # session-scoped vintage; affects all subsequent calls
obr_unpin()
get_efo_fiscal(vintage = "October 2024")    # explicit override
```

Vintage table seeded from the inventory in `dev/efo_vintages.csv` (33
rows, June 2010 to March 2026). Updated on each new EFO.

### 4.3 Fiscal rules + headroom calculator

``` r
obr_fiscal_rules(vintage = NULL)            # rule definitions for the active charter
obr_headroom(rule = c("stability", "investment", "welfare"), vintage = NULL)
obr_rule_status(vintage = NULL)             # pass / fail / margin per rule
obr_rules_history(rule)                     # headroom path across all forecasts
```

Encodes: - Stability rule: current budget surplus/deficit vs Charter
rolling target year (year 5 until 2026-27, then year 3) - Investment
rule: PSNFL/GDP year-on-year change vs target year - Welfare cap:
AME-capped welfare vs cap level (GBP 194.5bn for 2029-30) - Fiscal lock
(Budget Responsibility Act 2024): non-numeric, but exposed as
`obr_fiscal_lock_assessments()` for the OBR’s required statements

The hard part is faithful Charter encoding. Source: Charter for Budget
Responsibility Autumn 2024 + Autumn 2025 update. Cite both in
[`?obr_fiscal_rules`](https://charlescoverdale.github.io/obr/reference/obr_fiscal_rules.md).

### 4.4 Policy Measures Database

``` r
get_policy_measures(vintage = "March 2026", search = NULL, since = NULL)
policy_measures_summary(vintage)            # net Exchequer effect by year, fiscal event, department
policy_measures_compare(v1, v2)             # what's new / dropped / repriced between two vintages
```

Source: `obr.uk/download/policy-measures-database-march-2025/` and
successors. ~10,000 rows from 1970. First and only programmatic access.

### 4.5 Forecast Revisions Database

``` r
get_forecast_revisions(series = "PSNB", from_vintage, to_vintage)
decompose_revisions(series, vintage)        # economic determinants vs policy vs classification
```

Source: `obr.uk/download/forecast-revisions-database-march-2025/`. Pairs
naturally with
[`obr_as_of()`](https://charlescoverdale.github.io/obr/reference/obr_as_of.md).

### 4.6 Forecast error helpers

``` r
obr_forecast_error(series, h = 1:5, by = c("vintage", "horizon"))
obr_forecast_panel(series)                  # real-time panel: rows = vintages, cols = target dates
obr_forecast_accuracy(series, h)            # MAE, RMSE, bias, theil_u
obr_dm_test(series_a, series_b, h)          # Diebold-Mariano-ready frames (do not implement test; surface inputs)
```

Builds on the Historical Forecasts Database. Mirrors the structure of
`fred_real_time_panel()` in the user’s `fred` package so readers of one
understand the other.

### 4.7 Ready Reckoners

``` r
get_ready_reckoners(vintage = NULL)         # tax/spend sensitivities ("1p on basic rate = GBP X")
```

Source:
`obr.uk/download/march-2025-economic-and-fiscal-outlook-ready-reckoner/`.
Lookup, no compute.

### 4.8 Budget-day automation

``` r
obr_check_for_updates(quiet = FALSE)        # compares cached vintages to obr.uk/data/ index
```

No webhook in v0.3. Just a one-liner users can run to see if a new EFO
has been published since they last cached. Useful for cron jobs and
Budget-day dashboards.

### 4.9 Coverage extensions (lower priority, ship if time permits)

- Long-term Economic Determinants
- EFO chapter-level supplementary tables (Economy / Receipts /
  Expenditure detail)
- FER Annex A (economy errors) and Annex B (fiscal errors)
- Historical Public Finances Database (300 years)
- Devolved tax forecasts (Scotland, Wales)

------------------------------------------------------------------------

## 5. Build sequence

Four two-week sprints. Total ~8 weeks part-time, faster if compressed.

| Sprint        | Focus                          | Deliverable                                                                                                                                                                                                                                                                                                                   |
|---------------|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| S1 (week 1-2) | Audit fixes + provenance class | Items 1-10 in section 2; `obr_tbl` constructor + print method; all 15 existing exports refitted; tests for provenance attributes; CRAN re-submit ready                                                                                                                                                                        |
| S2 (week 3-4) | Vintage layer                  | [`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md), [`obr_as_of()`](https://charlescoverdale.github.io/obr/reference/obr_as_of.md), [`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md); vintage CSV seed; vignette: “Pinning to a specific OBR publication” |
| S3 (week 5-6) | Politics layer                 | Fiscal rules + headroom + Policy Measures Database; vignette: “Reproducing an IFS Green Budget headroom chart”                                                                                                                                                                                                                |
| S4 (week 7-8) | Academics layer                | Forecast Revisions Database + Forecast error helpers; vignette: “Replicating a FER forecast-error decomposition”                                                                                                                                                                                                              |

Each sprint ends with a CRAN-ready release (0.3.0-alpha through 0.3.0).
0.3.0 ships at end of S4. Items in 4.9 fold into 0.4.0.

### Test bar for v0.3

Drop the “skip on CRAN” pattern for the *core* download tests and run
them via a GitHub Actions weekly cron instead. Add: - Known-value tests:
PSNB outturn for 2019-20, 2020-21, 2021-22 against published OBR PFD
values (hand-verified) - Provenance tests: every export returns an
`obr_tbl` with non-NULL `vintage`, `source_url`, `retrieved` - Vintage
tests: `obr_as_of(as.Date("2024-11-01"), "EFO")` returns the October
2024 EFO; `obr_as_of(as.Date("2024-09-30"), "EFO")` returns March 2024 -
Headroom tests: stability rule headroom in March 2026 EFO is GBP 9.9bn ±
rounding; investment rule headroom is GBP 16.9bn ± rounding (these are
publicly stated figures in the EFO press notice and so can be
hard-coded) - Roundtrip tests:
[`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md)
then
[`obr_unpin()`](https://charlescoverdale.github.io/obr/reference/obr_unpin.md)
returns global vintage state to default

Target test count: ~120 (currently 46). Target coverage: ≥85%.

------------------------------------------------------------------------

## 6. Distribution and citation strategy

Shipping v0.3 is necessary but not sufficient. The downloads-per-month
gap between `obr` (~390) and `boe` / `fred` (~900) is an audience-reach
gap, not a feature gap. Three levers:

1.  **A short R Journal or JOSS paper** (“`obr`: Programmatic access to
    UK fiscal forecasts”). Use the `r-article` skill. JOSS turnaround is
    ~10 weeks; gives a citable DOI which the OBR data page can link.
2.  **DBnomics partnership.** DBnomics carries one OBR dataset (Labour
    Market). Offer to seed a full OBR provider feed sourced via `obr`.
    Cross-promotes both ways.
3.  **A macrowithR fiscal cookbook chapter.** The user already maintains
    [macrowithR](https://macrowithr.com) and Chapter 11 (fiscal) is
    published. Add a worked example using `obr` v0.3 — every reader
    becomes a candidate user.

### 6a. Outreach list (post v0.3 ship)

| Target                                            | Channel                                              | Pitch                                                                                                                        |
|---------------------------------------------------|------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|
| Ben Northcott (OBR)                               | Reply to current email thread                        | Demo: vintage-pinning + headroom calculator on March 2026 EFO. Offer to align variable naming with internal OBR conventions. |
| Carl Emmerson, Bee Boileau, Isabel Stockton (IFS) | Direct email                                         | “I built the package that reproduces your Green Budget public-finances chapter in 30 lines of R.” Show the worked example.   |
| James Smith, Cara Pacitti (Resolution Foundation) | Direct email                                         | Same pitch, RF angle.                                                                                                        |
| OBR data page maintainer                          | Email via OBR contact                                | Request listing as a third-party tool on `obr.uk/data/`.                                                                     |
| GES analytical community                          | GES Slack / R user community + a short LinkedIn post | “If you build fiscal impact assessments, here’s the R package.”                                                              |
| FT / Guardian data desk                           | Direct email week before Spring Budget 2027          | “30-second tidy access to OBR forecast tables on Budget day.”                                                                |
| PolicyEngine UK                                   | GitHub issue on policyengine-uk                      | Offer `obr` as a dep replacement for hand-coded uprating tables.                                                             |
| DBnomics                                          | Direct email to providers team                       | Offer to seed full OBR feed.                                                                                                 |

### 6b. Reply to Miles + Northcott

Hold the reply to Miles + Northcott until the vintage class and headroom
calculator are at least at alpha. Reason: the value of the demo is much
higher when a single command can reproduce the OBR’s own headroom
statement. A two-week delay buys an order-of-magnitude better first
impression. Keep the reply short, propose a 20-minute call, attach a
one-page note showing the headroom calculator output against the March
2026 EFO.

------------------------------------------------------------------------

## 7. Open questions

1.  Should
    [`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md)
    use options or an environment? Options is more idiomatic R but
    harder to test; env is cleaner but less discoverable. Default:
    options with documented escape hatch.
2.  Cache invalidation: how often should we re-validate cached files
    against the live URL? Default: never on read, opt-in via
    `obr_check_for_updates()`. Reason: minimise surprise network calls.
3.  Should we keep the legacy `get_*` API or rename to `obr_*`?
    Decision: keep both for 0.3.x, deprecate `get_*` with a 2-version
    warning starting 0.4.0. CRAN-compatible deprecation cycle.
4.  Should fiscal rules code live in `obr` or in a separate
    `fiscalrules` package (composable with `debtkit`)? Decision: in
    `obr` for v0.3 (convenience \> purity); spin out if it accumulates ≥
    8 functions.
5.  JOSS or R Journal first? JOSS is faster and easier; R Journal is
    higher prestige. Decision: JOSS first (4-month turnaround target), R
    Journal as a v1.0 deliverable.
