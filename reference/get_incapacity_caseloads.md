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

An `obr_tbl` with the standard v0.4.0 schema. The two series
(`"Claimants"` and `"Share of working age population"`) carry different
units: claimants are in thousands and the share is a percentage. After
calling, the caller may want to overwrite `unit` to `"count_k"` for the
claimants series, since the heuristic classifier cannot infer the
"thousands" denomination from the series name alone.

## See also

Other welfare:
[`get_incapacity_spending()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_spending.md),
[`get_welfare_spending()`](https://charlescoverdale.github.io/obr/reference/get_welfare_spending.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
cases <- get_incapacity_caseloads()
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Downloading welfare_trends.xlsx from OBR...
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ✔ Saved to cache.
cases[cases$series == "Claimants", ]
#> # obr_tbl: 16 rows x 6 cols
#> # Source:       OBR Welfare Trends Report, October 2024
#> # URL:          https://obr.uk/download/welfare-trends-report-october-2024-charts-and-tables/
#> # Retrieved:    2026-08-15 10:24:40 UTC
#> # File MD5:     c587017c08a1
#> # Package:      obr 0.6.1
#> 
#>     period period_type    series metric_type    value    unit
#> 1  2008-09 fiscal_year Claimants       level 2588.000 count_k
#> 2  2009-10 fiscal_year Claimants       level 2350.000 count_k
#> 3  2010-11 fiscal_year Claimants       level 2253.000 count_k
#> 4  2011-12 fiscal_year Claimants       level 2179.000 count_k
#> 5  2012-13 fiscal_year Claimants       level 1959.000 count_k
#> 6  2013-14 fiscal_year Claimants       level 1864.000 count_k
#> 7  2014-15 fiscal_year Claimants       level 1880.001 count_k
#> 8  2015-16 fiscal_year Claimants       level 2012.076 count_k
#> 9  2016-17 fiscal_year Claimants       level 2047.989 count_k
#> 10 2017-18 fiscal_year Claimants       level 2032.168 count_k
#> # ... with 6 more rows
options(op)
# }
```
