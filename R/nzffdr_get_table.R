#' Get NZFFD search terms
#'
#' Lists of possible argument options for function \code{nzffdr_import()}.
#'
#' Returns the possible argument values for arguments: fish_method, 
#' institution and taxon, used in the function \code{nzffdr_import()}
#' 
#' This function requires an internet connection to query NIWA's database.
#' 
#' @param x one of "fish_method", "institution" or "taxon", depending on
#' which argument values are wanted.
#'
#' @return A dataframe or character string of argument options.
#'
#' @import xml2
#' @importFrom httr GET
#'
#' @examples
#' \dontrun{
#'
#' dat <- nzffdr_get_table("taxon")
#' 
#' }
#' @export
nzffdr_get_table <- function(x = c("fish_method", "institution", "taxon")) {
  
  if (!curl::has_internet()){message("There appears to be no internet connection"); return(NULL)}
  
  if (x == "fish_method") {
    x <- "sample_method"
    res <- get_tbl2(x)
    res <- res[res$NAME != "", 1]
  }
  
  if (x == "institution") {
    x <- "organisation"
    res <- get_tbl2(x)
    res <- res[res$NAME != "", 1]
  }
  
  if (x == "taxon") {
    x <- "taxon]["
    res <- get_tbl2(x)
    res <- res[res$NAME != "", 1]
    
    res <-  data.frame(
      common_name = trimws(sub("\\(.*", "", res)),
      sci_name = trimws(gsub(".*\\((.*)\\).*", "\\1", res))
    )
  }
  return(res)
}
# helper functions -------------------------------------------------------------

# get web html info
get_doc <- function() {
  gr <- httr::GET("https://nzffdms.niwa.co.nz/search")
  xml2::read_html(httr::content(gr, "text"))
}

# get tables
get_tbl2 <- function(x) {
  do.call(
    rbind,
    lapply(
      xml2::xml_find_all(
        get_doc(),
        paste0(".//select[@name='sample_search[", x, "]']/option")
      ),
      function(n) {
        data.frame(
          NAME = xml2::xml_text(n),
          VALUE = xml2::xml_attr(n, "value")
        )
      }
    )
  )
}