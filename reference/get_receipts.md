# Get public sector receipts by tax type

Downloads (and caches) the OBR Public Finances Databank and returns
public sector current receipts broken down by individual tax type, in
tidy long format. Coverage begins in 1999-00.

## Usage

``` r
get_receipts(refresh = FALSE)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with the standard v0.4.0 schema (columns: `period`,
`period_type`, `series`, `metric_type`, `value`, `unit`). `series` is
the tax or receipt category, `metric_type` is `"level"`, `unit` is
`"gbp_bn"`. See
[`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md)
for full column docs.

## See also

Other public finances:
[`get_expenditure()`](https://charlescoverdale.github.io/obr/reference/get_expenditure.md),
[`get_psnb()`](https://charlescoverdale.github.io/obr/reference/get_psnb.md),
[`get_psnd()`](https://charlescoverdale.github.io/obr/reference/get_psnd.md),
[`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
receipts <- get_receipts()
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Warning: Could not resolve a current Public Finances Databank URL from 1 candidate.
#> ℹ Falling back to <https://obr.uk/download/public-finances-databank/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading public_finances_databank.xlsx from OBR...
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■■■■                       
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■            
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download <https://obr.uk/download/public-finances-databank/>.
#> ✖ HTTP 403 Forbidden.
receipts[grepl("income tax", receipts$series, ignore.case = TRUE), ]
#> Error: object 'receipts' not found
options(op)
# }
```
