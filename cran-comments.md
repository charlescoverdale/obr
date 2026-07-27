# CRAN submission comments — obr 0.5.1

## Resolving the check ERROR reported for 0.2.5

The 0.2.5 check page listed a `donttest` ERROR (Additional issues): the
`get_pension_projections()` example failed with `"Sheet 'C1.2' not found"`.

Cause: in July 2026 the OBR restructured the Fiscal Risks and
Sustainability Report workbook set. The executive-summary sheet the
function read (`C1.2`) no longer exists, so a live call errored.

Fix: `get_pension_projections()` is deprecated in this release. It no
longer accesses that resource; it emits a deprecation warning and returns
`NULL`. Its example is a single `suppressWarnings()` call, so the
`donttest` run completes cleanly. The equivalent series now sits in a
different OBR workbook (FSR Chapter 3, Chart 3.11) with a changed scenario
structure; repointing to it is left to a future release.

## Summary of this submission

The live CRAN version is 0.2.5. This submission bundles the accumulated
0.4.0, 0.5.0, and 0.5.1 changes.

**v0.4.0** standardised the columns returned by every data-fetching
function on a single tidy long schema (`period`, `period_type`, `series`,
`metric_type`, `value`, `unit`), so outputs from different OBR
publications can be joined and stacked without column mapping.

**v0.5.0** adds full coverage of every detailed-forecast table the OBR
publishes in the *Economic and Fiscal Outlook* Aggregates and Economy
workbooks. v0.2.5 exposed 4 tables; v0.5.0 exposes all 39 via a generic
`get_efo_table(table_id)` dispatcher and a catalogue `obr_efo_catalogue()`.
Two workflow helpers (`obr_compare_vintages`, `obr_actual_vs_forecast`)
plus a new `efo-forecasts` vignette round out the release.

**v0.5.1** deprecates `get_pension_projections()` (see above).

Each version bump is a separate entry in NEWS.md. v0.4.0 was uploaded to
the incoming queue on 2026-05-07 but allowed to expire so it could be
reissued together with the later changes.

## Breaking changes (documented in NEWS.md)

* Schema (v0.4.0): `year` / `fiscal_year` -> `period` (with `period_type`
  to disambiguate); `value_bn` / `psnb_bn` / `psnd_bn` / `tme_bn` ->
  `value` (with `unit`); `get_psnb()` / `get_psnd()` / `get_expenditure()`
  now tag rows with a `series` label and return the standard schema.
* Deprecation (v0.5.1): `get_pension_projections()` now returns `NULL`
  with a warning.

## R CMD check results

0 errors | 0 warnings | 0 notes (CRAN default settings, R 4.5.2, macOS).

## Test suite

Network-dependent tests are wrapped in `skip_on_cran()` and
`skip_if_offline()`. The deprecated `get_pension_projections()` is tested
offline, as it no longer performs any download.

## Notes on data access

Unchanged from v0.2.5: the package downloads data from the OBR website
<https://obr.uk> on first use and caches it locally using
`tools::R_user_dir()`. No data is bundled. All examples that make network
calls are wrapped in `\donttest{}`, with caching redirected to `tempdir()`
so that no files are written to the user's home filespace.

## Cross-reference resolution

Two EFO sheets (Tables 6.11 and 6.15 in the March 2026 edition) contain
only a redirect to a previous EFO. The package follows this redirect
automatically, downloading the previous EFO Aggregates workbook and
returning the linked table with provenance pointing at the previous
vintage. Cached separately by vintage tag so the live EFO and any pinned
vintages do not overwrite each other.

## Downstream dependencies

None on CRAN.
