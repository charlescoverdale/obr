# CRAN submission comments — obr 0.2.3

## Resubmission

This is a resubmission of obr 0.2.2. Changes made in response to CRAN
feedback (Prof Ripley, 2026-03-15):

* Examples now cache to `tempdir()` instead of the user's home directory,
  fixing CRAN policy compliance for `\donttest` examples.
* Cache directory is now configurable via `options(obr.cache_dir = ...)`.

## R CMD check results

0 errors | 0 warnings | 0 notes

## Test suite

121 tests across 6 test files. All network-dependent tests are wrapped in
`skip_on_cran()` and `skip_if_offline()`.

## Notes on data access

This package downloads data from the OBR website <https://obr.uk> on first
use and caches it locally using `tools::R_user_dir()`. No data is bundled.
All examples that make network calls are wrapped in `\donttest{}`, with
caching redirected to `tempdir()` so that no files are written to the user's
home filespace.

Download URLs for the EFO, WTR, and FSR embed the publication date
(e.g. `march-2026`). These are hardcoded to the most recent edition at the
time of submission and will be updated in subsequent package versions as new
editions are published.

## Downstream dependencies

None.
