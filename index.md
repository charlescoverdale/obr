# obr

[![CRAN
status](https://www.r-pkg.org/badges/version/obr)](https://CRAN.R-project.org/package=obr)
[![CRAN
downloads](https://cranlogs.r-pkg.org/badges/obr)](https://cran.r-project.org/package=obr)
[![Total
Downloads](https://cranlogs.r-pkg.org/badges/grand-total/obr)](https://CRAN.R-project.org/package=obr)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

An R package for accessing data published by the [Office for Budget
Responsibility](https://obr.uk/) (OBR).

## What is the OBR?

The Office for Budget Responsibility is the UK’s independent fiscal
watchdog. It was created in 2010 by the coalition government to provide
an independent check on the government’s fiscal plans, a role HM
Treasury previously held itself.

The distinction matters. HM Treasury is the government department that
*sets* fiscal policy: it decides tax rates, spending plans, and how much
the government intends to borrow. The OBR’s job is to *scrutinise* those
plans independently, producing its own economic and fiscal forecasts
that are not influenced by ministers. Think of it as the equivalent of
the Bank of England’s independence for monetary policy, but applied to
public finances.

In practice, this means the OBR publishes forecasts at each Budget and
Autumn Statement showing whether it thinks the government is on track to
meet its own fiscal rules, and it has no political incentive to be
optimistic.

------------------------------------------------------------------------

## Installation

``` r

install.packages("obr")

# Or install the development version from GitHub
# install.packages("devtools")
devtools::install_github("charlescoverdale/obr")
```

------------------------------------------------------------------------

## Key OBR datasets

| Dataset | What it contains | Frequency |
|----|----|----|
| [Public Finances Databank](https://obr.uk/public-finances-databank-2019-20/) | Outturn data on PSNB, PSND, receipts, and expenditure back to 1946-47 | Monthly |
| [Historical Official Forecasts Database](https://obr.uk/data/) | Every forecast the OBR (and pre-OBR Treasury) has published for key fiscal and economic variables since 1970 | Each fiscal event |
| [Economic and Fiscal Outlook](https://obr.uk/efo/economic-and-fiscal-outlook-october-2026/) | The flagship publication at each Budget: detailed projections across 5 years | Each Budget / Autumn Statement |
| [Fiscal Sustainability Report](https://obr.uk/frs/fiscal-risks-and-sustainability-july-2025/) | Long-run projections over 50 years, covering ageing, health, and debt dynamics | Annual |
| [Welfare Trends Report](https://obr.uk/wtr/welfare-trends-report-october-2024/) | Incapacity benefit spending and caseloads (October 2024 edition; later reports cover other themes) | Annual |
| [Monthly profiles](https://obr.uk/monthly-public-finances-briefing/) | The EFO forecast for receipts, spending, and the CGNCR apportioned across the months of the fiscal year, against which each month’s outturn is judged | Each EFO |

This package covers all six datasets listed above.

------------------------------------------------------------------------

## Why does this package exist?

All OBR data is freely available at [obr.uk](https://obr.uk). The
problem is *how* it is available: as Excel files with non-standard
layouts, inconsistent headers, and footnote-laden sheets that require
significant wrangling before they are usable in R.

For example, the Public Finances Databank has column headers buried in
row 4 of the spreadsheet, data starting in row 8, and trailing footnote
numbers appended to column names. The Historical Forecasts Database
stores forecasts as a vintage matrix (rows are fiscal events, columns
are fiscal years), which needs reshaping into a long format before it
can be plotted or analysed.

This package handles all of that automatically. One function call
returns a clean, tidy data frame. Data is cached locally so subsequent
calls are instant.

``` r

# Without this package
path <- "~/Downloads/Public_finances_databank_March_2025.xlsx"
raw  <- readxl::read_excel(path, sheet = "Aggregates (£bn)", col_names = FALSE)
series_names <- as.character(unlist(raw[4, ]))
# ... 30 more lines of wrangling ...

# With this package
library(obr)
get_psnb()
```

------------------------------------------------------------------------

## Provenance and reproducibility

Every data-returning function returns an `obr_tbl`: a `data.frame` with
attached metadata recording the OBR publication, the publication
vintage, the source URL, when the data was retrieved, and the MD5
fingerprint of the underlying spreadsheet. The provenance prints
automatically as a header above the data.

``` r

library(obr)
get_efo_fiscal()
#> # obr_tbl: 48 rows x 6 cols
#> # Source:       OBR Economic and Fiscal Outlook, October 2026
#> # URL:          https://obr.uk/download/october-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> # Retrieved:    2026-11-01 09:09:13 GMT
#> # File MD5:     09851806b48f
#> # Package:      obr 0.6.3
#> 
#>   period period_type              series metric_type    value   unit
#>  2026-27 fiscal_year    Current receipts       level 1315.971 gbp_bn
#>  2027-28 fiscal_year    Current receipts       level 1392.025 gbp_bn
#>  2028-29 fiscal_year    Current receipts       level 1448.986 gbp_bn
#>  2029-30 fiscal_year    Current receipts       level 1513.185 gbp_bn
#>  2030-31 fiscal_year    Current receipts       level 1571.493 gbp_bn
#>  2031-32 fiscal_year    Current receipts       level 1629.320 gbp_bn
#>  2026-27 fiscal_year Current expenditure       level 1278.433 gbp_bn
#>  2027-28 fiscal_year Current expenditure       level 1326.805 gbp_bn
#>  2028-29 fiscal_year Current expenditure       level 1370.322 gbp_bn
#>  2029-30 fiscal_year Current expenditure       level 1408.826 gbp_bn
#> # ... with 38 more rows
```

Use
[`obr_provenance()`](https://charlescoverdale.github.io/obr/reference/obr_provenance.md)
to extract the metadata as a list, or
[`summary()`](https://rdrr.io/r/base/summary.html) for the full
provenance card. Provenance survives `[` subsetting and is stripped only
on explicit
[`as.data.frame()`](https://rdrr.io/r/base/as.data.frame.html). This
means an analysis pinned against an `obr_tbl` always carries the audit
trail of which OBR publication produced the numbers.

``` r

psnb <- get_psnb()
obr_provenance(psnb)
# Returns a list with: publication, vintage, source_url,
# retrieved (POSIXct), file_md5, package_version, notes
```

------------------------------------------------------------------------

## Functions

### Public Finances Databank

| Function | Returns |
|----|----|
| [`get_psnb()`](https://charlescoverdale.github.io/obr/reference/get_psnb.md) | Annual Public Sector Net Borrowing in GBP bn |
| [`get_psnd()`](https://charlescoverdale.github.io/obr/reference/get_psnd.md) | Annual Public Sector Net Debt in GBP bn |
| [`get_expenditure()`](https://charlescoverdale.github.io/obr/reference/get_expenditure.md) | Annual Total Managed Expenditure in GBP bn |
| [`get_receipts()`](https://charlescoverdale.github.io/obr/reference/get_receipts.md) | Tax receipts broken down by type, in GBP bn |
| [`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md) | All aggregate series in tidy long format |

### Historical Forecasts Database

| Function | Returns |
|----|----|
| [`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md) | Data frame of available series (no download needed) |
| `get_forecasts(series)` | Every OBR forecast for a given series, in tidy long format |
| `obr_forecast_panel(series)` | Wide real-time panel: rows = forecast vintages, columns = fiscal years |
| `obr_compare_vintages(a, b, what)` | Tidy diff between two vintages of the same EFO table; returns `value_a`, `value_b`, and `revision = value_b - value_a` |
| `obr_actual_vs_forecast(series)` | Joins HFD forecasts against PFD outturn for the same series; returns `value_forecast`, `value_actual`, and `error` |
| `get_forecast_revisions(unit)` | EFO-to-EFO PSNB revisions decomposed into policy, classifications, and underlying components |

### Economic and Fiscal Outlook (EFO)

| Function | Returns |
|----|----|
| [`obr_efo_catalogue()`](https://charlescoverdale.github.io/obr/reference/obr_efo_catalogue.md) | All 39 detailed-forecast tables this package recognises, with id, section, title, layout, and default `metric_type` / `unit`. No download needed. |
| `get_efo_table(id)` | Generic fetcher: pass a catalogue id (e.g. `"6.13"`, `"1.19"`, `"6.5"`) and get the parsed contents in the standard v0.4 schema. Covers the 37 tables that hold data, across receipts, expenditure, debt, GDP, labour, inflation, housing, and household balance sheets. |
| [`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md) | Net borrowing components (Table 6.5). Convenience wrapper over `get_efo_table("6.5")`. |
| `get_efo_economy(measure)` | Quarterly economic projections: `"inflation"`, `"labour"`, or `"output_gap"`. Convenience wrapper over [`get_efo_table()`](https://charlescoverdale.github.io/obr/reference/get_efo_table.md). |
| [`list_efo_economy_measures()`](https://charlescoverdale.github.io/obr/reference/list_efo_economy_measures.md) | The three measures available via [`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md) (no download needed). |
| [`get_monthly_profiles()`](https://charlescoverdale.github.io/obr/reference/get_monthly_profiles.md) | The EFO forecast apportioned across the twelve months of the fiscal year (receipts and spending profiles, or the CGNCR breakdown). The reference point for “borrowing so far this year vs the OBR profile” in the run-up to a fiscal event. |

### Welfare Trends Report (WTR)

| Function | Returns |
|----|----|
| [`get_welfare_spending()`](https://charlescoverdale.github.io/obr/reference/get_welfare_spending.md) | Working-age welfare spending split by incapacity/non-incapacity (% GDP, from 1978-79) |
| [`get_incapacity_spending()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_spending.md) | Incapacity benefit spending by benefit type (ESA, IB, etc.) as % GDP |
| [`get_incapacity_caseloads()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_caseloads.md) | Combined incapacity caseloads and prevalence since 2008-09 |

### Fiscal Risks and Sustainability Report (FSR)

| Function | Returns |
|----|----|
| [`get_pension_projections()`](https://charlescoverdale.github.io/obr/reference/get_pension_projections.md) | **Deprecated in 0.5.1.** The OBR restructured the FSR workbooks in July 2026 and the state pension spending scenarios this returned are no longer published in that form. The series now lives in the FSR Chapter 3 workbook (Chart 3.11); see [obr.uk/frs](https://obr.uk/frs/fiscal-risks-and-sustainability-july-2026/). |

### Policy Measures Database (PMD)

| Function | Returns |
|----|----|
| [`get_policy_measures()`](https://charlescoverdale.github.io/obr/reference/get_policy_measures.md) | Every tax (since 1970) and spending (since 2010) measure scored at a UK fiscal event, with Exchequer effect by fiscal year in GBP million |
| [`policy_measures_summary()`](https://charlescoverdale.github.io/obr/reference/policy_measures_summary.md) | Net Exchequer effect aggregated by fiscal event and fiscal year |

### Fiscal rules

| Function | Returns |
|----|----|
| [`obr_fiscal_rules()`](https://charlescoverdale.github.io/obr/reference/obr_fiscal_rules.md) | The three Charter for Budget Responsibility rules (stability, investment, welfare cap) with metric, target description, and source Charter version. Numerical headroom is not shipped as a constant (changes at every fiscal event); derive it with [`obr_headroom()`](https://charlescoverdale.github.io/obr/reference/obr_headroom.md). |
| [`obr_headroom()`](https://charlescoverdale.github.io/obr/reference/obr_headroom.md) | The current budget surplus path from EFO Table 6.5: the margin against the stability rule in every forecast year. Pass `target_year` to flag the year the rule bites on. |

### Cache management

| Function | What it does |
|----|----|
| [`clear_cache()`](https://charlescoverdale.github.io/obr/reference/clear_cache.md) | Deletes all locally cached OBR files |

All download functions accept `refresh = TRUE` to force a fresh download
from the OBR website.

### Standard tidy long schema (v0.4.0)

The EFO, PFD, HFD, WTR, and FSR functions all return the same six
columns so outputs from different publications can be
[`rbind()`](https://rdrr.io/r/base/cbind.html)’d, joined, and plotted
the same way:

| Column | Type | Values |
|----|----|----|
| `period` | character | `"2024-25"`, `"2025Q1"`, etc. |
| `period_type` | character | `"fiscal_year"`, `"quarter"`, `"calendar_year"` |
| `series` | character | The variable name (e.g. `"CPI"`, `"PSNB"`, `"Net borrowing"`) |
| `metric_type` | character | `"level"`, `"yoy_pct"`, `"index"`, `"pct"`, `"pct_pts"` |
| `value` | double | The numeric value |
| `unit` | character | `"gbp_bn"`, `"pct"`, `"index"`, `"count_k"`, etc. |

[`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md)
adds `forecast_date` as a leading column.
[`get_forecast_revisions()`](https://charlescoverdale.github.io/obr/reference/get_forecast_revisions.md)
and
[`get_policy_measures()`](https://charlescoverdale.github.io/obr/reference/get_policy_measures.md)
use specialised multi-dimensional schemas (migration to the standard
layout queued for a later release).

The `metric_type` column resolves a class of bug from earlier versions
where, for example, CPI Index values and CPI year-on-year growth values
lived in the same `value` column with no machine-readable distinction.
See
[`vignette("efo-forecasts")`](https://charlescoverdale.github.io/obr/articles/efo-forecasts.md)
for a walkthrough.

### Vignettes

- [`vignette("efo-forecasts")`](https://charlescoverdale.github.io/obr/articles/efo-forecasts.md):
  working with the v0.4.0 schema, splitting Index from YoY, combining
  EFO with PFD outturn, comparing two vintages.
- [`vignette("vintages")`](https://charlescoverdale.github.io/obr/articles/vintages.md):
  pinning to a specific EFO vintage for reproducible analysis.
- [`vignette("forecast-revisions")`](https://charlescoverdale.github.io/obr/articles/forecast-revisions.md):
  decomposing PSNB revisions across vintages.
- [`vignette("policy-measures")`](https://charlescoverdale.github.io/obr/articles/policy-measures.md):
  working with the Policy Measures Database.

### Provenance and vintage control

| Function | What it does |
|----|----|
| `obr_provenance(x)` | Extracts the source URL, vintage, retrieval time, and file fingerprint attached to any returned `obr_tbl` |
| `summary(x)` | Prints the full provenance card alongside the structural summary |
| [`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md) | Lists every EFO published since June 2010, with publication dates and URL slugs |
| `obr_as_of(date)` | Returns the EFO that was current on a given calendar date |
| `obr_pin(vintage)` | Sets a session-wide EFO vintage; `get_efo_*` then defaults to that vintage |
| [`obr_unpin()`](https://charlescoverdale.github.io/obr/reference/obr_unpin.md) | Clears any pin set by [`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md) |
| [`obr_pinned()`](https://charlescoverdale.github.io/obr/reference/obr_pinned.md) | Returns the currently pinned vintage, or `NULL` |

------------------------------------------------------------------------

## Examples

### 1. How much did COVID cost the UK?

``` r

library(obr)

psnb <- get_psnb()
psnb[psnb$period %in% c("2018-19", "2019-20", "2020-21", "2021-22", "2022-23"),
     c("period", "value", "unit")]
#> # obr_tbl: 5 rows x 3 cols
#> # Source:       OBR Public Finances Databank, October 2026
#> # URL:          https://obr.uk/download/public-finances-databank-october-2026-efo/
#> # Retrieved:    2026-11-01 09:09:12 GMT
#> # File MD5:     be7530ecb36f
#> # Package:      obr 0.6.3
#> 
#>   period   value   unit
#>  2018-19  44.073 gbp_bn
#>  2019-20  58.763 gbp_bn
#>  2020-21 310.834 gbp_bn
#>  2021-22 115.978 gbp_bn
#>  2022-23 123.816 gbp_bn
```

The UK borrowed GBP 311bn in 2020-21, more than five times the GBP 59bn
of 2019-20, to pay for furlough, bounce-back loans and emergency NHS
spending.

------------------------------------------------------------------------

### 2. How has the OBR’s borrowing forecast changed over time?

The OBR first forecast 2024-25 borrowing at **GBP 58bn** (March 2020).
Its lowest forecast was **GBP 37bn** in March 2022; by March 2026 the
estimate had reached **GBP 153bn**, more than four times that low point.

``` r

psnb_fc <- get_forecasts("PSNB")
fc_2425 <- psnb_fc[psnb_fc$period == "2024-25", c("forecast_date", "value")]
print(fc_2425, n = 20)
#> # obr_tbl: 13 rows x 2 cols
#> # Source:       OBR Historical Official Forecasts Database, Spring 2026
#> # URL:          https://obr.uk/download/historical-official-forecasts-database/
#> # Retrieved:    2026-11-01 09:09:15 GMT
#> # File MD5:     4312a0cf5075
#> # Package:      obr 0.6.3
#> 
#>  forecast_date     value
#>     March 2020  57.92369
#>  November 2020  99.57407
#>     March 2021  74.43927
#>   October 2021  46.32206
#>     March 2022  36.52329
#>  November 2022  84.32658
#>     March 2023  85.39792
#>  November 2023  84.57033
#>     March 2024  87.22658
#>   October 2024 127.49186
#>     March 2025 137.32912
#>  November 2025 149.45600
#>     March 2026 152.74200
```

The
[`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md)
function returns every published forecast across all fiscal events,
making it straightforward to visualise forecast drift and assess how
fiscal plans have evolved.

------------------------------------------------------------------------

### 3. Has the UK ever run a surplus, and will it again?

``` r

psnb <- get_psnb()

# Years with a surplus (negative PSNB = receipts exceed spending)
psnb[psnb$value < 0, c("period", "value")]
#> # obr_tbl: 10 rows x 2 cols
#> # Source:       OBR Public Finances Databank, October 2026
#> # URL:          https://obr.uk/download/public-finances-databank-october-2026-efo/
#> # Retrieved:    2026-11-01 09:09:12 GMT
#> # File MD5:     be7530ecb36f
#> # Package:      obr 0.6.3
#> 
#>   period   value
#>  1948-49  -0.496
#>  1949-50  -0.587
#>  1950-51  -0.466
#>  1951-52  -0.069
#>  1955-56  -0.038
#>  1969-70  -0.872
#>  1970-71  -0.323
#>  1988-89  -5.530
#>  1999-00 -11.406
#>  2000-01 -16.305
```

The UK has run a surplus in only ten years since 1946-47, the last in
2000-01. The databank includes the OBR’s forecast to 2031-32, which has
borrowing in every year.

------------------------------------------------------------------------

### 4. Where does government revenue come from?

``` r

receipts <- get_receipts()

# Top tax sources in 2023-24
r <- receipts[receipts$period == "2023-24", ]
r <- r[order(-r$value), ]
head(r[, c("series", "value", "unit")], 8)
#> # obr_tbl: 8 rows x 3 cols
#> # Source:       OBR Public Finances Databank, October 2026
#> # URL:          https://obr.uk/download/public-finances-databank-october-2026-efo/
#> # Retrieved:    2026-11-01 09:09:12 GMT
#> # File MD5:     be7530ecb36f
#> # Package:      obr 0.6.3
#> 
#>                                                     series    value   unit
#>                             Public sector current receipts 1096.559 gbp_bn
#>                                    National accounts taxes  976.080 gbp_bn
#>                         Pay as your earn (PAYE) income tax  238.968 gbp_bn
#>                    National insurance contributions (NICs)  179.081 gbp_bn
#>                                   VAT (net of VAT refunds)  168.305 gbp_bn
#>  Onshore corporation tax (includes Bank Surcharge and EGL)   89.503 gbp_bn
#>                Public sector gross operating surplus (GOS)   74.662 gbp_bn
#>                     Other public sector taxes and receipts   59.039 gbp_bn
```

Income tax, National Insurance and VAT together raised 57% of current
receipts in 2023-24. Over time the breakdown shows long-run shifts, such
as income tax’s rising share as fiscal drag pulls more earners into
higher bands.

------------------------------------------------------------------------

### 5. What does the October 2026 Budget forecast for borrowing?

[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)
returns the latest EFO unless you pin a vintage.

``` r

efo <- get_efo_fiscal()
efo[efo$series == "Net borrowing", c("period", "series", "value", "unit")]
#> # obr_tbl: 6 rows x 4 cols
#> # Source:       OBR Economic and Fiscal Outlook, October 2026
#> # URL:          https://obr.uk/download/october-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> # Retrieved:    2026-11-01 09:09:13 GMT
#> # File MD5:     09851806b48f
#> # Package:      obr 0.6.3
#> 
#>   period        series     value   unit
#>  2026-27 Net borrowing 133.19601 gbp_bn
#>  2027-28 Net borrowing 111.98047 gbp_bn
#>  2028-29 Net borrowing  99.53613 gbp_bn
#>  2029-30 Net borrowing  73.78046 gbp_bn
#>  2030-31 Net borrowing  66.90011 gbp_bn
#>  2031-32 Net borrowing  68.33916 gbp_bn
```

The EFO detailed tables also include the full breakdown: current
receipts, current expenditure, depreciation, net investment and net
borrowing, so you can see exactly how the deficit is projected to
narrow.

### 5a. Reproducing an analysis as it would have looked on a past date

Because the OBR revises its forecast at every Budget and Statement, an
analysis run today and the same analysis run six months from now can
return materially different numbers. The vintage layer pins to a
specific EFO so the analysis is reproducible.

``` r

# What did the OBR forecast for 2027-28 borrowing in October 2024 vs March 2026?
oct_2024 <- get_efo_fiscal(vintage = "October 2024")
mar_2026 <- get_efo_fiscal(vintage = "March 2026")

oct_2024[oct_2024$series == "Net borrowing" & oct_2024$period == "2027-28", ]
mar_2026[mar_2026$series == "Net borrowing" & mar_2026$period == "2027-28", ]

# Or in one step, with the v0.4.0 helper:
diffs <- obr_compare_vintages("October 2024", "March 2026", what = "fiscal")
diffs[diffs$series == "Net borrowing", c("period", "value_a", "value_b", "revision")]
#> # obr_tbl: 5 rows x 4 cols
#> # Source:       OBR Economic and Fiscal Outlook, March 2026
#> # URL:          https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> # Retrieved:    2026-11-01 09:09:17 GMT
#> # File MD5:     5b5eeaf79b96
#> # Package:      obr 0.6.3
#> # Note:         Vintage diff: October 2024 (a) -> March 2026 (b). revision = value_b - value_a. Earlier vintage URL: https://obr.uk/download/october-2024-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/
#> 
#>   period   value_a   value_b  revision
#>  2025-26 105.57651 132.73508 27.158562
#>  2026-27  88.45967 115.46142 27.001754
#>  2027-28  72.16790  96.46737 24.299469
#>  2028-29  71.90672  86.01563 14.108919
#>  2029-30  70.58379  63.40344 -7.180343

# Or pin once and let every subsequent EFO call use that vintage
obr_pin("October 2024")
get_efo_fiscal()                  # uses October 2024
get_efo_economy("inflation")      # also uses October 2024
obr_unpin()

# Find which EFO was current on a given date
obr_as_of("2024-12-15")
#> [1] "October 2024"
```

------------------------------------------------------------------------

### 6. Is the UK’s incapacity benefits bill rising?

``` r

welfare <- get_welfare_spending()
# Working-age incapacity benefits spending, % of GDP (outturn, then forecast)
ic <- welfare[welfare$series == "Working-age incapacity benefits spending" &
              welfare$period >= "2018-19", c("period", "value", "unit")]
print(ic, n = 11)
#> # obr_tbl: 11 rows x 3 cols
#> # Source:       OBR Welfare Trends Report, October 2024
#> # URL:          https://obr.uk/download/welfare-trends-report-october-2024-charts-and-tables/
#> # Retrieved:    2026-11-01 09:09:18 GMT
#> # File MD5:     c587017c08a1
#> # Package:      obr 0.6.3
#> 
#>   period     value unit
#>  2018-19 0.6756497  pct
#>  2019-20 0.7386774  pct
#>  2020-21 0.8825464  pct
#>  2021-22 0.8717820  pct
#>  2022-23 0.8423765  pct
#>  2023-24 0.9239248  pct
#>  2024-25 0.9980306  pct
#>  2025-26 1.0051716  pct
#>  2026-27 1.0038338  pct
#>  2027-28 1.0023592  pct
#>  2028-29 1.0056712  pct

# Incapacity benefit claimants (thousands)
cases <- get_incapacity_caseloads()
cases[cases$series == "Claimants" & cases$period >= "2018-19",
      c("period", "value", "unit")]
#> # obr_tbl: 6 rows x 3 cols
#> # Source:       OBR Welfare Trends Report, October 2024
#> # URL:          https://obr.uk/download/welfare-trends-report-october-2024-charts-and-tables/
#> # Retrieved:    2026-11-01 09:09:18 GMT
#> # File MD5:     c587017c08a1
#> # Package:      obr 0.6.3
#> 
#>   period    value    unit
#>  2018-19 2129.911 count_k
#>  2019-20 2257.000 count_k
#>  2020-21 2396.000 count_k
#>  2021-22 2544.000 count_k
#>  2022-23 2744.000 count_k
#>  2023-24 2930.000 count_k
```

Working-age incapacity benefits spending rose from 0.7% of GDP in
2018-19 to 0.9% in 2023-24, and the October 2024 forecast holds it at
about 1.0% to 2028-29. Claimant numbers rose from 2.1 million to 2.9
million over the same five years.

------------------------------------------------------------------------

### 7. Every tax measure in a Budget

``` r

# All tax measures scored from 2025-26 onwards
pmd <- get_policy_measures(type = "tax", since = "2025-26")

# Filter to measures from a specific event, ordered by 2025-26 effect
oct24 <- pmd[grepl("October 2024", pmd$event) &
             pmd$fiscal_year == "2025-26", ]
oct24 <- oct24[order(-oct24$value_mn), ]
head(oct24[, c("measure", "head", "value_mn")])
```

The PMD covers every measure scored at a UK fiscal event: 1970 onwards
for tax, 2010 onwards for spending. Combine `search =` and `since =` to
pull a thematic time series, e.g. all alcohol-duty measures since 2010.

``` r

get_policy_measures(type = "tax", search = "alcohol", since = "2010-11")
```

### 7a. What does the OBR say about the fiscal rules?

``` r

obr_fiscal_rules()
```

Returns the three Charter for Budget Responsibility rules in force
(stability rule, investment rule, welfare cap), with their target
metric, direction of pass, and the source Charter version. Numerical
headroom is not shipped as a constant because it changes at every fiscal
event; derive it from
[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)
or consult the EFO press release for the relevant vintage.

------------------------------------------------------------------------

### 8. Browsing the full EFO databank

``` r

# Every detailed-forecast table the package recognises
cat <- obr_efo_catalogue()
nrow(cat)  # 39; 6.11 and 6.15 only point at tables in the EFO report

# All Debt-section tables
cat[cat$section == "Debt", c("table_id", "title")]
#>  table_id                                                          title
#>      6.11                    Public sector net debt year-on-year changes
#>      6.12                                          Total gross financing
#>      6.13                          Composition of public sector net debt
#>      6.14                         Composition of public sector net worth
#>      6.15                              Reconciliation of PSNCR and CGNCR
#>      6.16        Central government debt interest by financing component
#>      6.17 Outstanding stocks, debt interest payments and effective rates

# Pull any one
get_efo_table("6.13")             # composition of net debt, % of GDP
get_efo_table("1.19")             # CPI category inflation, quarterly
get_efo_table("6.16")             # debt interest by financing component
get_efo_table("6.5", vintage = "October 2024")
```

The
[`get_efo_table()`](https://charlescoverdale.github.io/obr/reference/get_efo_table.md)
dispatcher routes each id to a layout-specific parser and returns the
standard v0.4 schema. The headline wrappers
([`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md),
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md))
remain as convenience entry points; under the hood they call the
dispatcher.

------------------------------------------------------------------------

## Limitations

A few things `obr` deliberately does not do, and a few caveats worth
knowing.

- **Fiscal Risks and Sustainability coverage is thin.** The EFO
  detailed-forecast tables are complete: `obr` reaches all 37 that hold
  data in the Aggregates and Economy workbooks (sheets 6.11 and 6.15
  only point at tables in the EFO report), discoverable through
  [`obr_efo_catalogue()`](https://charlescoverdale.github.io/obr/reference/obr_efo_catalogue.md)
  and fetchable with
  [`get_efo_table()`](https://charlescoverdale.github.io/obr/reference/get_efo_table.md).
  The FSR long-run projections are the exception.
  [`get_pension_projections()`](https://charlescoverdale.github.io/obr/reference/get_pension_projections.md)
  was deprecated in v0.5.1 after the OBR restructured the FSR workbooks
  in July 2026, and nothing has replaced it yet.
- **EFO and PFD use the standard v0.4.0 schema; FRD and PMD do not
  yet.**
  [`get_forecast_revisions()`](https://charlescoverdale.github.io/obr/reference/get_forecast_revisions.md)
  and
  [`get_policy_measures()`](https://charlescoverdale.github.io/obr/reference/get_policy_measures.md)
  return their existing multi-dimensional schemas (forecast date x
  revision component, fiscal event x measure x head). Migration to the
  v0.4.0 layout is queued for a later release.
- **Vintage table is hardcoded and needs maintenance.**
  [`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md)
  returns a static list of EFOs. When a new EFO publishes, the package
  needs a release to recognise it as a pinnable vintage. Until then, the
  dynamic resolver will still find the live file but
  `obr_pin("November 2026")` will error.
- **The `classify_metric_type()` heuristic is regex-based.** It
  correctly handles the OBR’s current naming conventions (Index,
  deflator, inflation, growth, rate). New series with unusual names may
  default to `metric_type = "level"`; the per-measure default supplied
  by
  [`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md)
  corrects this for the inflation sheet but may need tuning if OBR adds
  a new sheet.
- **UK only.** The package wraps OBR publications; it does not cover the
  US Congressional Budget Office, the Australian Parliamentary Budget
  Office, or other fiscal-watchdog equivalents.
- **No Python equivalent.** A port to Python is not planned; users
  wanting the same data in Python should use the OBR’s published Excel
  files directly or contribute a port.
- **Network access is required on first use.** Each edition is cached
  separately and reused for 7 days (`options(obr.cache_ttl = )` sets the
  lifetime in hours);
  [`clear_cache()`](https://charlescoverdale.github.io/obr/reference/clear_cache.md)
  or `refresh = TRUE` forces a re-download. If a re-download fails, the
  expired copy is used with a warning. There is no offline mode.

------------------------------------------------------------------------

## Related packages

| Package | Description |
|----|----|
| [`ons`](https://github.com/charlescoverdale/ons) | UK Office for National Statistics data |
| [`hmrc`](https://github.com/charlescoverdale/hmrc) | HM Revenue & Customs tax data |
| [`boe`](https://github.com/charlescoverdale/boe) | Bank of England data |
| [`fred`](https://github.com/charlescoverdale/fred) | US Federal Reserve (FRED) data |
| [`debtkit`](https://github.com/charlescoverdale/debtkit) | Debt sustainability analysis |
| [`yieldcurves`](https://github.com/charlescoverdale/yieldcurves) | Yield curve fitting (Nelson-Siegel, Svensson) |
| [`inflateR`](https://github.com/charlescoverdale/inflateR) | Inflation adjustment for UK price series |
| [`inflationkit`](https://github.com/charlescoverdale/inflationkit) | Inflation analysis |
| [`greenbook`](https://github.com/charlescoverdale/greenbook) | HM Treasury Green Book CBA primitives |
| [`magentabook`](https://github.com/charlescoverdale/magentabook) | HM Treasury Magenta Book evaluation primitives |

------------------------------------------------------------------------

## Keeping data up to date

The Public Finances Databank is accessed via a stable URL that the OBR
keeps pointed at the latest file. The Historical Official Forecasts
Database, EFO, WTR, and FSR functions all use a dynamic URL resolver
that probes the OBR’s recent fiscal events (most recent first) and uses
whichever URL is live, so the package automatically picks up new
editions without a code change.

If the resolver cannot find a live URL (for example because of a
temporary network outage, or because the OBR has moved to an unfamiliar
slug pattern), it falls back to the last-known-good URL and emits an
explicit warning rather than failing silently. The returned `obr_tbl`
always records the URL that was actually used, so any analysis carries
its own audit trail.

The OBR publishes on a roughly predictable schedule: the EFO twice a
year (March and October/November), the FSR each summer, the WTR
annually. The package’s fallback URLs are refreshed at each release;
check the
[NEWS](https://github.com/charlescoverdale/obr/blob/main/NEWS.md) for
the current fallback edition.

------------------------------------------------------------------------

## Issues

Please report bugs or requests at
<https://github.com/charlescoverdale/obr/issues>.

## Keywords

Office for Budget Responsibility, OBR, UK fiscal forecasts, economic
forecasts, GDP forecast, inflation forecast, public finances, government
borrowing, fiscal policy, UK budget, R package
