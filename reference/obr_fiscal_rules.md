# Get the current UK fiscal rules

Returns a data frame describing the Charter for Budget Responsibility
fiscal rules currently in force, as encoded in the package at the time
of release. Numerical headroom against each rule is *not* shipped as a
constant because it is updated at every fiscal event and would go stale
within months; users should derive headroom from the current EFO output
of
[`get_efo_fiscal()`](https://charlescoverdale.github.io/obr/reference/get_efo_fiscal.md),
or consult the OBR's EFO press release for the relevant vintage.

## Usage

``` r
obr_fiscal_rules()
```

## Value

A data frame with columns:

- rule:

  Short rule code: `"stability"`, `"investment"`, `"welfare_cap"`.

- metric:

  The metric the rule binds on.

- target_description:

  Plain-English target.

- target_year_rule:

  How the target year is set under the Charter.

- direction_of_pass:

  Sign convention for headroom.

- source_charter:

  Charter version that defines the rule.

- source_act:

  Act of Parliament backing the rule.

## Details

The current Charter (Autumn 2024, with an Autumn 2025 update) sets three
numerical rules:

- **Stability rule**: current budget in balance or surplus by the target
  year. The target year is the 5th forecast year and rolls to the 3rd
  forecast year from 2026-27 onwards.

- **Investment rule**: Public Sector Net Financial Liabilities (PSNFL)
  as a share of GDP falling year-on-year by the target year.

- **Welfare cap**: AME-capped welfare spending below the statutory cap
  level by the target year.

The Budget Responsibility Act 2024 also adds a non-numerical **fiscal
lock** requiring an OBR forecast for any fiscally significant measure.

## Examples

``` r
obr_fiscal_rules()
#>          rule
#> 1   stability
#> 2  investment
#> 3 welfare_cap
#>                                                                           metric
#> 1                                               Current budget balance, % of GDP
#> 2 Public Sector Net Financial Liabilities (PSNFL), % of GDP, year-on-year change
#> 3                                     AME-capped welfare spending, GBP bn (cash)
#>                                                   target_description
#> 1            Current budget in balance or surplus by the target year
#> 2    PSNFL as a share of GDP falling year-on-year by the target year
#> 3 AME-capped welfare spending below the cap level by the target year
#>                                                  target_year_rule
#> 1           5th forecast year (rolls to 3rd from 2026-27 onwards)
#> 2           5th forecast year (rolls to 3rd from 2026-27 onwards)
#> 3 Set in nominal terms for a specific fiscal year by the Treasury
#>                               direction_of_pass
#> 1         current budget surplus larger -> pass
#> 2        PSNFL/GDP falling more steeply -> pass
#> 3 AME-capped spending further below cap -> pass
#>                                                         source_charter
#> 1 Charter for Budget Responsibility, Autumn 2024 (updated Autumn 2025)
#> 2 Charter for Budget Responsibility, Autumn 2024 (updated Autumn 2025)
#> 3 Charter for Budget Responsibility, Autumn 2024 (updated Autumn 2025)
#>                                     source_act
#> 1 Budget Responsibility Act 2024 (fiscal lock)
#> 2 Budget Responsibility Act 2024 (fiscal lock)
#> 3 Budget Responsibility Act 2024 (fiscal lock)
```
