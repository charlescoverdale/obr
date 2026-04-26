# Clear the pinned OBR EFO vintage

Removes any pin set by
[`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md).
After unpinning,
[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)
and
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md)
revert to resolving the most recent live EFO via the dynamic URL
resolver.

## Usage

``` r
obr_unpin()
```

## Value

Invisibly returns the previously pinned vintage (or `NULL` if no pin was
set).

## See also

Other vintage:
[`obr_as_of()`](https://charlescoverdale.github.io/obr/reference/obr_as_of.md),
[`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md),
[`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md),
[`obr_pinned()`](https://charlescoverdale.github.io/obr/reference/obr_pinned.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
obr_pin("March 2025")
#> ✔ Pinned EFO to "March 2025".
obr_unpin()
#> ✔ Unpinned EFO (was "March 2025").
options(op)
# }
```
