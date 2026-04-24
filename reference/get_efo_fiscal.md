# Get EFO fiscal projections (net borrowing components)

Downloads (and caches) the OBR *Economic and Fiscal Outlook* Detailed
Forecast Tables — Aggregates file and returns the components of net
borrowing (Table 6.5) in tidy long format.

## Usage

``` r
get_efo_fiscal(refresh = FALSE)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

A data frame with columns:

- fiscal_year:

  Fiscal year being forecast, e.g. `"2025-26"` (character)

- series:

  Component name, e.g. `"Net borrowing"` (character)

- value_bn:

  Projected value in £ billion (numeric)

## Details

Covers the five-year forecast horizon published at the most recent
Budget (OBR, March 2026). Key series include current receipts, current
expenditure, depreciation, net investment, and net borrowing (PSNB).

## See also

Other EFO:
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md),
[`list_efo_economy_measures()`](https://charlescoverdale.github.io/obr/reference/list_efo_economy_measures.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
efo <- get_efo_fiscal()
#> ℹ Downloading efo_aggregates.xlsx from OBR...
#> ✔ Saved to cache.
efo[efo$series == "Net borrowing", ]
#>    fiscal_year        series  value_bn
#> 43     2025-26 Net borrowing 132.73508
#> 44     2026-27 Net borrowing 115.46142
#> 45     2027-28 Net borrowing  96.46737
#> 46     2028-29 Net borrowing  86.01563
#> 47     2029-30 Net borrowing  63.40344
#> 48     2030-31 Net borrowing  59.01991
options(op)
# }
```
