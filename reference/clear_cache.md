# Clear cached OBR files

Deletes all files downloaded and cached by the obr package. The next
function call will re-download fresh data from the OBR website.

## Usage

``` r
clear_cache()
```

## Value

Invisibly returns `NULL`.

## Details

Files are cached in `tools::R_user_dir("obr", "cache")`, or the
directory set with `options(obr.cache_dir = )`. Each edition of a
publication is cached separately, and a cached file is used for 7 days
before it is downloaded again; set `options(obr.cache_ttl = )` to a
number of hours to change this. If a re-download fails, the expired copy
is used with a warning.

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
clear_cache()
#> Warning: cannot remove file '/tmp/RtmpIG70RJ/bslib-7db53ff92ec092c0dbca0588320fd109', reason 'Directory not empty'
#> Warning: cannot remove file '/tmp/RtmpIG70RJ/downlit', reason 'Directory not empty'
#> Removed 4 cached files.
options(op)
# }
```
