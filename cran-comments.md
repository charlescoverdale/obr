# CRAN submission comments — obr 0.2.2

## Resubmission

This is a resubmission of obr 0.2.1. Changes made in response to CRAN
incoming checks:

* Fixed 4 README URLs that returned 301 redirects — replaced with final
  destination URLs.
* Added "Databank" to inst/WORDLIST to resolve the misspelled-words NOTE.

## R CMD check results

0 errors | 0 warnings | 0 notes

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

## Acronyms

- **OBR**: Office for Budget Responsibility (UK independent fiscal watchdog)
- **PSNB**: Public Sector Net Borrowing (the annual deficit)
- **PSND**: Public Sector Net Debt
- **Databank**: Short for the OBR's "Public Finances Databank"

## Downstream dependencies

None — this is a new package.
