# Coerce an obr_tbl to a plain data.frame

Strips the provenance attributes and the `obr_tbl` class so the result
interacts smoothly with packages that dispatch on `data.frame` directly.

## Usage

``` r
# S3 method for class 'obr_tbl'
as.data.frame(x, ...)
```

## Arguments

- x:

  An `obr_tbl`.

- ...:

  Unused.

## Value

A plain `data.frame` with no provenance.
