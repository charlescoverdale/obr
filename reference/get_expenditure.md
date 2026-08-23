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

An `obr_tbl` with the standard v0.4.0 schema. `series` is `"TME"`,
`metric_type` is `"level"`, `unit` is `"gbp_bn"`. See
[`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md)
for column definitions.

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
try({
  tme <- get_expenditure()
  tail(tme)
})
#> ℹ Downloading public_finances_databank.xlsx from OBR...
#> ✔ Saved to cache.
#> # obr_tbl: 6 rows x 6 cols
#> # Source:       OBR Public Finances Databank
#> # URL:          https://obr.uk/download/public-finances-databank/
#> # Retrieved:    2026-08-23 18:05:03 UTC
#> # File MD5:     77a07b6641ca
#> # Package:      obr 0.6.2
#> 
#>     period period_type series metric_type     value   unit
#> 75 2020-21 fiscal_year    TME       level 1164.5793 gbp_bn
#> 76 2021-22 fiscal_year    TME       level 1011.4941 gbp_bn
#> 77 2022-23 fiscal_year    TME       level  990.4851 gbp_bn
#> 78 2023-24 fiscal_year    TME       level 1027.3872 gbp_bn
#> 79 2024-25 fiscal_year    TME       level 1063.9669 gbp_bn
#> 80 2025-26 fiscal_year    TME       level 1106.0997 gbp_bn
options(op)
# }
```
