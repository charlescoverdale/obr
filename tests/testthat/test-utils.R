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
