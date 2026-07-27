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
[`list_efo_economy_measures()`](https://charlescoverdale.github.io/obr/reference/list_efo_economy_measures.md),
[`obr_efo_catalogue()`](https://charlescoverdale.github.io/obr/reference/obr_efo_catalogue.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())

# Net borrowing components (same data as get_efo_fiscal())
get_efo_table("6.5")
#> Warning: Could not resolve a current EFO Aggregates URL from 9 candidates.
#> ℹ Falling back to
#>   <https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading efo_aggregates.xlsx from OBR...
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■         
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■■■                        
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■             
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download
#> <https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/>.
#> ✖ HTTP 403 Forbidden.

# CPI category inflation by year
get_efo_table("1.19")
#> Warning: Could not resolve a current EFO Economy URL from 9 candidates.
#> ℹ Falling back to
#>   <https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-economy/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading efo_economy.xlsx from OBR...
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■     
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■■■■■                      
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■          
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download
#> <https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-economy/>.
#> ✖ HTTP 403 Forbidden.

# Composition of public sector net debt
get_efo_table("6.13")
#> Warning: Could not resolve a current EFO Aggregates URL from 9 candidates.
#> ℹ Falling back to
#>   <https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading efo_aggregates.xlsx from OBR...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■                       
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Waiting 8s for retry backoff ■■■■                            
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■                   
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■        
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download
#> <https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/>.
#> ✖ HTTP 403 Forbidden.

# Pin to a specific vintage
get_efo_table("6.5", vintage = "October 2024")
#> ℹ Downloading efo_aggregates_october_2024.xlsx from OBR...
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■                            
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■                
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■     
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download
#> <https://obr.uk/download/october-2024-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/>.
#> ✖ HTTP 403 Forbidden.

options(op)
# }
```
