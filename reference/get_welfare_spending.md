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

Data cover fiscal years from 1978-79 to 2028-29, from the October 2024
Welfare Trends Report, the OBR's most recent report on incapacity
benefits. Later reports cover other themes and do not update this chart.

## See also

Other welfare:
[`get_incapacity_caseloads()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_caseloads.md),
[`get_incapacity_spending()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_spending.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
try({
  welfare <- get_welfare_spending()
  welfare[welfare$series == "Working-age incapacity benefits spending" &
  welfare$period >= "2000-01", ]
})
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Warning: Could not resolve a current Welfare Trends Report (October 2024) URL from 1
#> candidate.
#> ℹ Falling back to
#>   <https://obr.uk/download/welfare-trends-report-october-2024-charts-and-tables/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading
#>   welfare_trends_october_2024__welfare-trends-report-october-2024-charts-and-tables.xlsx
#>   from OBR...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Error : Failed to download
#> <https://obr.uk/download/welfare-trends-report-october-2024-charts-and-tables/>.
#> ✖ HTTP 403 Forbidden.
options(op)
# }
```
