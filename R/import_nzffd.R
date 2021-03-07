#' Import NZ Freshwater Fish datasets.
#'
#' Import data from the NZ Freshwater Fish Database. Enter search terms as 
#' arguments as you would in the NZFFD and import directly into R. You can 
#' search using all the same query options which are
#' used for the \href{https://nzffdms.niwa.co.nz/search}{NZFFFD}, see their
#' \href{https://niwa.co.nz/freshwater-and-estuaries/nzffd/user-guide/tips}{help page} 
#' for details. To import the entire database leave all arguments blank.  
#'
#' This function requires an internet connection to query NIWA's database.
#'
#' Data citation: Crow S (2017). New Zealand Freshwater Fish Database. Version
#' 1.2. The National Institute of Water and Atmospheric Research (NIWA).
#' Occurrence Dataset https://doi.org/10.15468/ms5iqu
#'
#' @param catchment catchment number. a 6 digit number unique to the reach of
#' interest. You can search using the indidviual number (e.g. \code{catchment =
#' "702.500"}), or for all rivers in a catchment you can use the wildcard
#' search term (e.g. \code{catchment = "702\%"}), or don't set the arg if you
#' want all catchments in NZ.
#'
#' @param river river name. e.g. to get all records for the Clutha, \code{river
#' = "Clutha"}.
#'
#' @param location sampling locality. e.g. \code{location = "Awakino"}. This
#' only works when the location is included in the name of the waterway.
#'
#' @param fish_method fishing method used. There are 59 different possible
#' options for \code{fish_method}, if you want to search for a specific fishing
#' method look at the dataset \code{?nzffd_method} to see a list of all possible
#' options, you can then copy/paste from there (e.g. if we only wanted fish
#' caught be lures use \code{fish_meth = "Angling - Lure"}) don't set the arg
#' if you want all fishing methods.
#'
#' @param species species of interest.There are 75 different possible options
#' for species, use \code{?nzffd_species} function to see a list of all
#' possible options. You can search using either common or scientific names
#' and can search for multiple species at once. e.g. to search for Black
#' mudfish use \code{species = "Black mudfish"} or \code{species = "Neochanna
#' diversus"} and to search for Black mudfish and Bluegill bully use \code{
#' species = c("Black mudfish", "Bluegill bully")} etc.
#'
#' @param starts start year, 1850 at the earliest.
#'
#' @param ends end year.
#'
#' @return A dataframe consisting of 22 columns where each row is a record for
#' an individual species. The number of rows will depend on search terms.
#'
#' @import httr xml2
#' @importFrom utils read.csv
#' @importFrom curl curl
#'
#' @examples
#' \dontrun{
#'
#' df <- nzffd_import(nzffdr::nzffd_data)

#' }
#' @export
nzffd_import <- function(catchment = "", river = "", location = "",
                         fish_method = "", species = "", starts = 1850, ends = 2100) {

  if(!curl::has_internet()) print("Internet connection is required, no connection detected")
  
  # check args are legit
  stopifnot(
    is.character(catchment),
    is.character(river),
    is.character(location),
    is.character(fish_method),
    is.character(species),
    is.numeric(starts),
    is.numeric(ends),
    length(catchment) == 1,
    length(river) == 1,
    length(location) == 1,
    length(fish_method) == 1,
    length(starts) == 1,
    length(ends) == 1
  )

  if (starts < 1850 | starts > as.integer(format(Sys.Date(), "%Y"))) {
    stop(paste0("arg starts must be a year between 1850 and ",
      format(Sys.Date(), "%Y")), call. = FALSE)
  }

  if (ends < 1850) {
    stop("arg ends must be greater than 1850", call. = FALSE)
  }
  
  if (((catchment == "") || grepl("^\\d+\\%$", catchment) ||
      grepl("^\\d{3}\\.\\d{3}$", catchment)) == FALSE) {
    stop("arg: catchment must be 6-digit character string (e.g. \"752.638\")
    or numbers followed by % for wildcard searches (e.g.\"752%\"), or left
    blank to seach all (e.g. \"\")", call. = FALSE)
  }

  # gather fishing methods
  fishing_method_ls <- get_tbl("[fishing_method]")

  if (fish_method %in% fishing_method_ls$NAME == TRUE) {
    fishing_method_ls$VALUE[which(fishing_method_ls == fish_method)]
  } else {
    stop("Unknown fish_method arg - see nzffd_method for list of
    acceptable inputs", call. = FALSE)
  }

  # convert fishing method to code - required by NZFFD
  if (fish_method != "") {
    fish_method <- fishing_method_ls$VALUE[which(fishing_method_ls == fish_method)]
  }

  # gather species
  species_tbl <- get_tbl("[species][]")
  species_tbl <- fish_tbl(species_tbl)
  species <- caps(species)

  if (all(species %in% species_tbl$name) == FALSE) {
    stop("Unknown species arg - see ?nzffdr_species for list of
    acceptable inputs", call. = FALSE)
  }

  species <- sapply(species, function(x){
    species_tbl$code[which(species_tbl == x)]
  })

  # compile search terms
  names(species) <- rep("search[species][]", length(species))
  species <- ifelse(is.na(species), "", species)

  # for species, need to add a new list element for each search term.
  fd <- c(list(
    "search[catchment_no_name]" = as.character(catchment),
    "search[river_lake]" = as.character(river),
    "search[sampling_locality]" = as.character(location),
    "search[fishing_method]" = as.character(fish_method),
    "search[start_year]" = as.character(starts),
    "search[end_year]" = as.character(ends),
    "search[download_format]" = "1",
    "search[_csrf_token]" = get_tok()
  ), species)

  # run search
  r <- httr::POST("https://nzffdms.niwa.co.nz/doSearch",
    body = fd,
    encode = "form"
  )

  res <- utils::read.csv(text = httr::content(r, "text", encoding = "UTF-8"))

  if (nrow(res) == 0) {
    warning("data.frame of 0 rows returned. Your search was successfully
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
    ".//input[@name='search[_csrf_token]']"
  ), "value")
}

# get tables
get_tbl <- function(x) {
  do.call(
    rbind,
    lapply(
      xml2::xml_find_all(
        get_doc(),
        paste0(".//select[@name='search", x, "']/option")
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
fish_tbl <- function(species_tbl) {
  species_tbl <- data.frame(
    name = c(
      trimws(gsub(".*\\((.*)\\).*", "\\1", species_tbl$NAME)),
      trimws(sub("\\(.*", "", species_tbl$NAME))
    ),
    code = rep(species_tbl$VALUE, 2)
  )
  species_tbl$name <- as.character(species_tbl$name)
  species_tbl$code <- as.integer(as.character(species_tbl$code))
  species_tbl <- species_tbl[2:nrow(species_tbl), ]
  return(species_tbl)
}

# capitalise first letter
caps <- function(x) {
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  return(x)
}

