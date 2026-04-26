# Package index

## Public Finances Databank

Outturn data on borrowing, debt, receipts, and expenditure since 1946.

- [`get_public_finances()`](https://charlescoverdale.github.io/obr/reference/get_public_finances.md)
  : Get all Public Finances Databank aggregates
- [`get_psnb()`](https://charlescoverdale.github.io/obr/reference/get_psnb.md)
  : Get Public Sector Net Borrowing (PSNB)
- [`get_psnd()`](https://charlescoverdale.github.io/obr/reference/get_psnd.md)
  : Get Public Sector Net Debt (PSND)
- [`get_expenditure()`](https://charlescoverdale.github.io/obr/reference/get_expenditure.md)
  : Get Total Managed Expenditure
- [`get_receipts()`](https://charlescoverdale.github.io/obr/reference/get_receipts.md)
  : Get public sector receipts by tax type

## Historical Official Forecasts

Every OBR forecast since 2010 for key fiscal and economic variables.

- [`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md)
  : List available forecast series
- [`get_forecasts()`](https://charlescoverdale.github.io/obr/reference/get_forecasts.md)
  : Get OBR forecast history for a fiscal series
- [`obr_forecast_panel()`](https://charlescoverdale.github.io/obr/reference/obr_forecast_panel.md)
  : Build a wide real-time panel of OBR forecasts
- [`get_forecast_revisions()`](https://charlescoverdale.github.io/obr/reference/get_forecast_revisions.md)
  : Get OBR forecast revisions

## Economic and Fiscal Outlook

Five-year projections from the latest Budget.

- [`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md)
  : Get EFO fiscal projections (net borrowing components)
- [`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md)
  : Get EFO economy projections
- [`list_efo_economy_measures()`](https://charlescoverdale.github.io/obr/reference/list_efo_economy_measures.md)
  : List available EFO economy measures

## Welfare Trends Report

Incapacity benefit spending and caseloads.

- [`get_welfare_spending()`](https://charlescoverdale.github.io/obr/reference/get_welfare_spending.md)
  : Get working-age welfare spending
- [`get_incapacity_spending()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_spending.md)
  : Get incapacity benefits spending by type
- [`get_incapacity_caseloads()`](https://charlescoverdale.github.io/obr/reference/get_incapacity_caseloads.md)
  : Get incapacity benefit caseloads

## Fiscal Risks and Sustainability Report

50-year state pension projections.

- [`get_pension_projections()`](https://charlescoverdale.github.io/obr/reference/get_pension_projections.md)
  : Get long-run state pension spending projections

## Policy Measures Database

Every UK fiscal-event-scored tax measure since 1970 and spending measure
since 2010.

- [`get_policy_measures()`](https://charlescoverdale.github.io/obr/reference/get_policy_measures.md)
  : Get OBR policy measures by fiscal event
- [`policy_measures_summary()`](https://charlescoverdale.github.io/obr/reference/policy_measures_summary.md)
  : Summarise policy measures by fiscal event

## Fiscal rules

Charter for Budget Responsibility rule definitions.

- [`obr_fiscal_rules()`](https://charlescoverdale.github.io/obr/reference/obr_fiscal_rules.md)
  : Get the current UK fiscal rules

## Vintage layer

Pin analyses to a specific OBR Economic and Fiscal Outlook for
reproducibility.

- [`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md)
  : List known OBR Economic and Fiscal Outlook vintages
- [`obr_as_of()`](https://charlescoverdale.github.io/obr/reference/obr_as_of.md)
  : Find the OBR publication that was current on a given date
- [`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md)
  : Pin a session-wide OBR EFO vintage
- [`obr_unpin()`](https://charlescoverdale.github.io/obr/reference/obr_unpin.md)
  : Clear the pinned OBR EFO vintage
- [`obr_pinned()`](https://charlescoverdale.github.io/obr/reference/obr_pinned.md)
  : Show the currently pinned OBR EFO vintage

## Provenance

Inspect and manage the source metadata attached to every returned
object.

- [`obr_provenance()`](https://charlescoverdale.github.io/obr/reference/obr_provenance.md)
  : Extract OBR provenance metadata
- [`print(`*`<obr_tbl>`*`)`](https://charlescoverdale.github.io/obr/reference/print.obr_tbl.md)
  : Print an obr_tbl
- [`summary(`*`<obr_tbl>`*`)`](https://charlescoverdale.github.io/obr/reference/summary.obr_tbl.md)
  : Summary of an obr_tbl
- [`` `[`( ``*`<obr_tbl>`*`)`](https://charlescoverdale.github.io/obr/reference/sub-.obr_tbl.md)
  : Subset an obr_tbl, preserving provenance
- [`as.data.frame(`*`<obr_tbl>`*`)`](https://charlescoverdale.github.io/obr/reference/as.data.frame.obr_tbl.md)
  : Coerce an obr_tbl to a plain data.frame

## Cache management

Manage locally cached OBR data files.

- [`clear_cache()`](https://charlescoverdale.github.io/obr/reference/clear_cache.md)
  : Clear cached OBR files

## Package

- [`obr`](https://charlescoverdale.github.io/obr/reference/obr-package.md)
  [`obr-package`](https://charlescoverdale.github.io/obr/reference/obr-package.md)
  : obr: Access 'Office for Budget Responsibility' Data
