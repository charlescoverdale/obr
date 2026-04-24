# Clear cached OBR files

Deletes all files downloaded and cached by the obr package. The next
function call will re-download fresh data from the OBR website.

## Usage

``` r
clear_cache()
```

## Value

Invisibly returns `NULL`.

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
clear_cache()
#> Warning: cannot remove file '/tmp/Rtmpw5wxxJ/bslib-246362e7e3ff6191071d5f9b40ba8d62', reason 'Directory not empty'
#> Warning: cannot remove file '/tmp/Rtmpw5wxxJ/downlit', reason 'Directory not empty'
#> Removed 3 cached files.
options(op)
# }
```
