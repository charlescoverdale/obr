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
#> Warning: cannot remove file '/tmp/RtmpOHinTY/bslib-e9b2b13fa612f50d23e4850d93d60d01', reason 'Directory not empty'
#> Warning: cannot remove file '/tmp/RtmpOHinTY/downlit', reason 'Directory not empty'
#> Removed 4 cached files.
options(op)
# }
```
