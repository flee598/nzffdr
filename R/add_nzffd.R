#' Add River Environment Classification (REC) data to the NZFFD
#'
#' Use the \code{nzreach} variable in the NZFFD to match NZFFD sample locations against the \code{NZREACH} code in the 
#' \href{https://data.mfe.govt.nz/layer/51845-river-environment-classification-new-zealand-2010-deprecated/}{River Environment Classification} (REC) database and attach corresponding REC data to the NZFFD dataframe.
#'
#' Note that any row that has an \code{nzreach} value of \code{0}, \code{9}
#' or \code{NA} will not return any REC data.
#'
#' This function requires an internet connection to query the REC database.
#'
#'
#' @param fishd A dataframe imported from the NZFFD using \code{nzffd_import}.
#'
#' @return A dataframe with the same number of rows as \code{fishd} but
#' with 24 additional columns from the REC database added.
#'
#' @import httr xml2 jsonlite
#'
#' @examples
#' \dontrun{
#'
#' df <- nzffd_add(nzffdr::nzffd_data)

#' }
#' @export
nzffd_add <- function(fishd) {
  
  if (!is.data.frame(fishd)) {
    stop("arg fishd must be a data.frame")
  }

  if (!("nzreach" %in% colnames(fishd))) {
    stop("dataframe must include \"nzreach\" column")
  }

  # filter out 0, 9 and NA nzreaches, these relate to lagoons, etc. 
  reach <- unique(fishd$nzreach)
  reach <- reach[!reach %in% c(NA, 0, 9)]

  resp <- httr::POST("http://elevation.auckland-cer.cloud.edu.au/rec",
    body = list(reach = jsonlite::toJSON(reach)),
    encode = "form"
  )
  
  results <- jsonlite::fromJSON(httr::content(resp,
    "text",encoding = "UTF-8"
  ))[[1]]

  fishd <- merge(fishd, results, by.x = "nzreach", by.y = "NZREACH", all = TRUE)
  return(fishd)
}
