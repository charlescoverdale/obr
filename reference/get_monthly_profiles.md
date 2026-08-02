# Get the OBR monthly profiles for the public finances

Downloads (and caches) the monthly profiles workbook the OBR publishes
alongside each *Economic and Fiscal Outlook*. The profiles apportion the
full-year EFO forecast for receipts, spending, and the central
government net cash requirement (CGNCR) across the twelve months of the
fiscal year, so that each month's ONS/HMT public sector finances outturn
can be judged against the path implied by the OBR's forecast.

## Usage

``` r
get_monthly_profiles(
  sheet = c("profiles", "cgncr"),
  vintage = NULL,
  refresh = FALSE
)
```

## Arguments

- sheet:

  Which profile table to return. `"profiles"` (the default) returns the
  receipts and spending profiles; `"cgncr"` returns the central
  government net cash requirement breakdown.

- vintage:

  Optional EFO vintage label such as `"March 2026"`. If `NULL` (the
  default), uses any pin set via
  [`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md)
  or resolves the latest live profiles workbook.

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with the standard schema columns (`period`, `period_type`,
`series`, `metric_type`, `value`, `unit`). Monthly rows have
`period_type = "month"` and `period` in `"YYYY-MM"` format; each series
also carries one `period_type = "fiscal_year"` row holding the full-year
EFO forecast the profile sums to. All values are GBP billion.

## Details

This is the reference point used every month in the run-up to a fiscal
event ("borrowing so far this year vs the OBR profile"). The OBR itself
publishes a monthly commentary against these profiles; this function
provides the underlying numbers in tidy long format. Pair with monthly
outturn data (e.g. from the ONS public sector finances release) to
compute in-year deviations from profile.

The profiles workbook is typically published a few weeks after the EFO
itself. The OBR describes the profiles as broad-brush and illustrative;
see the Notes sheet of the source workbook.

## See also

Other EFO:
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md),
[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md),
[`get_efo_table()`](https://charlescoverdale.github.io/obr/reference/get_efo_table.md),
[`list_efo_economy_measures()`](https://charlescoverdale.github.io/obr/reference/list_efo_economy_measures.md),
[`obr_efo_catalogue()`](https://charlescoverdale.github.io/obr/reference/obr_efo_catalogue.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())

mp <- tryCatch(get_monthly_profiles(), error = function(e) NULL)
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■                  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■                   
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■                   
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■                   
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■                    
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■                    
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■                    
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■                    
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■                     
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Warning: Could not resolve a current EFO Monthly Profiles URL from 9 candidates.
#> ℹ Falling back to
#>   <https://obr.uk/download/march-2026-economic-and-fiscal-outlook-monthly-profiles/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading efo_monthly_profiles.xlsx from OBR...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■                     
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■                            
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■                   
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■        
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
if (!is.null(mp)) {
  # Monthly profile for HMRC cash receipts
  mp[mp$series == "HMRC cash receipts" & mp$period_type == "month", ]
}

# CGNCR breakdown by month
cg <- tryCatch(get_monthly_profiles("cgncr"), error = function(e) NULL)
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■              
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■               
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■               
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■               
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■                
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■                
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■                
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Warning: Could not resolve a current EFO Monthly Profiles URL from 9 candidates.
#> ℹ Falling back to
#>   <https://obr.uk/download/march-2026-economic-and-fiscal-outlook-monthly-profiles/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading efo_monthly_profiles.xlsx from OBR...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■                            
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■     
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 

options(op)
# }
```
