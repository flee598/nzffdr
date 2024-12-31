
# nzffdr <img src='man/figures/nzffdr_hex.svg' align="right" height="150" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/nzffdr)](https://CRAN.R-project.org/package=nzffdr)
[![R-CMD-check](https://github.com/flee598/nzffdr/workflows/R-CMD-check/badge.svg)](https://github.com/flee598/nzffdr/actions)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/grand-total/nzffdr)](https://r-pkg.org/pkg/nzffdr)
[![R-CMD-check](https://github.com/flee598/nzffdr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/flee598/nzffdr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

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

``` r
install.packages("nzffdr")
```

### Development version

To install the latest development version install from GitHub.

``` r
devtools::install_github("flee598/nzffdr")
```

### Import data from the NZFFD

This function requires an internet connection to query the NZFFD
database.

``` r
# import all records 
library(nzffdr)

dat <- nzffdr_import(download_format = "essential")
head(dat)
#>   nzffdRecordNumber  eventDate eventTime institution       waterBody
#> 1                 1 1979-06-05     10:30        NIWA Limestone Creek
#> 2                 1 1979-06-05     10:30        NIWA Limestone Creek
#> 3                 1 1979-06-05     10:30        NIWA Limestone Creek
#> 4                 1 1979-06-05     10:30        NIWA Limestone Creek
#> 5                 1 1979-06-05     10:30        NIWA Limestone Creek
#> 6                 1 1979-06-05     10:30        NIWA Limestone Creek
#>   waterBodyType site catchmentNumber catchmentName eastingNZTM northingNZTM
#> 1   Not Entered              691.021       Hinds R     1463229      5157184
#> 2   Not Entered              691.021       Hinds R     1463229      5157184
#> 3   Not Entered              691.021       Hinds R     1463229      5157184
#> 4   Not Entered              691.021       Hinds R     1463229      5157184
#> 5   Not Entered              691.021       Hinds R     1463229      5157184
#> 6   Not Entered              691.021       Hinds R     1463229      5157184
#>   recSegment minimumElevation distanceOcean createdAt acceptedAt
#> 1   13137531              480            60        NA         NA
#> 2   13137531              480            60        NA         NA
#> 3   13137531              480            60        NA         NA
#> 4   13137531              480            60        NA         NA
#> 5   13137531              480            60        NA         NA
#> 6   13137531              480            60        NA         NA
#>                    samplingMethod samplingProtocol                   taxonName
#> 1 Electric fishing - Type unknown          Unknown      Gobiomorphus breviceps
#> 2 Electric fishing - Type unknown          Unknown       Salvelinus fontinalis
#> 3 Electric fishing - Type unknown          Unknown        Galaxias brevipinnis
#> 4 Electric fishing - Type unknown          Unknown Scardinius erythrophthalmus
#> 5 Electric fishing - Type unknown          Unknown          Galaxias maculatus
#> 6 Electric fishing - Type unknown          Unknown                    Anguilla
#>    taxonCommonName totalCount notCountedButPresent notDetectedButSoughtAtSite
#> 1     Upland bully         NA                 true                      false
#> 2       Brook char         NA                 true                      false
#> 3            Koaro         NA                 true                      false
#> 4             Rudd         NA                 true                      false
#> 5           Inanga         NA                 true                      false
#> 6 Unidentified eel         NA                 true                      false
#>   minLength maxLength dataVersion
#> 1        NA        NA          V1
#> 2        NA        NA          V1
#> 3        NA        NA          V1
#> 4        NA        NA          V1
#> 5        NA        NA          V1
#> 6        NA        NA          V1
```

``` r

# To import the entire NZFF Database:
# dat <- nzffd_import()
```
