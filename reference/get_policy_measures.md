# Get OBR policy measures by fiscal event

Downloads (and caches) the OBR Policy Measures Database, a single
workbook that lists every tax or spending measure scored at a UK fiscal
event, with the Exchequer effect in GBP million for each year of the
forecast horizon. Tax measures cover 1970 to date; spending measures
cover 2010 to date.

## Usage

``` r
get_policy_measures(
  type = c("tax", "spending"),
  search = NULL,
  since = NULL,
  refresh = FALSE
)
```

## Arguments

- type:

  Character vector. Which measures to return: `"tax"`, `"spending"`, or
  both (the default).

- search:

  Optional character. A regular expression used to filter `measure` and
  `head` (case-insensitive). For example, `search = "alcohol"` keeps any
  measure whose description or head mentions alcohol.

- since:

  Optional fiscal-year cut-off (e.g. `"2020-21"`). Rows whose
  `fiscal_year` is earlier are dropped.

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with columns:

- event:

  Fiscal event that scored the measure, e.g. `"Budget 2024"` (character)

- measure:

  Plain-English description of the measure (character)

- head:

  Tax head (for tax measures) or spending head (character)

- fiscal_year:

  Fiscal year being scored, e.g. `"2024-25"` (character)

- value_mn:

  Exchequer effect in GBP million. For tax measures, a positive value
  raises revenue; for spending measures, a positive value increases
  spending (numeric)

## Details

This is the only programmatic access to the PMD: the OBR otherwise
distributes it as a single Excel file.

## See also

Other policy measures:
[`policy_measures_summary()`](https://charlescoverdale.github.io/obr/reference/policy_measures_summary.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())

# Every measure scored at the October 2024 Budget
oct24 <- get_policy_measures()
#> Warning: Could not resolve a current Policy Measures Database URL from 16 candidates.
#> ℹ Falling back to
#>   <https://obr.uk/download/policy-measures-database-march-2025/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading policy_measures_database.xlsx from OBR...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■               
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■                           
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■                
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■     
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download
#> <https://obr.uk/download/policy-measures-database-march-2025/>.
#> ✖ HTTP 403 Forbidden.
oct24[grepl("2024", oct24$event) & oct24$fiscal_year == "2025-26", ]
#> Error: object 'oct24' not found

# All alcohol-duty measures since 2010
get_policy_measures(type = "tax", search = "alcohol", since = "2010-11")
#> Warning: Could not resolve a current Policy Measures Database URL from 16 candidates.
#> ℹ Falling back to
#>   <https://obr.uk/download/policy-measures-database-march-2025/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading policy_measures_database.xlsx from OBR...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■■                         
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■             
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download
#> <https://obr.uk/download/policy-measures-database-march-2025/>.
#> ✖ HTTP 403 Forbidden.

options(op)
# }
```
