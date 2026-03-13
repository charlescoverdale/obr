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

A data frame with columns:

- year:

  Fiscal year (character, e.g. `"2024-25"`)

- series:

  Tax or receipt category (character)

- value:

  Value in £ billion (numeric)

## Examples

``` r
# \donttest{
receipts <- get_receipts()
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
# Filter to income tax
receipts[grepl("income tax", receipts$series, ignore.case = TRUE), ]
#>        year                             series      value
#> 379 1999-00 Pay as your earn (PAYE) income tax  80.320000
#> 380 2000-01 Pay as your earn (PAYE) income tax  89.778000
#> 381 2001-02 Pay as your earn (PAYE) income tax  92.128000
#> 382 2002-03 Pay as your earn (PAYE) income tax  94.681000
#> 383 2003-04 Pay as your earn (PAYE) income tax 100.323000
#> 384 2004-05 Pay as your earn (PAYE) income tax 107.546000
#> 385 2005-06 Pay as your earn (PAYE) income tax 114.908000
#> 386 2006-07 Pay as your earn (PAYE) income tax 123.424000
#> 387 2007-08 Pay as your earn (PAYE) income tax 131.866000
#> 388 2008-09 Pay as your earn (PAYE) income tax 126.418000
#> 389 2009-10 Pay as your earn (PAYE) income tax 125.349000
#> 390 2010-11 Pay as your earn (PAYE) income tax 132.006000
#> 391 2011-12 Pay as your earn (PAYE) income tax 133.915000
#> 392 2012-13 Pay as your earn (PAYE) income tax 132.559000
#> 393 2013-14 Pay as your earn (PAYE) income tax 135.481000
#> 394 2014-15 Pay as your earn (PAYE) income tax 140.001000
#> 395 2015-16 Pay as your earn (PAYE) income tax 146.159000
#> 396 2016-17 Pay as your earn (PAYE) income tax 149.735000
#> 397 2017-18 Pay as your earn (PAYE) income tax 154.926000
#> 398 2018-19 Pay as your earn (PAYE) income tax 163.470000
#> 399 2019-20 Pay as your earn (PAYE) income tax 165.223000
#> 400 2020-21 Pay as your earn (PAYE) income tax 166.884537
#> 401 2021-22 Pay as your earn (PAYE) income tax 170.189243
#> 402 2022-23 Pay as your earn (PAYE) income tax 177.465185
#> 403 2023-24 Pay as your earn (PAYE) income tax 185.287363
#> 404 2024-25 Pay as your earn (PAYE) income tax 194.367668
#> 405 2025-26 Pay as your earn (PAYE) income tax 204.673169
#> 406 1999-00      Self assessed (SA) income tax  14.432000
#> 407 2000-01      Self assessed (SA) income tax  15.273000
#> 408 2001-02      Self assessed (SA) income tax  15.281000
#> 409 2002-03      Self assessed (SA) income tax  16.060000
#> 410 2003-04      Self assessed (SA) income tax  15.773000
#> 411 2004-05      Self assessed (SA) income tax  17.141000
#> 412 2005-06      Self assessed (SA) income tax  18.077000
#> 413 2006-07      Self assessed (SA) income tax  20.306000
#> 414 2007-08      Self assessed (SA) income tax  22.443000
#> 415 2008-09      Self assessed (SA) income tax  22.532000
#> 416 2009-10      Self assessed (SA) income tax  21.707000
#> 417 2010-11      Self assessed (SA) income tax  22.107000
#> 418 2011-12      Self assessed (SA) income tax  20.333000
#> 419 2012-13      Self assessed (SA) income tax  20.551000
#> 420 2013-14      Self assessed (SA) income tax  20.854000
#> 421 2014-15      Self assessed (SA) income tax  23.644000
#> 422 2015-16      Self assessed (SA) income tax  24.328000
#> 423 2016-17      Self assessed (SA) income tax  28.547000
#> 424 2017-18      Self assessed (SA) income tax  28.295000
#> 425 2018-19      Self assessed (SA) income tax  31.518000
#> 426 2019-20      Self assessed (SA) income tax  32.186000
#> 427 2020-21      Self assessed (SA) income tax  24.732535
#> 428 2021-22      Self assessed (SA) income tax  36.190835
#> 429 2022-23      Self assessed (SA) income tax  30.632842
#> 430 2023-24      Self assessed (SA) income tax  32.932438
#> 431 2024-25      Self assessed (SA) income tax  34.673715
#> 432 2025-26      Self assessed (SA) income tax  36.356173
#> 433 1999-00                   Other income tax   1.938000
#> 434 2000-01                   Other income tax   2.037000
#> 435 2001-02                   Other income tax   1.231000
#> 436 2002-03                   Other income tax   0.036000
#> 437 2003-04                   Other income tax   0.825000
#> 438 2004-05                   Other income tax   1.749000
#> 439 2005-06                   Other income tax   3.090000
#> 440 2006-07                   Other income tax   2.783000
#> 441 2007-08                   Other income tax   2.784000
#> 442 2008-09                   Other income tax   1.890000
#> 443 2009-10                   Other income tax   0.091000
#> 444 2010-11                   Other income tax  -0.867000
#> 445 2011-12                   Other income tax  -1.545000
#> 446 2012-13                   Other income tax  -0.819000
#> 447 2013-14                   Other income tax   1.281000
#> 448 2014-15                   Other income tax  -0.025000
#> 449 2015-16                   Other income tax  -1.613000
#> 450 2016-17                   Other income tax  -1.034000
#> 451 2017-18                   Other income tax  -2.629000
#> 452 2018-19                   Other income tax  -2.462000
#> 453 2019-20                   Other income tax  -3.805000
#> 454 2020-21                   Other income tax  -3.381573
#> 455 2021-22                   Other income tax  -2.817889
#> 456 2022-23                   Other income tax  -3.059341
#> 457 2023-24                   Other income tax  -3.209168
#> 458 2024-25                   Other income tax  -3.387269
#> 459 2025-26                   Other income tax  -3.556914
# }
```
