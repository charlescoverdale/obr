# Get OBR forecast revisions

Downloads (and caches) the OBR Forecast Revisions Database, which
decomposes each EFO-to-EFO revision in the headline Public Sector Net
Borrowing forecast into three top-level components - policy,
classifications and one-offs, and underlying (economic determinants) -
with sub-components for each.

## Usage

``` r
get_forecast_revisions(unit = c("gbp_bn", "pct_gdp"), refresh = FALSE)
```

## Arguments

- unit:

  Character. Either `"gbp_bn"` (GBP billion, the default) or `"pct_gdp"`
  (per cent of GDP).

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with columns:

- forecast_date:

  Forecast vintage, e.g. `"November 2024"` (character).

- component:

  Revision component. Top-level rows are `"Total"`, `"Policy"`,
  `"Classifications and one-offs"`, and `"Underlying"`. Sub-components
  carry the OBR's `"of which: ..."` labels (character).

- fiscal_year:

  Fiscal year being revised, e.g. `"2024-25"` (character).

- value:

  Revision value, in GBP billion or per cent of GDP per `unit`
  (numeric). A positive value indicates an upward revision to PSNB.

## Details

This is the dataset behind the "what changed?" attribution charts in OBR
fiscal commentary and IFS Green Budget chapters.

## See also

Other forecasts:
[`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md),
[`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md),
[`obr_forecast_panel()`](https://charlescoverdale.github.io/obr/reference/obr_forecast_panel.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
rev <- get_forecast_revisions()
#> ℹ Downloading forecast_revisions.xlsx from OBR...
#> ✔ Saved to cache.
# Top-level revisions only
rev[rev$component %in% c("Total", "Policy",
                         "Classifications and one-offs", "Underlying"), ]
#> # obr_tbl: 564 rows x 4 cols
#> # Source:       OBR Forecast Revisions Database
#> # URL:          https://obr.uk/download/forecast-revisions-database-march-2025/
#> # Retrieved:    2026-04-26 08:07:09 UTC
#> # File MD5:     88649f739c50
#> # Package:      obr 0.3.0
#> # Note:         Decomposition of PSNB forecast revisions in GBP billion.
#> 
#>    forecast_date component fiscal_year value
#> 1  November 2010     Total     2010-11  -0.6
#> 2  November 2010     Total     2011-12   1.8
#> 3  November 2010     Total     2012-13   1.9
#> 4  November 2010     Total     2013-14   0.1
#> 5  November 2010     Total     2014-15  -2.4
#> 6  November 2010     Total     2015-16  -2.2
#> 7  November 2010    Policy     2010-11   0.0
#> 8  November 2010    Policy     2011-12   0.8
#> 9  November 2010    Policy     2012-13   0.0
#> 10 November 2010    Policy     2013-14  -1.7
#> # ... with 554 more rows
options(op)
# }
```
