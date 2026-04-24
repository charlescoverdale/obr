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

A data frame with columns:

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
# Total claimants
cases[cases$series == "Claimants", ]
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
#> 11 2018-19 Claimants 2129.911
#> 12 2019-20 Claimants 2257.000
#> 13 2020-21 Claimants 2396.000
#> 14 2021-22 Claimants 2544.000
#> 15 2022-23 Claimants 2744.000
#> 16 2023-24 Claimants 2930.000
options(op)
# }
```
