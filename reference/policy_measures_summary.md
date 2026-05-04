# Summarise policy measures by fiscal event

Aggregates the measures returned by
[`get_policy_measures()`](https://charlescoverdale.github.io/obr/reference/get_policy_measures.md)
to give the net Exchequer effect (positive = revenue-raising /
spending-reducing for tax, spending-increasing for spending) by fiscal
event and fiscal year.

## Usage

``` r
policy_measures_summary(x)
```

## Arguments

- x:

  An `obr_tbl` returned by
  [`get_policy_measures()`](https://charlescoverdale.github.io/obr/reference/get_policy_measures.md).

## Value

An `obr_tbl` with columns:

- type:

  `"tax"` or `"spending"`

- event:

  Fiscal event

- fiscal_year:

  Fiscal year

- value_mn:

  Sum of the Exchequer effect across all measures scored at that event,
  in GBP million

Provenance is preserved.

## See also

Other policy measures:
[`get_policy_measures()`](https://charlescoverdale.github.io/obr/reference/get_policy_measures.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
pm <- get_policy_measures(type = "tax", since = "2024-25")
#> Warning: Could not resolve a current Policy Measures Database URL from 16 candidates.
#> ℹ Falling back to
#>   <https://obr.uk/download/policy-measures-database-march-2025/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading policy_measures_database.xlsx from OBR...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■         
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■■■                        
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■             
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> ✔ Saved to cache.
policy_measures_summary(pm)
#> # obr_tbl: 593 rows x 4 cols
#> # Source:       OBR Policy Measures Database, March 2025
#> # URL:          https://obr.uk/download/policy-measures-database-march-2025/
#> # Retrieved:    2026-05-04 19:15:09 UTC
#> # File MD5:     a76d78e7a14d
#> # Package:      obr 0.3.0
#> # Note:         Summed across measures by event and fiscal year.
#> 
#>    type       event fiscal_year   value_mn
#> 1   tax Autumn 2010     2024-25 1132.04747
#> 2   tax Autumn 2010     2025-26 1178.59655
#> 3   tax Autumn 2010     2026-27 1220.80995
#> 4   tax Autumn 2010     2027-28 1264.38398
#> 5   tax Autumn 2010     2028-29 1308.29845
#> 6   tax Autumn 2010     2029-30 1352.99870
#> 7   tax Autumn 2010     2030-31 1401.28704
#> 8   tax Autumn 2011     2024-25   21.71078
#> 9   tax Autumn 2011     2025-26   22.60351
#> 10  tax Autumn 2011     2026-27   23.41310
#> # ... with 583 more rows
options(op)
# }
```
