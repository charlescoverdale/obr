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
receipts <- get_receipts()
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
receipts[grepl("income tax", receipts$series, ignore.case = TRUE), ]
#> # obr_tbl: 81 rows x 6 cols
#> # Source:       OBR Public Finances Databank
#> # URL:          https://obr.uk/download/public-finances-databank/
#> # Retrieved:    2026-08-15 10:23:55 UTC
#> # File MD5:     77a07b6641ca
#> # Package:      obr 0.6.1
#> 
#>      period period_type                             series metric_type   value
#> 379 1999-00 fiscal_year Pay as your earn (PAYE) income tax       level  80.320
#> 380 2000-01 fiscal_year Pay as your earn (PAYE) income tax       level  89.778
#> 381 2001-02 fiscal_year Pay as your earn (PAYE) income tax       level  92.128
#> 382 2002-03 fiscal_year Pay as your earn (PAYE) income tax       level  94.681
#> 383 2003-04 fiscal_year Pay as your earn (PAYE) income tax       level 100.323
#> 384 2004-05 fiscal_year Pay as your earn (PAYE) income tax       level 107.546
#> 385 2005-06 fiscal_year Pay as your earn (PAYE) income tax       level 114.908
#> 386 2006-07 fiscal_year Pay as your earn (PAYE) income tax       level 123.424
#> 387 2007-08 fiscal_year Pay as your earn (PAYE) income tax       level 131.866
#> 388 2008-09 fiscal_year Pay as your earn (PAYE) income tax       level 126.418
#>       unit
#> 379 gbp_bn
#> 380 gbp_bn
#> 381 gbp_bn
#> 382 gbp_bn
#> 383 gbp_bn
#> 384 gbp_bn
#> 385 gbp_bn
#> 386 gbp_bn
#> 387 gbp_bn
#> 388 gbp_bn
#> # ... with 71 more rows
options(op)
# }
```
