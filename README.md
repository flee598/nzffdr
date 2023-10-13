
# nzffdr <img src='man/figures/nzffdr_hex.svg' align="right" height="150" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/nzffdr)](https://CRAN.R-project.org/package=nzffdr)
[![R-CMD-check](https://github.com/flee598/nzffdr/workflows/R-CMD-check/badge.svg)](https://github.com/flee598/nzffdr/actions)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/grand-total/nzffdr)](https://r-pkg.org/pkg/nzffdr)
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
#>   minimumElevation distanceOcean                  samplingMethod
#> 1              480            60 Electric fishing - Type unknown
#> 2              480            60 Electric fishing - Type unknown
#> 3              480            60 Electric fishing - Type unknown
#> 4              480            60 Electric fishing - Type unknown
#> 5              480            60 Electric fishing - Type unknown
#> 6              480            60 Electric fishing - Type unknown
#>   samplingProtocol                   taxonName     taxonCommonName totalCount
#> 1          Unknown          Galaxias maculatus              Inanga         NA
#> 2          Unknown           Carassius auratus            Goldfish         NA
#> 3          Unknown           Galaxias vulgaris Canterbury galaxias         NA
#> 4          Unknown      Gobiomorphus breviceps        Upland bully         NA
#> 5          Unknown       Salvelinus fontinalis          Brook char         NA
#> 6          Unknown Scardinius erythrophthalmus                Rudd         NA
#>   notCountedButPresent notDetectedButSoughtAtSite minLength maxLength
#> 1                 true                      false        NA        NA
#> 2                 true                      false        NA        NA
#> 3                 true                      false        NA        NA
#> 4                 true                      false        NA        NA
#> 5                 true                      false        NA        NA
#> 6                 true                      false        NA        NA
#>   dataVersion
#> 1          V1
#> 2          V1
#> 3          V1
#> 4          V1
#> 5          V1
#> 6          V1

# To import the entire NZFF Database:
# dat <- nzffd_import()
```
