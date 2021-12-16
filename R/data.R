#' Sample dataframe of 200 rows of the NZFFD.
#'
#' @docType data
#'
#' @usage data(nzffdr_data)
#'
#' @format A dataframe of 200 rows and 67 variables:
#' 
#' @source \href{https://niwa.co.nz}{NIWA}
"nzffdr_data"


#' Simple features map of New Zealand
#'
#' A simple features map of New Zealand. A simplified version of the 1:150k
#' NZ map outline available from Land Information New Zealand.
#' CRS: NZ Transverse Mercator (NZTM: EPSG 2193) 
#' The map contains polygons for the three main island plus the Chatham Islands.  
#' 
#' @source \url{https://data.linz.govt.nz}
#'
#' @docType data
#'
#' @usage nzffdr_nzmap
#'
#' @format A simple features dataframe with 4 rows and 2 columns:
#' \describe{
#'   \item{island}{Island name}
#'   \item{geometry}{Line geometry}
#' }
"nzffdr_nzmap"