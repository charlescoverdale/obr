# obr 0.3.0

## New: provenance metadata on every returned object

* All data-returning functions now return an `obr_tbl` object: a `data.frame`
  with attached provenance recording the source URL, OBR publication code
  ("PFD", "HFD", "EFO", "WTR", "FSR"), publication vintage (e.g. "March 2026"),
  retrieval timestamp, file MD5 fingerprint, and `obr` package version. This
  lets users audit which OBR publication produced any number, and reproduce
  analyses across new package or OBR releases.
* Print method shows a provenance header before the data.
* `summary()` returns the full provenance card.
* New helper `obr_provenance()` extracts the metadata as a list.
* Subsetting with `[` preserves the class and attributes; `as.data.frame()`
  strips them.

## New: vintage layer for reproducible analysis

* `obr_efo_vintages()` returns a structured table of every EFO published
  since the OBR was created in June 2010, with publication dates and URL
  slugs.
* `obr_as_of(date)` returns the EFO that was current on a given calendar
  date. Useful for reproducing analyses as they would have looked at a
  given point in time.
* `obr_pin(vintage)` sets a session-wide EFO vintage that flows into
  `get_efo_fiscal()` and `get_efo_economy()`. `obr_unpin()` clears it and
  `obr_pinned()` returns the current pin.
* `get_efo_fiscal()` and `get_efo_economy()` now accept a `vintage =`
  argument that overrides any pin and downloads the file for that specific
  EFO. Cached files are vintage-tagged so different vintages do not
  overwrite each other.

## New: Policy Measures Database

* `get_policy_measures()` provides programmatic access to the OBR's Policy
  Measures Database, with one row per fiscal-event-scored measure since
  1970 (tax) or 2010 (spending). Columns include the fiscal event, plain-
  English description, Treasury head, fiscal year, and Exchequer effect
  in GBP million.
* Supports filters: `type` ("tax", "spending", or both), `search` (regex
  on description / head, case-insensitive), `since` (fiscal-year cut-off).
* `policy_measures_summary()` aggregates the long format to net Exchequer
  effect by event and fiscal year.
* This is the only programmatic access to the PMD: the OBR otherwise
  distributes it as a single Excel workbook with non-standard layout.

## New: fiscal rules reference

* `obr_fiscal_rules()` returns a structured table of the three numerical
  rules in the current Charter for Budget Responsibility (Autumn 2024,
  updated Autumn 2025): the stability rule (current budget surplus), the
  investment rule (PSNFL/GDP falling), and the welfare cap. The metric,
  pass direction, target-year mechanics, and source Charter / Act are
  shipped as data. Numerical headroom is *not* shipped as a constant
  because it changes at every fiscal event; users should derive it from
  current EFO output via [get_efo_fiscal()] or read the EFO press release.

## New: Forecast Revisions Database and forecast panel

* `get_forecast_revisions()` provides programmatic access to the OBR's
  Forecast Revisions Database, which decomposes each EFO-to-EFO change
  in the headline PSNB forecast into policy, classifications and one-offs,
  and underlying (economic determinants) components. Available in both
  GBP billion and per cent of GDP.
* `obr_forecast_panel()` pivots the long-format Historical Forecasts
  Database to a wide real-time panel: rows are forecast vintages, columns
  are fiscal years, cells are forecast values. Mirrors how the OBR's own
  Forecast Evaluation Report lays out forecast performance and lets users
  read the h-step-ahead forecast for any vintage off the diagonal.

## Breaking-ish changes

* No public API was renamed or removed. All existing exports keep their
  signatures and return columns; the only difference is that returned frames
  now carry the `obr_tbl` class and provenance attributes.

## URL resolution and reliability

* The Historical Forecasts Database URL is now resolved dynamically across
  recent fiscal events (previously hardcoded to March 2025).
* When dynamic URL resolution falls through to the hardcoded fallback for
  any publication (EFO, WTR, FSR, HFD), the package now emits an explicit
  `cli::cli_warn()` instead of failing silently. The returned data frame
  records `source = "fallback"` so callers can detect this state.
* Excel sheet-name lookup now tolerates encoding changes via a regex
  fallback. Series whose primary sheet name uses a non-ASCII Pound symbol
  (PSNB, receipts, expenditure) fall back to a letter-only pattern if the
  literal name is missing.
* `obr_resolve_url()` now uses HEAD requests for faster candidate probing
  and captures the redirect target so the Public Finances Databank vintage
  can be recovered from the stable slug.

## Parser robustness

* `parse_efo_output_gap()` (sheet 1.14) now scans for the value column with
  the most aligned numeric entries instead of hardcoding column 3.
* `parse_pension_projections()` (FSR sheet C1.2) now detects sections via
  fuzzy matching on "demographic" and "triple lock" rather than exact strings.
* Receipts column footnote stripping now only removes 1-2 trailing digits
  when preceded by a letter, period, or whitespace, so series legitimately
  ending in digits are not corrupted.

## Documentation

* Em-dashes removed from roxygen titles to avoid encoding issues on Windows.
* `match.arg()` is now used for `series` and `measure` arguments.
* `inst/CITATION` reads the version from `DESCRIPTION` so it stays in sync.

# obr 0.2.5

* EFO, Welfare Trends Report, and Fiscal Sustainability Report download URLs
  are now resolved dynamically, trying recent publication dates in reverse
  chronological order. This prevents functions from breaking when OBR publishes
  new editions. Hardcoded URLs are retained as fallbacks.

# obr 0.2.4

* Removed non-existent pkgdown URL from DESCRIPTION.

# obr 0.2.3

* Examples now cache to `tempdir()` instead of the user's home directory,
  fixing CRAN policy compliance for `\donttest` examples.
* Cache directory is now configurable via `options(obr.cache_dir = ...)`.

# obr 0.2.2

* Fix README URLs flagged by CRAN incoming checks (301 redirects).
* Add "Databank" to WORDLIST.

# obr 0.2.1

* Update WORDLIST with domain-specific terms (EFO, FSR, WTR, CPIH, etc.)

# obr 0.2.0

## New datasets

### Economic and Fiscal Outlook (EFO)
* `get_efo_fiscal()` for five-year fiscal projections (net borrowing components) from the latest Budget
* `get_efo_economy(measure)` for quarterly economic projections: `"inflation"` (CPI, CPIH, RPI, RPIX), `"labour"` (employment, unemployment, participation), or `"output_gap"`
* `list_efo_economy_measures()` lists available economy measures

### Welfare Trends Report (WTR)
* `get_welfare_spending()` returns working-age welfare spending split by incapacity and non-incapacity (% of GDP, from 1978-79)
* `get_incapacity_spending()` returns incapacity benefits spending by benefit type (ESA, IB, Invalidity Benefit, Sickness Benefit, SDA) as % of GDP
* `get_incapacity_caseloads()` returns combined incapacity benefit caseloads and prevalence since 2008-09

### Fiscal Risks and Sustainability Report (FSR)
* `get_pension_projections()` returns 50-year state pension spending projections (% of GDP) under alternative demographic and triple-lock scenarios

# obr 0.1.0

* Initial release
* `get_psnb()`, `get_psnd()`, `get_expenditure()`, `get_receipts()` for Public Finances Databank aggregates
* `get_public_finances()` for all Databank series in tidy long format
* `get_forecasts()` and `list_forecast_series()` for Historical Official Forecasts Database
* `clear_cache()` to remove locally cached files
* Data sourced from the OBR Public Finances Databank and Historical Official Forecasts Database
