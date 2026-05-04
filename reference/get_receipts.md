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

An `obr_tbl` with columns:

- year:

  Fiscal year (character, e.g. `"2024-25"`)

- series:

  Tax or receipt category (character)

- value:

  Value in £ billion (numeric)

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
#> Warning: Could not resolve a current Public Finances Databank URL from 1 candidate.
#> ℹ Falling back to <https://obr.uk/download/public-finances-databank/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
receipts[grepl("income tax", receipts$series, ignore.case = TRUE), ]
#> # obr_tbl: 81 rows x 3 cols
#> # Source:       OBR Public Finances Databank
#> # URL:          https://obr.uk/download/public-finances-databank/
#> # Retrieved:    2026-05-04 19:14:00 UTC
#> # File MD5:     77a07b6641ca
#> # Package:      obr 0.3.0
#> 
#>        year                             series   value
#> 379 1999-00 Pay as your earn (PAYE) income tax  80.320
#> 380 2000-01 Pay as your earn (PAYE) income tax  89.778
#> 381 2001-02 Pay as your earn (PAYE) income tax  92.128
#> 382 2002-03 Pay as your earn (PAYE) income tax  94.681
#> 383 2003-04 Pay as your earn (PAYE) income tax 100.323
#> 384 2004-05 Pay as your earn (PAYE) income tax 107.546
#> 385 2005-06 Pay as your earn (PAYE) income tax 114.908
#> 386 2006-07 Pay as your earn (PAYE) income tax 123.424
#> 387 2007-08 Pay as your earn (PAYE) income tax 131.866
#> 388 2008-09 Pay as your earn (PAYE) income tax 126.418
#> # ... with 71 more rows
options(op)
# }
```
