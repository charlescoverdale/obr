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

An `obr_tbl` with columns:

- year:

  Fiscal year, e.g. `"2023-24"` (character)

- series:

  Spending category: `"Working-age incapacity benefits spending"` or
  `"Working-age non-incapacity spending"` (character)

- value:

  Spending as a percentage of GDP (numeric)

## Details

Data cover fiscal years from 1978-79 through the current forecast
horizon. The exact vintage is recorded in the returned object's
provenance.

## See also

Other welfare:
[`get_incapacity_caseloads()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_caseloads.md),
[`get_incapacity_spending()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_spending.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
welfare <- get_welfare_spending()
#> Warning: Could not resolve a current Welfare Trends Report URL from 9 candidates.
#> ℹ Falling back to
#>   <https://obr.uk/download/welfare-trends-report-october-2024-charts-and-tables/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
welfare[welfare$series == "Working-age incapacity benefits spending" &
        welfare$year >= "2000-01", ]
#> # obr_tbl: 29 rows x 3 cols
#> # Source:       OBR Welfare Trends Report, October 2024
#> # URL:          https://obr.uk/download/welfare-trends-report-october-2024-charts-and-tables/
#> # Retrieved:    2026-05-04 19:14:14 UTC
#> # File MD5:     c587017c08a1
#> # Package:      obr 0.3.0
#> 
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
#> # ... with 19 more rows
options(op)
# }
```
