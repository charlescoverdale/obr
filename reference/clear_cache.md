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
#> Warning: cannot remove file '/tmp/RtmpbypjAc/bslib-8a92d22979ec96a3105b4f8cbcdeeec5', reason 'Directory not empty'
#> Warning: cannot remove file '/tmp/RtmpbypjAc/downlit', reason 'Directory not empty'
#> Removed 4 cached files.
options(op)
# }
```
