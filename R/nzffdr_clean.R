#' Clean NZ Freshwater Fish fishdasets
#'
#' Clean up data imported from the NZ Freshwater Fish Database.
#'
#' Cleans up a few inconsistencies in the NZFFD data returned from
#'  \code{nzffd_import}. Column types are checked and converted to, integer,
#'  numeric or character. Empty cells are filled with NA, variable catchmentName
#'  entries are standardised (e.g. Clutha r, Clutha River and Clutha R all
#'  become Clutha R) and, any empty columns are removed.
#' 
#' @param fishd A dataframe imported from the NZFFD using \code{nzffdr_import}
#'
#' @return A cleaned NZFFD dataframe.
#'
#' @importFrom stringi stri_replace_all_regex 
#' @importFrom stringi stri_join
#' @importFrom utils stack
#' 
#' @examples
#' nzffdr_clean(nzffdr::nzffdr_data)
#' 
#' @export
nzffdr_clean <- function(fishd) {
  
  if (!is.data.frame(fishd)) {
    stop("arg fishd must be a data.frame returned from a call to nzffd_import()")
  }
  
  # covert column types
  fishd <- cols_num(fishd)
  fishd <- cols_chr(fishd)
  
  # fill empty cells with NA
  fishd[fishd == ""] <- NA
  
  # tidy up catchment name inconsistencies e.g. R, r and River all -> R
  repl2 <- stack(repl)
  
  fishd$catchmentName <- 
    stringi::stri_replace_all_regex(fishd$catchmentName,
                                    stringi::stri_join("\\b",
                                                       repl2$values,
                                                       "\\b",
                                                       sep=''),
                                    repl2$ind,
                                    vectorize_all = FALSE)
  
  # drop empty columns
  fishd <- Filter(function(x)!all(is.na(x)), fishd)
  
  return(fishd)
}

# helper functions ------------------------------------------------------------
# cols to character
cols_chr <- function(x) {
  cols2 <- c("institutionRecordNumber", "eventDate", "eventTime", "institution", 
             "samplingPurpose", "waterBody", "waterBodyType", "waterPermanence", 
             "site", "catchmentNumber", "catchmentName", "siteTidal",
             "siteLandlocked", "downstreamBarrier", "eventLocationRemarks",
             "waterLevel", "waterColour", "waterClarity", "clarityMethod",
             "habitatFlowPercent", "habitatSubstratePercent",
             "habitatInstreamCoverPresent", "habitatRiparianVegPercent",
             "samplingMethod", "samplingProtocol", "EfmAnodeSize",
             "NetsTrapsBaited", "NetsTrapsMeshSize", "NetsTrapsDayNight",
             "NetsTrapsAverageSetTime", "taxonName", "taxonCommonName",
             "taxonRemarks", "present", "soughtNotDetected",
             "occurrenceRemarks", "indLengths", "dataVersion")
  
  cols2 <- intersect(cols2, colnames(x))
  
  x[cols2] <- lapply(x[cols2], function(x) {
    suppressWarnings(as.character(x))
  })
  return(x)
}

# cols to numeric

cols_num <- function(x) {
  cols2 <- c("nzffdRecordNumber", "eastingNZTM", "northingNZTM", "decimalLongitude", 
             "decimalLatitude", "recSegment", "minimumElevation", "distanceOcean", 
             "siteReachLength", "siteAverageWidth", "minimumSampledDepth",
             "maximumSampledDepth", "waterTemperature", "waterConductivity",
             "waterDissolvedOxygenPercent", "waterDissolvedOxygenPPM", 
             "waterPH", "waterSalinity", "EfmNumberOfPasses",  "EfmPulseRate",  
             "EfmVoltage", "EfmPulseRateWidth", "EfmMinutes", "EfmArea",
             "NetsTrapsTotalNumber", "ObservationArea", "totalCount",
             "minLength", "maxLength")
  
  cols2 <- intersect(cols2, colnames(x))
  
  x[cols2] <- lapply(x[cols2], function(x) {
    suppressWarnings(as.numeric(x))
  })
  return(x)
  
}
