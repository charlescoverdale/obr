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

A data frame with columns:

- year:

  Fiscal year (character, e.g. `"2024-25"`)

- tme_bn:

  Total managed expenditure in £ billion (numeric)

## Examples

``` r
# \donttest{
tme <- get_expenditure()
#> ℹ Downloading public_finances_databank.xlsx from OBR...
#> ✔ Saved to cache.
tail(tme)
#>       year    tme_bn
#> 75 2020-21 1164.5793
#> 76 2021-22 1011.4941
#> 77 2022-23  990.4851
#> 78 2023-24 1027.3872
#> 79 2024-25 1063.9669
#> 80 2025-26 1106.0997
# }
```
