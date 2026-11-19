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

An `obr_tbl` with the standard v0.4.0 schema. `series` is `"PSND"`,
`metric_type` is `"level"`, `unit` is `"gbp_bn"`. See
[`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md)
for column definitions.

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
try({
  psnd <- get_psnd()
  tail(psnd)
})
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> # obr_tbl: 6 rows x 6 cols
#> # Source:       OBR Public Finances Databank, October 2026
#> # URL:          https://obr.uk/download/public-finances-databank-october-2026-efo/
#> # Retrieved:    2026-11-19 09:02:27 UTC
#> # File MD5:     22109612e810
#> # Package:      obr 0.6.3.9000
#> 
#>     period period_type series metric_type    value   unit
#> 53 2026-27 fiscal_year   PSND       level 3082.347 gbp_bn
#> 54 2027-28 fiscal_year   PSND       level 3239.104 gbp_bn
#> 55 2028-29 fiscal_year   PSND       level 3383.953 gbp_bn
#> 56 2029-30 fiscal_year   PSND       level 3487.198 gbp_bn
#> 57 2030-31 fiscal_year   PSND       level 3583.213 gbp_bn
#> 58 2031-32 fiscal_year   PSND       level 3694.553 gbp_bn
options(op)
# }
```
