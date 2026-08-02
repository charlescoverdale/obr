# Get all Public Finances Databank aggregates

Downloads (and caches) the OBR Public Finances Databank and returns all
aggregate fiscal series in tidy long format. Covers outturn from 1946-47
and OBR projections through the current forecast horizon.

## Usage

``` r
get_public_finances(refresh = FALSE)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` (a `data.frame` with attached provenance) with the standard
v0.4.0 schema (columns: `period`, `period_type`, `series`,
`metric_type`, `value`, `unit`):

- period:

  Fiscal year (character, e.g. `"2024-25"`)

- period_type:

  Always `"fiscal_year"` for this function

- series:

  Series name (character)

- metric_type:

  Usually `"level"`; ratio or index series get a more specific value
  derived from the series name

- value:

  Numeric value in units described by `unit`

- unit:

  Usually `"gbp_bn"`; ratios and indices override

Use
[`obr_provenance()`](https://charlescoverdale.github.io/obr/reference/obr_provenance.md)
to extract source URL, vintage, and retrieval time.

## Details

Series include: Public sector net borrowing, Public sector net debt,
Total managed expenditure, Public sector current receipts, Nominal GDP,
GDP deflator, and more.

## See also

Other public finances:
[`get_expenditure()`](https://charlescoverdale.github.io/obr/reference/get_expenditure.md),
[`get_psnb()`](https://charlescoverdale.github.io/obr/reference/get_psnb.md),
[`get_psnd()`](https://charlescoverdale.github.io/obr/reference/get_psnd.md),
[`get_receipts()`](https://charlescoverdale.github.io/obr/reference/get_receipts.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
pf <- get_public_finances()
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■             
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Warning: Could not resolve a current Public Finances Databank URL from 1 candidate.
#> ℹ Falling back to <https://obr.uk/download/public-finances-databank/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading public_finances_databank.xlsx from OBR...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■              
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■                          
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■               
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■   
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download <https://obr.uk/download/public-finances-databank/>.
#> ✖ HTTP 403 Forbidden.
unique(pf$series)
#> Error in pf$series: object of type 'closure' is not subsettable
obr_provenance(pf)
#> NULL
options(op)
# }
```
