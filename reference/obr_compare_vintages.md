# Compare two EFO vintages

Pulls the same EFO table from two vintages and returns a tidy diff with
a revision column (`value_b - value_a`). Useful for quantifying how the
OBR's view changed between fiscal events.

## Usage

``` r
obr_compare_vintages(
  vintage_a,
  vintage_b,
  what = c("fiscal", "inflation", "labour", "output_gap"),
  refresh = FALSE
)
```

## Arguments

- vintage_a, vintage_b:

  EFO vintage labels (e.g. `"October 2024"`, `"March 2026"`). Use
  [`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md)
  to see all valid labels.

- what:

  Which EFO table to compare. One of `"fiscal"` (Table 6.5 aggregates,
  the default), `"inflation"` (sheet 1.7), `"labour"` (sheet 1.6), or
  `"output_gap"` (sheet 1.14).

- refresh:

  Logical. If `TRUE`, re-download even if cached files exist. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with the standard v0.4.0 schema columns (`period`,
`period_type`, `series`, `metric_type`, `unit`) plus `value_a`,
`value_b`, and `revision` (`value_b - value_a`). Provenance points at
the second vintage; the first vintage URL is recorded in the `notes`
field.

## Details

Rows are the **inner join** of the two vintages on the schema keys
(`period`, `period_type`, `series`, `metric_type`, `unit`). Periods or
series that are present in only one vintage are silently dropped. If you
need to see what was added or removed between vintages, compare
[`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md)
row counts or call the underlying functions directly with each vintage
and [`setdiff()`](https://rdrr.io/r/base/sets.html) on the keys.

Calling the function with `vintage_a == vintage_b` is allowed and
returns an all-zero `revision` column. There is no special handling
beyond that.

## See also

Other forecasts:
[`get_forecast_revisions()`](https://charlescoverdale.github.io/obr/reference/get_forecast_revisions.md),
[`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md),
[`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md),
[`obr_actual_vs_forecast()`](https://charlescoverdale.github.io/obr/reference/obr_actual_vs_forecast.md),
[`obr_forecast_panel()`](https://charlescoverdale.github.io/obr/reference/obr_forecast_panel.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
diff <- obr_compare_vintages("October 2024", "March 2026")
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> ℹ Downloading efo_aggregates_march_2026.xlsx from OBR...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ✔ Saved to cache.
diff[diff$series == "Net borrowing", ]
#> # obr_tbl: 5 rows x 8 cols
#> # Source:       OBR Economic and Fiscal Outlook, March 2026
#> # URL:          https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> # Retrieved:    2026-05-07 20:03:04 UTC
#> # File MD5:     43d7526594ab
#> # Package:      obr 0.4.0
#> # Note:         Vintage diff: October 2024 (a) -> March 2026 (b). revision = value_b - value_a. Earlier vintage URL: https://obr.uk/download/october-2024-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> 
#>     period period_type        series metric_type   unit   value_a   value_b
#> 6  2025-26 fiscal_year Net borrowing       level gbp_bn 105.57651 132.73508
#> 13 2026-27 fiscal_year Net borrowing       level gbp_bn  88.45967 115.46142
#> 20 2027-28 fiscal_year Net borrowing       level gbp_bn  72.16790  96.46737
#> 27 2028-29 fiscal_year Net borrowing       level gbp_bn  71.90672  86.01563
#> 34 2029-30 fiscal_year Net borrowing       level gbp_bn  70.58379  63.40344
#>     revision
#> 6  27.158562
#> 13 27.001754
#> 20 24.299469
#> 27 14.108919
#> 34 -7.180343

# Compare the inflation forecast across two vintages
inf_diff <- obr_compare_vintages("October 2024", "March 2026",
                                 what = "inflation")
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
options(op)
# }
```
