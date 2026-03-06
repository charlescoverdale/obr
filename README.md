# obr

Access data published by the [Office for Budget Responsibility](https://obr.uk/) — the UK's independent fiscal watchdog — directly from R.

Data is downloaded on first use and cached locally. No API key required.

## Installation

```r
# Development version
devtools::install_github("charlescoverdale/obr")

# CRAN (once available)
install.packages("obr")
```

---

## What questions can you answer?

### How much did COVID cost the UK government?

```r
library(obr)

psnb <- get_psnb()
psnb[psnb$year %in% c("2018-19", "2019-20", "2020-21", "2021-22", "2022-23"), ]
#>       year  psnb_bn
#>  2018-19     42.5
#>  2019-20     57.1
#>  2020-21    317.8   # ← COVID year: furlough, bounce-back loans, NHS
#>  2021-22    144.8
#>  2022-23     87.6
```

The UK borrowed **£318 billion** in 2020-21 — nearly six times the pre-pandemic level. That's roughly £11,000 per household.

---

### How wrong were the OBR's forecasts?

The OBR first forecast 2024-25 borrowing at **£36bn** (March 2022). By November 2025 the outturn was tracking at **£149bn** — more than four times the original estimate.

```r
psnb_fc <- get_forecasts("PSNB")
psnb_fc[psnb_fc$fiscal_year == "2024-25", c("forecast_date", "value")]
#>    forecast_date   value
#>     March 2022    36.5   ← original forecast
#>  November 2022    84.3
#>     March 2023    85.4
#>  November 2023    84.6
#>     March 2024    87.2
#>   October 2024   127.5
#>     March 2025   137.3
#>  November 2025   149.5   ← latest estimate
```

The `get_forecasts()` function returns every forecast the OBR has ever made for a given year — useful for tracking forecast drift and assessing fiscal credibility.

---

### Has the UK ever run a surplus?

```r
psnb <- get_psnb()

# Years with a surplus (negative PSNB = government taking in more than it spends)
surpluses <- psnb[psnb$psnb_bn < 0, ]
surpluses
#>       year  psnb_bn
#>  1997-98    -12.7
#>  1998-99    -14.5
#>  1999-00    -17.9
#>  2000-01     -0.5
```

The UK last ran a surplus in 2000-01. In the 24 years since, the government has borrowed in every single year.

---

### How does the UK's debt trajectory look?

```r
psnd <- get_psnd()
tail(psnd, 10)
#>        year   psnd_bn
#>  2015-16    1590.5
#>  2016-17    1726.7
#>  2017-18    1763.8
#>  2018-19    1800.0
#>  2019-20    1870.4
#>  2020-21    2204.1
#>  2021-22    2365.4
#>  2022-23    2537.2
#>  2023-24    2700.3
#>  2024-25    2763.1   ← latest
```

UK national debt has roughly doubled since 2015 and increased by over £500bn during the COVID years alone.

---

### Where does the government's money come from?

```r
receipts <- get_receipts()

# Filter to a single year and sort by size
r2024 <- receipts[receipts$year == "2023-24", ]
r2024[order(-r2024$value), c("series", "value")]
#>                              series   value
#>   Public sector current receipts    1101.5   ← total
#>                       Income tax     290.4
#>    National insurance contributions  182.4
#>                              VAT     183.1
#>                    Corporation tax    88.4
#>                           Fuel duty   24.5
#>                      Council tax     44.9
#>                    ...
```

Income tax, NICs, and VAT together account for roughly 60% of all government receipts.

---

### How has OBR's CPI forecast held up?

```r
cpi_fc <- get_forecasts("CPI")

# What did the OBR forecast for 2022-23 CPI at each fiscal event?
cpi_fc[cpi_fc$fiscal_year == "2022-23", c("forecast_date", "value")]
#>   forecast_date  value
#>    March 2020     2.0   ← pre-pandemic forecast
#>  November 2020     2.0
#>     March 2021     1.5
#>   October 2021     4.4   ← first post-reopening warning
#>     March 2022     7.4   ← war in Ukraine hits energy prices
#>  November 2022     9.1   ← actual outturn tracking at 9%+
```

---

## Functions

### Public Finances Databank

| Function | Returns |
|---|---|
| `get_psnb()` | Annual Public Sector Net Borrowing (£bn) |
| `get_psnd()` | Annual Public Sector Net Debt (£bn) |
| `get_expenditure()` | Annual Total Managed Expenditure (£bn) |
| `get_receipts()` | Tax receipts broken down by type (£bn) |
| `get_public_finances()` | All aggregate series in tidy long format |

### Historical Forecasts Database

| Function | Returns |
|---|---|
| `list_forecast_series()` | All available forecast series |
| `get_forecasts("PSNB")` | Every OBR forecast for a given series |

Available series for `get_forecasts()`:

| Series | Description |
|---|---|
| `"PSNB"` | Public sector net borrowing (£bn) |
| `"PSNB_pct"` | Public sector net borrowing (% of GDP) |
| `"PSND"` | Public sector net debt (% of GDP) |
| `"receipts"` | Public sector current receipts (£bn) |
| `"receipts_pct"` | Public sector current receipts (% of GDP) |
| `"expenditure"` | Total managed expenditure (£bn) |
| `"expenditure_pct"` | Total managed expenditure (% of GDP) |
| `"GDP"` | Nominal GDP growth (%) |
| `"real_GDP"` | Real GDP growth (%) |
| `"CPI"` | CPI inflation (%) |

### Cache management

All functions cache downloaded files locally. Pass `refresh = TRUE` to force a fresh download:

```r
get_psnb(refresh = TRUE)  # re-download from OBR
clear_cache()              # delete all cached files
```

---

## Issues

Please report bugs or requests at <https://github.com/charlescoverdale/obr/issues>.
