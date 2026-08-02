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
#> Warning: cannot remove file '/tmp/RtmpGOVkTk/bslib-36dd7d54583ca31becd9906e27a99038', reason 'Directory not empty'
#> Warning: cannot remove file '/tmp/RtmpGOVkTk/downlit', reason 'Directory not empty'
#> Removed 4 cached files.
options(op)
# }
```
