# v0.4.0 schema for FSR output: standard tidy long cols + scenario_type.
fsr_cols <- c("period", "period_type", "series",
              "metric_type", "value", "unit", "scenario_type")

test_that("get_pension_projections() returns the v0.4.0 schema", {
  skip_on_cran()
  skip_if_offline()

  result <- get_pension_projections()

  expect_s3_class(result, "data.frame")
  expect_named(result, fsr_cols)
  expect_type(result$period,        "character")
  expect_type(result$series,        "character")
  expect_type(result$value,         "double")
  expect_type(result$scenario_type, "character")
  expect_gt(nrow(result), 100)
  expect_true(all(result$period_type == "fiscal_year"))
  expect_true(all(result$metric_type == "pct"))
  expect_true(all(result$unit == "pct"))
})

test_that("get_pension_projections() covers two scenario types", {
  skip_on_cran()
  skip_if_offline()

  result <- get_pension_projections()
  types  <- unique(result$scenario_type)

  expect_true("Demographic scenarios" %in% types)
  expect_true("Triple lock scenarios" %in% types)
})

test_that("get_pension_projections() covers 50-year horizon", {
  skip_on_cran()
  skip_if_offline()

  result  <- get_pension_projections()
  dem     <- result[result$scenario_type == "Demographic scenarios", ]
  n_years <- length(unique(dem$period))

  expect_gte(n_years, 40)
  expect_true(any(grepl("^206", dem$period)))
})

test_that("get_pension_projections() has plausible pension spending values", {
  skip_on_cran()
  skip_if_offline()

  result  <- get_pension_projections()
  expect_true(all(result$value >= 2 & result$value <= 20))
  central <- result[
    result$series == "Central projection" &
    result$scenario_type == "Demographic scenarios", ]
  expect_gt(nrow(central), 0)
  expect_true(all(central$value >= 3 & central$value <= 15))
})

test_that("get_pension_projections() returns obr_tbl with FSR provenance", {
  skip_on_cran()
  skip_if_offline()

  res  <- get_pension_projections()
  expect_s3_class(res, "obr_tbl")
  prov <- obr_provenance(res)
  expect_equal(prov$publication, "FSR")
  expect_match(prov$source_url, "fiscal-risks-and-sustainability")
  expect_match(prov$vintage, "^[A-Z][a-z]+ [0-9]{4}$")
})
