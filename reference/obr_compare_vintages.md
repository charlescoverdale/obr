# Compare two EFO vintages

Pulls the same EFO table from two vintages and returns a tidy diff with
a revision column (`value_b - value_a`). Useful for quantifying how the
OBR's view changed between fiscal events.

## Usage

``` r
obr_compare_vintages(vintage_a, vintage_b, what = "fiscal", refresh = FALSE)
```

## Arguments

- vintage_a, vintage_b:

  EFO vintage labels (e.g. `"October 2024"`, `"March 2026"`). Use
  [`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md)
  to see all valid labels.

- what:

  Which EFO table to compare. Either one of the named shortcuts
  `"fiscal"` (Table 6.5, the default), `"inflation"` (sheet 1.7),
  `"labour"` (sheet 1.6), `"output_gap"` (sheet 1.14), or any table id
  from
  [`obr_efo_catalogue()`](https://charlescoverdale.github.io/obr/reference/obr_efo_catalogue.md)
  (e.g. `"6.13"`, `"1.19"`), so all detailed-forecast tables can be
  diffed across vintages.

- refresh:

  Logical. If `TRUE`, re-download even if cached files exist. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with the standard v0.4.0 schema columns (`period`,
`period_type`, `series`, `metric_type`, `unit`) plus `value_a`,
`value_b`, and `revision` (`value_b - value_a`). Provenance points at
the second vintage; the first vintage URL is recorded in the `notes`
field.

## Details

Rows are the **inner join** of the two vintages on the schema keys
(`period`, `period_type`, `series`, `metric_type`, `unit`). Periods or
series that are present in only one vintage are silently dropped. If you
need to see what was added or removed between vintages, compare
[`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md)
row counts or call the underlying functions directly with each vintage
and [`setdiff()`](https://rdrr.io/r/base/sets.html) on the keys.

Calling the function with `vintage_a == vintage_b` is allowed and
returns an all-zero `revision` column. There is no special handling
beyond that.

## See also

Other forecasts:
[`get_forecast_revisions()`](https://charlescoverdale.github.io/obr/reference/get_forecast_revisions.md),
[`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md),
[`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md),
[`obr_actual_vs_forecast()`](https://charlescoverdale.github.io/obr/reference/obr_actual_vs_forecast.md),
[`obr_forecast_panel()`](https://charlescoverdale.github.io/obr/reference/obr_forecast_panel.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
diff <- obr_compare_vintages("October 2024", "March 2026")
#> ℹ Downloading efo_aggregates_october_2024.xlsx from OBR...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■                  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■                            
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■      
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download
#> <https://obr.uk/download/october-2024-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/>.
#> ✖ HTTP 403 Forbidden.
diff[diff$series == "Net borrowing", ]
#> Error in diff$series: object of type 'closure' is not subsettable

# Compare the inflation forecast across two vintages
inf_diff <- obr_compare_vintages("October 2024", "March 2026",
                                 what = "inflation")
#> ℹ Downloading efo_economy_october_2024.xlsx from OBR...
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■            
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■■                         
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■              
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■   
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download
#> <https://obr.uk/download/october-2024-economic-and-fiscal-outlook-detailed-forecast-tables-economy/>.
#> ✖ HTTP 403 Forbidden.

# Any catalogue table works too, e.g. debt interest (Table 6.16)
di_diff <- obr_compare_vintages("November 2025", "March 2026",
                                what = "6.16")
#> ℹ Downloading efo_aggregates_november_2025.xlsx from OBR...
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■     
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■■■■■                      
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download
#> <https://obr.uk/download/november-2025-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/>.
#> ✖ HTTP 403 Forbidden.
options(op)
# }
```
