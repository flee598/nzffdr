#' Converts habitat variables to tidy wide format
#'
#' Converts habitat variables to tidy wide format columns and appends to 
#' original dataframe. Warning, with large (>100k rows) datasets this function 
#' slow (~30 seconds).
#'
#' @param fishd an NZFFD dataframe returned from nzffdr_import.
#' 
#' @param cols_to_expand the habitat columns to expand, can be any combination
#'  of "habitatFlowPercent", "habitatInstreamCoverPresent",
#'  "habitatRiparianVegPercent", "habitatSubstratePercent". 
#'
#' @return An NZFFD dataframe with added wide format columns for each of the 
#' selected habitat columns.
#'
#' @importFrom stats reshape setNames na.omit
#'
#' @examples
#' nzffdr_widen_habitat(nzffdr::nzffdr_data)
#' @export
nzffdr_widen_habitat <- function(fishd,
                                 cols_to_expand = c(
                                   "habitatFlowPercent",
                                   "habitatInstreamCoverPresent",
                                   "habitatRiparianVegPercent",
                                   "habitatSubstratePercent")) {
  
  if (!all(cols_to_expand %in% colnames(fishd))) {
    stop("all of cols_to_expand must be present in fishd", call. = FALSE)
  }
  
  xx <- fishd[c("nzffdRecordNumber", cols_to_expand)]
  res <- vector(mode = "list", length = length(xx) - 1)
  
  for (i in 2:length(xx)) {

    xx2 <- xx[, c(1, i)]
    cl <- colnames(xx)[i]
    xx2[xx2 == ""] <- NA
    xx2 <- stats::na.omit(xx2)
    
    xx2 <- stack(stats::setNames(strsplit(xx2[[cl]], ','), xx2[["nzffdRecordNumber"]]))
    xx2 <- stack(stats::setNames(strsplit(xx2[["values"]], ':'), xx2[["ind"]]))
    xx2[["values"]] <- trimws(xx2[["values"]])
    
    xx3 <- suppressWarnings(fun_df(xx2, cl))
    xx3 <- xx3[!duplicated(xx3), ]
    
    out <- stats::reshape(xx3, v.names = "percent", idvar = "nzffdRecordNumber",
            timevar = "stuff", direction = "wide", sep = "_")
    
    if (cl != "habitatSubstratePercent") out[is.na(out)] <- 0

    out <- fun_col_names(out)
    res[[i-1]] <- out
  }
  res <- Reduce(function(...) merge(..., all = T), res)
  res <- merge(fishd, res, by = "nzffdRecordNumber", all = T)
  return(res)
}

# helper functions -------------------------------------------------------------
# clean col names
fun_col_names <- function(fishd) {
  clnm <- gsub("percent_", "", colnames(fishd))
  string <- gsub("\\s+", " ", gsub("[^[:alnum:] ]", " ", clnm))
  colnames(fishd) <- gsub(" ", "_", trimws(string))
  return(fishd)
}

# rebuild df
fun_df <- function(fishd, cl){
  
  colnames(fishd) <- c(cl, "nzffdRecordNumber")
  
  fishd2 <- data.frame(
    nzffdRecordNumber = fishd[["nzffdRecordNumber"]][c(TRUE, FALSE)],
    stuff = fishd[[cl]][c(TRUE, FALSE)])

  if (cl == "habitatSubstratePercent") {
    fishd2$percent <- fishd[[cl]][c(FALSE, TRUE)]
  } else {
    fishd2$percent <- as.integer(fishd[[cl]][c(FALSE, TRUE)])
  }
  return(fishd2)
}