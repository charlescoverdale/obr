# Get all Public Finances Databank aggregates

Downloads (and caches) the OBR Public Finances Databank and returns all
aggregate fiscal series in tidy long format. Covers outturn from 1946-47
and OBR projections through the current forecast horizon.

## Usage

``` r
get_public_finances(refresh = FALSE)
```

## Arguments

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

A data frame with columns:

- year:

  Fiscal year (character, e.g. `"2024-25"`)

- series:

  Series name (character)

- value:

  Value in £ billion (numeric)

## Details

Series include: Public sector net borrowing, Public sector net debt,
Total managed expenditure, Public sector current receipts, Nominal GDP,
GDP deflator, and more.

## See also

Other public finances:
[`get_expenditure()`](https://charlescoverdale.github.io/obr/reference/get_expenditure.md),
[`get_psnb()`](https://charlescoverdale.github.io/obr/reference/get_psnb.md),
[`get_psnd()`](https://charlescoverdale.github.io/obr/reference/get_psnd.md),
[`get_receipts()`](https://charlescoverdale.github.io/obr/reference/get_receipts.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
pf <- get_public_finances()
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
unique(pf$series)
#>  [1] "Public sector current receipts"              
#>  [2] "Total managed expenditure"                   
#>  [3] "Public sector current expenditure"           
#>  [4] "Public sector net investment"                
#>  [5] "Depreciation"                                
#>  [6] "Public sector gross investment"              
#>  [7] "National account taxes"                      
#>  [8] "Cyclically-adjusted current budget deficit"  
#>  [9] "Public sector net borrowing"                 
#> [10] "Current budget deficit"                      
#> [11] "Primary balance"                             
#> [12] "Cyclically-adjusted primary balance"         
#> [13] "Cyclically-adjusted net borrowing"           
#> [14] "Public sector net debt"                      
#> [15] "Central government net cash requirement"     
#> [16] "Public sector net cash requirement"          
#> [17] "Central government debt interest, net of APF"
#> [18] "Treaty deficit"                              
#> [19] "Cyclically-adjusted Treaty deficit"          
#> [20] "Treaty debt"                                 
#> [21] "Nominal GDP (£ billion)"                     
#> [22] "Nominal GDP, centred end-March (£ billion)"  
#> [23] "Output gap (per cent of GDP)"                
#> [24] "GDP Deflator (2019-20=100)"                  
options(op)
# }
```
