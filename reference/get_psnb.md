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
#> # Source:       OBR Public Finances Databank
#> # URL:          https://obr.uk/download/public-finances-databank/
#> # Retrieved:    2026-08-23 17:35:45 UTC
#> # File MD5:     77a07b6641ca
#> # Package:      obr 0.6.2
#> 
#>     period period_type series metric_type     value   unit
#> 75 2020-21 fiscal_year   PSNB       level 393.54689 gbp_bn
#> 76 2021-22 fiscal_year   PSNB       level 164.22802 gbp_bn
#> 77 2022-23 fiscal_year   PSNB       level 104.59795 gbp_bn
#> 78 2023-24 fiscal_year   PSNB       level 100.39440 gbp_bn
#> 79 2024-25 fiscal_year   PSNB       level  99.57407 gbp_bn
#> 80 2025-26 fiscal_year   PSNB       level 101.83223 gbp_bn
options(op)
# }
```
