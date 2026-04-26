# Find the OBR publication that was current on a given date

Returns the most recent EFO that had been published on or before `date`.
Useful for reproducing analyses as they would have looked at a given
point in time, before subsequent forecast revisions.

## Usage

``` r
obr_as_of(date, publication = "EFO")
```

## Arguments

- date:

  A Date, or anything coercible to one (e.g. `"2024-11-15"`).

- publication:

  Currently only `"EFO"` is supported.

## Value

A length-one character vector containing the vintage label, e.g.
`"October 2024"`.

## See also

Other vintage:
[`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md),
[`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md),
[`obr_pinned()`](https://charlescoverdale.github.io/obr/reference/obr_pinned.md),
[`obr_unpin()`](https://charlescoverdale.github.io/obr/reference/obr_unpin.md)

## Examples

``` r
obr_as_of("2024-11-15")
#> [1] "October 2024"
obr_as_of(Sys.Date())
#> [1] "March 2026"
```
