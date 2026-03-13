# Get OBR forecast history for a fiscal series

Downloads (and caches) the OBR Historical Official Forecasts Database
and returns a tidy long-format data frame showing every forecast the OBR
has ever published for a given series. Each row is one forecast for one
fiscal year, made at one fiscal event.

## Usage

``` r
get_forecasts(series = "PSNB", refresh = FALSE)
```

## Arguments

- series:

  Character. The series to return. Use
  [`list_forecast_series`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md)
  to see all options. Defaults to `"PSNB"` (Public Sector Net Borrowing
  in £bn).

- refresh:

  Logical. If `TRUE`, re-download even if a cached copy exists. Defaults
  to `FALSE`.

## Value

A data frame with columns:

- series:

  Series name as supplied (character)

- forecast_date:

  When the forecast was published, e.g. `"March 2024"` (character)

- fiscal_year:

  The fiscal year being forecast, e.g. `"2024-25"` (character)

- value:

  Forecast value (numeric)

## Details

This is useful for visualising how OBR forecasts have evolved over time,
and for comparing forecasts against outturns.

## Examples

``` r
# \donttest{
# All PSNB forecasts
get_forecasts("PSNB")
#> ℹ Downloading historical_forecasts.xlsx from OBR...
#> ✔ Saved to cache.
#>      series forecast_date fiscal_year     value
#> 1      PSNB    April 1970     1970-71  -0.20000
#> 2      PSNB    March 1971     1970-71   0.60000
#> 106    PSNB    March 1971     1971-72   1.20000
#> 107    PSNB    March 1972     1971-72   1.30000
#> 211    PSNB    March 1972     1972-73   3.40000
#> 212    PSNB    March 1973     1972-73   2.90000
#> 316    PSNB    March 1973     1973-74   4.40000
#> 317    PSNB    March 1974     1973-74   4.30000
#> 421    PSNB    March 1974     1974-75   2.70000
#> 422    PSNB    April 1975     1974-75   7.60000
#> 526    PSNB    April 1975     1975-76   9.10000
#> 527    PSNB    April 1976     1975-76  10.80000
#> 631    PSNB    April 1976     1976-77  12.00000
#> 632    PSNB  January 1977     1976-77  11.00000
#> 633    PSNB    March 1977     1976-77   8.80000
#> 634    PSNB November 1977     1976-77   7.50000
#> 736    PSNB  January 1977     1977-78   8.50000
#> 737    PSNB    March 1977     1977-78   8.50000
#> 738    PSNB November 1977     1977-78   7.00000
#> 739    PSNB    April 1978     1977-78   5.70000
#> 843    PSNB    April 1978     1978-79   8.50000
#> 844    PSNB November 1978     1978-79   8.00000
#> 845    PSNB     June 1979     1978-79   9.20000
#> 948    PSNB November 1978     1979-80   8.50000
#> 949    PSNB     June 1979     1979-80   8.30000
#> 950    PSNB    March 1980     1979-80   9.10000
#> 1054   PSNB    March 1980     1980-81   8.50000
#> 1055   PSNB    March 1981     1980-81  13.50000
#> 1159   PSNB    March 1981     1981-82  10.60000
#> 1160   PSNB    March 1982     1981-82  10.60000
#> 1161   PSNB November 1982     1981-82   9.00000
#> 1264   PSNB    March 1982     1982-83   9.50000
#> 1265   PSNB November 1982     1982-83   9.00000
#> 1266   PSNB    March 1983     1982-83   7.50000
#> 1267   PSNB November 1983     1982-83   9.00000
#> 1368   PSNB    March 1982     1983-84   8.50000
#> 1369   PSNB November 1982     1983-84   8.00000
#> 1370   PSNB    March 1983     1983-84   8.20000
#> 1371   PSNB November 1983     1983-84  10.00000
#> 1372   PSNB    March 1984     1983-84  10.00000
#> 1373   PSNB November 1984     1983-84   9.75000
#> 1472   PSNB    March 1982     1984-85   6.50000
#> 1474   PSNB    March 1983     1984-85   8.00000
#> 1475   PSNB November 1983     1984-85   8.00000
#> 1476   PSNB    March 1984     1984-85   7.20000
#> 1477   PSNB November 1984     1984-85   8.50000
#> 1478   PSNB    March 1985     1984-85  10.50000
#> 1479   PSNB November 1985     1984-85  10.00000
#> 1578   PSNB    March 1983     1985-86   7.00000
#> 1580   PSNB    March 1984     1985-86   7.00000
#> 1581   PSNB November 1984     1985-86   7.00000
#> 1582   PSNB    March 1985     1985-86   7.10000
#> 1583   PSNB November 1985     1985-86   8.00000
#> 1584   PSNB    March 1986     1985-86   7.00000
#> 1585   PSNB November 1986     1985-86   6.00000
#> 1684   PSNB    March 1984     1986-87   7.00000
#> 1686   PSNB    March 1985     1986-87   7.50000
#> 1688   PSNB    March 1986     1986-87   7.10000
#> 1689   PSNB November 1986     1986-87   7.00000
#> 1690   PSNB    March 1987     1986-87   4.10000
#> 1691   PSNB November 1987     1986-87   3.40000
#> 1788   PSNB    March 1984     1987-88   7.00000
#> 1790   PSNB    March 1985     1987-88   7.00000
#> 1792   PSNB    March 1986     1987-88   7.00000
#> 1794   PSNB    March 1987     1987-88   3.90000
#> 1795   PSNB November 1987     1987-88   1.00000
#> 1796   PSNB    March 1988     1987-88  -3.00000
#> 1797   PSNB November 1988     1987-88  -3.60000
#> 1892   PSNB    March 1984     1988-89   7.00000
#> 1894   PSNB    March 1985     1988-89   7.50000
#> 1896   PSNB    March 1986     1988-89   7.00000
#> 1898   PSNB    March 1987     1988-89   4.00000
#> 1900   PSNB    March 1988     1988-89  -3.00000
#> 1901   PSNB November 1988     1988-89  -9.80000
#> 1902   PSNB    March 1989     1988-89 -13.90000
#> 1903   PSNB November 1989     1988-89 -14.30000
#> 2000   PSNB    March 1986     1989-90   7.00000
#> 2002   PSNB    March 1987     1989-90   5.00000
#> 2004   PSNB    March 1988     1989-90   0.00000
#> 2006   PSNB    March 1989     1989-90 -13.80000
#> 2007   PSNB November 1989     1989-90 -12.60000
#> 2008   PSNB    March 1990     1989-90  -7.10000
#> 2106   PSNB    March 1987     1990-91   5.00000
#> 2108   PSNB    March 1988     1990-91   0.00000
#> 2110   PSNB    March 1989     1990-91 -10.00000
#> 2112   PSNB    March 1990     1990-91  -6.90000
#> 2113   PSNB November 1990     1990-91  -3.00000
#> 2114   PSNB    March 1991     1990-91  -0.80000
#> 2212   PSNB    March 1988     1991-92   0.00000
#> 2214   PSNB    March 1989     1991-92  -6.00000
#> 2216   PSNB    March 1990     1991-92  -3.00000
#> 2218   PSNB    March 1991     1991-92   7.90000
#> 2219   PSNB November 1991     1991-92  10.50000
#> 2220   PSNB    March 1992     1991-92  13.80000
#> 2318   PSNB    March 1989     1992-93  -3.00000
#> 2320   PSNB    March 1990     1992-93   0.00000
#> 2322   PSNB    March 1991     1992-93  12.00000
#> 2324   PSNB    March 1992     1992-93  28.10000
#> 2325   PSNB November 1992     1992-93  37.00000
#> 2326   PSNB    March 1993     1992-93  35.10000
#> 2424   PSNB    March 1990     1993-94   0.00000
#> 2426   PSNB    March 1991     1993-94   7.00000
#> 2428   PSNB    March 1992     1993-94  32.00000
#> 2430   PSNB    March 1993     1993-94  50.10000
#> 2431   PSNB November 1993     1993-94  49.80000
#> 2432   PSNB     June 1994     1993-94  46.00000
#> 2433   PSNB November 1994     1993-94  51.40000
#> 2530   PSNB    March 1991     1994-95   0.00000
#> 2532   PSNB    March 1992     1994-95  25.00000
#> 2534   PSNB    March 1993     1994-95  44.00000
#> 2535   PSNB November 1993     1994-95  37.90000
#> 2536   PSNB     June 1994     1994-95  36.10000
#> 2537   PSNB November 1994     1994-95  40.40000
#> 2538   PSNB     June 1995     1994-95  39.90000
#> 2539   PSNB November 1995     1994-95  40.50000
#> 2636   PSNB    March 1992     1995-96  19.00000
#> 2638   PSNB    March 1993     1995-96  39.00000
#> 2639   PSNB November 1993     1995-96  30.00000
#> 2640   PSNB     June 1994     1995-96  27.90000
#> 2641   PSNB November 1994     1995-96  25.20000
#> 2642   PSNB     June 1995     1995-96  27.90000
#> 2643   PSNB November 1995     1995-96  31.40000
#> 2644   PSNB     July 1996     1995-96  34.60000
#> 2645   PSNB November 1996     1995-96  34.80000
#> 2740   PSNB    March 1992     1996-97   6.00000
#> 2742   PSNB    March 1993     1996-97  35.00000
#> 2743   PSNB November 1993     1996-97  21.00000
#> 2745   PSNB November 1994     1996-97  16.00000
#> 2746   PSNB     June 1995     1996-97  20.80000
#> 2747   PSNB November 1995     1996-97  25.40000
#> 2748   PSNB     July 1996     1996-97  28.80000
#> 2749   PSNB November 1996     1996-97  29.40000
#> 2750   PSNB     July 1996     1996-97  29.20000
#> 2846   PSNB    March 1993     1997-98  30.00000
#> 2847   PSNB November 1993     1997-98  12.00000
#> 2849   PSNB November 1994     1997-98   6.00000
#> 2851   PSNB November 1995     1997-98  16.00000
#> 2852   PSNB     July 1996     1997-98  22.90000
#> 2853   PSNB November 1996     1997-98  20.50000
#> 2854   PSNB     July 1996     1997-98  13.00000
#> 2855   PSNB November 1997     1997-98  12.00000
#> 2856   PSNB     June 1998     1997-98   3.50000
#> 2858   PSNB    March 1999     1997-98   6.60000
#> 2951   PSNB November 1993     1998-99   2.00000
#> 2953   PSNB November 1994     1998-99  -1.00000
#> 2955   PSNB November 1995     1998-99   5.00000
#> 2957   PSNB November 1996     1998-99  12.00000
#> 2958   PSNB     July 1996     1998-99   3.50000
#> 2959   PSNB November 1997     1998-99   4.70000
#> 2960   PSNB     June 1998     1998-99   0.00000
#> 2961   PSNB November 1998     1998-99  -2.90000
#> 2962   PSNB    March 1999     1998-99  -2.80000
#> 2964   PSNB    March 2000     1998-99  -4.90000
#> 3057   PSNB November 1994     1999-00  -8.00000
#> 3059   PSNB November 1995     1999-00  -3.00000
#> 3061   PSNB November 1996     1999-00   2.00000
#> 3064   PSNB     June 1998     1999-00   3.00000
#> 3065   PSNB November 1998     1999-00   6.00000
#> 3066   PSNB    March 1999     1999-00   4.00000
#> 3067   PSNB November 1999     1999-00  -2.10000
#> 3068   PSNB    March 2000     1999-00 -11.00000
#> 3070   PSNB    March 2001     1999-00 -15.20000
#> 3163   PSNB November 1995     2000-01 -15.00000
#> 3165   PSNB November 1996     2000-01  -9.00000
#> 3168   PSNB     June 1998     2000-01   1.00000
#> 3169   PSNB November 1998     2000-01   6.00000
#> 3170   PSNB    March 1999     2000-01   5.00000
#> 3171   PSNB November 1999     2000-01  -1.00000
#> 3172   PSNB    March 2000     2000-01  -5.00000
#> 3173   PSNB November 2000     2000-01  -8.70000
#> 3174   PSNB    March 2001     2000-01 -15.00000
#> 3176   PSNB    April 2002     2000-01 -15.90000
#> 3269   PSNB November 1996     2001-02 -21.00000
#> 3272   PSNB     June 1998     2001-02   1.00000
#> 3273   PSNB November 1998     2001-02   3.00000
#> 3274   PSNB    March 1999     2001-02   2.00000
#> 3275   PSNB November 1999     2001-02  -1.00000
#> 3276   PSNB    March 2000     2001-02  -3.00000
#> 3277   PSNB November 2000     2001-02  -5.00000
#> 3278   PSNB    March 2001     2001-02  -5.00000
#> 3279   PSNB November 2001     2001-02   2.50000
#> 3280   PSNB    April 2002     2001-02   1.30000
#> 3282   PSNB    April 2003     2001-02  -0.40000
#> 3376   PSNB     June 1998     2002-03   2.00000
#> 3377   PSNB November 1998     2002-03   2.00000
#> 3378   PSNB    March 1999     2002-03   3.00000
#> 3379   PSNB November 1999     2002-03   1.00000
#> 3380   PSNB    March 2000     2002-03   3.00000
#> 3381   PSNB November 2000     2002-03   2.00000
#> 3382   PSNB    March 2001     2002-03   2.00000
#> 3383   PSNB November 2001     2002-03  12.00000
#> 3384   PSNB    April 2002     2002-03  11.00000
#> 3385   PSNB November 2002     2002-03  20.10000
#> 3386   PSNB    April 2003     2002-03  24.00000
#> 3388   PSNB    March 2004     2002-03  22.90000
#> 3480   PSNB     June 1998     2003-04   1.00000
#> 3481   PSNB November 1998     2003-04   1.00000
#> 3482   PSNB    March 1999     2003-04   4.00000
#> 3483   PSNB November 1999     2003-04   4.00000
#> 3484   PSNB    March 2000     2003-04  11.00000
#> 3485   PSNB November 2000     2003-04  10.00000
#> 3486   PSNB    March 2001     2003-04  10.00000
#> 3487   PSNB November 2001     2003-04  15.00000
#> 3488   PSNB    April 2002     2003-04  13.00000
#> 3489   PSNB November 2002     2003-04  24.00000
#> 3490   PSNB    April 2003     2003-04  27.00000
#> 3491   PSNB December 2003     2003-04  37.40000
#> 3492   PSNB    March 2004     2003-04  37.50000
#> 3494   PSNB    March 2005     2003-04  35.40000
#> 3587   PSNB November 1999     2004-05   6.00000
#> 3588   PSNB    March 2000     2004-05  13.00000
#> 3589   PSNB November 2000     2004-05  12.00000
#> 3590   PSNB    March 2001     2004-05  11.00000
#> 3591   PSNB November 2001     2004-05  13.00000
#> 3592   PSNB    April 2002     2004-05  13.00000
#> 3593   PSNB November 2002     2004-05  19.00000
#> 3594   PSNB    April 2003     2004-05  24.00000
#> 3595   PSNB December 2003     2004-05  31.00000
#> 3596   PSNB    March 2004     2004-05  33.00000
#> 3597   PSNB December 2004     2004-05  34.20000
#> 3598   PSNB    March 2005     2004-05  34.40000
#> 3599   PSNB December 2005     2004-05  38.80000
#> 3600   PSNB    March 2006     2004-05  39.70000
#> 3693   PSNB November 2000     2005-06  13.00000
#> 3694   PSNB    March 2001     2005-06  12.00000
#> 3695   PSNB November 2001     2005-06  13.00000
#> 3696   PSNB    April 2002     2005-06  17.00000
#> 3697   PSNB November 2002     2005-06  19.00000
#> 3698   PSNB    April 2003     2005-06  23.00000
#> 3699   PSNB December 2003     2005-06  30.00000
#> 3700   PSNB    March 2004     2005-06  31.00000
#> 3701   PSNB December 2004     2005-06  33.00000
#> 3702   PSNB    March 2005     2005-06  32.00000
#> 3703   PSNB December 2005     2005-06  37.00000
#> 3704   PSNB    March 2006     2005-06  37.10000
#> 3705   PSNB December 2006     2005-06  37.50000
#> 3706   PSNB    March 2007     2005-06  37.80000
#> 3799   PSNB November 2001     2006-07  13.00000
#> 3800   PSNB    April 2002     2006-07  18.00000
#> 3801   PSNB November 2002     2006-07  19.00000
#> 3802   PSNB    April 2003     2006-07  22.00000
#> 3803   PSNB December 2003     2006-07  27.00000
#> 3804   PSNB    March 2004     2006-07  27.00000
#> 3805   PSNB December 2004     2006-07  29.00000
#> 3806   PSNB    March 2005     2006-07  29.00000
#> 3807   PSNB December 2005     2006-07  34.00000
#> 3808   PSNB    March 2006     2006-07  36.00000
#> 3809   PSNB December 2006     2006-07  36.80000
#> 3810   PSNB    March 2007     2006-07  35.00000
#> 3811   PSNB  October 2007     2006-07  31.00000
#> 3812   PSNB    March 2008     2006-07  30.10000
#> 3905   PSNB November 2002     2007-08  20.00000
#> 3906   PSNB    April 2003     2007-08  22.00000
#> 3907   PSNB December 2003     2007-08  27.00000
#> 3908   PSNB    March 2004     2007-08  27.00000
#> 3909   PSNB December 2004     2007-08  28.00000
#> 3910   PSNB    March 2005     2007-08  27.00000
#> 3911   PSNB December 2005     2007-08  31.00000
#> 3912   PSNB    March 2006     2007-08  30.00000
#> 3913   PSNB December 2006     2007-08  31.00000
#> 3914   PSNB    March 2007     2007-08  34.00000
#> 3915   PSNB  October 2007     2007-08  38.00000
#> 3916   PSNB    March 2008     2007-08  36.40000
#> 3917   PSNB November 2008     2007-08  36.60000
#> 3918   PSNB    April 2009     2007-08  34.60000
#> 4011   PSNB December 2003     2008-09  24.00000
#> 4012   PSNB    March 2004     2008-09  23.00000
#> 4013   PSNB December 2004     2008-09  24.00000
#> 4014   PSNB    March 2005     2008-09  24.00000
#> 4015   PSNB December 2005     2008-09  26.00000
#> 4016   PSNB    March 2006     2008-09  25.00000
#> 4017   PSNB December 2006     2008-09  27.00000
#> 4018   PSNB    March 2007     2008-09  30.00000
#> 4019   PSNB  October 2007     2008-09  36.00000
#> 4020   PSNB    March 2008     2008-09  43.00000
#> 4021   PSNB November 2008     2008-09  77.60000
#> 4022   PSNB    April 2009     2008-09  90.00000
#> 4023   PSNB November 2009     2008-09  95.40000
#> 4024   PSNB    March 2010     2008-09  96.10000
#> 4025   PSNB     June 2010     2008-09  96.10000
#> 4117   PSNB December 2004     2009-10  22.00000
#> 4118   PSNB    March 2005     2009-10  22.00000
#> 4119   PSNB December 2005     2009-10  23.00000
#> 4120   PSNB    March 2006     2009-10  24.00000
#> 4121   PSNB December 2006     2009-10  26.00000
#> 4122   PSNB    March 2007     2009-10  28.00000
#> 4123   PSNB  October 2007     2009-10  31.00000
#> 4124   PSNB    March 2008     2009-10  38.00000
#> 4125   PSNB November 2008     2009-10 118.00000
#> 4126   PSNB    April 2009     2009-10 175.00000
#> 4127   PSNB November 2009     2009-10 177.60000
#> 4128   PSNB    March 2010     2009-10 166.50000
#> 4129   PSNB     June 2010     2009-10 154.70000
#> 4130   PSNB November 2010     2009-10 156.00000
#> 4131   PSNB    March 2011     2009-10 156.40000
#> 4223   PSNB December 2005     2010-11  22.00000
#> 4224   PSNB    March 2006     2010-11  23.00000
#> 4225   PSNB December 2006     2010-11  24.00000
#> 4226   PSNB    March 2007     2010-11  26.00000
#> 4227   PSNB  October 2007     2010-11  28.00000
#> 4228   PSNB    March 2008     2010-11  32.00000
#> 4229   PSNB November 2008     2010-11 105.00000
#> 4230   PSNB    April 2009     2010-11 173.00000
#> 4231   PSNB November 2009     2010-11 176.00000
#> 4232   PSNB    March 2010     2010-11 163.00000
#> 4233   PSNB     June 2010     2010-11 149.10000
#> 4234   PSNB November 2010     2010-11 148.50000
#> 4235   PSNB    March 2011     2010-11 145.90000
#> 4236   PSNB November 2011     2010-11 137.10000
#> 4237   PSNB    March 2012     2010-11 136.80000
#> 4329   PSNB December 2006     2011-12  22.00000
#> 4330   PSNB    March 2007     2011-12  24.00000
#> 4331   PSNB  October 2007     2011-12  25.00000
#> 4332   PSNB    March 2008     2011-12  27.00000
#> 4333   PSNB November 2008     2011-12  87.00000
#> 4334   PSNB    April 2009     2011-12 140.00000
#> 4335   PSNB November 2009     2011-12 140.00000
#> 4336   PSNB    March 2010     2011-12 131.00000
#> 4337   PSNB     June 2010     2011-12 116.00000
#> 4338   PSNB November 2010     2011-12 117.00000
#> 4339   PSNB    March 2011     2011-12 122.00000
#> 4340   PSNB November 2011     2011-12 127.00000
#> 4341   PSNB    March 2012     2011-12 126.00000
#> 4342   PSNB December 2012     2011-12 121.40000
#> 4343   PSNB    March 2013     2011-12 121.00000
#> 4435   PSNB  October 2007     2012-13  23.00000
#> 4436   PSNB    March 2008     2012-13  23.00000
#> 4437   PSNB November 2008     2012-13  70.00000
#> 4438   PSNB    April 2009     2012-13 118.00000
#> 4439   PSNB November 2009     2012-13 117.00000
#> 4440   PSNB    March 2010     2012-13 110.00000
#> 4441   PSNB     June 2010     2012-13  89.00000
#> 4442   PSNB November 2010     2012-13  91.00000
#> 4443   PSNB    March 2011     2012-13 101.00000
#> 4444   PSNB November 2011     2012-13 120.00000
#> 4445   PSNB    March 2012     2012-13  92.00000
#> 4446   PSNB December 2012     2012-13  80.50000
#> 4447   PSNB    March 2013     2012-13  86.50000
#> 4448   PSNB December 2013     2012-13  80.60000
#> 4449   PSNB    March 2014     2012-13  80.30000
#> 4541   PSNB November 2008     2013-14  54.00000
#> 4542   PSNB    April 2009     2013-14  97.00000
#> 4543   PSNB November 2009     2013-14  96.00000
#> 4544   PSNB    March 2010     2013-14  89.00000
#> 4545   PSNB     June 2010     2013-14  60.00000
#> 4546   PSNB November 2010     2013-14  60.00000
#> 4547   PSNB    March 2011     2013-14  70.00000
#> 4548   PSNB November 2011     2013-14 100.00000
#> 4549   PSNB    March 2012     2013-14  98.00000
#> 4550   PSNB December 2012     2013-14  99.30000
#> 4551   PSNB    March 2013     2013-14 107.70000
#> 4552   PSNB December 2013     2013-14  99.00000
#> 4553   PSNB    March 2014     2013-14  95.60000
#> 4554   PSNB December 2014     2013-14  97.50000
#> 4555   PSNB    March 2015     2013-14  97.30000
#> 4647   PSNB November 2009     2014-15  82.00000
#> 4648   PSNB    March 2010     2014-15  74.00000
#> 4649   PSNB     June 2010     2014-15  37.00000
#> 4650   PSNB November 2010     2014-15  35.00000
#> 4651   PSNB    March 2011     2014-15  46.00000
#> 4652   PSNB November 2011     2014-15  79.00000
#> 4653   PSNB    March 2012     2014-15  75.00000
#> 4654   PSNB December 2012     2014-15  87.90000
#> 4655   PSNB    March 2013     2014-15  97.30000
#> 4656   PSNB December 2013     2014-15  83.90000
#> 4657   PSNB    March 2014     2014-15  83.90000
#> 4658   PSNB December 2014     2014-15  91.30000
#> 4659   PSNB    March 2015     2014-15  90.20000
#> 4660   PSNB     July 2015     2014-15  89.20000
#> 4661   PSNB November 2015     2014-15  94.70000
#> 4662   PSNB    March 2016     2014-15  91.85500
#> 4753   PSNB     June 2010     2015-16  20.00000
#> 4754   PSNB November 2010     2015-16  18.00000
#> 4755   PSNB    March 2011     2015-16  29.00000
#> 4756   PSNB November 2011     2015-16  53.00000
#> 4757   PSNB    March 2012     2015-16  52.00000
#> 4758   PSNB December 2012     2015-16  73.30000
#> 4759   PSNB    March 2013     2015-16  87.10000
#> 4760   PSNB December 2013     2015-16  71.50000
#> 4761   PSNB    March 2014     2015-16  68.30000
#> 4762   PSNB December 2014     2015-16  75.90000
#> 4763   PSNB    March 2015     2015-16  75.30000
#> 4764   PSNB     July 2015     2015-16  69.50000
#> 4765   PSNB November 2015     2015-16  73.50000
#> 4766   PSNB    March 2016     2015-16  72.16180
#> 4767   PSNB November 2016     2015-16  76.03100
#> 4768   PSNB    March 2017     2015-16  71.65700
#> 4860   PSNB November 2011     2016-17  24.00000
#> 4861   PSNB    March 2012     2016-17  21.00000
#> 4862   PSNB December 2012     2016-17  49.00000
#> 4863   PSNB    March 2013     2016-17  60.80000
#> 4864   PSNB December 2013     2016-17  47.80000
#> 4865   PSNB    March 2014     2016-17  41.50000
#> 4866   PSNB December 2014     2016-17  40.90000
#> 4867   PSNB    March 2015     2016-17  39.40000
#> 4868   PSNB     July 2015     2016-17  43.10000
#> 4869   PSNB November 2015     2016-17  49.90000
#> 4870   PSNB    March 2016     2016-17  55.49061
#> 4871   PSNB November 2016     2016-17  68.18231
#> 4872   PSNB    March 2017     2016-17  51.74973
#> 4873   PSNB November 2017     2016-17  45.68100
#> 4874   PSNB    March 2018     2016-17  45.75300
#> 4966   PSNB December 2012     2017-18  31.20000
#> 4967   PSNB    March 2013     2017-18  42.00000
#> 4968   PSNB December 2013     2017-18  24.80000
#> 4969   PSNB    March 2014     2017-18  17.80000
#> 4970   PSNB December 2014     2017-18  14.50000
#> 4971   PSNB    March 2015     2017-18  12.80000
#> 4972   PSNB     July 2015     2017-18  24.30000
#> 4973   PSNB November 2015     2017-18  24.80000
#> 4974   PSNB    March 2016     2017-18  38.78350
#> 4975   PSNB November 2016     2017-18  58.97196
#> 4976   PSNB    March 2017     2017-18  58.25510
#> 4977   PSNB November 2017     2017-18  49.88248
#> 4978   PSNB    March 2018     2017-18  45.15968
#> 4979   PSNB  October 2018     2017-18  39.80900
#> 4980   PSNB    March 2019     2017-18  41.90400
#> 5072   PSNB December 2013     2018-19   1.90000
#> 5073   PSNB    March 2014     2018-19  -1.10000
#> 5074   PSNB December 2014     2018-19  -4.00000
#> 5075   PSNB    March 2015     2018-19  -5.20000
#> 5076   PSNB     July 2015     2018-19   6.40000
#> 5077   PSNB November 2015     2018-19   4.60000
#> 5078   PSNB    March 2016     2018-19  21.43870
#> 5079   PSNB November 2016     2018-19  46.51609
#> 5080   PSNB    March 2017     2018-19  40.81232
#> 5081   PSNB November 2017     2018-19  39.49845
#> 5082   PSNB    March 2018     2018-19  37.05502
#> 5083   PSNB  October 2018     2018-19  25.47768
#> 5084   PSNB    March 2019     2018-19  22.82216
#> 5085   PSNB    March 2020     2018-19  38.40900
#> 5178   PSNB December 2014     2019-20 -23.10000
#> 5179   PSNB    March 2015     2019-20  -7.00000
#> 5180   PSNB     July 2015     2019-20 -10.00000
#> 5181   PSNB November 2015     2019-20 -10.10000
#> 5182   PSNB    March 2016     2019-20 -10.44470
#> 5183   PSNB November 2016     2019-20  21.94069
#> 5184   PSNB    March 2017     2019-20  21.35984
#> 5185   PSNB November 2017     2019-20  34.74231
#> 5186   PSNB    March 2018     2019-20  33.90345
#> 5187   PSNB  October 2018     2019-20  31.75554
#> 5188   PSNB    March 2019     2019-20  29.33618
#> 5189   PSNB    March 2020     2019-20  47.44836
#> 5190   PSNB November 2020     2019-20  56.05600
#> 5191   PSNB    March 2021     2019-20  57.07700
#> 5284   PSNB     July 2015     2020-21 -11.60000
#> 5285   PSNB November 2015     2020-21 -14.70000
#> 5286   PSNB    March 2016     2020-21 -11.04248
#> 5287   PSNB November 2016     2020-21  20.74245
#> 5288   PSNB    March 2017     2020-21  20.59054
#> 5289   PSNB November 2017     2020-21  32.76802
#> 5290   PSNB    March 2018     2020-21  28.73563
#> 5291   PSNB  October 2018     2020-21  26.65718
#> 5292   PSNB    March 2019     2020-21  21.15655
#> 5293   PSNB    March 2020     2020-21  54.78562
#> 5294   PSNB November 2020     2020-21 393.54689
#> 5295   PSNB    March 2021     2020-21 354.62990
#> 5296   PSNB  October 2021     2020-21 319.94400
#> 5297   PSNB    March 2022     2020-21 321.91700
#> 5391   PSNB November 2016     2021-22  17.21912
#> 5392   PSNB    March 2017     2021-22  16.80280
#> 5393   PSNB November 2017     2021-22  30.07061
#> 5394   PSNB    March 2018     2021-22  25.99338
#> 5395   PSNB  October 2018     2021-22  23.81690
#> 5396   PSNB    March 2019     2021-22  17.63253
#> 5397   PSNB    March 2020     2021-22  66.65334
#> 5398   PSNB November 2020     2021-22 164.22802
#> 5399   PSNB    March 2021     2021-22 233.93434
#> 5400   PSNB  October 2021     2021-22 182.99378
#> 5401   PSNB    March 2022     2021-22 127.82988
#> 5402   PSNB November 2022     2021-22 133.27200
#> 5403   PSNB    March 2023     2021-22 122.37069
#> 5497   PSNB November 2017     2022-23  25.56316
#> 5498   PSNB    March 2018     2022-23  21.38825
#> 5499   PSNB  October 2018     2022-23  20.80849
#> 5500   PSNB    March 2019     2022-23  14.41548
#> 5501   PSNB    March 2020     2022-23  61.48594
#> 5502   PSNB November 2020     2022-23 104.59795
#> 5503   PSNB    March 2021     2022-23 106.92032
#> 5504   PSNB  October 2021     2022-23  83.00170
#> 5505   PSNB    March 2022     2022-23  99.14069
#> 5506   PSNB November 2022     2022-23 177.03392
#> 5507   PSNB    March 2023     2022-23 152.37240
#> 5508   PSNB November 2023     2022-23 128.26600
#> 5509   PSNB    March 2024     2022-23 128.68200
#> 5603   PSNB  October 2018     2023-24  19.75440
#> 5604   PSNB    March 2019     2023-24  13.45515
#> 5605   PSNB    March 2020     2023-24  60.23462
#> 5606   PSNB November 2020     2023-24 100.39440
#> 5607   PSNB    March 2021     2023-24  85.34083
#> 5608   PSNB  October 2021     2023-24  61.58387
#> 5609   PSNB    March 2022     2023-24  50.19457
#> 5610   PSNB November 2022     2023-24 140.02807
#> 5611   PSNB    March 2023     2023-24 131.56568
#> 5612   PSNB November 2023     2023-24 123.90988
#> 5613   PSNB    March 2024     2023-24 114.08493
#> 5614   PSNB  October 2024     2023-24 121.87400
#> 5615   PSNB    March 2025     2023-24 131.34400
#> 5709   PSNB    March 2020     2024-25  57.92369
#> 5710   PSNB November 2020     2024-25  99.57407
#> 5711   PSNB    March 2021     2024-25  74.43927
#> 5712   PSNB  October 2021     2024-25  46.32206
#> 5713   PSNB    March 2022     2024-25  36.52329
#> 5714   PSNB November 2022     2024-25  84.32658
#> 5715   PSNB    March 2023     2024-25  85.39792
#> 5716   PSNB November 2023     2024-25  84.57033
#> 5717   PSNB    March 2024     2024-25  87.22658
#> 5718   PSNB  October 2024     2024-25 127.49186
#> 5719   PSNB    March 2025     2024-25 137.32912
#> 5720   PSNB November 2025     2024-25 149.45600
#> 5814   PSNB November 2020     2025-26 101.83223
#> 5815   PSNB    March 2021     2025-26  73.67839
#> 5816   PSNB  October 2021     2025-26  46.36985
#> 5817   PSNB    March 2022     2025-26  34.82702
#> 5818   PSNB November 2022     2025-26  76.91501
#> 5819   PSNB    March 2023     2025-26  76.68430
#> 5820   PSNB November 2023     2025-26  76.83564
#> 5821   PSNB    March 2024     2025-26  77.48232
#> 5822   PSNB  October 2024     2025-26 105.57651
#> 5823   PSNB    March 2025     2025-26 117.68750
#> 5824   PSNB November 2025     2025-26 138.27003
#> 5920   PSNB  October 2021     2026-27  43.95607
#> 5921   PSNB    March 2022     2026-27  31.55087
#> 5922   PSNB November 2022     2026-27  80.34540
#> 5923   PSNB    March 2023     2026-27  63.45951
#> 5924   PSNB November 2023     2026-27  68.40559
#> 5925   PSNB    March 2024     2026-27  68.66064
#> 5926   PSNB  October 2024     2026-27  88.45967
#> 5927   PSNB    March 2025     2026-27  97.16124
#> 5928   PSNB November 2025     2026-27 112.09563
#> 6026   PSNB November 2022     2027-28  69.19774
#> 6027   PSNB    March 2023     2027-28  49.25826
#> 6028   PSNB November 2023     2027-28  49.05861
#> 6029   PSNB    March 2024     2027-28  50.56215
#> 6030   PSNB  October 2024     2027-28  72.16790
#> 6031   PSNB    March 2025     2027-28  80.16452
#> 6032   PSNB November 2025     2027-28  98.46789
#> 6132   PSNB November 2023     2028-29  35.00400
#> 6133   PSNB    March 2024     2028-29  39.43476
#> 6134   PSNB  October 2024     2028-29  71.90672
#> 6135   PSNB    March 2025     2028-29  77.42468
#> 6136   PSNB November 2025     2028-29  86.93911
#> 6238   PSNB  October 2024     2029-30  70.58379
#> 6239   PSNB    March 2025     2029-30  74.04239
#> 6240   PSNB November 2025     2029-30  67.86762
#> 6344   PSNB November 2025     2030-31  67.15492

# What did OBR forecast for 2024-25 PSNB at each Budget?
psnb <- get_forecasts("PSNB")
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
psnb[psnb$fiscal_year == "2024-25", ]
#>      series forecast_date fiscal_year     value
#> 5709   PSNB    March 2020     2024-25  57.92369
#> 5710   PSNB November 2020     2024-25  99.57407
#> 5711   PSNB    March 2021     2024-25  74.43927
#> 5712   PSNB  October 2021     2024-25  46.32206
#> 5713   PSNB    March 2022     2024-25  36.52329
#> 5714   PSNB November 2022     2024-25  84.32658
#> 5715   PSNB    March 2023     2024-25  85.39792
#> 5716   PSNB November 2023     2024-25  84.57033
#> 5717   PSNB    March 2024     2024-25  87.22658
#> 5718   PSNB  October 2024     2024-25 127.49186
#> 5719   PSNB    March 2025     2024-25 137.32912
#> 5720   PSNB November 2025     2024-25 149.45600
# }
```
