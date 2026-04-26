# List known OBR Economic and Fiscal Outlook vintages

Returns a data frame of every EFO published since the OBR was created in
June 2010, with publication dates and the URL slug used in the OBR's
download links. Use this to look up which vintages can be pinned via
[`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md)
or passed to `vintage =` arguments on
[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)
and
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md).

## Usage

``` r
obr_efo_vintages()
```

## Value

A data frame with columns:

- publication:

  Always `"EFO"`.

- vintage:

  Vintage label, e.g. `"March 2026"`.

- date:

  Publication date of the EFO (Date).

- slug:

  URL slug used by the OBR for that vintage's download pages.

## See also

Other vintage:
[`obr_as_of()`](https://charlescoverdale.github.io/obr/reference/obr_as_of.md),
[`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md),
[`obr_pinned()`](https://charlescoverdale.github.io/obr/reference/obr_pinned.md),
[`obr_unpin()`](https://charlescoverdale.github.io/obr/reference/obr_unpin.md)

## Examples

``` r
head(obr_efo_vintages())
#>   publication       vintage       date
#> 1         EFO     June 2010 2010-06-22
#> 2         EFO November 2010 2010-11-29
#> 3         EFO    March 2011 2011-03-23
#> 4         EFO November 2011 2011-11-29
#> 5         EFO    March 2012 2012-03-21
#> 6         EFO December 2012 2012-12-05
#>                                        slug
#> 1     june-2010-economic-and-fiscal-outlook
#> 2 november-2010-economic-and-fiscal-outlook
#> 3    march-2011-economic-and-fiscal-outlook
#> 4 november-2011-economic-and-fiscal-outlook
#> 5    march-2012-economic-and-fiscal-outlook
#> 6 december-2012-economic-and-fiscal-outlook
tail(obr_efo_vintages(), 5)
#>    publication       vintage       date
#> 29         EFO    March 2024 2024-03-06
#> 30         EFO  October 2024 2024-10-30
#> 31         EFO    March 2025 2025-03-26
#> 32         EFO November 2025 2025-11-26
#> 33         EFO    March 2026 2026-03-26
#>                                         slug
#> 29    march-2024-economic-and-fiscal-outlook
#> 30  october-2024-economic-and-fiscal-outlook
#> 31    march-2025-economic-and-fiscal-outlook
#> 32 november-2025-economic-and-fiscal-outlook
#> 33    march-2026-economic-and-fiscal-outlook
```
