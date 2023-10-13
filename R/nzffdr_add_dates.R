#' Add dates to a NZFFD dataset
#'
#' Add year, month and day columns to a NZFFD dataset.
#'
#' Adds year, month and day columns to a NZFFD dataset, based on values in 
#' the "eventDate" column.
#' 
#' @param fishd a dataframe imported from the NZFFD using \code{nzffdr_import()}, which contains the column \code{"eventDate"}
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
  
  # # add year, month, day columns
  # fishd <-  tidyr::separate(data = fishd,
  #                   col = .data$eventDate,
  #                   into = c("year", "month", "day"),
  #                   sep = "-",
  #                   remove = FALSE,
  #                   fill = "right",
  #                   convert = TRUE)
  
  
  datetxt <- as.Date(fishd$eventDate)
  df <- data.frame(date = datetxt,
                   year = as.integer(format(datetxt, format = "%Y")),
                   month = as.integer(format(datetxt, format = "%m")),
                   day = as.integer(format(datetxt, format = "%d")))
  
  # place new columns following the eventDate column
  target <- which(names(fishd) == 'eventDate')[1]
  
  fishd <- cbind(fishd[ ,1:target, drop = F],
                 df,
                 fishd[ ,(target + 1):length(fishd),
                        drop = F])

return(fishd)
}