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
try({
  efo <- get_efo_fiscal()
  efo[efo$series == "Net borrowing", ]
  obr_provenance(efo)$vintage

  # Pin to a specific EFO for reproducibility
  october_2024 <- get_efo_fiscal(vintage = "October 2024")
})
#> ℹ Downloading efo_aggregates.xlsx from OBR...
#> ✔ Saved to cache.
#> ℹ Downloading efo_aggregates_october_2024.xlsx from OBR...
#> ✔ Saved to cache.
options(op)
# }
```
