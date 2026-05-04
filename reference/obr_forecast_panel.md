# Build a wide real-time panel of OBR forecasts

Takes the long-format Historical Forecasts Database output of
[`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md)
and pivots it to a wide panel with one row per forecast vintage (e.g.
`"March 2024"`) and one column per fiscal year being forecast (e.g.
`"2024-25"`). The first column is the forecast vintage; remaining
columns are numeric forecast values.

## Usage

``` r
obr_forecast_panel(
  series = "PSNB",
  refresh = FALSE,
  order_chronologically = TRUE
)
```

## Arguments

- series:

  Character. Series to return; see
  [`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md).
  Defaults to `"PSNB"`.

- refresh:

  Logical. If `TRUE`, re-download the underlying database.

- order_chronologically:

  Logical. If `TRUE` (the default), rows are ordered from earliest to
  latest forecast vintage. If `FALSE`, rows appear in the order returned
  by
  [`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md).

## Value

An `obr_tbl` whose first column (`forecast_date`) is character and whose
remaining columns are numeric forecast values, one per fiscal year.
Provenance is inherited from the underlying call to
[`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md)
and a `notes` field describes the panel.

## Details

This format mirrors how the OBR's own Historical Forecasts Database is
laid out and how forecast-error studies (e.g. the OBR's own Forecast
Evaluation Report) decompose performance: each row is one forecast
published at a fiscal event, each column is the target year being
forecast, and the diagonal-like structure lets you read the h-step ahead
forecast for any vintage.

## See also

Other forecasts:
[`get_forecast_revisions()`](https://charlescoverdale.github.io/obr/reference/get_forecast_revisions.md),
[`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md),
[`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
panel <- obr_forecast_panel("PSNB")
#> Warning: Could not resolve a current Historical Forecasts Database URL from 16
#> candidates.
#> ℹ Falling back to
#>   <https://obr.uk/download/historical-official-forecasts-database-march-2025/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> Warning: multiple rows match for fiscal_year=1996-97: first taken
#> Warning: multiple rows match for fiscal_year=1997-98: first taken
# PSNB forecast for 2024-25 across every vintage
panel[, c("forecast_date", "2024-25")]
#> # obr_tbl: 104 rows x 2 cols
#> # Source:       OBR Historical Official Forecasts Database, March 2025
#> # URL:          https://obr.uk/download/historical-official-forecasts-database-march-2025/
#> # Retrieved:    2026-05-04 19:14:07 UTC
#> # File MD5:     4312a0cf5075
#> # Package:      obr 0.3.0
#> # Note:         Wide real-time panel for PSNB: rows = forecast vintage, columns = fiscal year.
#> 
#>    forecast_date 2024-25
#> 1     April 1970      NA
#> 2     March 1971      NA
#> 3     March 1972      NA
#> 4     March 1973      NA
#> 5     March 1974      NA
#> 6     April 1975      NA
#> 7     April 1976      NA
#> 8   January 1977      NA
#> 9     March 1977      NA
#> 10 November 1977      NA
#> # ... with 94 more rows
options(op)
# }
```
