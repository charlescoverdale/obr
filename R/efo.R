# EFO Detailed Forecast Tables
# URLs are resolved dynamically; the fallback is the latest known good URL
# at package release. Silent fallbacks were removed in 0.3.0; the resolver
# warns when it falls through.
EFO_AGGREGATES_FALLBACK <- "https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-aggregates/"
EFO_AGGREGATES_FILENAME <- "efo_aggregates.xlsx"
EFO_ECONOMY_FALLBACK    <- "https://obr.uk/download/march-2026-economic-and-fiscal-outlook-detailed-forecast-tables-economy/"
EFO_ECONOMY_FILENAME    <- "efo_economy.xlsx"

efo_aggregates_source <- function(refresh = FALSE, vintage = NULL) {
  vintage <- resolve_efo_vintage(vintage)
  if (!is.null(vintage)) {
    return(efo_pinned_source(
      vintage  = vintage,
      suffix   = "detailed-forecast-tables-aggregates",
      stem     = "efo_aggregates",
      refresh  = refresh
    ))
  }
  obr_get_xlsx(
    candidates = efo_url_candidates("detailed-forecast-tables-aggregates"),
    fallback   = EFO_AGGREGATES_FALLBACK,
    filename   = EFO_AGGREGATES_FILENAME,
    refresh    = refresh,
    label      = "EFO Aggregates"
  )
}

efo_economy_source <- function(refresh = FALSE, vintage = NULL) {
  vintage <- resolve_efo_vintage(vintage)
  if (!is.null(vintage)) {
    return(efo_pinned_source(
      vintage  = vintage,
      suffix   = "detailed-forecast-tables-economy",
      stem     = "efo_economy",
      refresh  = refresh
    ))
  }
  obr_get_xlsx(
    candidates = efo_url_candidates("detailed-forecast-tables-economy"),
    fallback   = EFO_ECONOMY_FALLBACK,
    filename   = EFO_ECONOMY_FILENAME,
    refresh    = refresh,
    label      = "EFO Economy"
  )
}

# Download an EFO file pinned to a specific vintage. No URL probing: the
# vintage table determines the slug. Cache filenames carry the vintage tag
# so different vintages do not overwrite each other.
efo_pinned_source <- function(vintage, suffix, stem, refresh = FALSE) {
  url <- efo_url_for_vintage(vintage, suffix)
  filename <- sprintf("%s_%s.xlsx", stem, vintage_cache_tag(vintage))
  path <- obr_fetch(url, filename, refresh = refresh)
  list(
    path      = path,
    url       = url,
    final_url = url,
    source    = "pinned",
    retrieved = tryCatch(file.info(path)$mtime, error = function(e) Sys.time()),
    file_md5  = tryCatch(unname(tools::md5sum(path)), error = function(e) NA_character_)
  )
}

# Build an obr_tbl from a parsed EFO frame and a source descriptor.
efo_obr_tbl <- function(data, src) {
  new_obr_tbl(
    data        = data,
    publication = "EFO",
    vintage     = obr_url_vintage(src$url),
    source_url  = src$url,
    retrieved   = src$retrieved,
    file_md5    = src$file_md5
  )
}

# Parse sheet 6.5 (Components of Net Borrowing) from EFO aggregates file.
# Row 5 has fiscal year labels in columns that contain year-like strings.
# Data rows are those where col 2 is non-NA and at least one value is numeric.
parse_efo_fiscal <- function(path) {
  raw <- readxl::read_excel(path, sheet = "6.5",
                            col_names = FALSE, .name_repair = "minimal")

  all_row5 <- as.character(unlist(raw[5, ]))
  year_cols <- which(grepl("^[0-9]{4}-[0-9]{2}$", all_row5))
  fiscal_years <- all_row5[year_cols]

  col2 <- as.character(unlist(raw[, 2]))

  result_list <- list()
  for (i in seq_len(nrow(raw))) {
    nm <- col2[i]
    if (is.na(nm) || nm == "") next
    vals <- suppressWarnings(
      as.numeric(as.character(unlist(raw[i, year_cols])))
    )
    if (all(is.na(vals))) next
    result_list[[length(result_list) + 1]] <- data.frame(
      fiscal_year = fiscal_years,
      series      = nm,
      value_bn    = vals,
      stringsAsFactors = FALSE
    )
  }

  result <- do.call(rbind, result_list)
  result[!is.na(result$value_bn), ]
}

# Generic parser for EFO economy sheets (quarterly, wide format).
# Finds the first row where col 2 has a quarterly period (e.g. "2008Q1"),
# then takes the row immediately before it as the series-name header.
parse_efo_economy_sheet <- function(path, sheet) {
  raw <- readxl::read_excel(path, sheet = sheet,
                            col_names = FALSE, .name_repair = "minimal")

  col2 <- as.character(unlist(raw[, 2]))
  is_period <- grepl("^[0-9]{4}Q[1-4]$", col2)
  first_data_row <- which(is_period)[1]
  if (is.na(first_data_row)) return(NULL)

  header_row <- NA
  for (i in (first_data_row - 1):1) {
    v <- as.character(unlist(raw[i, 3]))
    if (!is.na(v) && is.na(suppressWarnings(as.numeric(v)))) {
      header_row <- i
      break
    }
  }
  if (is.na(header_row)) return(NULL)

  series <- trimws(gsub("\r\n", " ",
                        as.character(unlist(raw[header_row, 3:ncol(raw)]))))
  valid_series <- !is.na(series) & series != ""

  data_idx <- which(is_period)
  periods  <- col2[data_idx]

  result_list <- list()
  for (j in which(valid_series)) {
    col_idx <- j + 2L
    if (col_idx > ncol(raw)) next
    vals <- suppressWarnings(
      as.numeric(as.character(unlist(raw[data_idx, col_idx])))
    )
    if (all(is.na(vals))) next
    result_list[[length(result_list) + 1]] <- data.frame(
      period = periods,
      series = series[j],
      value  = vals,
      stringsAsFactors = FALSE
    )
  }

  if (length(result_list) == 0) return(NULL)
  result <- do.call(rbind, result_list)
  result[!is.na(result$value), ]
}

# Special-case parser for sheet 1.14 (output gap).
# Fix in 0.3.0: locate the value column by scanning each column for the one
# containing the most numeric entries aligned with the quarterly periods,
# rather than hardcoding column 3. This protects us from OBR moving the
# column or inserting a leading column.
parse_efo_output_gap <- function(path) {
  raw <- readxl::read_excel(path, sheet = "1.14",
                            col_names = FALSE, .name_repair = "minimal")
  col2 <- as.character(unlist(raw[, 2]))
  is_period <- grepl("^[0-9]{4}Q[1-4]$", col2)
  data_idx  <- which(is_period)
  if (length(data_idx) == 0L) return(NULL)

  best_col <- NA_integer_
  best_n   <- -1L
  for (j in 3:ncol(raw)) {
    vals <- suppressWarnings(
      as.numeric(as.character(unlist(raw[data_idx, j])))
    )
    n <- sum(!is.na(vals))
    if (n > best_n) {
      best_n   <- n
      best_col <- j
    }
  }
  if (is.na(best_col)) return(NULL)

  data.frame(
    period = col2[data_idx],
    series = "Output gap",
    value  = suppressWarnings(
      as.numeric(as.character(unlist(raw[data_idx, best_col])))
    ),
    stringsAsFactors = FALSE
  )
}

#' List available EFO economy measures
#'
#' Returns a data frame of the economy measures available via
#' [get_efo_economy()], showing the `measure` name to pass and a
#' short description of what each covers.
#'
#' @return A data frame with columns `measure`, `sheet`, and `description`.
#'
#' @examples
#' list_efo_economy_measures()
#'
#' @family EFO
#' @export
list_efo_economy_measures <- function() {
  data.frame(
    measure = c("labour", "inflation", "output_gap"),
    sheet   = c("1.6", "1.7", "1.14"),
    description = c(
      "Labour market: employment, unemployment rate, participation rate, hours worked",
      "Inflation: CPI, CPIH, RPI, RPIX, mortgage rates, rents",
      "OBR central estimate of the output gap (% of potential output)"
    ),
    stringsAsFactors = FALSE
  )
}

#' Get EFO fiscal projections (net borrowing components)
#'
#' Downloads (and caches) the OBR \emph{Economic and Fiscal Outlook} Detailed
#' Forecast Tables - Aggregates file and returns the components of net
#' borrowing (Table 6.5) in tidy long format.
#'
#' Covers the five-year forecast horizon published at the most recent
#' fiscal event. Key series include current receipts, current expenditure,
#' depreciation, net investment, and net borrowing (PSNB). The exact
#' vintage is recorded in the returned object's provenance attribute and
#' visible in the printed header.
#'
#' @param refresh Logical. If `TRUE`, re-download even if a cached copy
#'   exists. Defaults to `FALSE`.
#' @param vintage Optional EFO vintage label such as `"October 2024"`. If
#'   supplied, the function downloads the file for that specific EFO. If
#'   `NULL` (the default), the function uses any vintage set via [obr_pin()],
#'   or falls back to the latest live EFO via the dynamic URL resolver. See
#'   [obr_efo_vintages()] for the full list of supported vintages.
#'
#' @return An `obr_tbl` with columns:
#' \describe{
#'   \item{fiscal_year}{Fiscal year being forecast, e.g. `"2025-26"` (character)}
#'   \item{series}{Component name, e.g. `"Net borrowing"` (character)}
#'   \item{value_bn}{Projected value in \enc{£}{GBP} billion (numeric)}
#' }
#'
#' @examples
#' \donttest{
#' op <- options(obr.cache_dir = tempdir())
#' efo <- get_efo_fiscal()
#' efo[efo$series == "Net borrowing", ]
#' obr_provenance(efo)$vintage
#'
#' # Pin to a specific EFO for reproducibility
#' october_2024 <- get_efo_fiscal(vintage = "October 2024")
#' options(op)
#' }
#'
#' @family EFO
#' @export
get_efo_fiscal <- function(refresh = FALSE, vintage = NULL) {
  src <- efo_aggregates_source(refresh = refresh, vintage = vintage)
  efo_obr_tbl(parse_efo_fiscal(src$path), src)
}

#' Get EFO economy projections
#'
#' Downloads (and caches) the OBR \emph{Economic and Fiscal Outlook} Detailed
#' Forecast Tables - Economy file and returns quarterly economic projections
#' for a chosen measure in tidy long format.
#'
#' Data run from 2008 Q1 through the current forecast horizon. Use
#' [list_efo_economy_measures()] to see all available measures.
#'
#' @param measure Character. Which economy table to return. One of
#'   `"inflation"`, `"labour"`, or `"output_gap"`. Defaults to
#'   `"inflation"`.
#' @param refresh Logical. If `TRUE`, re-download even if a cached copy
#'   exists. Defaults to `FALSE`.
#' @param vintage Optional EFO vintage label such as `"October 2024"`. If
#'   supplied, the function downloads the file for that specific EFO. If
#'   `NULL` (the default), the function uses any vintage set via [obr_pin()],
#'   or falls back to the latest live EFO via the dynamic URL resolver.
#'
#' @return An `obr_tbl` with columns:
#' \describe{
#'   \item{period}{Calendar quarter, e.g. `"2025Q1"` (character)}
#'   \item{series}{Variable name, e.g. `"CPI"` (character)}
#'   \item{value}{Value in units appropriate to the series (numeric)}
#' }
#'
#' @examples
#' \donttest{
#' op <- options(obr.cache_dir = tempdir())
#' inf <- get_efo_economy("inflation")
#' inf[inf$series == "CPI", ]
#'
#' lab <- get_efo_economy("labour")
#'
#' # Compare CPI projections from two different EFOs
#' inf_oct24 <- get_efo_economy("inflation", vintage = "October 2024")
#' inf_mar26 <- get_efo_economy("inflation", vintage = "March 2026")
#' options(op)
#' }
#'
#' @family EFO
#' @export
get_efo_economy <- function(measure = c("inflation", "labour", "output_gap"),
                            refresh = FALSE,
                            vintage = NULL) {
  measure <- match.arg(measure)
  src <- efo_economy_source(refresh = refresh, vintage = vintage)
  data <- if (measure == "output_gap") {
    parse_efo_output_gap(src$path)
  } else {
    sheet_map <- c(labour = "1.6", inflation = "1.7")
    parse_efo_economy_sheet(src$path, sheet_map[[measure]])
  }
  efo_obr_tbl(data, src)
}
