# Get long-run state pension spending projections (deprecated)

**Deprecated since obr 0.5.1.**

In July 2026 the OBR restructured the Fiscal Risks and Sustainability
Report workbook set. The executive-summary sheet this function read
(`C1.2`, state pension spending split into demographic and triple-lock
scenarios) no longer exists, so the function could no longer return
data.

The equivalent series is now published in the FSR Chapter 3 "Long-term
spending projections" workbook, as Chart 3.11 "State pension spending
under alternative uprating assumptions", with a different scenario
structure (triple-lock, CPI, and average-earnings uprating rather than
the old demographic vs triple-lock split). See
<https://obr.uk/frs/fiscal-risks-and-sustainability-july-2026/>.

This stub is retained so existing scripts do not error. It emits a
deprecation warning and returns `NULL`. It will be removed in a future
release.

## Usage

``` r
get_pension_projections(refresh = FALSE)
```

## Arguments

- refresh:

  Ignored. Retained so existing calls do not error.

## Value

`NULL`, invisibly.

## Examples

``` r
# Deprecated since 0.5.1: emits a warning and returns NULL.
suppressWarnings(get_pension_projections())
```
