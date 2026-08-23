# Get OBR forecast history for a fiscal series

Downloads (and caches) the OBR Historical Official Forecasts Database
and returns a tidy long-format data frame showing every forecast the OBR
has ever published for a given series. Each row is one forecast for one
fiscal year, made at one fiscal event.

## Usage

``` r
get_forecasts(series = "PSNB", refresh = FALSE)
```

## Arguments

- series:

  Character. The series to return. Use
  [`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md)
  to see all options. Defaults to `"PSNB"` (Public Sector Net Borrowing
  in £ billion).

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with the standard v0.4.0 schema plus a `forecast_date`
column (so each row identifies one fiscal-year value at one fiscal
event):

- forecast_date:

  When the forecast was published, e.g. `"March 2024"`

- period:

  Fiscal year being forecast, e.g. `"2024-25"`

- period_type:

  Always `"fiscal_year"`

- series:

  Series name as supplied (character)

- metric_type:

  One of `"level"`, `"pct"`, `"yoy_pct"`, set per series. CPI / GDP /
  real_GDP are `"yoy_pct"` (rates of change); PSNB / receipts /
  expenditure are `"level"`; the `_pct` variants and PSND are `"pct"` (%
  of GDP).

- value:

  Numeric forecast value in the unit described by `unit`

- unit:

  `"gbp_bn"` for level series, `"pct"` for percentage series

## Details

This is useful for visualising how OBR forecasts have evolved over time,
and for comparing forecasts against outturns. The vintage of the
underlying database is recorded in the returned object's provenance.

## See also

Other forecasts:
[`get_forecast_revisions()`](https://charlescoverdale.github.io/obr/reference/get_forecast_revisions.md),
[`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md),
[`obr_actual_vs_forecast()`](https://charlescoverdale.github.io/obr/reference/obr_actual_vs_forecast.md),
[`obr_compare_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_compare_vintages.md),
[`obr_forecast_panel()`](https://charlescoverdale.github.io/obr/reference/obr_forecast_panel.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
try({
  get_forecasts("PSNB")

  psnb <- get_forecasts("PSNB")
  psnb[psnb$period == "2024-25", ]
})
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Downloading historical_forecasts.xlsx from OBR...
#> ✔ Saved to cache.
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> # obr_tbl: 13 rows x 7 cols
#> # Source:       OBR Historical Official Forecasts Database, March 2025
#> # URL:          https://obr.uk/download/historical-official-forecasts-database-march-2025/
#> # Retrieved:    2026-08-23 18:05:16 UTC
#> # File MD5:     4312a0cf5075
#> # Package:      obr 0.6.2
#> 
#>     forecast_date  period period_type series metric_type     value   unit
#> 499    March 2020 2024-25 fiscal_year   PSNB       level  57.92369 gbp_bn
#> 500 November 2020 2024-25 fiscal_year   PSNB       level  99.57407 gbp_bn
#> 501    March 2021 2024-25 fiscal_year   PSNB       level  74.43927 gbp_bn
#> 502  October 2021 2024-25 fiscal_year   PSNB       level  46.32206 gbp_bn
#> 503    March 2022 2024-25 fiscal_year   PSNB       level  36.52329 gbp_bn
#> 504 November 2022 2024-25 fiscal_year   PSNB       level  84.32658 gbp_bn
#> 505    March 2023 2024-25 fiscal_year   PSNB       level  85.39792 gbp_bn
#> 506 November 2023 2024-25 fiscal_year   PSNB       level  84.57033 gbp_bn
#> 507    March 2024 2024-25 fiscal_year   PSNB       level  87.22658 gbp_bn
#> 508  October 2024 2024-25 fiscal_year   PSNB       level 127.49186 gbp_bn
#> # ... with 3 more rows
options(op)
# }
```
