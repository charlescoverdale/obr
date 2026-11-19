# Pair OBR forecasts with PFD outturn

Joins the long-format Historical Forecasts Database for a given series
against the Public Finances Databank outturn for the same series.
Returns one row per (forecast vintage, fiscal year) where both an OBR
forecast value and an ONS outturn value exist, with the forecast error
(`value_forecast - value_actual`) computed.

## Usage

``` r
obr_actual_vs_forecast(
  series = c("PSNB", "PSND", "expenditure"),
  refresh = FALSE
)
```

## Arguments

- series:

  Forecast series. One of `"PSNB"`, `"PSND"`, `"expenditure"`. Defaults
  to `"PSNB"`.

- refresh:

  Logical. If `TRUE`, re-download underlying files.

## Value

An `obr_tbl` with columns `forecast_date`, `period` (fiscal year being
forecast), `period_type`, `series`, `unit`, `value_forecast` (from HFD),
`value_actual` (from PFD outturn), and `error`
(`value_forecast - value_actual`). Provenance points at the HFD; the PFD
source URL is recorded in `notes`.

## Details

Useful for forecast-evaluation studies, similar in shape to the OBR's
own Forecast Evaluation Report decomposition.

Currently supports series for which a clean `gbp_bn` outturn function
exists in this package: `"PSNB"`, `"PSND"`, `"expenditure"`. Other
series (CPI, GDP, percentages of GDP) need outturn from external
packages and will error.

## See also

Other forecasts:
[`get_forecast_revisions()`](https://charlescoverdale.github.io/obr/reference/get_forecast_revisions.md),
[`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md),
[`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md),
[`obr_compare_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_compare_vintages.md),
[`obr_forecast_panel()`](https://charlescoverdale.github.io/obr/reference/obr_forecast_panel.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
try({
  eval <- obr_actual_vs_forecast("PSNB")

  # 1-year-ahead forecast errors only:
  # take the forecast vintage closest to the start of each fiscal year
  eval2425 <- eval[eval$period == "2024-25", ]
  eval2425[order(eval2425$forecast_date), ]
})
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> # obr_tbl: 13 rows x 8 cols
#> # Source:       OBR Historical Official Forecasts Database, Spring 2026
#> # URL:          https://obr.uk/download/historical-official-forecasts-database/
#> # Retrieved:    2026-11-19 09:02:29 UTC
#> # File MD5:     4312a0cf5075
#> # Package:      obr 0.6.3.9000
#> # Note:         Forecast vs outturn for PSNB. error = value_forecast - value_actual. Outturn source: https://obr.uk/download/public-finances-databank-october-2026-efo/
#> 
#>     forecast_date  period period_type series   unit value_forecast value_actual
#> 499    March 2020 2024-25 fiscal_year   PSNB gbp_bn       57.92369      149.769
#> 501    March 2021 2024-25 fiscal_year   PSNB gbp_bn       74.43927      149.769
#> 503    March 2022 2024-25 fiscal_year   PSNB gbp_bn       36.52329      149.769
#> 505    March 2023 2024-25 fiscal_year   PSNB gbp_bn       85.39792      149.769
#> 507    March 2024 2024-25 fiscal_year   PSNB gbp_bn       87.22658      149.769
#> 509    March 2025 2024-25 fiscal_year   PSNB gbp_bn      137.32912      149.769
#> 511    March 2026 2024-25 fiscal_year   PSNB gbp_bn      152.74200      149.769
#> 500 November 2020 2024-25 fiscal_year   PSNB gbp_bn       99.57407      149.769
#> 504 November 2022 2024-25 fiscal_year   PSNB gbp_bn       84.32658      149.769
#> 506 November 2023 2024-25 fiscal_year   PSNB gbp_bn       84.57033      149.769
#>          error
#> 499  -91.84531
#> 501  -75.32973
#> 503 -113.24571
#> 505  -64.37108
#> 507  -62.54242
#> 509  -12.43988
#> 511    2.97300
#> 500  -50.19493
#> 504  -65.44242
#> 506  -65.19867
#> # ... with 3 more rows
options(op)
# }
```
