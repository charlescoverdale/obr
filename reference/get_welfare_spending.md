# Get working-age welfare spending

Downloads (and caches) the OBR Welfare Trends Report charts and tables
workbook and returns annual working-age welfare spending as a share of
GDP, split into incapacity-related and non-incapacity spending.

## Usage

``` r
get_welfare_spending(refresh = FALSE)
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

  Spending category: `"Working-age incapacity benefits spending"` or
  `"Working-age non-incapacity spending"` (character)

- value:

  Spending as a percentage of GDP (numeric)

## Details

Data cover fiscal years from 1978-79 through the current forecast
horizon (OBR, October 2024).

## See also

Other welfare:
[`get_incapacity_caseloads()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_caseloads.md),
[`get_incapacity_spending()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_spending.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
welfare <- get_welfare_spending()
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
# Incapacity share since 2000
welfare[welfare$series == "Working-age incapacity benefits spending" &
        welfare$year >= "2000-01", ]
#>       year                                   series     value
#> 23 2000-01 Working-age incapacity benefits spending 1.0914588
#> 24 2001-02 Working-age incapacity benefits spending 1.0812179
#> 25 2002-03 Working-age incapacity benefits spending 1.0345429
#> 26 2003-04 Working-age incapacity benefits spending 0.9930008
#> 27 2004-05 Working-age incapacity benefits spending 0.9203422
#> 28 2005-06 Working-age incapacity benefits spending 0.8546259
#> 29 2006-07 Working-age incapacity benefits spending 0.8089978
#> 30 2007-08 Working-age incapacity benefits spending 0.8035180
#> 31 2008-09 Working-age incapacity benefits spending 0.7741892
#> 32 2009-10 Working-age incapacity benefits spending 0.7877039
#> 33 2010-11 Working-age incapacity benefits spending 0.7438999
#> 34 2011-12 Working-age incapacity benefits spending 0.7162770
#> 35 2012-13 Working-age incapacity benefits spending 0.6692722
#> 36 2013-14 Working-age incapacity benefits spending 0.6421571
#> 37 2014-15 Working-age incapacity benefits spending 0.6516647
#> 38 2015-16 Working-age incapacity benefits spending 0.6971264
#> 39 2016-17 Working-age incapacity benefits spending 0.6960196
#> 40 2017-18 Working-age incapacity benefits spending 0.6861634
#> 41 2018-19 Working-age incapacity benefits spending 0.6756497
#> 42 2019-20 Working-age incapacity benefits spending 0.7386774
#> 43 2020-21 Working-age incapacity benefits spending 0.8825464
#> 44 2021-22 Working-age incapacity benefits spending 0.8717820
#> 45 2022-23 Working-age incapacity benefits spending 0.8423765
#> 46 2023-24 Working-age incapacity benefits spending 0.9239248
#> 47 2024-25 Working-age incapacity benefits spending 0.9980306
#> 48 2025-26 Working-age incapacity benefits spending 1.0051716
#> 49 2026-27 Working-age incapacity benefits spending 1.0038338
#> 50 2027-28 Working-age incapacity benefits spending 1.0023592
#> 51 2028-29 Working-age incapacity benefits spending 1.0056712
options(op)
# }
```
