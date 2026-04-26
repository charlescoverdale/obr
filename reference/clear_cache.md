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
#> Warning: cannot remove file '/tmp/Rtmp6R5GMv/bslib-8dec8baf244994ef18e173f302c180eb', reason 'Directory not empty'
#> Warning: cannot remove file '/tmp/Rtmp6R5GMv/downlit', reason 'Directory not empty'
#> Removed 4 cached files.
options(op)
# }
```
