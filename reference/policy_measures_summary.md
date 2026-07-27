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
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■     
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■■■■■                      
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download
#> <https://obr.uk/download/policy-measures-database-march-2025/>.
#> ✖ HTTP 403 Forbidden.
policy_measures_summary(pm)
#> Error: object 'pm' not found
options(op)
# }
```
