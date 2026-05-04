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
#> ✔ Saved to cache.
tail(tme)
#> # obr_tbl: 6 rows x 2 cols
#> # Source:       OBR Public Finances Databank
#> # URL:          https://obr.uk/download/public-finances-databank/
#> # Retrieved:    2026-05-04 19:14:00 UTC
#> # File MD5:     77a07b6641ca
#> # Package:      obr 0.3.0
#> 
#>       year    tme_bn
#> 75 2020-21 1164.5793
#> 76 2021-22 1011.4941
#> 77 2022-23  990.4851
#> 78 2023-24 1027.3872
#> 79 2024-25 1063.9669
#> 80 2025-26 1106.0997
options(op)
# }
```
