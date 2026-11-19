# Get public sector receipts by tax type

Downloads (and caches) the OBR Public Finances Databank and returns
public sector current receipts broken down by individual tax type, in
tidy long format. Coverage begins in 1999-00.

## Usage

``` r
get_receipts(refresh = FALSE)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with the standard v0.4.0 schema (columns: `period`,
`period_type`, `series`, `metric_type`, `value`, `unit`). `series` is
the tax or receipt category, `metric_type` is `"level"`, `unit` is
`"gbp_bn"`. See
[`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md)
for full column docs.

## See also

Other public finances:
[`get_expenditure()`](https://charlescoverdale.github.io/obr/reference/get_expenditure.md),
[`get_psnb()`](https://charlescoverdale.github.io/obr/reference/get_psnb.md),
[`get_psnd()`](https://charlescoverdale.github.io/obr/reference/get_psnd.md),
[`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
try({
  receipts <- get_receipts()
  receipts[grepl("income tax", receipts$series, ignore.case = TRUE), ]
})
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> # obr_tbl: 99 rows x 6 cols
#> # Source:       OBR Public Finances Databank, October 2026
#> # URL:          https://obr.uk/download/public-finances-databank-october-2026-efo/
#> # Retrieved:    2026-11-19 09:02:27 UTC
#> # File MD5:     22109612e810
#> # Package:      obr 0.6.3.9000
#> 
#>      period period_type                             series metric_type   value
#> 463 1999-00 fiscal_year Pay as your earn (PAYE) income tax       level  80.320
#> 464 2000-01 fiscal_year Pay as your earn (PAYE) income tax       level  89.778
#> 465 2001-02 fiscal_year Pay as your earn (PAYE) income tax       level  92.128
#> 466 2002-03 fiscal_year Pay as your earn (PAYE) income tax       level  94.681
#> 467 2003-04 fiscal_year Pay as your earn (PAYE) income tax       level 100.323
#> 468 2004-05 fiscal_year Pay as your earn (PAYE) income tax       level 107.546
#> 469 2005-06 fiscal_year Pay as your earn (PAYE) income tax       level 114.908
#> 470 2006-07 fiscal_year Pay as your earn (PAYE) income tax       level 123.424
#> 471 2007-08 fiscal_year Pay as your earn (PAYE) income tax       level 131.866
#> 472 2008-09 fiscal_year Pay as your earn (PAYE) income tax       level 126.418
#>       unit
#> 463 gbp_bn
#> 464 gbp_bn
#> 465 gbp_bn
#> 466 gbp_bn
#> 467 gbp_bn
#> 468 gbp_bn
#> 469 gbp_bn
#> 470 gbp_bn
#> 471 gbp_bn
#> 472 gbp_bn
#> # ... with 89 more rows
options(op)
# }
```
