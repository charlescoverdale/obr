# Pin a session-wide OBR EFO vintage

Sets the EFO vintage that
[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)
and
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md)
will use when called without an explicit `vintage =` argument. The pin
is stored as the option `obr.efo_vintage` and lasts for the R session
unless overwritten or removed via
[`obr_unpin()`](https://charlescoverdale.github.io/obr/reference/obr_unpin.md).

## Usage

``` r
obr_pin(vintage = NULL)
```

## Arguments

- vintage:

  Vintage label such as `"October 2024"`. See
  [`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md)
  for the full list. If `NULL`, this function clears the pin (equivalent
  to calling
  [`obr_unpin()`](https://charlescoverdale.github.io/obr/reference/obr_unpin.md)).

## Value

Invisibly returns the pinned vintage string, or `NULL` after clearing.

## See also

Other vintage:
[`obr_as_of()`](https://charlescoverdale.github.io/obr/reference/obr_as_of.md),
[`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md),
[`obr_pinned()`](https://charlescoverdale.github.io/obr/reference/obr_pinned.md),
[`obr_unpin()`](https://charlescoverdale.github.io/obr/reference/obr_unpin.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
obr_pin("October 2024")
#> ✔ Pinned EFO to "October 2024".
obr_pinned()
#> [1] "October 2024"
obr_unpin()
#> ✔ Unpinned EFO (was "October 2024").
options(op)
# }
```
