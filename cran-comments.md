# CRAN submission comments — obr 0.2.4

## Resubmission

This is a resubmission addressing CRAN feedback (Prof Ripley, 2026-03-15).
Changes since obr 0.2.2 (currently on CRAN):

* Examples now cache to `tempdir()` instead of the user's home directory,
  fixing CRAN policy compliance for `\donttest` examples.
* Cache directory is now configurable via `options(obr.cache_dir = ...)`.
* Removed non-existent pkgdown URL from DESCRIPTION (was returning 404).

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

## Downstream dependencies

None.
