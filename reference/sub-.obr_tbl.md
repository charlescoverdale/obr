# Subset an obr_tbl, preserving provenance

Standard data.frame subsetting drops the `obr_tbl` class. This method
preserves it (and the provenance attributes) when the result is still a
data.frame.

## Usage

``` r
# S3 method for class 'obr_tbl'
x[...]
```

## Arguments

- x:

  An `obr_tbl`.

- ...:

  Subsetting arguments passed to \[`[.data.frame`\].

## Value

An `obr_tbl` if the subset is two-dimensional, otherwise the underlying
vector.
