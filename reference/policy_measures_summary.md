# Summarise policy measures by fiscal event

Aggregates the measures returned by
[`get_policy_measures()`](https://charlescoverdale.github.io/obr/reference/get_policy_measures.md)
to give the net Exchequer effect (positive = revenue-raising /
spending-reducing for tax, spending-increasing for spending) by fiscal
event and fiscal year.

## Usage

``` r
policy_measures_summary(x)
```

## Arguments

- x:

  An `obr_tbl` returned by
  [`get_policy_measures()`](https://charlescoverdale.github.io/obr/reference/get_policy_measures.md).

## Value

An `obr_tbl` with columns:

- type:

  `"tax"` or `"spending"`

- event:

  Fiscal event

- fiscal_year:

  Fiscal year

- value_mn:

  Sum of the Exchequer effect across all measures scored at that event,
  in GBP million

Provenance is preserved.

## See also

Other policy measures:
[`get_policy_measures()`](https://charlescoverdale.github.io/obr/reference/get_policy_measures.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
try({
  pm <- get_policy_measures(type = "tax", since = "2024-25")
  policy_measures_summary(pm)
})
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
#> # obr_tbl: 684 rows x 4 cols
#> # Source:       OBR Policy Measures Database, October 2026
#> # URL:          https://obr.uk/download/policy-measures-database/
#> # Retrieved:    2026-11-19 09:02:39 UTC
#> # File MD5:     5b49628a95d7
#> # Package:      obr 0.6.3.9000
#> # Note:         Summed across measures by event and fiscal year.
#> 
#>    type       event fiscal_year   value_mn
#> 1   tax Autumn 2010     2024-25 1132.02161
#> 2   tax Autumn 2010     2025-26 1184.43535
#> 3   tax Autumn 2010     2026-27 1226.90345
#> 4   tax Autumn 2010     2027-28 1269.81634
#> 5   tax Autumn 2010     2028-29 1317.30859
#> 6   tax Autumn 2010     2029-30 1367.02350
#> 7   tax Autumn 2010     2030-31 1417.19351
#> 8   tax Autumn 2010     2031-32 1466.89563
#> 9   tax Autumn 2011     2024-25   21.71029
#> 10  tax Autumn 2011     2025-26   22.71549
#> # ... with 674 more rows
options(op)
# }
```
