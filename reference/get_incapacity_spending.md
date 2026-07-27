# Get incapacity benefits spending by type

Downloads (and caches) the OBR Welfare Trends Report charts and tables
workbook and returns annual spending on each incapacity benefit as a
share of GDP, from 1978-79 to the current forecast horizon.

## Usage

``` r
get_incapacity_spending(refresh = FALSE)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with the standard v0.4.0 schema. `series` is the benefit
name, values are spending as a percentage of GDP, `metric_type` is
`"pct"`, `unit` is `"pct"`. See
[`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md)
for full column docs.

## Details

Series include: Invalidity Benefit, Incapacity Benefit, Employment and
Support Allowance (ESA), Sickness Benefit, and Severe Disablement
Allowance.

## See also

Other welfare:
[`get_incapacity_caseloads()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_caseloads.md),
[`get_welfare_spending()`](https://charlescoverdale.github.io/obr/reference/get_welfare_spending.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
ib <- get_incapacity_spending()
#> Warning: Could not resolve a current Welfare Trends Report URL from 9 candidates.
#> ℹ Falling back to
#>   <https://obr.uk/download/welfare-trends-report-october-2024-charts-and-tables/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading welfare_trends.xlsx from OBR...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■                     
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■                            
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■                   
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■        
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download
#> <https://obr.uk/download/welfare-trends-report-october-2024-charts-and-tables/>.
#> ✖ HTTP 403 Forbidden.
unique(ib$series)
#> Error: object 'ib' not found
options(op)
# }
```
