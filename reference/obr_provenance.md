# Extract OBR provenance metadata

Returns the provenance list attached to an `obr_tbl`: the OBR
publication it came from, the publication vintage, the source URL,
retrieval time, file fingerprint, and package version.

## Usage

``` r
obr_provenance(x)
```

## Arguments

- x:

  An `obr_tbl` (or any object; returns `NULL` if none attached).

## Value

A named list of provenance fields, or `NULL` if no provenance is
attached. Fields:

- publication:

  Short code: `"PFD"`, `"HFD"`, `"EFO"`, `"WTR"`, `"FSR"`, `"PMD"`.

- vintage:

  Publication vintage label, e.g. `"March 2026"`.

- source_url:

  Canonical OBR download URL the data came from.

- retrieved:

  `POSIXct` timestamp of when the file was downloaded or last validated
  in the cache.

- file_md5:

  MD5 fingerprint of the underlying spreadsheet.

- package_version:

  `obr` package version that produced the object.

- notes:

  Optional free-text notes, or `NULL`.

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
psnb <- get_psnb()
#> Warning: Could not resolve a current Public Finances Databank URL from 1 candidate.
#> ℹ Falling back to <https://obr.uk/download/public-finances-databank/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
obr_provenance(psnb)
#> $publication
#> [1] "PFD"
#> 
#> $vintage
#> [1] NA
#> 
#> $source_url
#> [1] "https://obr.uk/download/public-finances-databank/"
#> 
#> $retrieved
#> [1] "2026-05-04 19:14:00 UTC"
#> 
#> $file_md5
#> [1] "77a07b6641ca8ef85449de08077a9b87"
#> 
#> $package_version
#> [1] "0.3.0"
#> 
#> $notes
#> NULL
#> 
options(op)
# }
```
