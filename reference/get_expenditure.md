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
#> ℹ Downloading
#>   public_finances_databank__public-finances-databank-october-2026-efo.xlsx from
#>   OBR...
#> ✔ Saved to cache.
#> # obr_tbl: 6 rows x 6 cols
#> # Source:       OBR Public Finances Databank, October 2026
#> # URL:          https://obr.uk/download/public-finances-databank-october-2026-efo/
#> # Retrieved:    2026-11-19 09:02:27 UTC
#> # File MD5:     22109612e810
#> # Package:      obr 0.6.3.9000
#> 
#>     period period_type series metric_type    value   unit
#> 81 2026-27 fiscal_year    TME       level 1449.167 gbp_bn
#> 82 2027-28 fiscal_year    TME       level 1504.005 gbp_bn
#> 83 2028-29 fiscal_year    TME       level 1548.522 gbp_bn
#> 84 2029-30 fiscal_year    TME       level 1586.965 gbp_bn
#> 85 2030-31 fiscal_year    TME       level 1638.393 gbp_bn
#> 86 2031-32 fiscal_year    TME       level 1697.659 gbp_bn
options(op)
# }
```
