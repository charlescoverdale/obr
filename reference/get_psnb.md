# Get Public Sector Net Borrowing (PSNB)

Downloads (and caches) the OBR Public Finances Databank and returns
annual Public Sector Net Borrowing in £ billion. A positive value means
the government is borrowing (deficit); a negative value means a surplus.

## Usage

``` r
get_psnb(refresh = FALSE)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with columns:

- year:

  Fiscal year (character, e.g. `"2024-25"`)

- psnb_bn:

  PSNB in £ billion (numeric)

## See also

Other public finances:
[`get_expenditure()`](https://charlescoverdale.github.io/obr/reference/get_expenditure.md),
[`get_psnd()`](https://charlescoverdale.github.io/obr/reference/get_psnd.md),
[`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md),
[`get_receipts()`](https://charlescoverdale.github.io/obr/reference/get_receipts.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
psnb <- get_psnb()
#> Warning: Could not resolve a current Public Finances Databank URL from 1 candidate.
#> ℹ Falling back to <https://obr.uk/download/public-finances-databank/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading public_finances_databank.xlsx from OBR...
#> Error: Failed to download <https://obr.uk/download/public-finances-databank/>.
#> ✖ HTTP 504 Gateway Timeout.
tail(psnb)
#> Error: object 'psnb' not found
options(op)
# }
```
