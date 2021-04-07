#' Clean NZ Freshwater Fish fishdasets
#'
#' Clean up data imported from the NZ Freshwater Fish Database.
#'
#' The first letter of all words in \code{catchname} and \code{locality} are 
#' capitalised and any non-alphanumeric characters are removed. \code{time} 
#' is converted to a standardised 24 hour format and nonsesical values 
#' converted to \code{NA}. \code{org} is converted to all lowercase and has
#' non-alphanumeric characters removed. \code{map} is converted to lower case
#' and has any non-three digit codes converted to \code{NA}. \code{catchname} 
#' codes are tidied following the suggested abbreviations (add URL), e.g.
#' \code{Cluth River}, \code{Clutha r} and \code{Clutha river} all 
#' become \code{Clutha R}. Finally a new variable \code{form} is added which
#' defines the sampled habitat type for each observation.
#' @param fishd A dataframe imported from the NZFFD using \code{nzffd_import}
#'
#' @return A dataframe of the same dimensions as \code{fishd}, but cleaned.
#'
#' @import stringr
#' @importFrom chron chron
#'
#' @examples
#' \dontrun{
#'
#' dat <- nzffd_clean(nzffdr::nzffd_data)
#' 
#' }
#' @export
nzffd_clean <- function(fishd) {

  if (is.data.frame(fishd) == FALSE) {
    stop("arg fishd must be a data.frame")
  }

  if (identical(cl_nms, colnames(fishd)) == FALSE) {
    stop(paste0("column names must be exactly: ", paste(cl_nms, collapse = ", "))
      )
  }

  # covert column types
  cols_int(fishd)
  cols_chr(fishd)

  fishd$m[fishd$m < 1 | fishd$m > 12] <- NA
  fishd$y[fishd$y > as.integer(format(Sys.Date(), "%Y"))] <- NA

  fishd$catchname <- uppr_case(fishd$catchname)

  
  # replace site type with relevant abbr. from repl list.
  for (i in names(repl)) {
    fishd$catchname <- sub(paste(paste0("\\b", repl[[i]], "\\b"),
      collapse = "|"
    ), i, fishd$catchname)
  }
  
  # run function again, if there is the word River twice, this 
  # corrects the second occurrence, penalty of ~3sec on the whole NZFFD
  for (i in names(repl)) {
    fishd$catchname <- sub(paste(paste0("\\b", repl[[i]], "\\b"),
                                 collapse = "|"
    ), i, fishd$catchname)
  }
  
  fishd$catchname[fishd$catchname == ""] <- NA
  fishd$catch[fishd$catch == ""] <- NA
  fishd$locality <- uppr_case(fishd$locality)
  fishd$locality <- to_txt(fishd$locality)
  fishd$locality[fishd$locality == ""] <- NA
  fishd$fishmeth[fishd$fishmeth == ""] <- NA
  fishd$abund[fishd$abund == ""] <- NA
  
  
  
  # add new variable "form"
  fishd <- add_frm(fishd)

  # fix time
  fishd$time <- to_txt(fishd$time)
  fishd$time <- as.POSIXct(sprintf("%s.0f", fishd$time), format = "%H%M")
  fishd$time <- chron::chron(times = substr(fishd$time, 12, 19))
  attr(fishd$time, "format") <- NULL

  fishd$org <- to_txt(fishd$org)
  fishd$org <- tolower(fishd$org)

  fishd$map <- tolower(fishd$map)
  fishd$map[nchar(fishd$map) != 3] <- NA

  return(fishd)
}

# helper functions ------------------------------------------------------------

# first letter to upper case
uppr_case <- function(x) {
  gsub("\\b([[:lower:]])([[:lower:]]+)",
    "\\U\\1\\L\\2", x,
    perl = TRUE
  )
}

# remove non-letter elements
to_txt <- function(x) {
  gsub("[[:punct:]]", "", x)
}

# get last word
lst_wrd <- function(x) {
  sub("^.* ([[:alnum:]]+)$", "\\1", x)
}

# cols to intiger
cols_int <- function(x) {
  cols <- c(
    "card", "m", "y", "east", "north", "altitude", "penet",
    "effort", "pass", "number", "minl", "maxl", "nzreach"
  )
  x[cols] <- lapply(x[cols], function(x) {
    suppressWarnings(as.integer(as.character(x)))
  })
}

# cols to character
cols_chr <- function(x) {
  cols2 <- c("time", "map", "abund")

  x[cols2] <- lapply(x[cols2], function(x) {
    suppressWarnings(as.character(x))
  })
}

# add new variable "form"
add_frm <- function(fishd){
  fishd$form <- lst_wrd(fishd$locality)
  is.na(fishd$form) <- !(fishd$form %in% frm)
  fishd$frm <- stringr::str_extract(fishd$locality, paste(frm, collapse = "|"))
  fishd$form <- ifelse(is.na(fishd$form) == TRUE, fishd$frm, fishd$form)
  fishd <- subset(fishd, select = -frm)
  return(fishd)
}
