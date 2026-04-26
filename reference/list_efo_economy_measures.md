# List available EFO economy measures

Returns a data frame of the economy measures available via
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md),
showing the `measure` name to pass and a short description of what each
covers.

## Usage

``` r
list_efo_economy_measures()
```

## Value

A data frame with columns `measure`, `sheet`, and `description`.

## See also

Other EFO:
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md),
[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)

## Examples

``` r
list_efo_economy_measures()
#>      measure sheet
#> 1     labour   1.6
#> 2  inflation   1.7
#> 3 output_gap  1.14
#>                                                                      description
#> 1 Labour market: employment, unemployment rate, participation rate, hours worked
#> 2                         Inflation: CPI, CPIH, RPI, RPIX, mortgage rates, rents
#> 3                 OBR central estimate of the output gap (% of potential output)
```
