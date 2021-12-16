#' Add taxonomic and threat status data
#'
#' Adds additional common and scientific names, and threat classification status
#' information.
#'
#' Adds additional taxonomic data ("commonMaoriName", "alternativeNames",
#' "species", "genus", "family", "order", "class", "phylum") and NZ Threat 
#' Classification Status information ("category", "status", "taxonomicStatus",
#' "bioStatus"). See \href{https://nztcs.org.nz/home}{NZTCS} for details
#' regarding the NZTCS variables. 
#' 
#' @param fishd A dataframe imported from the NZFFD using \code{nzffd_import}
#'
#' @return An NZFFD dataframe, with 12 additional columns.
#'
#' @examples
#' nzffdr_taxon_threat(nzffdr::nzffdr_data)
#' @export
nzffdr_taxon_threat <- function(fishd){
  
  if (is.data.frame(fishd) == FALSE) {
    stop("arg fishd must be a data.frame")
  }
  if("taxonName" %in% colnames(fishd) == FALSE) {
    stop("dataframe must include the \"taxonName\" column")
  }
  
  fishd <- merge(fishd, threat_status_names,
                  by = "taxonName", all.x = TRUE)
  
  return(fishd)
}