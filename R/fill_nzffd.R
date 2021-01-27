#' Add additional data to the NZFFD
#'
#' Adds columns for family, genus, species and common names, the species threat
#' classification status, whether the species is native or exotic. 
#' Also add missing values for the \code{map} and \code{alt} variables.
#'
#' Altitude data is added by taking the site coordinates and pulling the relevant
#' data from an 8m \href{https://data.linz.govt.nz/layer/51768-nz-8m-digital-elevation-model-2012/}{DEM}. Note data taken from the DEM is suitable for cartographic visualisation only.
#'
#' If \code{alt = TRUE} this function requires an internet connection to query
#' the 8m DEM.
#'
#' @param fishd A dataframe imported from the NZFFD using \code{import_nzffd}.
#'
#' @param maps Should missing map tiles be added to the dataframe.
#'
#' @param alt Should missing elevation data be added to the dataframe.
#'
#' @return A dataframe with the same number of rows as \code{fishd} but with
#' seven additional columns added (\code{common_name, sci_name, family, genus, species, threat_class, native}).
#'
#' @import httr jsonlite
#' @examples
#' \dontrun{
#'
#' df <- fill_nzffd(nzffdr::nzffd_data)
#' head(df)
#' }
#' @export
fill_nzffd <- function(fishd, alt = TRUE, maps = TRUE) {

  if (is.data.frame(fishd) == FALSE) {
    stop("arg fishd must be a data.frame")
  }
  if("spcode" %in% colnames(fishd) == FALSE) {
    stop("dataframe must include \"spcode\" column")
  }

  # add common, sci, fam names and threat status
  fishd <- merge(fishd, sp_codes, by = "spcode")

  
  
  if (alt == TRUE) {

    if("altitude" %in% colnames(fishd) == FALSE) {
      stop("dataframe must include \"altitude\" column")
    }

    # add missing altitude data
    alts <- subset(fishd, is.na(fishd$altitude))

    if (nrow(alts) > 0) {
      points <- data.frame(card = alts$card, north = alts$north, east = alts$east)
      points <- as.matrix(unique(points), ncol = 3, byrow = T)

      resp <- httr::POST("http://elevation.auckland-cer.cloud.edu.au",
        body = list(
          points = jsonlite::toJSON(points[, 2:3]),
          proj = "EPSG:27200"
        ),
        encode = "form"
      )

      alts2 <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"))
      alts2 <- data.frame(points, altitude = (round(alts2$results)))

      fishd$altitude <- ifelse(is.na(fishd$altitude) == TRUE,
        alts2$altitude[alts2$card %in% fishd$card], fishd$altitude
      )
    }
  }

  # add missing maptile data
  if (maps == TRUE) {

    if("map" %in% colnames(fishd) == FALSE) {
      stop("dataframe must include \"map\" column")
    }

    fishd$map <- ifelse(is.na(fishd$map) == TRUE,
      MapTilesNZMS260$map[MapTilesNZMS260$card %in% fishd$card], fishd$map
    )
  }

  return(fishd)
}
