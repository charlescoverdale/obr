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

A data frame with columns:

- scenario_type:

  Either `"Demographic scenarios"` or `"Triple lock scenarios"`
  (character)

- scenario:

  Scenario name, e.g. `"Central projection"`, `"Higher life expectancy"`
  (character)

- fiscal_year:

  Fiscal year, e.g. `"2030-31"` (character)

- pct_gdp:

  State pension spending as a percentage of GDP (numeric)

## Details

This data is unique to the Fiscal Risks and Sustainability Report (OBR,
July 2025) and is not available in any other OBR publication. It
illustrates how ageing demographics and pension uprating rules interact
to determine the long-run cost of the state pension.

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
proj <- get_pension_projections()
#> ℹ Downloading fsr_executive_summary.xlsx from OBR...
#> ✔ Saved to cache.

# Central demographic projection over the 50-year horizon
central <- proj[proj$scenario_type == "Demographic scenarios" &
                proj$scenario == "Central projection", ]
tail(central, 10)
#>            scenario_type           scenario fiscal_year  pct_gdp
#> 42 Demographic scenarios Central projection     2064-65 7.240896
#> 43 Demographic scenarios Central projection     2065-66 7.344158
#> 44 Demographic scenarios Central projection     2066-67 7.448355
#> 45 Demographic scenarios Central projection     2067-68 7.548574
#> 46 Demographic scenarios Central projection     2068-69 7.640862
#> 47 Demographic scenarios Central projection     2069-70 7.732326
#> 48 Demographic scenarios Central projection     2070-71 7.820863
#> 49 Demographic scenarios Central projection     2071-72 7.769048
#> 50 Demographic scenarios Central projection     2072-73 7.661269
#> 51 Demographic scenarios Central projection     2073-74 7.650863

# How much more expensive is 'higher life expectancy' vs central?
dem <- proj[proj$scenario_type == "Demographic scenarios", ]
options(op)
# }
```
