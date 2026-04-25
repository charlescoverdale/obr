# Try a sequence of OBR download URLs until one responds with status < 400.
# Returns a list with: $url        (the working candidate URL or NA),
#                      $final_url  (URL after redirects, used to recover the
#                                  publication vintage when the slug is stable),
#                      $source     ("live" if a candidate worked, "none" if not).
# OBR URLs follow the pattern: https://obr.uk/download/{month}-{year}-{publication}/
# Stable slugs (like public-finances-databank/) redirect to the latest file;
# capturing the redirect target lets us recover the vintage.
obr_resolve_url <- function(url_candidates) {
  for (url in url_candidates) {
    # GET (the OBR's WordPress endpoints don't reliably support HEAD).
    # Redirects are followed so the final URL can be recovered for
    # publications that use a stable slug.
    resp <- tryCatch(
      httr2::request(url) |>
        httr2::req_user_agent("obr R package (https://github.com/charlescoverdale/obr)") |>
        httr2::req_error(is_error = function(resp) FALSE) |>
        httr2::req_perform(),
      error = function(e) NULL
    )
    if (!is.null(resp) && httr2::resp_status(resp) < 400L) {
      final_url <- tryCatch(httr2::resp_url(resp), error = function(e) url)
      return(list(url = url, final_url = final_url, source = "live"))
    }
  }
  list(url = NA_character_, final_url = NA_character_, source = "none")
}

# Build EFO URL candidates for recent publication cycles (most recent first).
efo_url_candidates <- function(suffix) {
  current_year <- as.integer(format(Sys.Date(), "%Y"))
  months <- c("march", "october", "november")
  candidates <- character(0)
  for (yr in seq(current_year, current_year - 2L)) {
    for (mn in months) {
      candidates <- c(candidates, paste0(
        "https://obr.uk/download/", mn, "-", yr,
        "-economic-and-fiscal-outlook-", suffix, "/"
      ))
    }
  }
  candidates
}

# Build WTR URL candidates.
wtr_url_candidates <- function() {
  current_year <- as.integer(format(Sys.Date(), "%Y"))
  months <- c("october", "june", "march")
  candidates <- character(0)
  for (yr in seq(current_year, current_year - 2L)) {
    for (mn in months) {
      candidates <- c(candidates, paste0(
        "https://obr.uk/download/welfare-trends-report-", mn, "-", yr,
        "-charts-and-tables/"
      ))
    }
  }
  candidates
}

# Build FSR URL candidates.
fsr_url_candidates <- function() {
  current_year <- as.integer(format(Sys.Date(), "%Y"))
  months <- c("july", "march", "october")
  candidates <- character(0)
  for (yr in seq(current_year, current_year - 2L)) {
    for (mn in months) {
      candidates <- c(candidates, paste0(
        "https://obr.uk/download/", mn, "-", yr,
        "-fiscal-risks-and-sustainability-charts-and-tables-executive-summary/"
      ))
    }
  }
  candidates
}

# Build Historical Official Forecasts Database URL candidates.
# OBR sometimes re-uses an older slug across vintages, so we try recent slugs
# first and fall through to the known-stable slug as a fallback.
forecasts_url_candidates <- function() {
  current_year <- as.integer(format(Sys.Date(), "%Y"))
  months <- c("march", "november", "october", "july")
  candidates <- character(0)
  for (yr in seq(current_year, current_year - 3L)) {
    for (mn in months) {
      candidates <- c(candidates, paste0(
        "https://obr.uk/download/historical-official-forecasts-database-",
        mn, "-", yr, "/"
      ))
    }
  }
  candidates
}

# Cache directory (platform-aware, base R).
obr_cache_dir <- function() {
  d <- getOption("obr.cache_dir", default = tools::R_user_dir("obr", "cache"))
  if (!dir.exists(d)) dir.create(d, recursive = TRUE)
  d
}

# Download a file and cache it; return local path.
obr_fetch <- function(url, filename, refresh = FALSE) {
  if (!is.logical(refresh) || length(refresh) != 1L || is.na(refresh)) {
    cli::cli_abort("{.arg refresh} must be a single {.cls logical} value.")
  }

  path <- file.path(obr_cache_dir(), filename)

  if (file.exists(path) && !refresh) {
    cli::cli_inform(c("i" = "Loading from cache. Use {.code refresh = TRUE} to re-download."))
    return(path)
  }

  cli::cli_inform(c("i" = "Downloading {.file {filename}} from OBR..."))

  resp <- tryCatch(
    httr2::request(url) |>
      httr2::req_user_agent("obr R package (https://github.com/charlescoverdale/obr)") |>
      httr2::req_throttle(rate = 5 / 10) |>
      httr2::req_retry(
        # 403 is included alongside 429/503 because the OBR's CDN occasionally
        # returns 403 to legitimate requests when probing many URLs in quick
        # succession; backing off and retrying typically clears it.
        max_tries    = 4,
        is_transient = function(resp) {
          httr2::resp_status(resp) %in% c(403L, 429L, 503L)
        },
        backoff      = function(i) min(30, 2 ^ i)
      ) |>
      httr2::req_perform(),
    error = function(e) {
      cli::cli_abort(
        c("Failed to download {.url {url}}.",
          "x" = conditionMessage(e)),
        call = NULL
      )
    }
  )

  writeBin(httr2::resp_body_raw(resp), path)
  cli::cli_inform(c("v" = "Saved to cache."))
  path
}

# Resolve URL with fallback, download, return list with full source metadata.
# Raises a clear warning if the live candidates all failed and a fallback was
# used: this is the audit fix for the silent-fallback issue.
obr_get_xlsx <- function(candidates, fallback, filename, refresh = FALSE,
                         label = "OBR publication") {
  resolved <- obr_resolve_url(candidates)
  if (resolved$source == "live") {
    url       <- resolved$url
    final_url <- resolved$final_url
    source    <- "live"
  } else {
    cli::cli_warn(c(
      "Could not resolve a current {label} URL from {length(candidates)} candidate{?s}.",
      "i" = "Falling back to {.url {fallback}}.",
      "!" = "Returned data may be older than expected. Run with internet access, or pin a vintage explicitly when that feature ships."
    ))
    url       <- fallback
    final_url <- fallback
    source    <- "fallback"
  }

  path <- obr_fetch(url, filename, refresh = refresh)

  retrieved <- tryCatch(file.info(path)$mtime,
                        error = function(e) Sys.time())
  md5 <- tryCatch(unname(tools::md5sum(path)),
                  error = function(e) NA_character_)

  list(
    path      = path,
    url       = url,
    final_url = final_url,
    source    = source,
    retrieved = retrieved,
    file_md5  = md5
  )
}

# Tolerant sheet-name resolver. Pass a primary expected name and an optional
# regex fallback; returns the first match found in the file. Errors clearly
# (with the available sheet list) if neither matches.
resolve_sheet_name <- function(path, primary, fallback_pattern = NULL) {
  available <- readxl::excel_sheets(path)
  if (primary %in% available) return(primary)
  if (!is.null(fallback_pattern)) {
    m <- grep(fallback_pattern, available, value = TRUE)
    if (length(m) >= 1L) return(m[1L])
  }
  cli::cli_abort(c(
    "Could not find sheet matching {.val {primary}} in {.file {basename(path)}}.",
    "i" = "Available sheets: {.val {available}}.",
    "!" = "OBR may have changed the sheet name. Please file an issue at https://github.com/charlescoverdale/obr/issues."
  ))
}

#' Clear cached OBR files
#'
#' Deletes all files downloaded and cached by the obr package. The next
#' function call will re-download fresh data from the OBR website.
#'
#' @return Invisibly returns `NULL`.
#'
#' @examples
#' \donttest{
#' op <- options(obr.cache_dir = tempdir())
#' clear_cache()
#' options(op)
#' }
#'
#' @family data access
#' @export
clear_cache <- function() {
  files <- list.files(obr_cache_dir(), full.names = TRUE)
  n <- length(files)
  if (n > 0) file.remove(files)
  cli::cli_inform("Removed {n} cached file{?s}.")
  invisible(NULL)
}
