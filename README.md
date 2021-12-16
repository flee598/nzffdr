
# nzffdr <img src='man/figures/nzffdr_hex.svg' align="right" height="150" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/flee598/nzffdr/workflows/R-CMD-check/badge.svg)](https://github.com/flee598/nzffdr/actions)
<!-- badges: end -->

## Major update December 2021

Following a significant update to the NZFFD, the nzffdr package has been
completely overhauled. The NZFFD update resulted in nzffdr v 1.0.0
functions either i) not working or, ii) being redundant. Therefore I
have completely rewritten nzffdr. This does mean there is **NO**
backwards compatibility, and any previous code that used nzffdr
functions will no longer work. I am sorry for this, but it was
unavoidable.

On the up side, the NZFFD now contains lots of useful additional
information by default, and the new and improved nzffdr has added
functionality.

## Package overview

The purpose of this package is to allow for direct access to the NZ
Freshwater Fish Database ([NZFFD](https://nzffdms.niwa.co.nz/search))
from R and additional functions for cleaning imported data and adding
missing data.

For a detailed guide to using the package see the [help
page](https://flee598.github.io/nzffdr/).

A preprint describing the package is now available (if you wish to cite
the package please use this):

Lee, F., & Young, N. (2021). nzffdr: an R package to import, clean and
update data from the New Zealand Freshwater Fish Database. bioRxiv.
<https://doi.org/10.1101/2021.06.22.449519>

### Installation

For now, the only functioning version of nzffdr is here on GitHub, I aim
to get nzffdr v 2.0.0 on CRAN in early 2022.

### Development version

To install the latest development version install from GitHub.

``` r
devtools::install_github("flee598/nzffdr")
```

### Import data from the NZFFD

This function requires an internet connection to query the NZFFD
database.

``` r
# import all records between 2010 and 2015
library(nzffdr)

dat <- nzffdr_import(institution = "", catchment_num = "", catchment_name = "",
                    water_body = "", fish_method = "", taxon = "", 
                    starts = 2010, ends = 2015, download_format = "all")
head(dat)
#>   nzffdRecordNumber institutionRecordNumber  eventDate eventTime
#> 1             12132                         2011-01-18       day
#> 2             12132                         2011-01-18       day
#> 3             12132                         2011-01-18       day
#> 4             12132                         2011-01-18       day
#> 5             12132                         2011-01-18       day
#> 6             12132                         2011-01-18       day
#>                             institution samplingPurpose
#> 1 Department of Conservation Canterbury                
#> 2 Department of Conservation Canterbury                
#> 3 Department of Conservation Canterbury                
#> 4 Department of Conservation Canterbury                
#> 5 Department of Conservation Canterbury                
#> 6 Department of Conservation Canterbury                
#>                     waterBody waterBodyType waterPermanence site
#> 1 Otukaikino Stream tributary   Not Entered       Perennial   NA
#> 2 Otukaikino Stream tributary   Not Entered       Perennial   NA
#> 3 Otukaikino Stream tributary   Not Entered       Perennial   NA
#> 4 Otukaikino Stream tributary   Not Entered       Perennial   NA
#> 5 Otukaikino Stream tributary   Not Entered       Perennial   NA
#> 6 Otukaikino Stream tributary   Not Entered       Perennial   NA
#>   catchmentNumber catchmentName eastingNZTM northingNZTM decimalLongitude
#> 1             664 Waimakariri R     1569366      5189668        -43.44526
#> 2             664 Waimakariri R     1569366      5189668        -43.44526
#> 3             664 Waimakariri R     1569366      5189668        -43.44526
#> 4             664 Waimakariri R     1569366      5189668        -43.44526
#> 5             664 Waimakariri R     1569366      5189668        -43.44526
#> 6             664 Waimakariri R     1569366      5189668        -43.44526
#>   decimalLatitude recSegment minimumElevation distanceOcean siteTidal
#> 1        172.6214   13121594               10          10.9         n
#> 2        172.6214   13121594               10          10.9         n
#> 3        172.6214   13121594               10          10.9         n
#> 4        172.6214   13121594               10          10.9         n
#> 5        172.6214   13121594               10          10.9         n
#> 6        172.6214   13121594               10          10.9         n
#>   siteLandlocked downstreamBarrier eventLocationRemarks siteReachLength
#> 1              u                 n                                   NA
#> 2              u                 n                                   NA
#> 3              u                 n                                   NA
#> 4              u                 n                                   NA
#> 5              u                 n                                   NA
#> 6              u                 n                                   NA
#>   siteAverageWidth minimumSampledDepth maximumSampledDepth waterLevel
#> 1                1                  NA                 0.6    Unknown
#> 2                1                  NA                 0.6    Unknown
#> 3                1                  NA                 0.6    Unknown
#> 4                1                  NA                 0.6    Unknown
#> 5                1                  NA                 0.6    Unknown
#> 6                1                  NA                 0.6    Unknown
#>   waterColour waterClarity clarityMethod waterTemperature waterConductivity
#> 1  Colourless           NA            NA               16                NA
#> 2  Colourless           NA            NA               16                NA
#> 3  Colourless           NA            NA               16                NA
#> 4  Colourless           NA            NA               16                NA
#> 5  Colourless           NA            NA               16                NA
#> 6  Colourless           NA            NA               16                NA
#>   waterDissolvedOxygenPercent waterDissolvedOxygenPPM waterPH waterSalinity
#> 1                          NA                      NA      NA            NA
#> 2                          NA                      NA      NA            NA
#> 3                          NA                      NA      NA            NA
#> 4                          NA                      NA      NA            NA
#> 5                          NA                      NA      NA            NA
#> 6                          NA                      NA      NA            NA
#>                                                                  habitatFlowPercent
#> 1 Coarse gravel:10, Mud:50, Sand (1-2 mm):25, Cobbles (64-257 mm):5, Fine gravel:10
#> 2 Coarse gravel:10, Mud:50, Sand (1-2 mm):25, Cobbles (64-257 mm):5, Fine gravel:10
#> 3 Coarse gravel:10, Mud:50, Sand (1-2 mm):25, Cobbles (64-257 mm):5, Fine gravel:10
#> 4 Coarse gravel:10, Mud:50, Sand (1-2 mm):25, Cobbles (64-257 mm):5, Fine gravel:10
#> 5 Coarse gravel:10, Mud:50, Sand (1-2 mm):25, Cobbles (64-257 mm):5, Fine gravel:10
#> 6 Coarse gravel:10, Mud:50, Sand (1-2 mm):25, Cobbles (64-257 mm):5, Fine gravel:10
#>                                                            habitatSubstratePercent
#> 1 Undercut banks:y, Macrophytes-algae:y, Wood/instream debris:y, Bank vegetation:y
#> 2 Undercut banks:y, Macrophytes-algae:y, Wood/instream debris:y, Bank vegetation:y
#> 3 Undercut banks:y, Macrophytes-algae:y, Wood/instream debris:y, Bank vegetation:y
#> 4 Undercut banks:y, Macrophytes-algae:y, Wood/instream debris:y, Bank vegetation:y
#> 5 Undercut banks:y, Macrophytes-algae:y, Wood/instream debris:y, Bank vegetation:y
#> 6 Undercut banks:y, Macrophytes-algae:y, Wood/instream debris:y, Bank vegetation:y
#>   habitatInstreamCoverPresent                 habitatRiparianVegPercent
#> 1              Run:95, Pool:5 Scrub:10, Grass/tussock:60, Raupo/flax:30
#> 2              Run:95, Pool:5 Scrub:10, Grass/tussock:60, Raupo/flax:30
#> 3              Run:95, Pool:5 Scrub:10, Grass/tussock:60, Raupo/flax:30
#> 4              Run:95, Pool:5 Scrub:10, Grass/tussock:60, Raupo/flax:30
#> 5              Run:95, Pool:5 Scrub:10, Grass/tussock:60, Raupo/flax:30
#> 6              Run:95, Pool:5 Scrub:10, Grass/tussock:60, Raupo/flax:30
#>                              samplingMethod samplingProtocol EfmNumberOfPasses
#> 1 Other net - combination of nets and traps          Unknown                NA
#> 2 Other net - combination of nets and traps          Unknown                NA
#> 3 Other net - combination of nets and traps          Unknown                NA
#> 4 Other net - combination of nets and traps          Unknown                NA
#> 5 Other net - combination of nets and traps          Unknown                NA
#> 6 Other net - combination of nets and traps          Unknown                NA
#>   EfmVoltage EfmPulseRate EfmPulseRateWidth EfmAnodeSize EfmMinutes EfmArea
#> 1         NA           NA                NA                      NA      NA
#> 2         NA           NA                NA                      NA      NA
#> 3         NA           NA                NA                      NA      NA
#> 4         NA           NA                NA                      NA      NA
#> 5         NA           NA                NA                      NA      NA
#> 6         NA           NA                NA                      NA      NA
#>   NetsTrapsTotalNumber NetsTrapsBaited NetsTrapsMeshSize NetsTrapsDayNight
#> 1                   17              NA                NA                NA
#> 2                   17              NA                NA                NA
#> 3                   17              NA                NA                NA
#> 4                   17              NA                NA                NA
#> 5                   17              NA                NA                NA
#> 6                   17              NA                NA                NA
#>   NetsTrapsAverageSetTime ObservationArea               taxonName
#> 1                      NA              NA  Gobiomorphus gobioides
#> 2                      NA              NA  Gobiomorphus breviceps
#> 3                      NA              NA      Galaxias maculatus
#> 4                      NA              NA      Anguilla australis
#> 5                      NA              NA Gobiomorphus cotidianus
#> 6                      NA              NA  Anguilla dieffenbachii
#>   taxonCommonName taxonRemarks totalCount present soughtNotDetected
#> 1     Giant bully                       1   false             false
#> 2    Upland bully                       1   false             false
#> 3          Inanga                       1   false             false
#> 4    Shortfin eel                      50   false             false
#> 5    Common bully                      20   false             false
#> 6     Longfin eel                      18   false             false
#>   occurrenceRemarks minLength maxLength indLengths dataVersion
#> 1                NA       125        NA                     V1
#> 2                NA        56        NA                     V1
#> 3                NA       150        NA                     V1
#> 4                NA       250       900                     V1
#> 5                NA        40       110                     V1
#> 6                NA       400      1100                     V1

# To import the entire NZFF Database:
# dat <- nzffd_import()
```
