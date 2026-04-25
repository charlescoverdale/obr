# Welfare Trends Report: charts and tables.
# URL resolved dynamically; resolver warns if it falls through to the
# hardcoded fallback.
WTR_FALLBACK <- "https://obr.uk/download/welfare-trends-report-october-2024-charts-and-tables/"
WTR_FILENAME <- "welfare_trends.xlsx"

wtr_source <- function(refresh = FALSE) {
  obr_get_xlsx(
    candidates = wtr_url_candidates(),
    fallback   = WTR_FALLBACK,
    filename   = WTR_FILENAME,
    refresh    = refresh,
    label      = "Welfare Trends Report"
  )
}

wtr_obr_tbl <- function(data, src) {
  new_obr_tbl(
    data        = data,
    publication = "WTR",
    vintage     = obr_url_vintage(src$url),
    source_url  = src$url,
    retrieved   = src$retrieved,
    file_md5    = src$file_md5
  )
}

# Generic parser for WTR chart data sheets.
# Layout: col 1 = NA (except "Back to contents" in row 1),
#         col 2 = chart title (row 2) then series names in last data rows,
#         cols 3+ = fiscal year labels (year_row) then values (data rows).
parse_wtr_chart <- function(path, sheet) {
  raw <- readxl::read_excel(path, sheet = sheet,
                            col_names = FALSE, .name_repair = "minimal")
  col2 <- as.character(unlist(raw[, 2]))

  non_na    <- which(!is.na(col2) & col2 != "")
  data_rows <- non_na[non_na > 2L]
  if (length(data_rows) == 0L) return(NULL)

  year_row_idx <- data_rows[1L] - 1L
  all_yr       <- as.character(unlist(raw[year_row_idx, ]))
  year_cols    <- which(grepl("^[0-9]{4}-[0-9]{2}$", all_yr))
  fiscal_years <- all_yr[year_cols]
  if (length(year_cols) == 0L) return(NULL)

  series_names <- col2[data_rows]

  result_list <- vector("list", length(data_rows))
  for (j in seq_along(data_rows)) {
    vals <- suppressWarnings(
      as.numeric(as.character(unlist(raw[data_rows[j], year_cols])))
    )
    result_list[[j]] <- data.frame(
      year   = fiscal_years,
      series = series_names[j],
      value  = vals,
      stringsAsFactors = FALSE
    )
  }

  result <- do.call(rbind, result_list)
  result[!is.na(result$value), ]
}

#' Get working-age welfare spending
#'
#' Downloads (and caches) the OBR Welfare Trends Report charts and tables
#' workbook and returns annual working-age welfare spending as a share of
#' GDP, split into incapacity-related and non-incapacity spending.
#'
#' Data cover fiscal years from 1978-79 through the current forecast horizon.
#' The exact vintage is recorded in the returned object's provenance.
#'
#' @param refresh Logical. If `TRUE`, re-download even if a cached copy
#'   exists. Defaults to `FALSE`.
#'
#' @return An `obr_tbl` with columns:
#' \describe{
#'   \item{year}{Fiscal year, e.g. `"2023-24"` (character)}
#'   \item{series}{Spending category: `"Working-age incapacity benefits spending"`
#'     or `"Working-age non-incapacity spending"` (character)}
#'   \item{value}{Spending as a percentage of GDP (numeric)}
#' }
#'
#' @examples
#' \donttest{
#' op <- options(obr.cache_dir = tempdir())
#' welfare <- get_welfare_spending()
#' welfare[welfare$series == "Working-age incapacity benefits spending" &
#'         welfare$year >= "2000-01", ]
#' options(op)
#' }
#'
#' @family welfare
#' @export
get_welfare_spending <- function(refresh = FALSE) {
  src <- wtr_source(refresh)
  wtr_obr_tbl(parse_wtr_chart(src$path, "C1.3"), src)
}

#' Get incapacity benefits spending by type
#'
#' Downloads (and caches) the OBR Welfare Trends Report charts and tables
#' workbook and returns annual spending on each incapacity benefit as a
#' share of GDP, from 1978-79 to the current forecast horizon.
#'
#' Series include: Invalidity Benefit, Incapacity Benefit, Employment and
#' Support Allowance (ESA), Sickness Benefit, and Severe Disablement
#' Allowance.
#'
#' @param refresh Logical. If `TRUE`, re-download even if a cached copy
#'   exists. Defaults to `FALSE`.
#'
#' @return An `obr_tbl` with columns:
#' \describe{
#'   \item{year}{Fiscal year, e.g. `"2023-24"` (character)}
#'   \item{series}{Benefit name (character)}
#'   \item{value}{Spending as a percentage of GDP (numeric)}
#' }
#'
#' @examples
#' \donttest{
#' op <- options(obr.cache_dir = tempdir())
#' ib <- get_incapacity_spending()
#' unique(ib$series)
#' options(op)
#' }
#'
#' @family welfare
#' @export
get_incapacity_spending <- function(refresh = FALSE) {
  src <- wtr_source(refresh)
  wtr_obr_tbl(parse_wtr_chart(src$path, "C1.1"), src)
}

#' Get incapacity benefit caseloads
#'
#' Downloads (and caches) the OBR Welfare Trends Report charts and tables
#' workbook and returns the combined incapacity benefit caseload since
#' 2008-09, in both absolute terms (thousands of claimants) and as a share
#' of the working-age population.
#'
#' @param refresh Logical. If `TRUE`, re-download even if a cached copy
#'   exists. Defaults to `FALSE`.
#'
#' @return An `obr_tbl` with columns:
#' \describe{
#'   \item{year}{Fiscal year, e.g. `"2023-24"` (character)}
#'   \item{series}{Either `"Claimants"` (thousands) or
#'     `"Share of working age population"` (per cent) (character)}
#'   \item{value}{Value in units appropriate to the series (numeric)}
#' }
#'
#' @examples
#' \donttest{
#' op <- options(obr.cache_dir = tempdir())
#' cases <- get_incapacity_caseloads()
#' cases[cases$series == "Claimants", ]
#' options(op)
#' }
#'
#' @family welfare
#' @export
get_incapacity_caseloads <- function(refresh = FALSE) {
  src <- wtr_source(refresh)
  wtr_obr_tbl(parse_wtr_chart(src$path, "C3.1"), src)
}
