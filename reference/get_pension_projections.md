# Get long-run state pension spending projections

Downloads (and caches) the OBR Fiscal Risks and Sustainability Report
executive summary charts and tables workbook and returns 50-year
projections for state pension spending as a share of GDP, under
alternative demographic and triple-lock uprating scenarios.

## Usage

``` r
get_pension_projections(refresh = FALSE)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with the standard v0.4.0 schema plus a `scenario_type`
column to group scenarios:

- period:

  Fiscal year, e.g. `"2030-31"` (character)

- period_type:

  Always `"fiscal_year"`

- series:

  Scenario name, e.g. `"Central projection"`, `"Higher life expectancy"`
  (character)

- metric_type:

  Always `"pct"`

- value:

  State pension spending as a percentage of GDP (numeric)

- unit:

  Always `"pct"`

- scenario_type:

  Either `"Demographic scenarios"` or `"Triple lock scenarios"`
  (character)

## Details

This data is unique to the Fiscal Risks and Sustainability Report and is
not available in any other OBR publication. It illustrates how ageing
demographics and pension uprating rules interact to determine the
long-run cost of the state pension. The exact vintage is recorded in the
returned object's provenance.

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
proj <- get_pension_projections()
#> ℹ Downloading fsr_executive_summary.xlsx from OBR...
#> ✔ Saved to cache.

central <- proj[proj$scenario_type == "Demographic scenarios" &
                proj$series == "Central projection", ]
tail(central, 10)
#> # obr_tbl: 10 rows x 7 cols
#> # Source:       OBR Fiscal Risks and Sustainability Report, July 2025
#> # URL:          https://obr.uk/download/july-2025-fiscal-risks-and-sustainability-charts-and-tables-executive-summary/
#> # Retrieved:    2026-05-07 20:02:43 UTC
#> # File MD5:     bdf4d8711300
#> # Package:      obr 0.4.0
#> 
#>     period period_type             series metric_type    value unit
#> 42 2064-65 fiscal_year Central projection         pct 7.240896  pct
#> 43 2065-66 fiscal_year Central projection         pct 7.344158  pct
#> 44 2066-67 fiscal_year Central projection         pct 7.448355  pct
#> 45 2067-68 fiscal_year Central projection         pct 7.548574  pct
#> 46 2068-69 fiscal_year Central projection         pct 7.640862  pct
#> 47 2069-70 fiscal_year Central projection         pct 7.732326  pct
#> 48 2070-71 fiscal_year Central projection         pct 7.820863  pct
#> 49 2071-72 fiscal_year Central projection         pct 7.769048  pct
#> 50 2072-73 fiscal_year Central projection         pct 7.661269  pct
#> 51 2073-74 fiscal_year Central projection         pct 7.650863  pct
#>            scenario_type
#> 42 Demographic scenarios
#> 43 Demographic scenarios
#> 44 Demographic scenarios
#> 45 Demographic scenarios
#> 46 Demographic scenarios
#> 47 Demographic scenarios
#> 48 Demographic scenarios
#> 49 Demographic scenarios
#> 50 Demographic scenarios
#> 51 Demographic scenarios

dem <- proj[proj$scenario_type == "Demographic scenarios", ]
options(op)
# }
```
