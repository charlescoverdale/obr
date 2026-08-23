# Compute the stability-rule margin from the EFO forecast

Returns the current budget surplus for every year of an EFO forecast,
derived from Table 6.5 (Components of net borrowing). Under the Charter
for Budget Responsibility's stability rule the current budget must be in
balance or surplus by the target year, so the value in the target year
is the margin, or "headroom", against the rule: positive means the rule
is met with room to spare, negative means it is missed.

## Usage

``` r
obr_headroom(vintage = NULL, target_year = NULL, refresh = FALSE)
```

## Arguments

- vintage:

  Optional EFO vintage label such as `"March 2026"`. If `NULL` (the
  default), uses any pin set via
  [`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md)
  or the latest live EFO.

- target_year:

  Optional fiscal-year string (e.g. `"2029-30"`). If supplied, an
  `is_target_year` column flags that year.

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

An `obr_tbl` with the standard schema columns (`period`, `period_type`,
`series`, `metric_type`, `value`, `unit`), where `series` is
`"Current budget surplus"` and `value` is in GBP billion (positive =
surplus = headroom under the stability rule). If `target_year` is
supplied, an additional logical `is_target_year` column is included.

## Details

The value returned is `-1 *` the published "Current budget deficit"
series, i.e. a surplus is positive. Pass `target_year` to flag the year
the rule currently bites on; the function does not guess it, because the
Charter's target-year convention changes over time (see
[`obr_fiscal_rules()`](https://charlescoverdale.github.io/obr/reference/obr_fiscal_rules.md)
for the rules as encoded at release).

Note the OBR's own published headroom figure at a fiscal event can
differ slightly from the Table 6.5 arithmetic (rounding, and any
rule-specific adjustments described in the EFO text). Treat this as the
published forecast path for the rule metric, not a reproduction of the
OBR's press-notice headroom number.

## See also

Other fiscal rules:
[`obr_fiscal_rules()`](https://charlescoverdale.github.io/obr/reference/obr_fiscal_rules.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())

hr <- tryCatch(obr_headroom(), error = function(e) NULL)
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
if (!is.null(hr)) hr
#> # obr_tbl: 6 rows x 6 cols
#> # Source:       OBR Economic and Fiscal Outlook, March 2026
#> # URL:          https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> # Retrieved:    2026-08-23 17:35:40 UTC
#> # File MD5:     5b5eeaf79b96
#> # Package:      obr 0.6.2
#> # Note:         Derived from EFO Table 6.5: value = -(Current budget deficit). Positive = surplus = margin against the Charter stability rule.
#> 
#>    period period_type                 series metric_type      value   unit
#> 1 2025-26 fiscal_year Current budget surplus       level -49.181816 gbp_bn
#> 2 2026-27 fiscal_year Current budget surplus       level -33.917536 gbp_bn
#> 3 2027-28 fiscal_year Current budget surplus       level  -4.559471 gbp_bn
#> 4 2028-29 fiscal_year Current budget surplus       level   3.288368 gbp_bn
#> 5 2029-30 fiscal_year Current budget surplus       level  23.563635 gbp_bn
#> 6 2030-31 fiscal_year Current budget surplus       level  30.293367 gbp_bn

# Flag the target year and read off the margin
hr <- tryCatch(obr_headroom(target_year = "2029-30"),
               error = function(e) NULL)
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
if (!is.null(hr)) hr[hr$is_target_year, ]
#> # obr_tbl: 1 rows x 7 cols
#> # Source:       OBR Economic and Fiscal Outlook, March 2026
#> # URL:          https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> # Retrieved:    2026-08-23 17:35:40 UTC
#> # File MD5:     5b5eeaf79b96
#> # Package:      obr 0.6.2
#> # Note:         Derived from EFO Table 6.5: value = -(Current budget deficit). Positive = surplus = margin against the Charter stability rule. Target year flagged: 2029-30.
#> 
#>    period period_type                 series metric_type    value   unit
#> 5 2029-30 fiscal_year Current budget surplus       level 23.56364 gbp_bn
#>   is_target_year
#> 5           TRUE

options(op)
# }
```
