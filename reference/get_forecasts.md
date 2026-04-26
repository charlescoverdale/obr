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

An `obr_tbl` with columns:

- series:

  Series name as supplied (character)

- forecast_date:

  When the forecast was published, e.g. `"March 2024"` (character)

- fiscal_year:

  The fiscal year being forecast, e.g. `"2024-25"` (character)

- value:

  Forecast value (numeric)

## Details

This is useful for visualising how OBR forecasts have evolved over time,
and for comparing forecasts against outturns. The vintage of the
underlying database is recorded in the returned object's provenance.

## See also

Other forecasts:
[`get_forecast_revisions()`](https://charlescoverdale.github.io/obr/reference/get_forecast_revisions.md),
[`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md),
[`obr_forecast_panel()`](https://charlescoverdale.github.io/obr/reference/obr_forecast_panel.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
get_forecasts("PSNB")
#> ℹ Downloading historical_forecasts.xlsx from OBR...
#> ✔ Saved to cache.
#> # obr_tbl: 553 rows x 4 cols
#> # Source:       OBR Historical Official Forecasts Database, March 2025
#> # URL:          https://obr.uk/download/historical-official-forecasts-database-march-2025/
#> # Retrieved:    2026-04-26 08:07:32 UTC
#> # File MD5:     4312a0cf5075
#> # Package:      obr 0.3.0
#> 
#>    series forecast_date fiscal_year value
#> 1    PSNB    April 1970     1970-71  -0.2
#> 2    PSNB    March 1971     1970-71   0.6
#> 3    PSNB    March 1971     1971-72   1.2
#> 4    PSNB    March 1972     1971-72   1.3
#> 5    PSNB    March 1972     1972-73   3.4
#> 6    PSNB    March 1973     1972-73   2.9
#> 7    PSNB    March 1973     1973-74   4.4
#> 8    PSNB    March 1974     1973-74   4.3
#> 9    PSNB    March 1974     1974-75   2.7
#> 10   PSNB    April 1975     1974-75   7.6
#> # ... with 543 more rows

psnb <- get_forecasts("PSNB")
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
psnb[psnb$fiscal_year == "2024-25", ]
#> # obr_tbl: 13 rows x 4 cols
#> # Source:       OBR Historical Official Forecasts Database, March 2025
#> # URL:          https://obr.uk/download/historical-official-forecasts-database-march-2025/
#> # Retrieved:    2026-04-26 08:07:32 UTC
#> # File MD5:     4312a0cf5075
#> # Package:      obr 0.3.0
#> 
#>     series forecast_date fiscal_year     value
#> 499   PSNB    March 2020     2024-25  57.92369
#> 500   PSNB November 2020     2024-25  99.57407
#> 501   PSNB    March 2021     2024-25  74.43927
#> 502   PSNB  October 2021     2024-25  46.32206
#> 503   PSNB    March 2022     2024-25  36.52329
#> 504   PSNB November 2022     2024-25  84.32658
#> 505   PSNB    March 2023     2024-25  85.39792
#> 506   PSNB November 2023     2024-25  84.57033
#> 507   PSNB    March 2024     2024-25  87.22658
#> 508   PSNB  October 2024     2024-25 127.49186
#> # ... with 3 more rows
options(op)
# }
```
