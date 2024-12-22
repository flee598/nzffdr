#' Import NZ Freshwater Fish datasets.
#'
#' Import data from the NZ Freshwater Fish Database. Enter search terms as 
#' arguments as you would in the NZFFD and import directly into R. You can 
#' search using all the same query options which are
#' used for in the \href{https://nzffdms.niwa.co.nz/search}{NZFFFD}, see their
#' \href{https://niwa.co.nz/information-services/nz-freshwater-fish-database}{info page} 
#' for details. To import the entire database leave all arguments as default.  
#'
#' This function requires an internet connection to query NIWA's database.
#'
#' Data citation: Stoffels R (2022). New Zealand Freshwater Fish Database (extended).
#' The National Institute of Water and Atmospheric Research (NIWA).
#' Sampling event dataset https://doi.org/10.15468/jbpw92
#'
#' @param institution institution that collected the data. Use the
#' \code{nzffdr_get_table("institution")} function to see a list of all possible options,
#' or don't set the arg if you want all institutions in the database.
#' 
#' @param catchment_num catchment number. A 6 digit number unique to the reach of
#' interest. You can search using the individual number (e.g. \code{catchment =
#' "702.500"}), or for all rivers in a catchment you can use the wildcard
#' search term (e.g. \code{catchment = "702\%"}), or don't set the arg if you
#' want all catchments in the database.
#'
#' @param catchment_name catchment name. e.g. \code{catchment_name = "Hinds R"}. 
#' Case sensitive. Don't set the arg if you want all catchments in the database.
#'
#' @param water_body water body name. e.g. to get all records for Limestone
#' Creek, \code{water_body = "Limestone Creek"}. Don't set the arg if you
#' want all water bodies in the database.
#'
#' @param fish_method fishing method used. Use the \code{nzffdr_get_table("fish_method")} 
#' function to see a list of all possible options. If you only want fish caught
#' be lures use \code{fish_meth = "Angling - Lure"}, don't set the arg if
#' you want all fishing methods in the database.
#'
#' @param taxon taxon of interest. Use the \code{nzffdr_get_table("taxon")} function
#' to see a list of all possible options. You can search using either 
#' common or scientific names and can search for multiple taxon at 
#' once, e.g. to search for Black mudfish use \code{taxon = "Black mudfish"} 
#' or \code{taxon = "Neochanna diversus"} and to search for Black mudfish
#' and Bluegill bully use \code{taxon = c("Black mudfish", "Bluegill bully")} 
#' etc.
#' 
#' @param download_format use "all" or "essential" to download either, all 
#' variables (67 columns), which now includes some River Environment
#' Classification data, or just essential data (23 columns).
#'
#' @param starts start year. Don't set the arg if
#' you want all records in the database.
#'
#' @param ends end year. Don't set the arg if
#' you want all records in the database.
#'
#' @return A dataframe where each row is a NZFFD record.
#'
#' @import httr xml2
#' @importFrom utils read.csv
#' @importFrom curl curl
#'
#' @examples
#' \dontrun{
#' # import entire NZFFD
#' dat <- nzffdr_import()
#' }
#' @export
nzffdr_import <- function(institution = "", catchment_num = "", catchment_name = "",
                         water_body = "", fish_method = "", taxon = "",
                         starts = "", ends = "", download_format = "all") {
  
  message("WARNING: since the 2021 update to the NZFFD, according to the NZFFD help manual (p. 4) users have had difficulty obtaining subsets of records using search terms. It is highly recommended to download the entire database, i.e. leave all search terms blank (
          download_format can be set to either all or essential), the database can then be filtered as required.")  
  
  if (!curl::has_internet()){message("There appears to be no internet connection"); return(NULL)}
  
  # check args are legit
  stopifnot(
    is.character(catchment_num),
    is.character(catchment_name),
    is.character(water_body),
    is.character(fish_method),
    is.character(taxon),
    is.character(download_format)
  )
 
  if (((catchment_num == "") || grepl("^\\d+\\%$", catchment_num) ||
       grepl("^\\d{3}\\.\\d{3}$", catchment_num)) == FALSE) {
    stop("arg: catchment_num must be 6-digit character string (e.g. \"752.638\")
    or numbers followed by % for wildcard searches (e.g.\"752%\"), or left
    blank to seach all (e.g. \"\")", call. = FALSE)
  }
  
  # gather fishing methods
  fishing_method_ls <- get_tbl("[sample_method]")
  
  if (fish_method != "") {
    if (fish_method %in% fishing_method_ls$NAME) {
      fish_method <- fishing_method_ls$VALUE[which(fishing_method_ls == fish_method)]
    } else {
      stop("Unknown fish_method arg - see ?nzffdr_get_table for list of
    acceptable inputs", call. = FALSE)
    }}
    
  # gather institution options
  institute_ls <- get_tbl("[organisation]")

  if (institution != "") {
    if (institution %in% institute_ls$NAME) {
      institution <- institute_ls$VALUE[which(institute_ls == institution)]
  } else {
    stop("Unknown institution arg - see ?nzffdr_get_table for list of
    acceptable inputs", call. = FALSE)
  }}

  # gather species
  taxon_tbl <- get_tbl("[taxon][]")
  taxon_tbl <- fish_tbl(taxon_tbl)
  taxon <- caps(taxon)

  if (any(taxon != "")) {
    if (!all(taxon %in% taxon_tbl$name)) {
      stop("Unknown taxon arg - see ?nzffdr_get_table for list of
    acceptable inputs", call. = FALSE)
    }
    taxon <- sapply(taxon, function(x){
      as.character(taxon_tbl$code[which(taxon_tbl == x)])
    })
  }

  # compile search terms
  names(taxon) <- rep("sample_search[taxon][]", length(taxon))
  taxon <- ifelse(is.na(taxon), "", taxon)
  
  # download format
  if (download_format != "essential") {
    download_format <- "cda"
  } else {
    download_format <- "cde"
  }
  
  # all search terms
  fd <- c(list(
    "sample_search[organisation]" = as.character(institution),
    "sample_search[catchment_no_name]" = as.character(catchment_num),
    "sample_search[catchment_name]" = as.character(catchment_name),
    "sample_search[water_body]" = as.character(water_body),
    "sample_search[sample_method]" = as.character(fish_method),
    "sample_search[start_year]" = as.character(starts),
    "sample_search[end_year]" = as.character(ends),
    "sample_search[download_format]" = as.character(download_format),
    "sample_search[_token]" = as.character(get_tok())
  ), taxon)
  
  message("\n...searching NZFFD, this may take up to 1 minute or so.")
  
  # run search
  r <- httr::POST("https://nzffdms.niwa.co.nz/download",
                  body = fd,
                  encode = "form"
  )

  res <- utils::read.csv(text = httr::content(r, "text", encoding = "UTF-8"))
  
  if (nrow(res) == 0) {
    warning("\ndata.frame of 0 rows returned. Your search was successfully
    submitted but returned no results.")
  }
  return(res)
}

# helper functions ------------------------------------------------------------
# get web html info
get_doc <- function() {
  gr <- httr::GET("https://nzffdms.niwa.co.nz/search")
  xml2::read_html(httr::content(gr, "text"))

}

# get csrf_token
get_tok <- function() {
  xml2::xml_attr(xml2::xml_find_all(
    get_doc(),
    ".//input[@name='sample_search[_token]']"
  ), "value")
}

# get tables
get_tbl <- function(x) {
  do.call(
    rbind,
    lapply(
      xml2::xml_find_all(
        get_doc(),
        paste0(".//select[@name='sample_search", x, "']/option")
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

# clean table
fish_tbl <- function(taxon_tbl) {
  taxon_tbl <- data.frame(
    name = c(
      trimws(gsub(".*\\((.*)\\).*", "\\1", taxon_tbl$NAME)),
      trimws(sub("\\(.*", "", taxon_tbl$NAME))
    ),
    code = rep(taxon_tbl$VALUE, 2)
  )
  taxon_tbl$name <- as.character(taxon_tbl$name)
  taxon_tbl$code <- as.integer(as.character(taxon_tbl$code))
  taxon_tbl <- taxon_tbl[2:nrow(taxon_tbl), ]
  return(taxon_tbl)
}


# capitalise first letter
caps <- function(x) {
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  return(x)
}

