# Get any EFO detailed-forecast table by id

Generic fetcher that takes an EFO table identifier (e.g. `"6.5"`,
`"1.7"`, `"4.1"`) and returns the parsed contents in the standard v0.4.0
schema. Use
[`obr_efo_catalogue()`](https://charlescoverdale.github.io/obr/reference/obr_efo_catalogue.md)
to discover which tables are available.

## Usage

``` r
get_efo_table(table_id, vintage = NULL, refresh = FALSE)
```

## Arguments

- table_id:

  Character. The EFO table identifier, e.g. `"6.5"`, `"1.7"`, `"6.13"`.
  See
  [`obr_efo_catalogue()`](https://charlescoverdale.github.io/obr/reference/obr_efo_catalogue.md)
  for the full list.

- vintage:

  Optional EFO vintage label (e.g. `"October 2024"`). If `NULL`, uses
  any pin set via
  [`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md)
  or falls back to the latest live EFO.

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with the standard v0.4.0 schema columns (`period`,
`period_type`, `series`, `metric_type`, `value`, `unit`). Returns `NULL`
(with a warning) for cross-reference sheets.

## Details

Internally, this function looks up `table_id` in the catalogue, fetches
the right workbook (Aggregates or Economy), dispatches to a layout-
specific parser, and tags every row with `metric_type` and `unit`
according to the catalogue's defaults plus per-row classification.

Coverage today: 17 fiscal Aggregates tables + 22 macro Economy tables.
One sheet (6.11 PSND year-on-year changes) is a cross-reference to a
previous EFO and returns `NULL` with a warning rather than data; OBR
itself directs users to the previous EFO for that table.

Headline functions
[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)
and
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md)
are kept as thin wrappers over this dispatcher.

## See also

Other EFO:
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md),
[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md),
[`get_monthly_profiles()`](https://charlescoverdale.github.io/obr/reference/get_monthly_profiles.md),
[`list_efo_economy_measures()`](https://charlescoverdale.github.io/obr/reference/list_efo_economy_measures.md),
[`obr_efo_catalogue()`](https://charlescoverdale.github.io/obr/reference/obr_efo_catalogue.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())

# Net borrowing components (same data as get_efo_fiscal())
get_efo_table("6.5")
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> # obr_tbl: 48 rows x 6 cols
#> # Source:       OBR Economic and Fiscal Outlook, March 2026
#> # URL:          https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> # Retrieved:    2026-08-15 10:23:52 UTC
#> # File MD5:     5b5eeaf79b96
#> # Package:      obr 0.6.1
#> 
#>     period period_type              series metric_type    value   unit
#> 1  2025-26 fiscal_year    Current receipts       level 1235.253 gbp_bn
#> 2  2026-27 fiscal_year    Current receipts       level 1303.793 gbp_bn
#> 3  2027-28 fiscal_year    Current receipts       level 1375.408 gbp_bn
#> 4  2028-29 fiscal_year    Current receipts       level 1427.438 gbp_bn
#> 5  2029-30 fiscal_year    Current receipts       level 1491.944 gbp_bn
#> 6  2030-31 fiscal_year    Current receipts       level 1551.485 gbp_bn
#> 7  2025-26 fiscal_year Current expenditure       level 1211.485 gbp_bn
#> 8  2026-27 fiscal_year Current expenditure       level 1260.266 gbp_bn
#> 9  2027-28 fiscal_year Current expenditure       level 1299.180 gbp_bn
#> 10 2028-29 fiscal_year Current expenditure       level 1340.119 gbp_bn
#> # ... with 38 more rows

# CPI category inflation by year
get_efo_table("1.19")
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> # obr_tbl: 245 rows x 6 cols
#> # Source:       OBR Economic and Fiscal Outlook, March 2026
#> # URL:          https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-economy/
#> # Retrieved:    2026-08-15 10:23:50 UTC
#> # File MD5:     da58dba1f8d3
#> # Package:      obr 0.6.1
#> 
#>    period period_type                      series metric_type      value unit
#> 1  2019Q1     quarter Food, beverages and tobacco     yoy_pct 2.02147714  pct
#> 2  2019Q2     quarter Food, beverages and tobacco     yoy_pct 1.79552314  pct
#> 3  2019Q3     quarter Food, beverages and tobacco     yoy_pct 2.10170705  pct
#> 4  2019Q4     quarter Food, beverages and tobacco     yoy_pct 1.85312851  pct
#> 5  2020Q1     quarter Food, beverages and tobacco     yoy_pct 1.26399562  pct
#> 6  2020Q2     quarter Food, beverages and tobacco     yoy_pct 1.68885403  pct
#> 7  2020Q3     quarter Food, beverages and tobacco     yoy_pct 0.86752929  pct
#> 8  2020Q4     quarter Food, beverages and tobacco     yoy_pct 0.34913717  pct
#> 9  2021Q1     quarter Food, beverages and tobacco     yoy_pct 0.11016879  pct
#> 10 2021Q2     quarter Food, beverages and tobacco     yoy_pct 0.01870086  pct
#> # ... with 235 more rows

# Composition of public sector net debt
get_efo_table("6.13")
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> # obr_tbl: 175 rows x 6 cols
#> # Source:       OBR Economic and Fiscal Outlook, March 2026
#> # URL:          https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> # Retrieved:    2026-08-15 10:23:52 UTC
#> # File MD5:     5b5eeaf79b96
#> # Package:      obr 0.6.1
#> 
#>     period period_type                                     series metric_type
#> 1  2024-25 fiscal_year Public sector debt liabilities, ex BoE (a)         pct
#> 2  2025-26 fiscal_year Public sector debt liabilities, ex BoE (a)         pct
#> 3  2026-27 fiscal_year Public sector debt liabilities, ex BoE (a)         pct
#> 4  2027-28 fiscal_year Public sector debt liabilities, ex BoE (a)         pct
#> 5  2028-29 fiscal_year Public sector debt liabilities, ex BoE (a)         pct
#> 6  2029-30 fiscal_year Public sector debt liabilities, ex BoE (a)         pct
#> 7  2030-31 fiscal_year Public sector debt liabilities, ex BoE (a)         pct
#> 8  2024-25 fiscal_year                         Central government         pct
#> 9  2025-26 fiscal_year                         Central government         pct
#> 10 2026-27 fiscal_year                         Central government         pct
#>        value unit
#> 1   96.09720  pct
#> 2   99.24287  pct
#> 3  100.39931  pct
#> 4  101.32878  pct
#> 5  102.01492  pct
#> 6  101.85901  pct
#> 7  101.40423  pct
#> 8   96.61700  pct
#> 9   99.77216  pct
#> 10 100.94374  pct
#> # ... with 165 more rows

# Pin to a specific vintage
get_efo_table("6.5", vintage = "October 2024")
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> # obr_tbl: 56 rows x 6 cols
#> # Source:       OBR Economic and Fiscal Outlook, October 2024
#> # URL:          https://obr.uk/download/october-2024-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> # Retrieved:    2026-08-15 10:23:52 UTC
#> # File MD5:     e647b168d466
#> # Package:      obr 0.6.1
#> 
#>     period period_type              series metric_type    value   unit
#> 1  2023-24 fiscal_year    Current receipts       level 1100.811 gbp_bn
#> 2  2024-25 fiscal_year    Current receipts       level 1148.687 gbp_bn
#> 3  2025-26 fiscal_year    Current receipts       level 1229.480 gbp_bn
#> 4  2026-27 fiscal_year    Current receipts       level 1290.534 gbp_bn
#> 5  2027-28 fiscal_year    Current receipts       level 1345.979 gbp_bn
#> 6  2028-29 fiscal_year    Current receipts       level 1389.767 gbp_bn
#> 7  2029-30 fiscal_year    Current receipts       level 1439.914 gbp_bn
#> 8  2023-24 fiscal_year Current expenditure       level 1087.805 gbp_bn
#> 9  2024-25 fiscal_year Current expenditure       level 1134.438 gbp_bn
#> 10 2025-26 fiscal_year Current expenditure       level 1182.846 gbp_bn
#> # ... with 46 more rows

options(op)
# }
```
