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

A data frame with columns:

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
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
tail(psnd)
#>       year  psnd_bn
#> 47 2020-21 2273.854
#> 48 2021-22 2478.406
#> 49 2022-23 2602.171
#> 50 2023-24 2720.901
#> 51 2024-25 2714.067
#> 52 2025-26 2816.625
options(op)
# }
```
