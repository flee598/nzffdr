#' Fish length to tidy long format
#'
#' Converts individual fish length measures from multiple entries in
#' a single cell to tidy long format.
#'
#' @param fishd an NZFFD dataframe returned from [nzffdr_import()]. Must contain
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
nzffdr_ind_lengths <- function(fishd){

  cls <- c("nzffdRecordNumber", "taxonName", "indLengths")
  
  if (!all(cls %in% colnames(fishd))) {
    stop(paste(cls,  "must be present in fishd"), call. = FALSE)
  }
  
  dl <- fishd[cls]
  dl <- stats::na.omit(dl)
  dl <- stack(stats::setNames(strsplit(dl[[cls[3]]], ','), dl[[cls[1]]]))
  colnames(dl) <- cls[c(3,1)]
  df2 <- fishd[cls[-3]]
  dl2 <- merge(dl, df2)
  dl2 <- dl2[cls]
  
  return(dl2)
}
