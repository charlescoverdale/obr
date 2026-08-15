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

An `obr_tbl` with the standard v0.4.0 schema (columns: `period`,
`period_type`, `series`, `metric_type`, `value`, `unit`):

- period:

  Fiscal year being forecast, e.g. `"2025-26"` (character)

- period_type:

  Always `"fiscal_year"` for this function (character)

- series:

  Component name, e.g. `"Net borrowing"` (character)

- metric_type:

  Always `"level"` for this function (character)

- value:

  Projected value (numeric)

- unit:

  Always `"gbp_bn"` for this function (character)

## Details

Covers the five-year forecast horizon published at the most recent
fiscal event. Key series include current receipts, current expenditure,
depreciation, net investment, and net borrowing (PSNB). The exact
vintage is recorded in the returned object's provenance attribute and
visible in the printed header.

## See also

Other EFO:
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md),
[`get_efo_table()`](https://charlescoverdale.github.io/obr/reference/get_efo_table.md),
[`get_monthly_profiles()`](https://charlescoverdale.github.io/obr/reference/get_monthly_profiles.md),
[`list_efo_economy_measures()`](https://charlescoverdale.github.io/obr/reference/list_efo_economy_measures.md),
[`obr_efo_catalogue()`](https://charlescoverdale.github.io/obr/reference/obr_efo_catalogue.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
efo <- get_efo_fiscal()
#> ℹ Downloading efo_aggregates.xlsx from OBR...
#> ✔ Saved to cache.
efo[efo$series == "Net borrowing", ]
#> # obr_tbl: 6 rows x 6 cols
#> # Source:       OBR Economic and Fiscal Outlook, March 2026
#> # URL:          https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> # Retrieved:    2026-08-15 10:23:52 UTC
#> # File MD5:     5b5eeaf79b96
#> # Package:      obr 0.6.1
#> 
#>     period period_type        series metric_type     value   unit
#> 43 2025-26 fiscal_year Net borrowing       level 132.73508 gbp_bn
#> 44 2026-27 fiscal_year Net borrowing       level 115.46142 gbp_bn
#> 45 2027-28 fiscal_year Net borrowing       level  96.46737 gbp_bn
#> 46 2028-29 fiscal_year Net borrowing       level  86.01563 gbp_bn
#> 47 2029-30 fiscal_year Net borrowing       level  63.40344 gbp_bn
#> 48 2030-31 fiscal_year Net borrowing       level  59.01991 gbp_bn
obr_provenance(efo)$vintage
#> [1] "March 2026"

# Pin to a specific EFO for reproducibility
october_2024 <- get_efo_fiscal(vintage = "October 2024")
#> ℹ Downloading efo_aggregates_october_2024.xlsx from OBR...
#> ✔ Saved to cache.
options(op)
# }
```
