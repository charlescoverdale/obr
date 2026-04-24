# Changelog

## obr 0.2.5

CRAN release: 2026-04-14

- EFO, Welfare Trends Report, and Fiscal Sustainability Report download
  URLs are now resolved dynamically, trying recent publication dates in
  reverse chronological order. This prevents functions from breaking
  when OBR publishes new editions. Hardcoded URLs are retained as
  fallbacks.

## obr 0.2.4

CRAN release: 2026-03-17

- Removed non-existent pkgdown URL from DESCRIPTION.

## obr 0.2.3

- Examples now cache to
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html) instead of the
  user’s home directory, fixing CRAN policy compliance for `\donttest`
  examples.
- Cache directory is now configurable via
  `options(obr.cache_dir = ...)`.

## obr 0.2.2

CRAN release: 2026-03-12

- Fix README URLs flagged by CRAN incoming checks (301 redirects).
- Add “Databank” to WORDLIST.

## obr 0.2.1

- Update WORDLIST with domain-specific terms (EFO, FSR, WTR, CPIH, etc.)

## obr 0.2.0

### New datasets

#### Economic and Fiscal Outlook (EFO)

- [`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)
  — five-year fiscal projections (net borrowing components) from the
  latest Budget
- `get_efo_economy(measure)` — quarterly economic projections:
  `"inflation"` (CPI, CPIH, RPI, RPIX), `"labour"` (employment,
  unemployment, participation), or `"output_gap"`
- [`list_efo_economy_measures()`](https://charlescoverdale.github.io/obr/reference/list_efo_economy_measures.md)
  — list available economy measures

#### Welfare Trends Report (WTR)

- [`get_welfare_spending()`](https://charlescoverdale.github.io/obr/reference/get_welfare_spending.md)
  — working-age welfare spending split by incapacity and non-incapacity
  (% of GDP, from 1978-79)
- [`get_incapacity_spending()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_spending.md)
  — incapacity benefits spending by benefit type (ESA, IB, Invalidity
  Benefit, Sickness Benefit, SDA) as % of GDP
- [`get_incapacity_caseloads()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_caseloads.md)
  — combined incapacity benefit caseloads and prevalence since 2008-09

#### Fiscal Risks and Sustainability Report (FSR)

- [`get_pension_projections()`](https://charlescoverdale.github.io/obr/reference/get_pension_projections.md)
  — 50-year state pension spending projections (% of GDP) under
  alternative demographic and triple-lock scenarios

## obr 0.1.0

- Initial release
- [`get_psnb()`](https://charlescoverdale.github.io/obr/reference/get_psnb.md),
  [`get_psnd()`](https://charlescoverdale.github.io/obr/reference/get_psnd.md),
  [`get_expenditure()`](https://charlescoverdale.github.io/obr/reference/get_expenditure.md),
  [`get_receipts()`](https://charlescoverdale.github.io/obr/reference/get_receipts.md)
  for Public Finances Databank aggregates
- [`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md)
  for all Databank series in tidy long format
- [`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md)
  and
  [`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md)
  for Historical Official Forecasts Database
- [`clear_cache()`](https://charlescoverdale.github.io/obr/reference/clear_cache.md)
  to remove locally cached files
- Data sourced from the OBR Public Finances Databank and Historical
  Official Forecasts Database
