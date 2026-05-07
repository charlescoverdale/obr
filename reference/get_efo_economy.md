# Get EFO economy projections

Downloads (and caches) the OBR *Economic and Fiscal Outlook* Detailed
Forecast Tables - Economy file and returns quarterly economic
projections for a chosen measure in tidy long format.

## Usage

``` r
get_efo_economy(
  measure = c("inflation", "labour", "output_gap"),
  refresh = FALSE,
  vintage = NULL
)
```

## Arguments

- measure:

  Character. Which economy table to return. One of `"inflation"`,
  `"labour"`, or `"output_gap"`. Defaults to `"inflation"`.

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

- vintage:

  Optional EFO vintage label such as `"October 2024"`. If supplied, the
  function downloads the file for that specific EFO. If `NULL` (the
  default), the function uses any vintage set via
  [`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md),
  or falls back to the latest live EFO via the dynamic URL resolver.

## Value

An `obr_tbl` with the standard v0.4.0 schema (columns: `period`,
`period_type`, `series`, `metric_type`, `value`, `unit`):

- period:

  Calendar quarter, e.g. `"2025Q1"` (character)

- period_type:

  Always `"quarter"` for this function (character)

- series:

  Variable name, e.g. `"CPI"` (character)

- metric_type:

  One of `"index"`, `"yoy_pct"`, `"pct"`, `"level"`, classified from the
  series name. This is the v0.4.0 fix for the v0.3.x issue where, e.g.,
  CPI Index values and CPI YoY values shared a single `value` column
  with no machine-readable distinction.

- value:

  Numeric value in units described by `unit`

- unit:

  One of `"index"`, `"pct"`, etc., paired with `metric_type`

## Details

Data run from 2008 Q1 through the current forecast horizon. Use
[`list_efo_economy_measures()`](https://charlescoverdale.github.io/obr/reference/list_efo_economy_measures.md)
to see all available measures.

## See also

Other EFO:
[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md),
[`get_efo_table()`](https://charlescoverdale.github.io/obr/reference/get_efo_table.md),
[`list_efo_economy_measures()`](https://charlescoverdale.github.io/obr/reference/list_efo_economy_measures.md),
[`obr_efo_catalogue()`](https://charlescoverdale.github.io/obr/reference/obr_efo_catalogue.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
inf <- get_efo_economy("inflation")
#> ℹ Downloading efo_economy.xlsx from OBR...
#> ✔ Saved to cache.
inf[inf$series == "CPI", ]
#> # obr_tbl: 186 rows x 6 cols
#> # Source:       OBR Economic and Fiscal Outlook, March 2026
#> # URL:          https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-economy/
#> # Retrieved:    2026-05-07 20:59:05 UTC
#> # File MD5:     da58dba1f8d3
#> # Package:      obr 0.5.0
#> 
#>     period period_type series metric_type    value unit
#> 183 2008Q1     quarter    CPI     yoy_pct 2.375720  pct
#> 184 2008Q2     quarter    CPI     yoy_pct 3.419723  pct
#> 185 2008Q3     quarter    CPI     yoy_pct 4.838841  pct
#> 186 2008Q4     quarter    CPI     yoy_pct 3.824052  pct
#> 187 2009Q1     quarter    CPI     yoy_pct 3.005551  pct
#> 188 2009Q2     quarter    CPI     yoy_pct 2.088718  pct
#> 189 2009Q3     quarter    CPI     yoy_pct 1.489726  pct
#> 190 2009Q4     quarter    CPI     yoy_pct 2.103189  pct
#> 191 2010Q1     quarter    CPI     yoy_pct 3.274537  pct
#> 192 2010Q2     quarter    CPI     yoy_pct 3.456674  pct
#> # ... with 176 more rows

lab <- get_efo_economy("labour")
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.

# Compare CPI projections from two different EFOs
inf_oct24 <- get_efo_economy("inflation", vintage = "October 2024")
#> ℹ Downloading efo_economy_october_2024.xlsx from OBR...
#> ✔ Saved to cache.
inf_mar26 <- get_efo_economy("inflation", vintage = "March 2026")
#> ℹ Downloading efo_economy_march_2026.xlsx from OBR...
#> ✔ Saved to cache.
options(op)
# }
```
