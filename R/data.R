#' nzffd_data
#'
#' A random sample of 200 rows of the NZFFD.
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
#' @source \url{www.niwa.co.nz}
"nzffd_data"


#' method_nzffd
#'
#' A dataframe listing the possible inputs for the fish_method argument
#' of the import_nzffd function.
#'
#' @docType data
#'
#' @usage method_nzffd
#'
#' @format A dataframe of 59 rows and one variable:
#' \describe{
#'   \item{method}{fishing method used}
#' }
"method_nzffd"


#' species_nzffd
#'
#' A dataframe listing the possible inputs for the species argument
#' of the import_nzffd function. Either the scientific or common name can
#' be used.
#'
#' @docType data
#'
#' @usage species_nzffd
#'
#' @format A dataframe of 75 rows and two variables:
#' \describe{
#'   \item{sci}{Genus and species}
#'   \item{common}{common name}
#'   ...
#' }
"species_nzffd"

