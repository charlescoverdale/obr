# Show the currently pinned OBR EFO vintage

Returns the vintage string currently active via
[`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md),
or `NULL` if no pin is set.

## Usage

``` r
obr_pinned()
```

## Value

Either a length-one character vector or `NULL`.

## See also

Other vintage:
[`obr_as_of()`](https://charlescoverdale.github.io/obr/reference/obr_as_of.md),
[`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md),
[`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md),
[`obr_unpin()`](https://charlescoverdale.github.io/obr/reference/obr_unpin.md)

## Examples

``` r
obr_pinned()
#> NULL
```
