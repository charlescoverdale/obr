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

An `obr_tbl` with the standard v0.4.0 schema (columns: `period`,
`period_type`, `series`, `metric_type`, `value`, `unit`). Values are
spending as a percentage of GDP; `metric_type` is `"pct"`, `unit` is
`"pct"`.

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
        welfare$period >= "2000-01", ]
#> # obr_tbl: 29 rows x 6 cols
#> # Source:       OBR Welfare Trends Report, October 2024
#> # URL:          https://obr.uk/download/welfare-trends-report-october-2024-charts-and-tables/
#> # Retrieved:    2026-05-07 20:59:18 UTC
#> # File MD5:     c587017c08a1
#> # Package:      obr 0.5.0
#> 
#>     period period_type                                   series metric_type
#> 23 2000-01 fiscal_year Working-age incapacity benefits spending       level
#> 24 2001-02 fiscal_year Working-age incapacity benefits spending       level
#> 25 2002-03 fiscal_year Working-age incapacity benefits spending       level
#> 26 2003-04 fiscal_year Working-age incapacity benefits spending       level
#> 27 2004-05 fiscal_year Working-age incapacity benefits spending       level
#> 28 2005-06 fiscal_year Working-age incapacity benefits spending       level
#> 29 2006-07 fiscal_year Working-age incapacity benefits spending       level
#> 30 2007-08 fiscal_year Working-age incapacity benefits spending       level
#> 31 2008-09 fiscal_year Working-age incapacity benefits spending       level
#> 32 2009-10 fiscal_year Working-age incapacity benefits spending       level
#>        value unit
#> 23 1.0914588  pct
#> 24 1.0812179  pct
#> 25 1.0345429  pct
#> 26 0.9930008  pct
#> 27 0.9203422  pct
#> 28 0.8546259  pct
#> 29 0.8089978  pct
#> 30 0.8035180  pct
#> 31 0.7741892  pct
#> 32 0.7877039  pct
#> # ... with 19 more rows
options(op)
# }
```
