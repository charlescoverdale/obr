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

A data frame with columns:

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
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
tail(psnb)
#>       year   psnb_bn
#> 75 2020-21 393.54689
#> 76 2021-22 164.22802
#> 77 2022-23 104.59795
#> 78 2023-24 100.39440
#> 79 2024-25  99.57407
#> 80 2025-26 101.83223
options(op)
# }
```
