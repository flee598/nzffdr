#' Add dates to a NZFFD dataset
#'
#' Add year, month and day columns to a NZFFD dataset.
#'
#' Adds year, month and day columns to a NZFFD dataset, based on values in 
#' the "eventDate" column.
#' 
#' @param fishd a dataframe imported from the NZFFD using [nzffdr_import()], which contains the column "eventDate"
#'
#' @return a NZFFD dataframe, with year, month and day columns added.
#'
#' @examples
#' nzffdr_add_dates(nzffdr::nzffdr_data)
#' 
#' @export
nzffdr_add_dates <- function(fishd){
  
  if (!any(colnames(fishd) == "eventDate")) {
    stop("fishd must be a data.frame returned from a call to nzffd_import(), containing the \"eventDate\" column")
  }
  
  # add year, month, day columns
  fishd$year <- as.integer(sapply(fishd$eventDate,
                                  function(x) unlist(strsplit(x, "\\-"))[1]))
  fishd$month <- as.integer(sapply(fishd$eventDate,
                                   function(x) unlist(strsplit(x, "\\-"))[2]))
  fishd$day <- as.integer(sapply(fishd$eventDate,
                                 function(x) unlist(strsplit(x, "\\-"))[3]))
return(fishd)
}