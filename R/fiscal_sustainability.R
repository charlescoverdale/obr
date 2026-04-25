# Fiscal Risks and Sustainability: executive summary charts and tables.
# URL resolved dynamically; resolver warns if it falls through to the
# hardcoded fallback.
FSR_EXEC_FALLBACK <- "https://obr.uk/download/july-2025-fiscal-risks-and-sustainability-charts-and-tables-executive-summary/"
FSR_EXEC_FILENAME <- "fsr_executive_summary.xlsx"

fsr_exec_source <- function(refresh = FALSE) {
  obr_get_xlsx(
    candidates = fsr_url_candidates(),
    fallback   = FSR_EXEC_FALLBACK,
    filename   = FSR_EXEC_FILENAME,
    refresh    = refresh,
    label      = "Fiscal Risks and Sustainability Report"
  )
}

fsr_obr_tbl <- function(data, src) {
  new_obr_tbl(
    data        = data,
    publication = "FSR",
    vintage     = obr_url_vintage(src$url),
    source_url  = src$url,
    retrieved   = src$retrieved,
    file_md5    = src$file_md5
  )
}

# Parse C1.2: state pension spending scenarios.
# The sheet has two separate sections, each beginning with a section-header
# row whose col 2 names the section and whose cols 3+ contain fiscal year
# labels. Data rows have a scenario name in col 2 and projected values
# (% of GDP) in the same column positions as the fiscal years.
#
# 0.3.0 fix: section detection now uses fuzzy matching ("demographic" /
# "triple lock") rather than exact strings, so OBR can rename the section
# header without silently breaking the parser.
parse_pension_projections <- function(path) {
  raw  <- readxl::read_excel(path, sheet = "C1.2",
                             col_names = FALSE, .name_repair = "minimal")
  col2 <- as.character(unlist(raw[, 2]))

  is_demographic <- !is.na(col2) & grepl("demographic", col2, ignore.case = TRUE)
  is_triple_lock <- !is.na(col2) & grepl("triple lock",  col2, ignore.case = TRUE)
  section_idx    <- which(is_demographic | is_triple_lock)
  if (length(section_idx) == 0L) {
    cli::cli_warn(c(
      "Could not find expected section headers in FSR sheet C1.2.",
      "i" = "Looked for rows whose second column matches {.val demographic} or {.val triple lock}.",
      "!" = "OBR may have renamed the sections. Please file an issue at https://github.com/charlescoverdale/issues."
    ))
    return(NULL)
  }

  section_name <- vapply(section_idx, function(i) {
    if (is_demographic[i]) "Demographic scenarios" else "Triple lock scenarios"
  }, character(1))

  result_list <- list()

  for (s_idx in seq_along(section_idx)) {
    s_row    <- section_idx[s_idx]
    sec_name <- section_name[s_idx]

    end_row <- if (s_idx < length(section_idx)) {
      section_idx[s_idx + 1L] - 1L
    } else {
      nrow(raw)
    }

    yr_vals   <- as.character(unlist(raw[s_row, ]))
    year_cols <- which(grepl("^[0-9]{4}-[0-9]{2}$", yr_vals))
    if (length(year_cols) == 0L) next
    fiscal_years <- yr_vals[year_cols]

    for (i in (s_row + 1L):end_row) {
      if (i > nrow(raw)) break
      nm <- col2[i]
      if (is.na(nm) || nm == "") next
      vals <- suppressWarnings(
        as.numeric(as.character(unlist(raw[i, year_cols])))
      )
      if (all(is.na(vals))) next
      result_list[[length(result_list) + 1L]] <- data.frame(
        scenario_type = sec_name,
        scenario      = nm,
        fiscal_year   = fiscal_years,
        pct_gdp       = vals,
        stringsAsFactors = FALSE
      )
    }
  }

  if (length(result_list) == 0L) return(NULL)
  do.call(rbind, result_list)
}

#' Get long-run state pension spending projections
#'
#' Downloads (and caches) the OBR Fiscal Risks and Sustainability Report
#' executive summary charts and tables workbook and returns 50-year
#' projections for state pension spending as a share of GDP, under
#' alternative demographic and triple-lock uprating scenarios.
#'
#' This data is unique to the Fiscal Risks and Sustainability Report and is
#' not available in any other OBR publication. It illustrates how ageing
#' demographics and pension uprating rules interact to determine the
#' long-run cost of the state pension. The exact vintage is recorded in
#' the returned object's provenance.
#'
#' @param refresh Logical. If `TRUE`, re-download even if a cached copy
#'   exists. Defaults to `FALSE`.
#'
#' @return An `obr_tbl` with columns:
#' \describe{
#'   \item{scenario_type}{Either `"Demographic scenarios"` or
#'     `"Triple lock scenarios"` (character)}
#'   \item{scenario}{Scenario name, e.g. `"Central projection"`,
#'     `"Higher life expectancy"` (character)}
#'   \item{fiscal_year}{Fiscal year, e.g. `"2030-31"` (character)}
#'   \item{pct_gdp}{State pension spending as a percentage of GDP (numeric)}
#' }
#'
#' @examples
#' \donttest{
#' op <- options(obr.cache_dir = tempdir())
#' proj <- get_pension_projections()
#'
#' central <- proj[proj$scenario_type == "Demographic scenarios" &
#'                 proj$scenario == "Central projection", ]
#' tail(central, 10)
#'
#' dem <- proj[proj$scenario_type == "Demographic scenarios", ]
#' options(op)
#' }
#'
#' @family long-term fiscal
#' @export
get_pension_projections <- function(refresh = FALSE) {
  src <- fsr_exec_source(refresh)
  fsr_obr_tbl(parse_pension_projections(src$path), src)
}
