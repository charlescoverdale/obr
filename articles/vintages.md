# Pinning to a specific OBR publication

The OBR revises every forecast at every Budget and Statement. A number
that is correct in March can be wrong in October. For research, audit,
and reproducibility, you need a way to say “this analysis used the
October 2024 forecast” and have the package reliably return the same
numbers six months later.

`obr` calls this the **vintage layer**. This vignette walks through the
four ways to use it. The chunks that do not require a network connection
are run inline; the chunks that download from the OBR are shown as code
only.

## The vintage table

``` r

library(obr)

efos <- obr_efo_vintages()
nrow(efos)
#> [1] 33
head(efos, 3)
#>   publication       vintage       date
#> 1         EFO     June 2010 2010-06-22
#> 2         EFO November 2010 2010-11-29
#> 3         EFO    March 2011 2011-03-23
#>                                        slug
#> 1     june-2010-economic-and-fiscal-outlook
#> 2 november-2010-economic-and-fiscal-outlook
#> 3    march-2011-economic-and-fiscal-outlook
tail(efos, 3)
#>    publication       vintage       date
#> 31         EFO    March 2025 2025-03-26
#> 32         EFO November 2025 2025-11-26
#> 33         EFO    March 2026 2026-03-26
#>                                         slug
#> 31    march-2025-economic-and-fiscal-outlook
#> 32 november-2025-economic-and-fiscal-outlook
#> 33    march-2026-economic-and-fiscal-outlook
```

[`obr_efo_vintages()`](https://charlescoverdale.github.io/obr/reference/obr_efo_vintages.md)
is offline: the publication calendar is hardcoded into the package and
refreshed at each release.

## Resolving an EFO by date

``` r

obr_as_of("2024-12-15")
#> [1] "October 2024"
obr_as_of("2010-05-01") |> tryCatch(error = function(e) conditionMessage(e))
#> [1] "\033[1m\033[22mNo EFO had been published on or before 2010-05-01.\n\033[36mℹ\033[39m The OBR was established in June 2010; the first EFO was published 22 June\n  2010."
```

The first call returns the most recent EFO published on or before 15
December 2024. The second errors because no EFO existed before June
2010.

## Pinning a session-wide vintage

``` r

obr_pin("October 2024")
#> ✔ Pinned EFO to "October 2024".
obr_pinned()
#> [1] "October 2024"
obr_unpin()
#> ✔ Unpinned EFO (was "October 2024").
obr_pinned()
#> NULL
```

When pinned, the EFO functions default to that vintage.
[`obr_unpin()`](https://charlescoverdale.github.io/obr/reference/obr_unpin.md)
clears the pin and returns to the dynamic resolver.

## Downloading a specific vintage

These chunks require a network connection and are shown as code only.

``` r

# Pull two vintages of the same fiscal table to compare forecast revisions
oct24 <- get_efo_fiscal(vintage = "October 2024")
mar26 <- get_efo_fiscal(vintage = "March 2026")

# Net borrowing forecast for 2027-28 from each vintage
oct24[oct24$series == "Net borrowing" & oct24$fiscal_year == "2027-28", ]
mar26[mar26$series == "Net borrowing" & mar26$fiscal_year == "2027-28", ]
```

Cached files are vintage-tagged, so different vintages do not overwrite
each other in the cache. The `vintage = ...` argument always overrides
any pin set with
[`obr_pin()`](https://charlescoverdale.github.io/obr/reference/obr_pin.md).

## What’s recorded as provenance

Every `obr_tbl` carries enough metadata for an OBR analyst to audit
which publication produced any number.

``` r

obr_provenance(get_efo_fiscal(vintage = "October 2024"))
# $publication: "EFO"
# $vintage:     "October 2024"
# $source_url:  https://obr.uk/download/october-2024-economic-and-fiscal-outlook-...
# $retrieved:   timestamp of download
# $file_md5:    MD5 fingerprint of the underlying spreadsheet
# $package_version: obr version that produced the object
```

The MD5 fingerprint lets two analyses verify they ran against an
identical underlying file, even if downloaded weeks apart.

## How vintage interacts with `get_forecasts()`

The Historical Forecasts Database is a single workbook covering every
OBR vintage in one file, so it does not take a `vintage =` argument. To
filter to a specific forecast date, subset the long-format result.

``` r

fc  <- get_forecasts("PSNB")
fc[fc$forecast_date == "October 2024", ]
```

For reproducibility, the HFD itself is itself versioned: the OBR
releases a new HFD at each fiscal event, so the underlying file MD5
changes over time even if the older forecasts within it do not.
[`obr_provenance()`](https://charlescoverdale.github.io/obr/reference/obr_provenance.md)
records the HFD vintage on every result.
