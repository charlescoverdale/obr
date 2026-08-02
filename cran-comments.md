# CRAN submission comments — obr 0.6.0

## Apology for the quick succession after 0.5.1

0.5.1 was accepted earlier than the normal release cadence would suggest
because it fixed the `donttest` ERROR reported for 0.2.5 (deadline
2026-08-21). This submission, 0.6.0, is the planned feature release. It
is submitted promptly for a time-sensitive reason: the OBR has been
commissioned to produce the forecast for the UK's autumn Budget, and
this release fixes a URL-resolution bug that would surface on Budget
day (see below) as well as adding the pre-Budget monitoring datasets
users need in the run-up. I intend to return to a normal 1-2 month
cadence after this release.

## Summary of this submission

**Bug fix (time-sensitive).** The dynamic URL resolver probed
`march-<year>` publication slugs before `october-<year>` /
`november-<year>` within each year. Once the OBR publishes its autumn
*Economic and Fiscal Outlook*, the resolver would keep silently
returning the spring edition for the rest of the year. Candidates are
now probed newest-first; the resolver also rejects `text/html`
responses (soft 404s) and retries 403s, which the OBR CDN uses for
rate limiting rather than missing files.

**New functionality.**

* `get_monthly_profiles()`: the monthly profiles workbook the OBR
  publishes alongside each EFO (receipts, spending, and CGNCR
  apportioned across the twelve months of the fiscal year), in the
  package's standard tidy schema with a new `period_type = "month"`.
* `obr_headroom()`: the current budget surplus path derived from EFO
  Table 6.5, the margin against the Charter for Budget Responsibility
  stability rule.
* `obr_compare_vintages()` now accepts any of the 39 catalogue table
  ids, not just four named shortcuts.
* `obr_pin()` accepts a well-formed vintage label not yet in the
  package's EFO calendar (e.g. a brand-new EFO on publication day),
  constructing the download URL from the OBR's slug convention, with a
  warning.

No breaking changes. New behaviour is additive; all existing function
signatures are unchanged except `obr_compare_vintages()`'s `what`
argument, which now accepts a superset of its previous values.

## R CMD check results

0 errors | 0 warnings | 0 notes (CRAN default settings, R 4.5.2, macOS).

## Test suite

Network-dependent tests are wrapped in `skip_on_cran()` and
`skip_if_offline()`. New parser and dispatch logic is additionally
covered by offline unit tests (URL candidate ordering, month-to-period
mapping, slug construction, argument validation).

## Notes on data access

Unchanged: the package downloads data from the OBR website
<https://obr.uk> on first use and caches it locally using
`tools::R_user_dir()`. No data is bundled. All examples that make
network calls are wrapped in `\donttest{}`, with caching redirected to
`tempdir()` so that no files are written to the user's home filespace.

## Downstream dependencies

None on CRAN.
