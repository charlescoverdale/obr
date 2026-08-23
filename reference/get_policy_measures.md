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

# The OBR CDN occasionally rate-limits or returns 403 to repeated
# requests. tryCatch so the example degrades gracefully if that happens
# during the CRAN check.
oct24 <- tryCatch(get_policy_measures(),
                  error = function(e) NULL)
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Downloading policy_measures_database.xlsx from OBR...
#> ✔ Saved to cache.
if (!is.null(oct24)) {
  head(oct24[grepl("2024", oct24$event) &
             oct24$fiscal_year == "2025-26", ])

  # All alcohol-duty measures since 2010
  tryCatch(
    get_policy_measures(type = "tax", search = "alcohol",
                        since = "2010-11"),
    error = function(e) NULL
  )
}
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> # obr_tbl: 1141 rows x 6 cols
#> # Source:       OBR Policy Measures Database
#> # URL:          https://obr.uk/download/policy-measures-database-march-2025/
#> # Retrieved:    2026-08-23 17:37:14 UTC
#> # File MD5:     a76d78e7a14d
#> # Package:      obr 0.6.2
#> 
#>    type       event                           measure         head fiscal_year
#> 1   tax Budget 1974 Alterations in rates of beer duty Alcohol duty     2010-11
#> 2   tax Budget 1975          Increase in tobacco duty Alcohol duty     2010-11
#> 3   tax Budget 1975           Increase in spirit duty Alcohol duty     2010-11
#> 4   tax Budget 1975             Increase in beer duty Alcohol duty     2010-11
#> 5   tax Budget 1975             Increase in wine duty Alcohol duty     2010-11
#> 6   tax Budget 1976    Increase in rates of beer duty Alcohol duty     2010-11
#> 7   tax Budget 1980    Increase in rates of beer duty Alcohol duty     2010-11
#> 8   tax Budget 1981          Increase of spirits duty Alcohol duty     2010-11
#> 9   tax Budget 1981             Increase of beer duty Alcohol duty     2010-11
#> 10  tax Budget 1981             Increase in wine duty Alcohol duty     2010-11
#>     value_mn
#> 1  1318.8490
#> 2  3099.6078
#> 3   676.2781
#> 4  2085.1907
#> 5   901.7041
#> 6   916.7808
#> 7  1122.3349
#> 8   299.2076
#> 9  1919.9157
#> 10  334.1152
#> # ... with 1131 more rows

options(op)
# }
```
