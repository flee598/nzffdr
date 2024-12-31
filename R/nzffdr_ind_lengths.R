#' Fish length to tidy long format
#'
#' Converts individual fish length measures from multiple entries in
#' a single cell to tidy long format.
#'
#' @param fishd an NZFFD dataframe returned from nzffdr_import(). Must contain
#' the columns "nzffdRecordNumber", "taxonName" and "indLengths".
#'
#' @return A dataframe with three columns,"nzffdRecordNumber", "taxonName" and
#'  "indLengths".
#'
#' @importFrom stats na.omit setNames
#'
#' @examples
#' nzffdr_ind_lengths(nzffdr::nzffdr_data)
#' @export
nzffdr_ind_lengths <- function (fishd) {
  
  cls <- c("nzffdRecordNumber", "taxonName", "indLengths")
  
  if (!all(cls %in% colnames(fishd))) {
    stop(paste(cls, "must be present in fishd"), call. = FALSE)
  }
  
  dl <- fishd[cls]
  dl <- stats::na.omit(dl)
  
  lens <- strsplit(dl[[cls[3]]], ",")
  n_lens <- sapply(lens, length)
  dl2 <- stack(stats::setNames(lens, dl[["nzffdRecordNumber"]]))
  colnames(dl2) <- cls[c(3, 1)]
  dl2$taxonName <- rep(dl$taxonName, n_lens)
  
  dl2$indLengths <- trimws(dl2$indLengths, which = "both")
  
  # some data entries (missing commas) in the lengths gives a warning - don't need
  # to see it.
  dl2$indLengths <- suppressWarnings(as.integer(dl2$indLengths))
  
  dl2 <- stats::na.omit(dl2)
  
  return(dl2[cls])
}

