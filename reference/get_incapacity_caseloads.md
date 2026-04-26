# Get incapacity benefit caseloads

Downloads (and caches) the OBR Welfare Trends Report charts and tables
workbook and returns the combined incapacity benefit caseload since
2008-09, in both absolute terms (thousands of claimants) and as a share
of the working-age population.

## Usage

``` r
get_incapacity_caseloads(refresh = FALSE)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with columns:

- year:

  Fiscal year, e.g. `"2023-24"` (character)

- series:

  Either `"Claimants"` (thousands) or
  `"Share of working age population"` (per cent) (character)

- value:

  Value in units appropriate to the series (numeric)

## See also

Other welfare:
[`get_incapacity_spending()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_spending.md),
[`get_welfare_spending()`](https://charlescoverdale.github.io/obr/reference/get_welfare_spending.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
cases <- get_incapacity_caseloads()
#> ℹ Downloading welfare_trends.xlsx from OBR...
#> ✔ Saved to cache.
cases[cases$series == "Claimants", ]
#> # obr_tbl: 16 rows x 3 cols
#> # Source:       OBR Welfare Trends Report, October 2024
#> # URL:          https://obr.uk/download/welfare-trends-report-october-2024-charts-and-tables/
#> # Retrieved:    2026-04-26 08:08:36 UTC
#> # File MD5:     c587017c08a1
#> # Package:      obr 0.3.0
#> 
#>       year    series    value
#> 1  2008-09 Claimants 2588.000
#> 2  2009-10 Claimants 2350.000
#> 3  2010-11 Claimants 2253.000
#> 4  2011-12 Claimants 2179.000
#> 5  2012-13 Claimants 1959.000
#> 6  2013-14 Claimants 1864.000
#> 7  2014-15 Claimants 1880.001
#> 8  2015-16 Claimants 2012.076
#> 9  2016-17 Claimants 2047.989
#> 10 2017-18 Claimants 2032.168
#> # ... with 6 more rows
options(op)
# }
```
