# Print an obr_tbl

Prints the data with a provenance header that names the OBR publication,
vintage, source URL, retrieval time, and underlying file fingerprint.

## Usage

``` r
# S3 method for class 'obr_tbl'
print(x, n = 10L, ...)
```

## Arguments

- x:

  An `obr_tbl` object.

- n:

  Number of rows to display (default 10).

- ...:

  Further arguments passed to
  [`print.data.frame()`](https://rdrr.io/r/base/print.dataframe.html).

## Value

The input, returned invisibly.
