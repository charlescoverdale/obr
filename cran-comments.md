# CRAN submission comments: obr 0.6.3

## Purpose

Bug-fix release. The OBR moved two of its databases to new download
addresses, so four functions errored for users without a cached file,
and a themed report changed its chart layout. Details in NEWS.md. No
change to exported function signatures.

## Test environments

* Local macOS, R 4.5.2: `R CMD check --as-cran`.

## R CMD check results

0 errors | 0 warnings | 0 notes

As in 0.6.2, every test and example that needs obr.uk is skipped on
CRAN or wrapped in `try()` inside `\donttest{}`, and retries against
obr.uk are capped at 5 seconds per request.

## Downstream dependencies

None on CRAN.
