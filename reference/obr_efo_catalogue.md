# List the EFO detailed-forecast tables this package can fetch

Returns a data frame describing every Detailed Forecast Table in the OBR
Economic and Fiscal Outlook (Aggregates and Economy workbooks) that
[`get_efo_table()`](https://charlescoverdale.github.io/obr/reference/get_efo_table.md)
knows how to parse.

## Usage

``` r
obr_efo_catalogue()
```

## Value

A data frame with columns:

- table_id:

  The EFO table identifier (e.g. `"6.5"`, `"1.7"`).

- file:

  Which EFO workbook the table sits in: `"aggregates"` or `"economy"`.

- section:

  Theme tag (e.g. `"GDP"`, `"Labour"`, `"Debt"`).

- title:

  Human-readable title taken from the OBR contents page.

- layout:

  Layout family the parser uses: `"quarterly_wide"`,
  `"quarterly_single"`, `"annual_year_wide"`, `"fiscal_year_wide"`, or
  `"cross_reference"`.

- default_metric_type:

  Default `metric_type` applied to series whose name does not signal
  otherwise. `NA` lets the heuristic decide per row.

- default_unit:

  Default `unit` for the same.

## Details

Use this catalogue to discover which tables are available, what each
contains, and the default `metric_type` / `unit`
[`get_efo_table()`](https://charlescoverdale.github.io/obr/reference/get_efo_table.md)
will attach. Pass any `table_id` to
[`get_efo_table()`](https://charlescoverdale.github.io/obr/reference/get_efo_table.md).

Coverage: 17 fiscal aggregates tables (Section 6) plus 22 macro economy
tables (Section 1). One sheet (6.11) is currently a cross-reference to a
previous EFO and returns `NULL` with a warning rather than data.

## See also

Other EFO:
[`get_efo_economy()`](https://charlescoverdale.github.io/obr/reference/get_efo_economy.md),
[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md),
[`get_efo_table()`](https://charlescoverdale.github.io/obr/reference/get_efo_table.md),
[`list_efo_economy_measures()`](https://charlescoverdale.github.io/obr/reference/list_efo_economy_measures.md)

## Examples

``` r
head(obr_efo_catalogue())
#>   table_id    file section                                             title
#> 1      1.1 economy     GDP GDP expenditure components (chain-linked volumes)
#> 2      1.2 economy     GDP       GDP expenditure components (current prices)
#> 3      1.3 economy     GDP                             GDP income components
#> 4      1.4 economy     GDP             Nominal GDP (non-seasonally adjusted)
#> 5      1.5 economy     GDP                              Per capita (age 16+)
#> 6      1.6 economy  Labour                                     Labour market
#>             layout default_metric_type default_unit
#> 1   quarterly_wide               level       gbp_bn
#> 2   quarterly_wide               level       gbp_bn
#> 3   quarterly_wide               level       gbp_bn
#> 4 quarterly_single               level       gbp_bn
#> 5   quarterly_wide               level         <NA>
#> 6   quarterly_wide                <NA>         <NA>

# All tables in the Debt section
cat <- obr_efo_catalogue()
cat[cat$section == "Debt", c("table_id", "title")]
#>    table_id                                                          title
#> 33     6.11                    Public sector net debt year-on-year changes
#> 34     6.12                                          Total gross financing
#> 35     6.13                          Composition of public sector net debt
#> 36     6.14                         Composition of public sector net worth
#> 37     6.15                              Reconciliation of PSNCR and CGNCR
#> 38     6.16        Central government debt interest by financing component
#> 39     6.17 Outstanding stocks, debt interest payments and effective rates
```
