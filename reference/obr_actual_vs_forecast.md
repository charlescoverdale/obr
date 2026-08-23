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
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> # obr_tbl: 13 rows x 8 cols
#> # Source:       OBR Historical Official Forecasts Database, March 2025
#> # URL:          https://obr.uk/download/historical-official-forecasts-database-march-2025/
#> # Retrieved:    2026-08-23 17:35:55 UTC
#> # File MD5:     4312a0cf5075
#> # Package:      obr 0.6.2
#> # Note:         Forecast vs outturn for PSNB. error = value_forecast - value_actual. Outturn source: https://obr.uk/download/public-finances-databank/
#> 
#>     forecast_date  period period_type series   unit value_forecast value_actual
#> 509    March 2020 2024-25 fiscal_year   PSNB gbp_bn       57.92369     99.57407
#> 500    March 2021 2024-25 fiscal_year   PSNB gbp_bn       74.43927     99.57407
#> 504    March 2022 2024-25 fiscal_year   PSNB gbp_bn       36.52329     99.57407
#> 502    March 2023 2024-25 fiscal_year   PSNB gbp_bn       85.39792     99.57407
#> 508    March 2024 2024-25 fiscal_year   PSNB gbp_bn       87.22658     99.57407
#> 506    March 2025 2024-25 fiscal_year   PSNB gbp_bn      137.32912     99.57407
#> 511    March 2026 2024-25 fiscal_year   PSNB gbp_bn      152.74200     99.57407
#> 499 November 2020 2024-25 fiscal_year   PSNB gbp_bn       99.57407     99.57407
#> 501 November 2022 2024-25 fiscal_year   PSNB gbp_bn       84.32658     99.57407
#> 507 November 2023 2024-25 fiscal_year   PSNB gbp_bn       84.57033     99.57407
#>         error
#> 509 -41.65038
#> 500 -25.13480
#> 504 -63.05078
#> 502 -14.17616
#> 508 -12.34749
#> 506  37.75505
#> 511  53.16793
#> 499   0.00000
#> 501 -15.24749
#> 507 -15.00375
#> # ... with 3 more rows
options(op)
# }
```
