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
#> ℹ Downloading policy_measures_database.xlsx from OBR...
#> ✔ Saved to cache.
oct24[grepl("2024", oct24$event) & oct24$fiscal_year == "2025-26", ]
#> # obr_tbl: 325 rows x 6 cols
#> # Source:       OBR Policy Measures Database
#> # URL:          https://obr.uk/download/policy-measures-database-march-2025/
#> # Retrieved:    2026-04-26 08:10:05 UTC
#> # File MD5:     a76d78e7a14d
#> # Package:      obr 0.3.0
#> 
#>       type              event
#> 36487  tax Spring Budget 2024
#> 36488  tax Spring Budget 2024
#> 36489  tax Spring Budget 2024
#> 36490  tax Spring Budget 2024
#> 36491  tax Spring Budget 2024
#> 36492  tax Spring Budget 2024
#> 36493  tax Spring Budget 2024
#> 36494  tax Spring Budget 2024
#> 36495  tax Spring Budget 2024
#> 36496  tax Spring Budget 2024
#>                                                                                                                                measure
#> 36487      National Insurance contributions (NICs): 2 percentage point cut to the main rate of Class 1 employee NICs from 6 April 2024
#> 36488      National Insurance contributions (NICs): 2 percentage point cut to the main rate of Class 1 employee NICs from 6 April 2024
#> 36489      National Insurance contributions (NICs): 2 percentage point cut to the main rate of Class 1 employee NICs from 6 April 2024
#> 36490 National Insurance contributions (NICs): 2 percentage point cut to the main rate of Class 4 self-employed NICs from 6 April 2024
#> 36491 National Insurance contributions (NICs): 2 percentage point cut to the main rate of Class 4 self-employed NICs from 6 April 2024
#> 36492 National Insurance contributions (NICs): 2 percentage point cut to the main rate of Class 4 self-employed NICs from 6 April 2024
#> 36493   High Income Child Benefit Charge: increase income threshold to £60,000 and taper range to £60,000 to £80,000 from 6 April 2024
#> 36494                                              Fuel Duty: 12 month extension to the 5p cut in rates and no RPI increase in 2024-25
#> 36495                                                                                 Alcohol duty: freeze rates until 1 February 2025
#> 36496                VAT: increase the registration threshold to £90,000 and the deregistration threshold to £88,000 from 1 April 2024
#>                            head fiscal_year    value_mn
#> 36487                Income tax     2025-26   259.60908
#> 36488                      NICs     2025-26 -9471.67852
#> 36489 Corporation tax (onshore)     2025-26  -257.01126
#> 36490                Income tax     2025-26   -13.56977
#> 36491                      NICs     2025-26  -678.43160
#> 36492 Corporation tax (onshore)     2025-26  -168.73511
#> 36493                Income tax     2025-26  -277.00000
#> 36494                 Fuel Duty     2025-26  -820.80953
#> 36495              Alcohol duty     2025-26  -345.47915
#> 36496                       VAT     2025-26  -183.43763
#> # ... with 315 more rows

# All alcohol-duty measures since 2010
get_policy_measures(type = "tax", search = "alcohol", since = "2010-11")
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> # obr_tbl: 1141 rows x 6 cols
#> # Source:       OBR Policy Measures Database
#> # URL:          https://obr.uk/download/policy-measures-database-march-2025/
#> # Retrieved:    2026-04-26 08:10:05 UTC
#> # File MD5:     a76d78e7a14d
#> # Package:      obr 0.3.0
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
