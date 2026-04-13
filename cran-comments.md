# CRAN submission comments — obr 0.2.5

## Resubmission of archived package

This package was archived on 2026-03-30 ("issues were not corrected in time").
The original issue (Prof Ripley, 2026-03-15) was fixed in v0.2.4 but did not
clear the incoming queue before the deadline. All issues are resolved:

* Examples redirect cache to `tempdir()` via `options(obr.cache_dir = ...)`,
  so no files are written to the user's home filespace (original issue).
* Download URLs for OBR publications (EFO, WTR, FSR) are now resolved
  dynamically, trying recent publication dates in reverse chronological order.
  This prevents breakage when OBR publishes new editions.
* Test suite isolates cache operations to temporary directories, preventing
  rate-limit failures during R CMD check.

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
