# Get Total Managed Expenditure

Downloads (and caches) the OBR Public Finances Databank and returns
annual Total Managed Expenditure (TME) in £ billion. TME is the broadest
measure of UK government spending.

## Usage

``` r
get_expenditure(refresh = FALSE)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with columns:

- year:

  Fiscal year (character, e.g. `"2024-25"`)

- tme_bn:

  Total managed expenditure in £ billion (numeric)

## See also

Other public finances:
[`get_psnb()`](https://charlescoverdale.github.io/obr/reference/get_psnb.md),
[`get_psnd()`](https://charlescoverdale.github.io/obr/reference/get_psnd.md),
[`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md),
[`get_receipts()`](https://charlescoverdale.github.io/obr/reference/get_receipts.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
tme <- get_expenditure()
#> ℹ Downloading public_finances_databank.xlsx from OBR...
#> Error: Failed to download <https://obr.uk/download/public-finances-databank/>.
#> ✖ HTTP 504 Gateway Timeout.
tail(tme)
#> Error: object 'tme' not found
options(op)
# }
```
