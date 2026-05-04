# Get EFO fiscal projections (net borrowing components)

Downloads (and caches) the OBR *Economic and Fiscal Outlook* Detailed
Forecast Tables - Aggregates file and returns the components of net
borrowing (Table 6.5) in tidy long format.

## Usage

``` r
get_efo_fiscal(refresh = FALSE, vintage = NULL)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

- vintage:

  Optional EFO vintage label such as `"October 2024"`. If supplied, the
  function downloads the file for that specific EFO. If `NULL` (the
  default), the function uses any vintage set via
  [`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md),
  or falls back to the latest live EFO via the dynamic URL resolver. See
  [`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md)
  for the full list of supported vintages.

## Value

An `obr_tbl` with columns:

- fiscal_year:

  Fiscal year being forecast, e.g. `"2025-26"` (character)

- series:

  Component name, e.g. `"Net borrowing"` (character)

- value_bn:

  Projected value in £ billion (numeric)

## Details

Covers the five-year forecast horizon published at the most recent
fiscal event. Key series include current receipts, current expenditure,
depreciation, net investment, and net borrowing (PSNB). The exact
vintage is recorded in the returned object's provenance attribute and
visible in the printed header.

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
#> # obr_tbl: 6 rows x 3 cols
#> # Source:       OBR Economic and Fiscal Outlook, March 2026
#> # URL:          https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> # Retrieved:    2026-05-04 19:13:59 UTC
#> # File MD5:     43d7526594ab
#> # Package:      obr 0.3.0
#> 
#>    fiscal_year        series  value_bn
#> 43     2025-26 Net borrowing 132.73508
#> 44     2026-27 Net borrowing 115.46142
#> 45     2027-28 Net borrowing  96.46737
#> 46     2028-29 Net borrowing  86.01563
#> 47     2029-30 Net borrowing  63.40344
#> 48     2030-31 Net borrowing  59.01991
obr_provenance(efo)$vintage
#> [1] "March 2026"

# Pin to a specific EFO for reproducibility
october_2024 <- get_efo_fiscal(vintage = "October 2024")
#> ℹ Downloading efo_aggregates_october_2024.xlsx from OBR...
#> ✔ Saved to cache.
options(op)
# }
```
