# Get incapacity benefits spending by type

Downloads (and caches) the OBR Welfare Trends Report charts and tables
workbook and returns annual spending on each incapacity benefit as a
share of GDP, from 1978-79 to the current forecast horizon.

## Usage

``` r
get_incapacity_spending(refresh = FALSE)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

A data frame with columns:

- year:

  Fiscal year, e.g. `"2023-24"` (character)

- series:

  Benefit name (character)

- value:

  Spending as a percentage of GDP (numeric)

## Details

Series include: Invalidity Benefit, Incapacity Benefit, Employment and
Support Allowance (ESA), Sickness Benefit, and Severe Disablement
Allowance.

## See also

Other welfare:
[`get_incapacity_caseloads()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_caseloads.md),
[`get_welfare_spending()`](https://charlescoverdale.github.io/obr/reference/get_welfare_spending.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
ib <- get_incapacity_spending()
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
unique(ib$series)
#> [1] "Employment and support allowance (excluding assessment phase)"
#> [2] "Incapacity benefit"                                           
#> [3] "Invalidity benefit"                                           
#> [4] "Sickness benefit"                                             
#> [5] "Severe disablement allowance"                                 
#> [6] "Universal credit health (excluding assessment phase)"         
#> [7] "Income support (incapacity/sick and disabled)"                
#> [8] "Incapacity benefits (total)"                                  
options(op)
# }
```
