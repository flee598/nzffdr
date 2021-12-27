#' Wrapper for multiple nzffdr functions
#'
#'Wraps multiple nzffdr functions allowing, importing, cleaning and adding
#'of new information all in one step.
#'
#' Wraps: [nzffdr_import()], [nzffdr_clean()], [nzffdr_add_date()],
#' [nzffdr_taxon_threat()], [nzffdr_widen_habitat()] and runs the lot
#' in one go, returning a downloaded and cleaned NZFFD dataset.
#'
#' This function requires an internet connection to query the NZFFD
#'
#' @return An NZFFD dataframe which has been cleaned and had date, taxonomic and 
#' threat classification status data added. 
#' 
#' @examples
#' \dontrun{
#' dat <- nzffdr_razzle_dazzle()
#' }
#' @export
nzffdr_razzle_dazzle <- function(){
  dat <- nzffdr::nzffdr_import()
  dat <- nzffdr::nzffdr_clean(dat)
  dat <- nzffdr::nzffdr_add_dates(dat)
  dat <- nzffdr::nzffdr_taxon_threat(dat)
  dat <- nzffdr::nzffdr_widen_habitat(dat)
  return(dat)
}