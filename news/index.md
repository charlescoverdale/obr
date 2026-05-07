# Changelog

## obr 0.5.0

### Full EFO detailed-forecast-table coverage

This release closes the v0.3.x feedback that “the range of forecast
lines was fairly limited” by exposing every parsable detailed-forecast
table in the EFO Aggregates and Economy workbooks (35 of 39 today, with
the remaining 4 marked as cross-reference or non-standard layout).
v0.4.x exposed only 4.

### New: `get_efo_table()` and `obr_efo_catalogue()`

- [`obr_efo_catalogue()`](https://charlescoverdale.github.io/obr/reference/obr_efo_catalogue.md)
  returns a data frame describing every detailed- forecast table the
  package can fetch: `table_id`, `file`, `section`, `title`, `layout`,
  default `metric_type`, default `unit`. Use this to discover what’s
  available.
- `get_efo_table(table_id, vintage, refresh)` is the generic dispatcher.
  Pass any catalogue id (e.g. `"6.13"`, `"1.19"`, `"6.1"`) and get the
  parsed contents back in the standard v0.4.0 schema (`period`,
  `period_type`, `series`, `metric_type`, `value`, `unit`).

[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)
and
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md)
are now thin wrappers over the dispatcher and continue to work
unchanged. Series names for the single-series Economy tables (output
gap, nominal GDP, electricity price) are preserved via internal
overrides so v0.4.x scripts still match.

### New layouts handled

The dispatcher routes each table to one of:

- `quarterly_wide` periods in col 2 (Q1/Q2 strings), series across
- `quarterly_single` periods in col 2, single value column to the right
- `annual_year_wide` calendar years as column headers, series in col 2
- `annual_period_wide` calendar years in col 2 (rows), series across
- `fiscal_year_wide` fiscal years as column headers, series in col 2
- `cross_reference` sheet redirects to a previous EFO; returns NULL with
  a warning
- `complex_layout` sheet has a non-standard layout the package does not
  yet parse; returns NULL with a warning

### Classifier hardening

Tightened `classify_metric_type()` so the v0.5.0 expanded coverage tags
each row correctly:

- `Index-linked gilts` (and similar) is no longer classified as
  `metric_type = "index"`. The “index” pattern now requires `Index` at
  the end of the series name or an explicit `(2015=100)` / `(2010=100)`
  base-year tag. Net-debt composition (Table 6.13) now correctly tags
  every row as `pct`.
- Bare `change` no longer triggers `yoy_pct` because OBR uses “change in
  X” for level differences too
  (e.g. `Adjustment for the change in pension entitlements`, in £bn).
  Explicit YoY signals (`growth`, `inflation`, `y/y`, `yoy`,
  `year on year`, `% change`, `annual %`) still trigger.

## obr 0.4.0

### Breaking: standard tidy long schema for the EFO / PFD / HFD / WTR / FSR functions

This release standardises the columns returned by the data-fetching
functions backing the Public Finances Databank (PFD), Economic and
Fiscal Outlook (EFO), Historical Forecasts Database (HFD), Welfare
Trends Report (WTR), and Fiscal Risks and Sustainability Report (FSR) so
they can be [`rbind()`](https://rdrr.io/r/base/cbind.html)’d, joined,
plotted, and reasoned about the same way regardless of which OBR
publication produced them. Driven by feedback from Ben Northcott (Office
for Budget Responsibility) on the v0.3.x release.

The Forecast Revisions Database
([`get_forecast_revisions()`](https://charlescoverdale.github.io/obr/reference/get_forecast_revisions.md))
and Policy Measures Database
([`get_policy_measures()`](https://charlescoverdale.github.io/obr/reference/get_policy_measures.md))
keep their existing multi-dimensional schemas in v0.4.0; migrating them
to the standard schema is queued for a later release.

All long-format outputs from the EFO / PFD / HFD / WTR / FSR functions
now share the columns:

- `period` - the time period as a character string
- `period_type` - one of `"fiscal_year"`, `"quarter"`, `"calendar_year"`
- `series` - the variable name
- `metric_type` - one of `"level"`, `"yoy_pct"`, `"index"`, `"pct"`,
  `"pct_pts"`
- `value` - the numeric value
- `unit` - one of `"gbp_bn"`, `"pct"`, `"pct_pts"`, `"index"`,
  `"count_k"`, etc.

[`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md)
adds `forecast_date` as a leading column.
[`get_pension_projections()`](https://charlescoverdale.github.io/obr/reference/get_pension_projections.md)
adds `scenario_type` as a trailing column.

#### Migration

| Old column | New column |
|----|----|
| `year`, `fiscal_year` | `period` (with `period_type` to disambiguate) |
| `value_bn`, `psnb_bn`, `psnd_bn`, `tme_bn` | `value` (with `unit = "gbp_bn"`) |
| `pct_gdp` (FSR pension projections) | `value` (with `unit = "pct"`) |
| `scenario` (FSR) | `series` |

[`get_psnb()`](https://charlescoverdale.github.io/obr/reference/get_psnb.md),
[`get_psnd()`](https://charlescoverdale.github.io/obr/reference/get_psnd.md),
[`get_expenditure()`](https://charlescoverdale.github.io/obr/reference/get_expenditure.md)
now return the standard long schema and tag rows with `series = "PSNB"`,
`"PSND"`, `"TME"` respectively rather than collapsing the value into a
series-named column.

### CPI Index vs YoY split (the headline fix)

In v0.3.x, calling `get_efo_economy("inflation")` returned CPI Index
values (~135) and CPI YoY growth values (~2.1) in the same `value`
column with no machine-readable distinction between them. v0.4.0 tags
every row with a `metric_type` (`"index"` for index levels, `"yoy_pct"`
for growth rates, `"pct"` for shares, etc.) and a matching `unit`, so
callers can filter or facet on metric type directly.

This is the v0.4.0 fix for the bug Ben Northcott raised on 2026-04-29:
“If I pull e.g. the CPI forecast the index value and the YoY growth rate
appear in the same ‘value’ column. Probably an additional column in long
format indicating YoY or Index would be useful.”

### New helpers

- `classify_metric_type()` (internal): heuristic classifier for series
  names. Returns `"index"`, `"yoy_pct"`, `"pct"`, `"pct_pts"`, or
  `"level"`. Used by every parser to populate `metric_type` from raw
  source labels.
- `default_unit_for_metric()` (internal): maps a `metric_type` to its
  default `unit`. For `"level"` returns `NA` (caller must supply since a
  level can be `gbp_bn`, `count_mn`, etc.).
- `obr_long()` (internal): canonical constructor for the v0.4.0 schema.
  All parsers use this to build their tidy long output.

### Constants

- `OBR_PERIOD_TYPES`, `OBR_METRIC_TYPES`, `OBR_UNITS`: controlled
  vocabularies for the schema metadata columns. Internal but documented
  in the package source.

### New: workflow helpers

- `obr_compare_vintages(vintage_a, vintage_b, what)` joins the same EFO
  table from two vintages on the standard schema and returns a tidy diff
  with `value_a`, `value_b`, and `revision = value_b - value_a`.
  Supports `what = "fiscal"` (default), `"inflation"`, `"labour"`, or
  `"output_gap"`.
- `obr_actual_vs_forecast(series)` joins the long-format Historical
  Forecasts Database against PFD outturn for the same series, returning
  one row per (forecast vintage, fiscal year) with the realised forecast
  error. Supports `series = "PSNB"`, `"PSND"`, or `"expenditure"`.

Both helpers feed naturally into the kind of forecast-evaluation tables
the OBR’s own Forecast Evaluation Report uses.

### New: vignette

- [`vignette("efo-forecasts")`](https://charlescoverdale.github.io/obr/articles/efo-forecasts.md)
  covers the v0.4.0 schema: how to read the Index vs YoY split, how to
  combine EFO with PFD outturn via the shared schema, and how to compare
  two vintages. The existing
  [`vignette("vintages")`](https://charlescoverdale.github.io/obr/articles/vintages.md)
  is updated for the renamed `period` column.

## obr 0.3.0

### New: provenance metadata on every returned object

- All data-returning functions now return an `obr_tbl` object: a
  `data.frame` with attached provenance recording the source URL, OBR
  publication code (“PFD”, “HFD”, “EFO”, “WTR”, “FSR”), publication
  vintage (e.g. “March 2026”), retrieval timestamp, file MD5
  fingerprint, and `obr` package version. This lets users audit which
  OBR publication produced any number, and reproduce analyses across new
  package or OBR releases.
- Print method shows a provenance header before the data.
- [`summary()`](https://rdrr.io/r/base/summary.html) returns the full
  provenance card.
- New helper
  [`obr_provenance()`](https://charlescoverdale.github.io/obr/reference/obr_provenance.md)
  extracts the metadata as a list.
- Subsetting with `[` preserves the class and attributes;
  [`as.data.frame()`](https://rdrr.io/r/base/as.data.frame.html) strips
  them.

### New: vintage layer for reproducible analysis

- [`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md)
  returns a structured table of every EFO published since the OBR was
  created in June 2010, with publication dates and URL slugs.
- `obr_as_of(date)` returns the EFO that was current on a given calendar
  date. Useful for reproducing analyses as they would have looked at a
  given point in time.
- `obr_pin(vintage)` sets a session-wide EFO vintage that flows into
  [`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)
  and
  [`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md).
  [`obr_unpin()`](https://charlescoverdale.github.io/obr/reference/obr_unpin.md)
  clears it and
  [`obr_pinned()`](https://charlescoverdale.github.io/obr/reference/obr_pinned.md)
  returns the current pin.
- [`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)
  and
  [`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md)
  now accept a `vintage =` argument that overrides any pin and downloads
  the file for that specific EFO. Cached files are vintage-tagged so
  different vintages do not overwrite each other.

### New: Policy Measures Database

- [`get_policy_measures()`](https://charlescoverdale.github.io/obr/reference/get_policy_measures.md)
  provides programmatic access to the OBR’s Policy Measures Database,
  with one row per fiscal-event-scored measure since 1970 (tax) or 2010
  (spending). Columns include the fiscal event, plain- English
  description, Treasury head, fiscal year, and Exchequer effect in GBP
  million.
- Supports filters: `type` (“tax”, “spending”, or both), `search` (regex
  on description / head, case-insensitive), `since` (fiscal-year
  cut-off).
- [`policy_measures_summary()`](https://charlescoverdale.github.io/obr/reference/policy_measures_summary.md)
  aggregates the long format to net Exchequer effect by event and fiscal
  year.
- This is the only programmatic access to the PMD: the OBR otherwise
  distributes it as a single Excel workbook with non-standard layout.

### New: fiscal rules reference

- [`obr_fiscal_rules()`](https://charlescoverdale.github.io/obr/reference/obr_fiscal_rules.md)
  returns a structured table of the three numerical rules in the current
  Charter for Budget Responsibility (Autumn 2024, updated Autumn 2025):
  the stability rule (current budget surplus), the investment rule
  (PSNFL/GDP falling), and the welfare cap. The metric, pass direction,
  target-year mechanics, and source Charter / Act are shipped as data.
  Numerical headroom is *not* shipped as a constant because it changes
  at every fiscal event; users should derive it from current EFO output
  via \[get_efo_fiscal()\] or read the EFO press release.

### New: Forecast Revisions Database and forecast panel

- [`get_forecast_revisions()`](https://charlescoverdale.github.io/obr/reference/get_forecast_revisions.md)
  provides programmatic access to the OBR’s Forecast Revisions Database,
  which decomposes each EFO-to-EFO change in the headline PSNB forecast
  into policy, classifications and one-offs, and underlying (economic
  determinants) components. Available in both GBP billion and per cent
  of GDP.
- [`obr_forecast_panel()`](https://charlescoverdale.github.io/obr/reference/obr_forecast_panel.md)
  pivots the long-format Historical Forecasts Database to a wide
  real-time panel: rows are forecast vintages, columns are fiscal years,
  cells are forecast values. Mirrors how the OBR’s own Forecast
  Evaluation Report lays out forecast performance and lets users read
  the h-step-ahead forecast for any vintage off the diagonal.

### Breaking-ish changes

- No public API was renamed or removed. All existing exports keep their
  signatures and return columns; the only difference is that returned
  frames now carry the `obr_tbl` class and provenance attributes.

### URL resolution and reliability

- The Historical Forecasts Database URL is now resolved dynamically
  across recent fiscal events (previously hardcoded to March 2025).
- When dynamic URL resolution falls through to the hardcoded fallback
  for any publication (EFO, WTR, FSR, HFD), the package now emits an
  explicit
  [`cli::cli_warn()`](https://cli.r-lib.org/reference/cli_abort.html)
  instead of failing silently. The returned data frame records
  `source = "fallback"` so callers can detect this state.
- Excel sheet-name lookup now tolerates encoding changes via a regex
  fallback. Series whose primary sheet name uses a non-ASCII Pound
  symbol (PSNB, receipts, expenditure) fall back to a letter-only
  pattern if the literal name is missing.
- `obr_resolve_url()` now uses HEAD requests for faster candidate
  probing and captures the redirect target so the Public Finances
  Databank vintage can be recovered from the stable slug.

### Parser robustness

- `parse_efo_output_gap()` (sheet 1.14) now scans for the value column
  with the most aligned numeric entries instead of hardcoding column 3.
- `parse_pension_projections()` (FSR sheet C1.2) now detects sections
  via fuzzy matching on “demographic” and “triple lock” rather than
  exact strings.
- Receipts column footnote stripping now only removes 1-2 trailing
  digits when preceded by a letter, period, or whitespace, so series
  legitimately ending in digits are not corrupted.

### Documentation

- Em-dashes removed from roxygen titles to avoid encoding issues on
  Windows.
- [`match.arg()`](https://rdrr.io/r/base/match.arg.html) is now used for
  `series` and `measure` arguments.
- `inst/CITATION` reads the version from `DESCRIPTION` so it stays in
  sync.

## obr 0.2.5

CRAN release: 2026-04-14

- EFO, Welfare Trends Report, and Fiscal Sustainability Report download
  URLs are now resolved dynamically, trying recent publication dates in
  reverse chronological order. This prevents functions from breaking
  when OBR publishes new editions. Hardcoded URLs are retained as
  fallbacks.

## obr 0.2.4

CRAN release: 2026-03-17

- Removed non-existent pkgdown URL from DESCRIPTION.

## obr 0.2.3

- Examples now cache to
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html) instead of the
  user’s home directory, fixing CRAN policy compliance for `\donttest`
  examples.
- Cache directory is now configurable via
  `options(obr.cache_dir = ...)`.

## obr 0.2.2

CRAN release: 2026-03-12

- Fix README URLs flagged by CRAN incoming checks (301 redirects).
- Add “Databank” to WORDLIST.

## obr 0.2.1

- Update WORDLIST with domain-specific terms (EFO, FSR, WTR, CPIH, etc.)

## obr 0.2.0

### New datasets

#### Economic and Fiscal Outlook (EFO)

- [`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)
  for five-year fiscal projections (net borrowing components) from the
  latest Budget
- `get_efo_economy(measure)` for quarterly economic projections:
  `"inflation"` (CPI, CPIH, RPI, RPIX), `"labour"` (employment,
  unemployment, participation), or `"output_gap"`
- [`list_efo_economy_measures()`](https://charlescoverdale.github.io/obr/reference/list_efo_economy_measures.md)
  lists available economy measures

#### Welfare Trends Report (WTR)

- [`get_welfare_spending()`](https://charlescoverdale.github.io/obr/reference/get_welfare_spending.md)
  returns working-age welfare spending split by incapacity and
  non-incapacity (% of GDP, from 1978-79)
- [`get_incapacity_spending()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_spending.md)
  returns incapacity benefits spending by benefit type (ESA, IB,
  Invalidity Benefit, Sickness Benefit, SDA) as % of GDP
- [`get_incapacity_caseloads()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_caseloads.md)
  returns combined incapacity benefit caseloads and prevalence since
  2008-09

#### Fiscal Risks and Sustainability Report (FSR)

- [`get_pension_projections()`](https://charlescoverdale.github.io/obr/reference/get_pension_projections.md)
  returns 50-year state pension spending projections (% of GDP) under
  alternative demographic and triple-lock scenarios

## obr 0.1.0

- Initial release
- [`get_psnb()`](https://charlescoverdale.github.io/obr/reference/get_psnb.md),
  [`get_psnd()`](https://charlescoverdale.github.io/obr/reference/get_psnd.md),
  [`get_expenditure()`](https://charlescoverdale.github.io/obr/reference/get_expenditure.md),
  [`get_receipts()`](https://charlescoverdale.github.io/obr/reference/get_receipts.md)
  for Public Finances Databank aggregates
- [`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md)
  for all Databank series in tidy long format
- [`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md)
  and
  [`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md)
  for Historical Official Forecasts Database
- [`clear_cache()`](https://charlescoverdale.github.io/obr/reference/clear_cache.md)
  to remove locally cached files
- Data sourced from the OBR Public Finances Databank and Historical
  Official Forecasts Database
