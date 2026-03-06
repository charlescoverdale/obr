## R CMD check results

0 errors | 0 warnings | 3 notes

The 3 notes are:

* `New submission` — expected for a first-time submission
* `README.md or NEWS.md cannot be checked without 'pandoc' being installed` — pandoc is not on PATH in the non-interactive R session used for checks; files are valid markdown
* `Skipping checking HTML validation: 'tidy' doesn't look like recent enough HTML Tidy` — local tidy version limitation; not a package issue

## Test suite

49 tests across 3 test files. All network-dependent tests are wrapped in
`skip_on_cran()` and `skip_if_offline()`.

## Notes on data access

This package downloads data from the OBR website <https://obr.uk> on first
use and caches it locally using `tools::R_user_dir()`. No data is bundled.
All examples that make network calls are wrapped in `\donttest{}`.

## Acronyms

- **OBR**: Office for Budget Responsibility (UK independent fiscal watchdog)
- **PSNB**: Public Sector Net Borrowing (the annual deficit)
- **PSND**: Public Sector Net Debt
- **TME**: Total Managed Expenditure
- **PSCR**: Public Sector Current Receipts

## Downstream dependencies

None — this is a new package.
