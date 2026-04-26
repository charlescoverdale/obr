# Get Public Sector Net Debt (PSND)

Downloads (and caches) the OBR Public Finances Databank and returns
annual Public Sector Net Debt in £ billion.

## Usage

``` r
get_psnd(refresh = FALSE)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with columns:

- year:

  Fiscal year (character, e.g. `"2024-25"`)

- psnd_bn:

  PSND in £ billion (numeric)

## See also

Other public finances:
[`get_expenditure()`](https://charlescoverdale.github.io/obr/reference/get_expenditure.md),
[`get_psnb()`](https://charlescoverdale.github.io/obr/reference/get_psnb.md),
[`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md),
[`get_receipts()`](https://charlescoverdale.github.io/obr/reference/get_receipts.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
psnd <- get_psnd()
#> Warning: Could not resolve a current Public Finances Databank URL from 1 candidate.
#> ℹ Falling back to <https://obr.uk/download/public-finances-databank/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading public_finances_databank.xlsx from OBR...
#> Error: Failed to download <https://obr.uk/download/public-finances-databank/>.
#> ✖ HTTP 504 Gateway Timeout.
tail(psnd)
#> Error: object 'psnd' not found
options(op)
# }
```
