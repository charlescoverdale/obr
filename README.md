# obr

Access data published by the [Office for Budget Responsibility](https://obr.uk/) — the UK's independent fiscal watchdog — directly from R.

Data is downloaded from the OBR on first use and cached locally. No API key or bundled data files required.

## Installation

```r
# Development version
devtools::install_github("charlescoverdale/obr")
```

## Data sources

obr provides access to two OBR datasets:

| Dataset | Coverage | Update frequency |
|---|---|---|
| [Public Finances Databank](https://obr.uk/public-finances-databank/) | 1946–present (outturn + forecast) | Monthly |
| [Historical Official Forecasts Database](https://obr.uk/data/) | Every fiscal event since 1970 | Each Budget / Autumn Statement |

## Functions

### Public Finances Databank

```r
library(obr)

# Annual PSNB in £bn (the deficit)
get_psnb()

# Annual PSND in £bn (total debt)
get_psnd()

# Total Managed Expenditure in £bn
get_expenditure()

# Receipts broken down by tax type (VAT, income tax, NICs, etc.)
get_receipts()

# All aggregate series in tidy long format
get_public_finances()
```

All functions cache the downloaded file locally. Use `refresh = TRUE` to force a re-download:

```r
get_psnb(refresh = TRUE)
```

### Historical Forecasts Database

The forecasts database records every OBR forecast at every fiscal event since 2010, alongside historical Budget forecasts going back to 1970 for some series. This makes it easy to see how forecasts have evolved and compare them with outturns.

```r
# See available series
list_forecast_series()

# Get all PSNB forecasts in tidy long format
get_forecasts("PSNB")

# What did OBR forecast for 2024-25 PSNB at each fiscal event?
psnb <- get_forecasts("PSNB")
psnb[psnb$fiscal_year == "2024-25", ]
#>      series forecast_date fiscal_year      value
#> ...    PSNB    March 2020     2024-25   57.92369
#> ...    PSNB November 2020     2024-25   99.57407
#> ...    PSNB    March 2021     2024-25   74.43927
#> ...    PSNB  October 2021     2024-25   46.32206
#> ...    PSNB    March 2022     2024-25   36.52329
#> ...    PSNB November 2022     2024-25   84.32658
#> ...    PSNB    March 2023     2024-25   85.39792
#> ...    PSNB November 2023     2024-25   84.57033
#> ...    PSNB    March 2024     2024-25   87.22658
#> ...    PSNB  October 2024     2024-25  127.49186
#> ...    PSNB    March 2025     2024-25  137.32912
#> ...    PSNB November 2025     2024-25  149.45600
```

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

```r
# Delete all cached files (forces fresh download on next call)
clear_cache()
```

## Issues

Please report bugs or requests at <https://github.com/charlescoverdale/obr/issues>.
