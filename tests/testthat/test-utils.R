test_that("clear_cache() runs without error", {
  op <- options(obr.cache_dir = tempfile("obr_test_cache_"))
  on.exit(options(op))
  dir.create(getOption("obr.cache_dir"), recursive = TRUE)
  expect_invisible(clear_cache())
})

test_that("obr_cache_dir() creates and returns a directory", {
  op <- options(obr.cache_dir = tempfile("obr_test_dir_"))
  on.exit(options(op))
  d <- obr_cache_dir()
  expect_type(d, "character")
  expect_true(dir.exists(d))
})

test_that("each edition of a publication gets its own cache file", {
  a <- edition_cache_name("public_finances_databank.xlsx",
    "https://obr.uk/download/public-finances-databank-october-2026-efo/")
  b <- edition_cache_name("public_finances_databank.xlsx",
    "https://obr.uk/download/public-finances-databank-march-2026-efo/")
  expect_equal(a, "public_finances_databank__public-finances-databank-october-2026-efo.xlsx")
  expect_false(identical(a, b))
})

test_that("obr_cache_ttl() defaults to 7 days and rejects bad values", {
  op <- options(obr.cache_ttl = NULL)
  on.exit(options(op))
  expect_equal(obr_cache_ttl(), 168)
  options(obr.cache_ttl = -1)
  expect_error(obr_cache_ttl(), "non-negative")
  options(obr.cache_ttl = "a week")
  expect_error(obr_cache_ttl(), "non-negative")
})

test_that("obr_fetch() serves a fresh cached copy without the network", {
  op <- options(obr.cache_dir = tempfile("obr_test_ttl_"), obr.cache_ttl = 1)
  on.exit(options(op))
  path <- file.path(obr_cache_dir(), "x.xlsx")
  writeLines("cached", path)
  expect_equal(suppressMessages(obr_fetch("http://127.0.0.1:9/", "x.xlsx")), path)
})

test_that("obr_fetch() falls back to an expired copy when the download fails", {
  skip_on_cran()
  op <- options(obr.cache_dir = tempfile("obr_test_ttl_"), obr.cache_ttl = 0)
  on.exit(options(op))
  path <- file.path(obr_cache_dir(), "x.xlsx")
  writeLines("cached", path)
  expect_warning(
    out <- suppressMessages(obr_fetch("http://127.0.0.1:9/", "x.xlsx")),
    "cached copy"
  )
  expect_equal(out, path)
  expect_equal(readLines(path), "cached")
})

test_that("classify_metric_type() splits Index from YoY series names", {
  expect_equal(classify_metric_type("CPI Index"),     "index")
  expect_equal(classify_metric_type("CPIH Index"),    "index")
  expect_equal(classify_metric_type("CPI inflation"), "yoy_pct")
  expect_equal(classify_metric_type("Real GDP growth"), "yoy_pct")
  expect_equal(classify_metric_type("Y/Y change"),    "yoy_pct")
  expect_equal(classify_metric_type("Unemployment rate"), "pct")
  expect_equal(classify_metric_type("Participation rate"), "pct")
  expect_equal(classify_metric_type("Net borrowing"),  "level")
  # "deflator" is intentionally NOT classified as index because OBR sometimes
  # reports it as YoY % change rather than as a level index. Caller (e.g.
  # the inflation sheet parser) supplies a default_metric_type for these.
  expect_equal(classify_metric_type("GDP deflator"),   "level")
  expect_equal(classify_metric_type("Output gap (pp)"), "pct_pts")
  # v0.5.0: tighter rules so EFO Aggregates Section 6 series classify cleanly.
  # "Index-linked gilts" should NOT be index (it's a % of GDP value); "Index"
  # only matches at end of string or with explicit base-year tag.
  expect_equal(classify_metric_type("Index-linked gilts"), "level")
  expect_equal(classify_metric_type("CPI (2015=100)"),     "index")
  # Bare "change" must not trigger yoy_pct: OBR has many "change in X"
  # series that are level differences in £bn.
  expect_equal(
    classify_metric_type("Adjustment for the change in pension entitlements"),
    "level"
  )
  # Vectorised
  expect_equal(
    classify_metric_type(c("CPI Index", "CPI inflation", "Net borrowing")),
    c("index", "yoy_pct", "level")
  )
})

test_that("default_unit_for_metric() maps metric_type to unit", {
  expect_equal(default_unit_for_metric("index"),   "index")
  expect_equal(default_unit_for_metric("yoy_pct"), "pct")
  expect_equal(default_unit_for_metric("pct"),     "pct")
  expect_equal(default_unit_for_metric("pct_pts"), "pct_pts")
  expect_true(is.na(default_unit_for_metric("level")))
})

test_that("obr_long() builds the standard schema", {
  out <- obr_long(
    period      = c("2024-25", "2025-26"),
    period_type = "fiscal_year",
    series      = "PSNB",
    value       = c(120.5, 110.2),
    unit        = "gbp_bn",
    metric_type = "level"
  )
  expect_named(out, c("period", "period_type", "series",
                      "metric_type", "value", "unit"))
  expect_equal(nrow(out), 2)
  expect_equal(out$series, c("PSNB", "PSNB"))
  expect_equal(out$unit, c("gbp_bn", "gbp_bn"))
})

test_that("obr_long() infers metric_type from series when omitted", {
  out <- obr_long(
    period      = c("2025Q1", "2025Q1"),
    period_type = "quarter",
    series      = c("CPI Index", "CPI inflation"),
    value       = c(135.1, 2.1),
    unit        = c("index", "pct")
  )
  expect_equal(out$metric_type, c("index", "yoy_pct"))
})

test_that("URL candidates probe autumn slugs before spring within a year", {
  cands <- efo_url_candidates("detailed-forecast-tables-aggregates")
  yr <- format(Sys.Date(), "%Y")
  nov <- grep(paste0("november-", yr), cands)
  oct <- grep(paste0("october-", yr), cands)
  mar <- grep(paste0("march-", yr), cands)
  expect_true(nov < oct && oct < mar)

  fc <- forecasts_url_candidates()
  expect_true(grep(paste0("november-", yr), fc) <
                grep(paste0("march-", yr), fc))
})
