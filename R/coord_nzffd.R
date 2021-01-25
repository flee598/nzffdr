#' NZMG coordinate conversion
#'
#' update New Zealand Map Grid coordinates (the default in the freshwater fish 
#' database) to another projection. 
#'
#'
#' This function is a wrapper for a series of functions from the 
#' sp package.
#'
#' REC citation:
#'
#' @param east A vector of New Zealand Map Grid eastings
#' @param north A vector of New Zealand Map Grid northings
#' @inheritParams sp::projargs
#'
#' @return a dataframe of two columns, the new eastings and northings#'
#' @import sp rgdal
#'
#' @examples
#' \dontrun{
#'
#' df <- coords_nzffd(east = nzffdr::nzffd_data$east, 
#'                    north = nzffdr::nzffd_data$north)
#' head(df)
#' }
#' @export
coord_nzffd <- function(east, north, projargs = "+init=epsg:4326") {
  
  stopifnot(
  is.numeric(east),
  is.numeric(north)
  )

  coords <- data.frame(east, north)
  
  proj4string <- "+proj=nzmg +lat_0=-41 +lon_0=173 +x_0=2510000 +y_0=6023150 
  +ellps=intl +datum=nzgd49 +units=m +towgs84=59.47,-5.04,187.44,0.47,-0.1,1.024,-4.5993 
  +nadgrids=nzgd2kgrid0005.gsb +no_defs"
  
  sp::coordinates(coords) <- ~ east + north
  sp::proj4string(coords) <- sp::CRS(proj4string) 
  coords <- sp::spTransform(coords, sp::CRS(projargs)) 
  as.data.frame(coords)
}


