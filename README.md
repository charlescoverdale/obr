# obr

An R package for accessing data published by the [Office for Budget Responsibility](https://obr.uk/) (OBR).

## What is the OBR?

The Office for Budget Responsibility is the UK's independent fiscal watchdog. It was created in 2010 by the coalition government to provide an independent check on the government's fiscal plans — a role previously held by HM Treasury itself.

The distinction matters. HM Treasury is the government department that *sets* fiscal policy: it decides tax rates, spending plans, and how much the government intends to borrow. The OBR's job is to *scrutinise* those plans independently, producing its own economic and fiscal forecasts that are not influenced by ministers. Think of it as the equivalent of the Bank of England's independence for monetary policy, but applied to public finances.

In practice, this means the OBR publishes forecasts at each Budget and Autumn Statement showing whether it thinks the government is on track to meet its own fiscal rules — and it has no political incentive to be optimistic.

---

## Key OBR datasets

| Dataset | What it contains | Frequency |
|---|---|---|
| [Public Finances Databank](https://obr.uk/public-finances-databank/) | Outturn data on PSNB, PSND, receipts, and expenditure back to 1946-47 | Monthly |
| [Historical Official Forecasts Database](https://obr.uk/data/) | Every forecast the OBR (and pre-OBR Treasury) has published for key fiscal and economic variables since 1970 | Each fiscal event |
| [Economic and Fiscal Outlook](https://obr.uk/efo/) | The flagship publication at each Budget — detailed projections across 5 years | Each Budget / Autumn Statement |
| [Fiscal Sustainability Report](https://obr.uk/fsr/) | Long-run projections over 50 years, covering ageing, health, and debt dynamics | Annual |
| [Welfare Trends Report](https://obr.uk/wtr/) | Spending trends across the benefits system | Annual |

This package covers the **Public Finances Databank** and **Historical Official Forecasts Database** — the two datasets most useful for programmatic analysis.

---

## Why does this package exist?

All OBR data is freely available at [obr.uk](https://obr.uk). The problem is *how* it is available: as Excel files with non-standard layouts, inconsistent headers, and footnote-laden sheets that require significant wrangling before they are usable in R.

For example, the Public Finances Databank has column headers buried in row 4 of the spreadsheet, data starting in row 8, and trailing footnote numbers appended to column names. The Historical Forecasts Database stores forecasts as a vintage matrix — rows are fiscal events, columns are fiscal years — which needs reshaping into a long format before it can be plotted or analysed.

This package handles all of that automatically. One function call returns a clean, tidy data frame. Data is cached locally so subsequent calls are instant.

```r
# Without this package
path <- "~/Downloads/Public_finances_databank_March_2025.xlsx"
raw  <- readxl::read_excel(path, sheet = "Aggregates (£bn)", col_names = FALSE)
series_names <- as.character(unlist(raw[4, ]))
# ... 30 more lines of wrangling ...

# With this package
library(obr)
get_psnb()
```

---

## Functions

### Public Finances Databank

| Function | Returns |
|---|---|
| `get_psnb()` | Annual Public Sector Net Borrowing in £bn |
| `get_psnd()` | Annual Public Sector Net Debt in £bn |
| `get_expenditure()` | Annual Total Managed Expenditure in £bn |
| `get_receipts()` | Tax receipts broken down by type, in £bn |
| `get_public_finances()` | All aggregate series in tidy long format |

### Historical Forecasts Database

| Function | Returns |
|---|---|
| `list_forecast_series()` | Data frame of available series (no download needed) |
| `get_forecasts(series)` | Every OBR forecast for a given series, in tidy long format |

### Cache management

| Function | What it does |
|---|---|
| `clear_cache()` | Deletes all locally cached OBR files |

All download functions accept `refresh = TRUE` to force a fresh download from the OBR website.

---

## Examples

### 1. How much did COVID cost the UK?

```r
library(obr)

psnb <- get_psnb()
psnb[psnb$year %in% c("2018-19", "2019-20", "2020-21", "2021-22", "2022-23"), ]
#>       year  psnb_bn
#>  2018-19     42.5
#>  2019-20     57.1
#>  2020-21    317.8   # ← COVID year
#>  2021-22    144.8
#>  2022-23     87.6
```

The UK borrowed £318bn in 2020-21 — roughly seven times the pre-pandemic level — to fund furlough, bounce-back loans, and emergency NHS spending.

---

### 2. How has the OBR's borrowing forecast changed over time?

The OBR first forecast 2024-25 borrowing at **£37bn** (March 2022). By November 2025, that estimate had risen to **£149bn** — four times the original figure.

```r
psnb_fc <- get_forecasts("PSNB")
fc_2425 <- psnb_fc[psnb_fc$fiscal_year == "2024-25", c("forecast_date", "value")]
fc_2425
#>    forecast_date   value
#>     March 2022    36.5
#>  November 2022    84.3
#>     March 2023    85.4
#>  November 2023    84.6
#>     March 2024    87.2
#>   October 2024   127.5
#>     March 2025   137.3
#>  November 2025   149.5
```

The `get_forecasts()` function returns every published forecast across all fiscal events, making it straightforward to visualise forecast drift and assess how fiscal plans have evolved.

---

### 3. Has the UK ever run a surplus — and how likely is it to again?

```r
psnb <- get_psnb()

# Years with a surplus (negative PSNB = receipts exceed spending)
psnb[psnb$psnb_bn < 0, ]
#>       year  psnb_bn
#>  1969-70    -0.5
#>  1970-71    -1.3
#>  1971-72    -0.1
#>  1988-89    -9.0
#>  1989-90    -8.0
#>  1990-91    -0.1
#>  1997-98   -12.7
#>  1998-99   -14.5
#>  1999-00   -17.9
#>  2000-01    -0.5
```

The UK last ran a surplus in 2000-01. In the 24 years since, the government has borrowed every year. Combine with `get_forecasts("PSNB_pct")` to see whether the OBR projects any future surpluses.

---

### 4. Where does government revenue come from?

```r
receipts <- get_receipts()

# Top tax sources in 2023-24
r <- receipts[receipts$year == "2023-24", ]
r <- r[order(-r$value), ]
head(r[, c("series", "value")], 8)
#>                              series   value
#>   Public sector current receipts   1101.5
#>                       Income tax    290.4
#>                              VAT    183.1
#>    National insurance contributions 182.4
#>                    Corporation tax   88.4
#>                       Council tax   44.9
#>                         Fuel duty   24.5
#>                    Stamp duties     18.4
```

Income tax, VAT, and National Insurance together account for around 60% of all government receipts. Breaking this down over time reveals long-run shifts — such as the rising share of income tax as fiscal drag pulls more earners into higher bands.

---

## Related packages

| Package | What it covers |
|---|---|
| [`nomisr`](https://github.com/ropensci/nomisr) | ONS/Nomis labour market data: employment, unemployment, earnings, by geography |
| [`WDI`](https://github.com/vincentarelbundock/WDI) | World Bank Development Indicators — useful for international comparisons with UK fiscal data |
| [`OECD`](https://github.com/expersso/OECD) | OECD statistics API, covering fiscal, economic, and social indicators across member countries |
| [`fredr`](https://github.com/sboysel/fredr) | US Federal Reserve FRED database — macroeconomic time series for cross-country analysis |
| [`inflateR`](https://github.com/charlescoverdale/inflateR) | Adjust nominal values for inflation across 13 currencies — pairs naturally with OBR nominal spending and receipts data |

---

## Issues

Please report bugs or requests at <https://github.com/charlescoverdale/obr/issues>.
