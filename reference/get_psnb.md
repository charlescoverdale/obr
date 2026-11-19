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

An `obr_tbl` with the standard v0.4.0 schema. `series` is `"PSNB"`,
`metric_type` is `"level"`, `unit` is `"gbp_bn"`. See
[`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md)
for column definitions.

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
try({
  psnb <- get_psnb()
  tail(psnb)
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
#>     period period_type series metric_type     value   unit
#> 81 2026-27 fiscal_year   PSNB       level 133.19601 gbp_bn
#> 82 2027-28 fiscal_year   PSNB       level 111.98047 gbp_bn
#> 83 2028-29 fiscal_year   PSNB       level  99.53613 gbp_bn
#> 84 2029-30 fiscal_year   PSNB       level  73.78046 gbp_bn
#> 85 2030-31 fiscal_year   PSNB       level  66.90011 gbp_bn
#> 86 2031-32 fiscal_year   PSNB       level  68.33916 gbp_bn
options(op)
# }
```
