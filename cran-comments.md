## R CMD check results

0 errors | 0 warnings | 3 notes

The 3 notes are:

* `New submission` — expected for a first-time submission
* `README.md or NEWS.md cannot be checked without 'pandoc' being installed` — pandoc is not on PATH in the non-interactive R session used for checks; files are valid markdown
* `Skipping checking HTML validation: 'tidy' doesn't look like recent enough HTML Tidy` — local tidy version limitation; not a package issue

## Test suite

121 tests across 6 test files. All network-dependent tests are wrapped in
`skip_on_cran()` and `skip_if_offline()`.

## Notes on data access

This package downloads data from the OBR website <https://obr.uk> on first
use and caches it locally using `tools::R_user_dir()`. No data is bundled.
All examples that make network calls are wrapped in `\donttest{}`.

Download URLs for the EFO, WTR, and FSR embed the publication date
(e.g. `march-2026`). These are hardcoded to the most recent edition at the
time of submission and will be updated in subsequent package versions as new
editions are published.

## URL redirects in README

`urlchecker::url_check()` reports 4 redirect warnings for the following
README links: `https://obr.uk/efo/`, `https://obr.uk/fsr/`,
`https://obr.uk/public-finances-databank/`, and `https://obr.uk/wtr/`.
These are stable OBR dataset index pages that redirect to the most recent
edition. The redirects are intentional: using index pages ensures links
remain meaningful after new editions are published, whereas linking directly
to a dated page (e.g. `/efo/economic-and-fiscal-outlook-march-2026/`) would
become stale after the next Budget. All links resolve successfully.

## Acronyms

- **OBR**: Office for Budget Responsibility (UK independent fiscal watchdog)
- **PSNB**: Public Sector Net Borrowing (the annual deficit)
- **PSND**: Public Sector Net Debt
- **TME**: Total Managed Expenditure
- **PSCR**: Public Sector Current Receipts
- **EFO**: Economic and Fiscal Outlook (OBR's flagship Budget publication)
- **WTR**: Welfare Trends Report
- **FSR**: Fiscal Risks and Sustainability Report
- **ESA**: Employment and Support Allowance
- **CPI**: Consumer Prices Index
- **CPIH**: Consumer Prices Index including owner-occupiers' housing costs

## Downstream dependencies

None — this is a new package.
