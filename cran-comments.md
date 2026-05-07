# CRAN submission comments — obr 0.4.0

## Summary of v0.4.0

Standardises the columns returned by every data-fetching function on a
single tidy long schema (`period`, `period_type`, `series`, `metric_type`,
`value`, `unit`), so outputs from different OBR publications can be
joined and stacked without column mapping. Driven by user feedback from
the Office for Budget Responsibility on the v0.3.x release.

Headline change: `get_efo_economy("inflation")` now tags every row with
`metric_type` and `unit` so callers can distinguish CPI Index level
values from CPI year-on-year growth values, which previously sat in
the same `value` column with no machine-readable distinction.

Two new workflow helpers (`obr_compare_vintages()`,
`obr_actual_vs_forecast()`) and a new vignette (`efo-forecasts`) cover
the new schema and how to use it for forecast-evaluation work.

## Breaking schema changes (documented in NEWS.md)

* `year`, `fiscal_year` -> `period` (with `period_type` to disambiguate)
* `value_bn`, `psnb_bn`, `psnd_bn`, `tme_bn` -> `value` (with `unit = "gbp_bn"`)
* `pct_gdp` (FSR pension projections) -> `value` (with `unit = "pct"`)
* `scenario` (FSR) -> `series`
* `get_psnb()` / `get_psnd()` / `get_expenditure()` now tag rows with
  `series = "PSNB"` / `"PSND"` / `"TME"` and return the standard schema

## R CMD check results

0 errors | 0 warnings | 0 notes (CRAN default settings, R 4.5.x macOS).

## Test suite

136 tests across 13 test files. Network-dependent tests are wrapped in
`skip_on_cran()` and `skip_if_offline()`.

## Notes on data access

Unchanged from v0.2.5: the package downloads data from the OBR website
<https://obr.uk> on first use and caches it locally using
`tools::R_user_dir()`. No data is bundled. All examples that make
network calls are wrapped in `\donttest{}`, with caching redirected to
`tempdir()` so that no files are written to the user's home filespace.

## Downstream dependencies

None on CRAN.
