#' Add River Environment Classification (REC) data to the NZFFD
#'
#' Use the reachID variable to match NZFFD sample locations against the REC database and add
#' coresponding REC data to the NZFFD.
#'
#' Note that any row that has an \code{nzreach} value of \code{0}, \code{9}
#' or \code{NA} will not return any REC data.
#'
#' This function requires an internet connection to query the REC database.
#'
#' REC citation:
#'
#' @param fishd A dataframe imported from the NZFFD using \code{import_nzffd}.
#'
#' @return A dataframe with the same number of rows as \code{fishd} but
#' with *XX* additional columns from the REC database added.
#'
#' @import httr xml2 jsonlite
#'
#' @examples
#' \dontrun{
#'
#' df <- add_nzffd(nzffdr::nzffd_data)
#' head(df)
#' }
#' @export
add_nzffd <- function(fishd) {

  if (is.data.frame(fishd) == FALSE) {
    stop("arg fishd must be a data.frame")
  }
  if("nzreach" %in% colnames(fishd) == FALSE) {
    stop("dataframe must include \"nzreach\" column")

  }
  # rec data, filter out 0, 9 and NA
  reach <- unique(fishd$nzreach)
  reach <- reach[!reach %in% c(NA, 0, 9)]

  resp <- httr::POST("http://elevation.auckland-cer.cloud.edu.au/rec",
    body = list(reach = jsonlite::toJSON(reach)),
    encode = "form"
  )
  results <- jsonlite::fromJSON(httr::content(resp,
    "text", encoding = "UTF-8"))[[1]]

  fishd <- merge(fishd, results, by.x = "nzreach", by.y = "NZREACH", all = TRUE)
  return(fishd)
  }

