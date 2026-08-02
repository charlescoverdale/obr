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
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Warning: Could not resolve a current Public Finances Databank URL from 1 candidate.
#> ℹ Falling back to <https://obr.uk/download/public-finances-databank/>.
#> ! Returned data may be older than expected. Run with internet access, or pin a
#>   vintage explicitly when that feature ships.
#> ℹ Downloading public_finances_databank.xlsx from OBR...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■■                         
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■             
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Error: Failed to download <https://obr.uk/download/public-finances-databank/>.
#> ✖ HTTP 403 Forbidden.
obr_provenance(psnb)
#> Error: object 'psnb' not found
options(op)
# }
```
