# List available forecast series

Returns a data frame showing the series names accepted by
[`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md),
the corresponding Excel sheet in the OBR Historical Official Forecasts
Database, and a plain-English description.

## Usage

``` r
list_forecast_series()
```

## Value

A data frame with columns `series`, `sheet`, and `description`.

## See also

Other forecasts:
[`get_forecast_revisions()`](https://charlescoverdale.github.io/obr/reference/get_forecast_revisions.md),
[`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md),
[`obr_forecast_panel()`](https://charlescoverdale.github.io/obr/reference/obr_forecast_panel.md)

## Examples

``` r
list_forecast_series()
#>             series sheet                               description
#> 1             PSNB £PSNB         Public sector net borrowing (£bn)
#> 2         PSNB_pct  PSNB    Public sector net borrowing (% of GDP)
#> 3             PSND  PSND         Public sector net debt (% of GDP)
#> 4         receipts £PSCR      Public sector current receipts (£bn)
#> 5     receipts_pct  PSCR Public sector current receipts (% of GDP)
#> 6      expenditure  £TME           Total managed expenditure (£bn)
#> 7  expenditure_pct   TME      Total managed expenditure (% of GDP)
#> 8              GDP  NGDP                    Nominal GDP growth (%)
#> 9         real_GDP UKGDP                       Real GDP growth (%)
#> 10             CPI   CPI                         CPI inflation (%)
```
