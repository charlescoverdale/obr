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

## See also

Other forecasts:
[`list_forecast_series()`](https://charlescoverdale.github.io/obr/reference/list_forecast_series.md)

## Examples

``` r
# \donttest{
op <- options(obr.cache_dir = tempdir())
# All PSNB forecasts
get_forecasts("PSNB")
#> ℹ Downloading historical_forecasts.xlsx from OBR...
#> ✔ Saved to cache.
#>      series forecast_date fiscal_year     value
#> 1      PSNB    April 1970     1970-71  -0.20000
#> 2      PSNB    March 1971     1970-71   0.60000
#> 107    PSNB    March 1971     1971-72   1.20000
#> 108    PSNB    March 1972     1971-72   1.30000
#> 213    PSNB    March 1972     1972-73   3.40000
#> 214    PSNB    March 1973     1972-73   2.90000
#> 319    PSNB    March 1973     1973-74   4.40000
#> 320    PSNB    March 1974     1973-74   4.30000
#> 425    PSNB    March 1974     1974-75   2.70000
#> 426    PSNB    April 1975     1974-75   7.60000
#> 531    PSNB    April 1975     1975-76   9.10000
#> 532    PSNB    April 1976     1975-76  10.80000
#> 637    PSNB    April 1976     1976-77  12.00000
#> 638    PSNB  January 1977     1976-77  11.00000
#> 639    PSNB    March 1977     1976-77   8.80000
#> 640    PSNB November 1977     1976-77   7.50000
#> 743    PSNB  January 1977     1977-78   8.50000
#> 744    PSNB    March 1977     1977-78   8.50000
#> 745    PSNB November 1977     1977-78   7.00000
#> 746    PSNB    April 1978     1977-78   5.70000
#> 851    PSNB    April 1978     1978-79   8.50000
#> 852    PSNB November 1978     1978-79   8.00000
#> 853    PSNB     June 1979     1978-79   9.20000
#> 957    PSNB November 1978     1979-80   8.50000
#> 958    PSNB     June 1979     1979-80   8.30000
#> 959    PSNB    March 1980     1979-80   9.10000
#> 1064   PSNB    March 1980     1980-81   8.50000
#> 1065   PSNB    March 1981     1980-81  13.50000
#> 1170   PSNB    March 1981     1981-82  10.60000
#> 1171   PSNB    March 1982     1981-82  10.60000
#> 1172   PSNB November 1982     1981-82   9.00000
#> 1276   PSNB    March 1982     1982-83   9.50000
#> 1277   PSNB November 1982     1982-83   9.00000
#> 1278   PSNB    March 1983     1982-83   7.50000
#> 1279   PSNB November 1983     1982-83   9.00000
#> 1381   PSNB    March 1982     1983-84   8.50000
#> 1382   PSNB November 1982     1983-84   8.00000
#> 1383   PSNB    March 1983     1983-84   8.20000
#> 1384   PSNB November 1983     1983-84  10.00000
#> 1385   PSNB    March 1984     1983-84  10.00000
#> 1386   PSNB November 1984     1983-84   9.75000
#> 1486   PSNB    March 1982     1984-85   6.50000
#> 1488   PSNB    March 1983     1984-85   8.00000
#> 1489   PSNB November 1983     1984-85   8.00000
#> 1490   PSNB    March 1984     1984-85   7.20000
#> 1491   PSNB November 1984     1984-85   8.50000
#> 1492   PSNB    March 1985     1984-85  10.50000
#> 1493   PSNB November 1985     1984-85  10.00000
#> 1593   PSNB    March 1983     1985-86   7.00000
#> 1595   PSNB    March 1984     1985-86   7.00000
#> 1596   PSNB November 1984     1985-86   7.00000
#> 1597   PSNB    March 1985     1985-86   7.10000
#> 1598   PSNB November 1985     1985-86   8.00000
#> 1599   PSNB    March 1986     1985-86   7.00000
#> 1600   PSNB November 1986     1985-86   6.00000
#> 1700   PSNB    March 1984     1986-87   7.00000
#> 1702   PSNB    March 1985     1986-87   7.50000
#> 1704   PSNB    March 1986     1986-87   7.10000
#> 1705   PSNB November 1986     1986-87   7.00000
#> 1706   PSNB    March 1987     1986-87   4.10000
#> 1707   PSNB November 1987     1986-87   3.40000
#> 1805   PSNB    March 1984     1987-88   7.00000
#> 1807   PSNB    March 1985     1987-88   7.00000
#> 1809   PSNB    March 1986     1987-88   7.00000
#> 1811   PSNB    March 1987     1987-88   3.90000
#> 1812   PSNB November 1987     1987-88   1.00000
#> 1813   PSNB    March 1988     1987-88  -3.00000
#> 1814   PSNB November 1988     1987-88  -3.60000
#> 1910   PSNB    March 1984     1988-89   7.00000
#> 1912   PSNB    March 1985     1988-89   7.50000
#> 1914   PSNB    March 1986     1988-89   7.00000
#> 1916   PSNB    March 1987     1988-89   4.00000
#> 1918   PSNB    March 1988     1988-89  -3.00000
#> 1919   PSNB November 1988     1988-89  -9.80000
#> 1920   PSNB    March 1989     1988-89 -13.90000
#> 1921   PSNB November 1989     1988-89 -14.30000
#> 2019   PSNB    March 1986     1989-90   7.00000
#> 2021   PSNB    March 1987     1989-90   5.00000
#> 2023   PSNB    March 1988     1989-90   0.00000
#> 2025   PSNB    March 1989     1989-90 -13.80000
#> 2026   PSNB November 1989     1989-90 -12.60000
#> 2027   PSNB    March 1990     1989-90  -7.10000
#> 2126   PSNB    March 1987     1990-91   5.00000
#> 2128   PSNB    March 1988     1990-91   0.00000
#> 2130   PSNB    March 1989     1990-91 -10.00000
#> 2132   PSNB    March 1990     1990-91  -6.90000
#> 2133   PSNB November 1990     1990-91  -3.00000
#> 2134   PSNB    March 1991     1990-91  -0.80000
#> 2233   PSNB    March 1988     1991-92   0.00000
#> 2235   PSNB    March 1989     1991-92  -6.00000
#> 2237   PSNB    March 1990     1991-92  -3.00000
#> 2239   PSNB    March 1991     1991-92   7.90000
#> 2240   PSNB November 1991     1991-92  10.50000
#> 2241   PSNB    March 1992     1991-92  13.80000
#> 2340   PSNB    March 1989     1992-93  -3.00000
#> 2342   PSNB    March 1990     1992-93   0.00000
#> 2344   PSNB    March 1991     1992-93  12.00000
#> 2346   PSNB    March 1992     1992-93  28.10000
#> 2347   PSNB November 1992     1992-93  37.00000
#> 2348   PSNB    March 1993     1992-93  35.10000
#> 2447   PSNB    March 1990     1993-94   0.00000
#> 2449   PSNB    March 1991     1993-94   7.00000
#> 2451   PSNB    March 1992     1993-94  32.00000
#> 2453   PSNB    March 1993     1993-94  50.10000
#> 2454   PSNB November 1993     1993-94  49.80000
#> 2455   PSNB     June 1994     1993-94  46.00000
#> 2456   PSNB November 1994     1993-94  51.40000
#> 2554   PSNB    March 1991     1994-95   0.00000
#> 2556   PSNB    March 1992     1994-95  25.00000
#> 2558   PSNB    March 1993     1994-95  44.00000
#> 2559   PSNB November 1993     1994-95  37.90000
#> 2560   PSNB     June 1994     1994-95  36.10000
#> 2561   PSNB November 1994     1994-95  40.40000
#> 2562   PSNB     June 1995     1994-95  39.90000
#> 2563   PSNB November 1995     1994-95  40.50000
#> 2661   PSNB    March 1992     1995-96  19.00000
#> 2663   PSNB    March 1993     1995-96  39.00000
#> 2664   PSNB November 1993     1995-96  30.00000
#> 2665   PSNB     June 1994     1995-96  27.90000
#> 2666   PSNB November 1994     1995-96  25.20000
#> 2667   PSNB     June 1995     1995-96  27.90000
#> 2668   PSNB November 1995     1995-96  31.40000
#> 2669   PSNB     July 1996     1995-96  34.60000
#> 2670   PSNB November 1996     1995-96  34.80000
#> 2766   PSNB    March 1992     1996-97   6.00000
#> 2768   PSNB    March 1993     1996-97  35.00000
#> 2769   PSNB November 1993     1996-97  21.00000
#> 2771   PSNB November 1994     1996-97  16.00000
#> 2772   PSNB     June 1995     1996-97  20.80000
#> 2773   PSNB November 1995     1996-97  25.40000
#> 2774   PSNB     July 1996     1996-97  28.80000
#> 2775   PSNB November 1996     1996-97  29.40000
#> 2776   PSNB     July 1996     1996-97  29.20000
#> 2873   PSNB    March 1993     1997-98  30.00000
#> 2874   PSNB November 1993     1997-98  12.00000
#> 2876   PSNB November 1994     1997-98   6.00000
#> 2878   PSNB November 1995     1997-98  16.00000
#> 2879   PSNB     July 1996     1997-98  22.90000
#> 2880   PSNB November 1996     1997-98  20.50000
#> 2881   PSNB     July 1996     1997-98  13.00000
#> 2882   PSNB November 1997     1997-98  12.00000
#> 2883   PSNB     June 1998     1997-98   3.50000
#> 2885   PSNB    March 1999     1997-98   6.60000
#> 2979   PSNB November 1993     1998-99   2.00000
#> 2981   PSNB November 1994     1998-99  -1.00000
#> 2983   PSNB November 1995     1998-99   5.00000
#> 2985   PSNB November 1996     1998-99  12.00000
#> 2986   PSNB     July 1996     1998-99   3.50000
#> 2987   PSNB November 1997     1998-99   4.70000
#> 2988   PSNB     June 1998     1998-99   0.00000
#> 2989   PSNB November 1998     1998-99  -2.90000
#> 2990   PSNB    March 1999     1998-99  -2.80000
#> 2992   PSNB    March 2000     1998-99  -4.90000
#> 3086   PSNB November 1994     1999-00  -8.00000
#> 3088   PSNB November 1995     1999-00  -3.00000
#> 3090   PSNB November 1996     1999-00   2.00000
#> 3093   PSNB     June 1998     1999-00   3.00000
#> 3094   PSNB November 1998     1999-00   6.00000
#> 3095   PSNB    March 1999     1999-00   4.00000
#> 3096   PSNB November 1999     1999-00  -2.10000
#> 3097   PSNB    March 2000     1999-00 -11.00000
#> 3099   PSNB    March 2001     1999-00 -15.20000
#> 3193   PSNB November 1995     2000-01 -15.00000
#> 3195   PSNB November 1996     2000-01  -9.00000
#> 3198   PSNB     June 1998     2000-01   1.00000
#> 3199   PSNB November 1998     2000-01   6.00000
#> 3200   PSNB    March 1999     2000-01   5.00000
#> 3201   PSNB November 1999     2000-01  -1.00000
#> 3202   PSNB    March 2000     2000-01  -5.00000
#> 3203   PSNB November 2000     2000-01  -8.70000
#> 3204   PSNB    March 2001     2000-01 -15.00000
#> 3206   PSNB    April 2002     2000-01 -15.90000
#> 3300   PSNB November 1996     2001-02 -21.00000
#> 3303   PSNB     June 1998     2001-02   1.00000
#> 3304   PSNB November 1998     2001-02   3.00000
#> 3305   PSNB    March 1999     2001-02   2.00000
#> 3306   PSNB November 1999     2001-02  -1.00000
#> 3307   PSNB    March 2000     2001-02  -3.00000
#> 3308   PSNB November 2000     2001-02  -5.00000
#> 3309   PSNB    March 2001     2001-02  -5.00000
#> 3310   PSNB November 2001     2001-02   2.50000
#> 3311   PSNB    April 2002     2001-02   1.30000
#> 3313   PSNB    April 2003     2001-02  -0.40000
#> 3408   PSNB     June 1998     2002-03   2.00000
#> 3409   PSNB November 1998     2002-03   2.00000
#> 3410   PSNB    March 1999     2002-03   3.00000
#> 3411   PSNB November 1999     2002-03   1.00000
#> 3412   PSNB    March 2000     2002-03   3.00000
#> 3413   PSNB November 2000     2002-03   2.00000
#> 3414   PSNB    March 2001     2002-03   2.00000
#> 3415   PSNB November 2001     2002-03  12.00000
#> 3416   PSNB    April 2002     2002-03  11.00000
#> 3417   PSNB November 2002     2002-03  20.10000
#> 3418   PSNB    April 2003     2002-03  24.00000
#> 3420   PSNB    March 2004     2002-03  22.90000
#> 3513   PSNB     June 1998     2003-04   1.00000
#> 3514   PSNB November 1998     2003-04   1.00000
#> 3515   PSNB    March 1999     2003-04   4.00000
#> 3516   PSNB November 1999     2003-04   4.00000
#> 3517   PSNB    March 2000     2003-04  11.00000
#> 3518   PSNB November 2000     2003-04  10.00000
#> 3519   PSNB    March 2001     2003-04  10.00000
#> 3520   PSNB November 2001     2003-04  15.00000
#> 3521   PSNB    April 2002     2003-04  13.00000
#> 3522   PSNB November 2002     2003-04  24.00000
#> 3523   PSNB    April 2003     2003-04  27.00000
#> 3524   PSNB December 2003     2003-04  37.40000
#> 3525   PSNB    March 2004     2003-04  37.50000
#> 3527   PSNB    March 2005     2003-04  35.40000
#> 3621   PSNB November 1999     2004-05   6.00000
#> 3622   PSNB    March 2000     2004-05  13.00000
#> 3623   PSNB November 2000     2004-05  12.00000
#> 3624   PSNB    March 2001     2004-05  11.00000
#> 3625   PSNB November 2001     2004-05  13.00000
#> 3626   PSNB    April 2002     2004-05  13.00000
#> 3627   PSNB November 2002     2004-05  19.00000
#> 3628   PSNB    April 2003     2004-05  24.00000
#> 3629   PSNB December 2003     2004-05  31.00000
#> 3630   PSNB    March 2004     2004-05  33.00000
#> 3631   PSNB December 2004     2004-05  34.20000
#> 3632   PSNB    March 2005     2004-05  34.40000
#> 3633   PSNB December 2005     2004-05  38.80000
#> 3634   PSNB    March 2006     2004-05  39.70000
#> 3728   PSNB November 2000     2005-06  13.00000
#> 3729   PSNB    March 2001     2005-06  12.00000
#> 3730   PSNB November 2001     2005-06  13.00000
#> 3731   PSNB    April 2002     2005-06  17.00000
#> 3732   PSNB November 2002     2005-06  19.00000
#> 3733   PSNB    April 2003     2005-06  23.00000
#> 3734   PSNB December 2003     2005-06  30.00000
#> 3735   PSNB    March 2004     2005-06  31.00000
#> 3736   PSNB December 2004     2005-06  33.00000
#> 3737   PSNB    March 2005     2005-06  32.00000
#> 3738   PSNB December 2005     2005-06  37.00000
#> 3739   PSNB    March 2006     2005-06  37.10000
#> 3740   PSNB December 2006     2005-06  37.50000
#> 3741   PSNB    March 2007     2005-06  37.80000
#> 3835   PSNB November 2001     2006-07  13.00000
#> 3836   PSNB    April 2002     2006-07  18.00000
#> 3837   PSNB November 2002     2006-07  19.00000
#> 3838   PSNB    April 2003     2006-07  22.00000
#> 3839   PSNB December 2003     2006-07  27.00000
#> 3840   PSNB    March 2004     2006-07  27.00000
#> 3841   PSNB December 2004     2006-07  29.00000
#> 3842   PSNB    March 2005     2006-07  29.00000
#> 3843   PSNB December 2005     2006-07  34.00000
#> 3844   PSNB    March 2006     2006-07  36.00000
#> 3845   PSNB December 2006     2006-07  36.80000
#> 3846   PSNB    March 2007     2006-07  35.00000
#> 3847   PSNB  October 2007     2006-07  31.00000
#> 3848   PSNB    March 2008     2006-07  30.10000
#> 3942   PSNB November 2002     2007-08  20.00000
#> 3943   PSNB    April 2003     2007-08  22.00000
#> 3944   PSNB December 2003     2007-08  27.00000
#> 3945   PSNB    March 2004     2007-08  27.00000
#> 3946   PSNB December 2004     2007-08  28.00000
#> 3947   PSNB    March 2005     2007-08  27.00000
#> 3948   PSNB December 2005     2007-08  31.00000
#> 3949   PSNB    March 2006     2007-08  30.00000
#> 3950   PSNB December 2006     2007-08  31.00000
#> 3951   PSNB    March 2007     2007-08  34.00000
#> 3952   PSNB  October 2007     2007-08  38.00000
#> 3953   PSNB    March 2008     2007-08  36.40000
#> 3954   PSNB November 2008     2007-08  36.60000
#> 3955   PSNB    April 2009     2007-08  34.60000
#> 4049   PSNB December 2003     2008-09  24.00000
#> 4050   PSNB    March 2004     2008-09  23.00000
#> 4051   PSNB December 2004     2008-09  24.00000
#> 4052   PSNB    March 2005     2008-09  24.00000
#> 4053   PSNB December 2005     2008-09  26.00000
#> 4054   PSNB    March 2006     2008-09  25.00000
#> 4055   PSNB December 2006     2008-09  27.00000
#> 4056   PSNB    March 2007     2008-09  30.00000
#> 4057   PSNB  October 2007     2008-09  36.00000
#> 4058   PSNB    March 2008     2008-09  43.00000
#> 4059   PSNB November 2008     2008-09  77.60000
#> 4060   PSNB    April 2009     2008-09  90.00000
#> 4061   PSNB November 2009     2008-09  95.40000
#> 4062   PSNB    March 2010     2008-09  96.10000
#> 4063   PSNB     June 2010     2008-09  96.10000
#> 4156   PSNB December 2004     2009-10  22.00000
#> 4157   PSNB    March 2005     2009-10  22.00000
#> 4158   PSNB December 2005     2009-10  23.00000
#> 4159   PSNB    March 2006     2009-10  24.00000
#> 4160   PSNB December 2006     2009-10  26.00000
#> 4161   PSNB    March 2007     2009-10  28.00000
#> 4162   PSNB  October 2007     2009-10  31.00000
#> 4163   PSNB    March 2008     2009-10  38.00000
#> 4164   PSNB November 2008     2009-10 118.00000
#> 4165   PSNB    April 2009     2009-10 175.00000
#> 4166   PSNB November 2009     2009-10 177.60000
#> 4167   PSNB    March 2010     2009-10 166.50000
#> 4168   PSNB     June 2010     2009-10 154.70000
#> 4169   PSNB November 2010     2009-10 156.00000
#> 4170   PSNB    March 2011     2009-10 156.40000
#> 4263   PSNB December 2005     2010-11  22.00000
#> 4264   PSNB    March 2006     2010-11  23.00000
#> 4265   PSNB December 2006     2010-11  24.00000
#> 4266   PSNB    March 2007     2010-11  26.00000
#> 4267   PSNB  October 2007     2010-11  28.00000
#> 4268   PSNB    March 2008     2010-11  32.00000
#> 4269   PSNB November 2008     2010-11 105.00000
#> 4270   PSNB    April 2009     2010-11 173.00000
#> 4271   PSNB November 2009     2010-11 176.00000
#> 4272   PSNB    March 2010     2010-11 163.00000
#> 4273   PSNB     June 2010     2010-11 149.10000
#> 4274   PSNB November 2010     2010-11 148.50000
#> 4275   PSNB    March 2011     2010-11 145.90000
#> 4276   PSNB November 2011     2010-11 137.10000
#> 4277   PSNB    March 2012     2010-11 136.80000
#> 4370   PSNB December 2006     2011-12  22.00000
#> 4371   PSNB    March 2007     2011-12  24.00000
#> 4372   PSNB  October 2007     2011-12  25.00000
#> 4373   PSNB    March 2008     2011-12  27.00000
#> 4374   PSNB November 2008     2011-12  87.00000
#> 4375   PSNB    April 2009     2011-12 140.00000
#> 4376   PSNB November 2009     2011-12 140.00000
#> 4377   PSNB    March 2010     2011-12 131.00000
#> 4378   PSNB     June 2010     2011-12 116.00000
#> 4379   PSNB November 2010     2011-12 117.00000
#> 4380   PSNB    March 2011     2011-12 122.00000
#> 4381   PSNB November 2011     2011-12 127.00000
#> 4382   PSNB    March 2012     2011-12 126.00000
#> 4383   PSNB December 2012     2011-12 121.40000
#> 4384   PSNB    March 2013     2011-12 121.00000
#> 4477   PSNB  October 2007     2012-13  23.00000
#> 4478   PSNB    March 2008     2012-13  23.00000
#> 4479   PSNB November 2008     2012-13  70.00000
#> 4480   PSNB    April 2009     2012-13 118.00000
#> 4481   PSNB November 2009     2012-13 117.00000
#> 4482   PSNB    March 2010     2012-13 110.00000
#> 4483   PSNB     June 2010     2012-13  89.00000
#> 4484   PSNB November 2010     2012-13  91.00000
#> 4485   PSNB    March 2011     2012-13 101.00000
#> 4486   PSNB November 2011     2012-13 120.00000
#> 4487   PSNB    March 2012     2012-13  92.00000
#> 4488   PSNB December 2012     2012-13  80.50000
#> 4489   PSNB    March 2013     2012-13  86.50000
#> 4490   PSNB December 2013     2012-13  80.60000
#> 4491   PSNB    March 2014     2012-13  80.30000
#> 4584   PSNB November 2008     2013-14  54.00000
#> 4585   PSNB    April 2009     2013-14  97.00000
#> 4586   PSNB November 2009     2013-14  96.00000
#> 4587   PSNB    March 2010     2013-14  89.00000
#> 4588   PSNB     June 2010     2013-14  60.00000
#> 4589   PSNB November 2010     2013-14  60.00000
#> 4590   PSNB    March 2011     2013-14  70.00000
#> 4591   PSNB November 2011     2013-14 100.00000
#> 4592   PSNB    March 2012     2013-14  98.00000
#> 4593   PSNB December 2012     2013-14  99.30000
#> 4594   PSNB    March 2013     2013-14 107.70000
#> 4595   PSNB December 2013     2013-14  99.00000
#> 4596   PSNB    March 2014     2013-14  95.60000
#> 4597   PSNB December 2014     2013-14  97.50000
#> 4598   PSNB    March 2015     2013-14  97.30000
#> 4691   PSNB November 2009     2014-15  82.00000
#> 4692   PSNB    March 2010     2014-15  74.00000
#> 4693   PSNB     June 2010     2014-15  37.00000
#> 4694   PSNB November 2010     2014-15  35.00000
#> 4695   PSNB    March 2011     2014-15  46.00000
#> 4696   PSNB November 2011     2014-15  79.00000
#> 4697   PSNB    March 2012     2014-15  75.00000
#> 4698   PSNB December 2012     2014-15  87.90000
#> 4699   PSNB    March 2013     2014-15  97.30000
#> 4700   PSNB December 2013     2014-15  83.90000
#> 4701   PSNB    March 2014     2014-15  83.90000
#> 4702   PSNB December 2014     2014-15  91.30000
#> 4703   PSNB    March 2015     2014-15  90.20000
#> 4704   PSNB     July 2015     2014-15  89.20000
#> 4705   PSNB November 2015     2014-15  94.70000
#> 4706   PSNB    March 2016     2014-15  91.85500
#> 4798   PSNB     June 2010     2015-16  20.00000
#> 4799   PSNB November 2010     2015-16  18.00000
#> 4800   PSNB    March 2011     2015-16  29.00000
#> 4801   PSNB November 2011     2015-16  53.00000
#> 4802   PSNB    March 2012     2015-16  52.00000
#> 4803   PSNB December 2012     2015-16  73.30000
#> 4804   PSNB    March 2013     2015-16  87.10000
#> 4805   PSNB December 2013     2015-16  71.50000
#> 4806   PSNB    March 2014     2015-16  68.30000
#> 4807   PSNB December 2014     2015-16  75.90000
#> 4808   PSNB    March 2015     2015-16  75.30000
#> 4809   PSNB     July 2015     2015-16  69.50000
#> 4810   PSNB November 2015     2015-16  73.50000
#> 4811   PSNB    March 2016     2015-16  72.16180
#> 4812   PSNB November 2016     2015-16  76.03100
#> 4813   PSNB    March 2017     2015-16  71.65700
#> 4906   PSNB November 2011     2016-17  24.00000
#> 4907   PSNB    March 2012     2016-17  21.00000
#> 4908   PSNB December 2012     2016-17  49.00000
#> 4909   PSNB    March 2013     2016-17  60.80000
#> 4910   PSNB December 2013     2016-17  47.80000
#> 4911   PSNB    March 2014     2016-17  41.50000
#> 4912   PSNB December 2014     2016-17  40.90000
#> 4913   PSNB    March 2015     2016-17  39.40000
#> 4914   PSNB     July 2015     2016-17  43.10000
#> 4915   PSNB November 2015     2016-17  49.90000
#> 4916   PSNB    March 2016     2016-17  55.49061
#> 4917   PSNB November 2016     2016-17  68.18231
#> 4918   PSNB    March 2017     2016-17  51.74973
#> 4919   PSNB November 2017     2016-17  45.68100
#> 4920   PSNB    March 2018     2016-17  45.75300
#> 5013   PSNB December 2012     2017-18  31.20000
#> 5014   PSNB    March 2013     2017-18  42.00000
#> 5015   PSNB December 2013     2017-18  24.80000
#> 5016   PSNB    March 2014     2017-18  17.80000
#> 5017   PSNB December 2014     2017-18  14.50000
#> 5018   PSNB    March 2015     2017-18  12.80000
#> 5019   PSNB     July 2015     2017-18  24.30000
#> 5020   PSNB November 2015     2017-18  24.80000
#> 5021   PSNB    March 2016     2017-18  38.78350
#> 5022   PSNB November 2016     2017-18  58.97196
#> 5023   PSNB    March 2017     2017-18  58.25510
#> 5024   PSNB November 2017     2017-18  49.88248
#> 5025   PSNB    March 2018     2017-18  45.15968
#> 5026   PSNB  October 2018     2017-18  39.80900
#> 5027   PSNB    March 2019     2017-18  41.90400
#> 5120   PSNB December 2013     2018-19   1.90000
#> 5121   PSNB    March 2014     2018-19  -1.10000
#> 5122   PSNB December 2014     2018-19  -4.00000
#> 5123   PSNB    March 2015     2018-19  -5.20000
#> 5124   PSNB     July 2015     2018-19   6.40000
#> 5125   PSNB November 2015     2018-19   4.60000
#> 5126   PSNB    March 2016     2018-19  21.43870
#> 5127   PSNB November 2016     2018-19  46.51609
#> 5128   PSNB    March 2017     2018-19  40.81232
#> 5129   PSNB November 2017     2018-19  39.49845
#> 5130   PSNB    March 2018     2018-19  37.05502
#> 5131   PSNB  October 2018     2018-19  25.47768
#> 5132   PSNB    March 2019     2018-19  22.82216
#> 5133   PSNB    March 2020     2018-19  38.40900
#> 5227   PSNB December 2014     2019-20 -23.10000
#> 5228   PSNB    March 2015     2019-20  -7.00000
#> 5229   PSNB     July 2015     2019-20 -10.00000
#> 5230   PSNB November 2015     2019-20 -10.10000
#> 5231   PSNB    March 2016     2019-20 -10.44470
#> 5232   PSNB November 2016     2019-20  21.94069
#> 5233   PSNB    March 2017     2019-20  21.35984
#> 5234   PSNB November 2017     2019-20  34.74231
#> 5235   PSNB    March 2018     2019-20  33.90345
#> 5236   PSNB  October 2018     2019-20  31.75554
#> 5237   PSNB    March 2019     2019-20  29.33618
#> 5238   PSNB    March 2020     2019-20  47.44836
#> 5239   PSNB November 2020     2019-20  56.05600
#> 5240   PSNB    March 2021     2019-20  57.07700
#> 5334   PSNB     July 2015     2020-21 -11.60000
#> 5335   PSNB November 2015     2020-21 -14.70000
#> 5336   PSNB    March 2016     2020-21 -11.04248
#> 5337   PSNB November 2016     2020-21  20.74245
#> 5338   PSNB    March 2017     2020-21  20.59054
#> 5339   PSNB November 2017     2020-21  32.76802
#> 5340   PSNB    March 2018     2020-21  28.73563
#> 5341   PSNB  October 2018     2020-21  26.65718
#> 5342   PSNB    March 2019     2020-21  21.15655
#> 5343   PSNB    March 2020     2020-21  54.78562
#> 5344   PSNB November 2020     2020-21 393.54689
#> 5345   PSNB    March 2021     2020-21 354.62990
#> 5346   PSNB  October 2021     2020-21 319.94400
#> 5347   PSNB    March 2022     2020-21 321.91700
#> 5442   PSNB November 2016     2021-22  17.21912
#> 5443   PSNB    March 2017     2021-22  16.80280
#> 5444   PSNB November 2017     2021-22  30.07061
#> 5445   PSNB    March 2018     2021-22  25.99338
#> 5446   PSNB  October 2018     2021-22  23.81690
#> 5447   PSNB    March 2019     2021-22  17.63253
#> 5448   PSNB    March 2020     2021-22  66.65334
#> 5449   PSNB November 2020     2021-22 164.22802
#> 5450   PSNB    March 2021     2021-22 233.93434
#> 5451   PSNB  October 2021     2021-22 182.99378
#> 5452   PSNB    March 2022     2021-22 127.82988
#> 5453   PSNB November 2022     2021-22 133.27200
#> 5454   PSNB    March 2023     2021-22 122.37069
#> 5549   PSNB November 2017     2022-23  25.56316
#> 5550   PSNB    March 2018     2022-23  21.38825
#> 5551   PSNB  October 2018     2022-23  20.80849
#> 5552   PSNB    March 2019     2022-23  14.41548
#> 5553   PSNB    March 2020     2022-23  61.48594
#> 5554   PSNB November 2020     2022-23 104.59795
#> 5555   PSNB    March 2021     2022-23 106.92032
#> 5556   PSNB  October 2021     2022-23  83.00170
#> 5557   PSNB    March 2022     2022-23  99.14069
#> 5558   PSNB November 2022     2022-23 177.03392
#> 5559   PSNB    March 2023     2022-23 152.37240
#> 5560   PSNB November 2023     2022-23 128.26600
#> 5561   PSNB    March 2024     2022-23 128.68200
#> 5656   PSNB  October 2018     2023-24  19.75440
#> 5657   PSNB    March 2019     2023-24  13.45515
#> 5658   PSNB    March 2020     2023-24  60.23462
#> 5659   PSNB November 2020     2023-24 100.39440
#> 5660   PSNB    March 2021     2023-24  85.34083
#> 5661   PSNB  October 2021     2023-24  61.58387
#> 5662   PSNB    March 2022     2023-24  50.19457
#> 5663   PSNB November 2022     2023-24 140.02807
#> 5664   PSNB    March 2023     2023-24 131.56568
#> 5665   PSNB November 2023     2023-24 123.90988
#> 5666   PSNB    March 2024     2023-24 114.08493
#> 5667   PSNB  October 2024     2023-24 121.87400
#> 5668   PSNB    March 2025     2023-24 131.34400
#> 5763   PSNB    March 2020     2024-25  57.92369
#> 5764   PSNB November 2020     2024-25  99.57407
#> 5765   PSNB    March 2021     2024-25  74.43927
#> 5766   PSNB  October 2021     2024-25  46.32206
#> 5767   PSNB    March 2022     2024-25  36.52329
#> 5768   PSNB November 2022     2024-25  84.32658
#> 5769   PSNB    March 2023     2024-25  85.39792
#> 5770   PSNB November 2023     2024-25  84.57033
#> 5771   PSNB    March 2024     2024-25  87.22658
#> 5772   PSNB  October 2024     2024-25 127.49186
#> 5773   PSNB    March 2025     2024-25 137.32912
#> 5774   PSNB November 2025     2024-25 149.45600
#> 5775   PSNB    March 2026     2024-25 152.74200
#> 5869   PSNB November 2020     2025-26 101.83223
#> 5870   PSNB    March 2021     2025-26  73.67839
#> 5871   PSNB  October 2021     2025-26  46.36985
#> 5872   PSNB    March 2022     2025-26  34.82702
#> 5873   PSNB November 2022     2025-26  76.91501
#> 5874   PSNB    March 2023     2025-26  76.68430
#> 5875   PSNB November 2023     2025-26  76.83564
#> 5876   PSNB    March 2024     2025-26  77.48232
#> 5877   PSNB  October 2024     2025-26 105.57651
#> 5878   PSNB    March 2025     2025-26 117.68750
#> 5879   PSNB November 2025     2025-26 138.27003
#> 5880   PSNB    March 2026     2025-26 132.73508
#> 5976   PSNB  October 2021     2026-27  43.95607
#> 5977   PSNB    March 2022     2026-27  31.55087
#> 5978   PSNB November 2022     2026-27  80.34540
#> 5979   PSNB    March 2023     2026-27  63.45951
#> 5980   PSNB November 2023     2026-27  68.40559
#> 5981   PSNB    March 2024     2026-27  68.66064
#> 5982   PSNB  October 2024     2026-27  88.45967
#> 5983   PSNB    March 2025     2026-27  97.16124
#> 5984   PSNB November 2025     2026-27 112.09563
#> 5985   PSNB    March 2026     2026-27 115.46142
#> 6083   PSNB November 2022     2027-28  69.19774
#> 6084   PSNB    March 2023     2027-28  49.25826
#> 6085   PSNB November 2023     2027-28  49.05861
#> 6086   PSNB    March 2024     2027-28  50.56215
#> 6087   PSNB  October 2024     2027-28  72.16790
#> 6088   PSNB    March 2025     2027-28  80.16452
#> 6089   PSNB November 2025     2027-28  98.46789
#> 6090   PSNB    March 2026     2027-28  96.46737
#> 6190   PSNB November 2023     2028-29  35.00400
#> 6191   PSNB    March 2024     2028-29  39.43476
#> 6192   PSNB  October 2024     2028-29  71.90672
#> 6193   PSNB    March 2025     2028-29  77.42468
#> 6194   PSNB November 2025     2028-29  86.93911
#> 6195   PSNB    March 2026     2028-29  86.01563
#> 6297   PSNB  October 2024     2029-30  70.58379
#> 6298   PSNB    March 2025     2029-30  74.04239
#> 6299   PSNB November 2025     2029-30  67.86762
#> 6300   PSNB    March 2026     2029-30  63.40344
#> 6404   PSNB November 2025     2030-31  67.15492
#> 6405   PSNB    March 2026     2030-31  59.01991

# What did OBR forecast for 2024-25 PSNB at each Budget?
psnb <- get_forecasts("PSNB")
#> ℹ Loading from cache. Use `refresh = TRUE` to re-download.
psnb[psnb$fiscal_year == "2024-25", ]
#>      series forecast_date fiscal_year     value
#> 5763   PSNB    March 2020     2024-25  57.92369
#> 5764   PSNB November 2020     2024-25  99.57407
#> 5765   PSNB    March 2021     2024-25  74.43927
#> 5766   PSNB  October 2021     2024-25  46.32206
#> 5767   PSNB    March 2022     2024-25  36.52329
#> 5768   PSNB November 2022     2024-25  84.32658
#> 5769   PSNB    March 2023     2024-25  85.39792
#> 5770   PSNB November 2023     2024-25  84.57033
#> 5771   PSNB    March 2024     2024-25  87.22658
#> 5772   PSNB  October 2024     2024-25 127.49186
#> 5773   PSNB    March 2025     2024-25 137.32912
#> 5774   PSNB November 2025     2024-25 149.45600
#> 5775   PSNB    March 2026     2024-25 152.74200
options(op)
# }
```
