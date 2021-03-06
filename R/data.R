#' Sample dataframe of 200 rows of the NZFFD.
#'
#' @docType data
#'
#' @usage data(nzffd_data)
#'
#' @format A dataframe of 141708 rows and 22 variables:
#' \describe{
#'   \item{card}{NZFFD card id}
#'   \item{m}{month sampling occured}
#'   \item{y}{year sampling occured}
#'   \item{catchname}{catchment name}
#'   \item{catch}{catchment number}
#'   \item{locality}{sampling locality}
#'   \item{time}{time sampling occured}
#'   \item{org}{3 letter code identifying the organisation that carried out
#'              the sampling see vignette for code descriptions}
#'   \item{map}{NZMS260 map tile code}
#'   \item{east}{easting, in NZMG}
#'   \item{north}{northing, in NZMG}
#'   \item{altitude}{sample site altitude, in meters above sea level}
#'   \item{penet}{ distance to sea along the network, in meters}
#' }
#' @source \href{www.niwa.co.nz}{NIWA}
"nzffd_data"

#' Dataframe listing all fishing methods used in the NZFFD
#' 
#' Dataframe listing the possible inputs for the fish_method argument
#' of the nzffd_import function.
#'
#' @docType data
#'
#' @usage nzffd_method
#'
#' @format A dataframe of 59 rows and one variable:
#' \describe{
#'   \item{method}{fishing method used}
#' }
"nzffd_method"


#' Dataframe listing all species in the NZFFD
#'
#' A dataframe listing the possible inputs for the species argument
#' of the nzffd_import function. Either the scientific or common name can
#' be used.
#'
#' @docType data
#'
#' @usage nzffd_species
#'
#' @format A dataframe of 75 rows and two variables:
#' \describe{
#'   \item{sci}{Genus and species}
#'   \item{common}{common name}
#' }
"nzffd_species"

#' Simple features map of New Zealand
#'
#' A simple features map of New Zealand. A simplified version of the 1:150k
#' NZ map outline available from Land Information New Zealand.
#' CRS: New Zealand Map Grid, EPSG:27200 (matching NZFFD observations). 
#' The map contains polygons for the three main island plus the Chatham Islands.  
#' 
#' @source \url{https://data.linz.govt.nz}
#'
#' @docType data
#'
#' @usage nzffd_nzmap
#'
#' @format A simple features dataframe with 4 rows and 3 columns:
#' \describe{
#'   \item{name}{Island name}
#'   \item{name_ascii}{Island name ascii characters}
#'   \item{geometry}{Line geometry}
#' }
"nzffd_nzmap"