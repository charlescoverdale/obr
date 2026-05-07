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
psnd <- get_psnd()
#> Warning: Could not resolve a current Public Finances Databank URL from 1 candidate.
#> ℹ Falling back to <https://obr.uk/download/public-finances-databank/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
tail(psnd)
#> # obr_tbl: 6 rows x 6 cols
#> # Source:       OBR Public Finances Databank
#> # URL:          https://obr.uk/download/public-finances-databank/
#> # Retrieved:    2026-05-07 21:08:38 UTC
#> # File MD5:     77a07b6641ca
#> # Package:      obr 0.5.0
#> 
#>     period period_type series metric_type    value   unit
#> 47 2020-21 fiscal_year   PSND       level 2273.854 gbp_bn
#> 48 2021-22 fiscal_year   PSND       level 2478.406 gbp_bn
#> 49 2022-23 fiscal_year   PSND       level 2602.171 gbp_bn
#> 50 2023-24 fiscal_year   PSND       level 2720.901 gbp_bn
#> 51 2024-25 fiscal_year   PSND       level 2714.067 gbp_bn
#> 52 2025-26 fiscal_year   PSND       level 2816.625 gbp_bn
options(op)
# }
```
