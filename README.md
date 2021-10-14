
# nzffdr <img src='man/figures/nzffdr_hex.svg' align="right" height="150" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/flee598/nzffdr/workflows/R-CMD-check/badge.svg)](https://github.com/flee598/nzffdr/actions)
<!-- badges: end -->


# warning 
The NZFFD is currently undergoing maintenance and not available at the moment. Therefore the nzffdr R package function nzffd_import() is not working. I will look to get it back up and runnin as soon as NIWA has the NZFFD up and running again. 

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

To install the latest development version install from GitHub, warning
there may be bugs!

``` r
devtools::install_github("flee598/nzffdr")
```

### Import data from the NZFFD

This function requires an internet connection to query the NZFFD
database.

``` r
# import all records between 2010 and 2015
library(nzffdr)

dat <- nzffd_import(catchment = "", river = "", location = "", 
  fish_method = "", species = "", starts = 2010, ends = 2015)
head(dat)
#>    card  m    y     catchname catch                    locality time  org map
#> 1 10142 12 2010     Waikato R   434               Waikato River      niwa R13
#> 2 10142 12 2010     Waikato R   434               Waikato River      niwa R13
#> 3 12132  1 2011 Waimakariri R   664 Otukaikino Stream tributary  day docc M35
#> 4 12132  1 2011 Waimakariri R   664 Otukaikino Stream tributary  day docc M35
#> 5 12132  1 2011 Waimakariri R   664 Otukaikino Stream tributary  day docc M35
#> 6 12132  1 2011 Waimakariri R   664 Otukaikino Stream tributary  day docc M35
#>      east   north altitude penet fishmeth effort pass spcode abund number minl
#> 1 2691748 6427557       15    49              NA   NA anguil            3   NA
#> 2 2691748 6427557       15    49              NA   NA chefos            1   NA
#> 3 2479366 5751283       10    11      ntc     17   NA angdie           18  400
#> 4 2479366 5751283       10    11      ntc     17   NA angaus           50  250
#> 5 2479366 5751283       10    11      ntc     17   NA gobcot           20   40
#> 6 2479366 5751283       10    11      ntc     17   NA gobbre            1   56
#>   maxl  nzreach
#> 1   NA  3008300
#> 2   NA  3008300
#> 3 1100 13043121
#> 4  900 13043121
#> 5  110 13043121
#> 6   NA 13043121

# To import the entire NZFF database:
# dat <- nzffd_import()
```

### Cleaning data

``` r
dat2 <- nzffd_clean(dat)
head(dat2)
#>    card  m    y     catchname catch                    locality time  org map
#> 1 10142 12 2010     Waikato R   434               Waikato River   NA niwa r13
#> 2 10142 12 2010     Waikato R   434               Waikato River   NA niwa r13
#> 3 12132  1 2011 Waimakariri R   664 Otukaikino Stream Tributary   NA docc m35
#> 4 12132  1 2011 Waimakariri R   664 Otukaikino Stream Tributary   NA docc m35
#> 5 12132  1 2011 Waimakariri R   664 Otukaikino Stream Tributary   NA docc m35
#> 6 12132  1 2011 Waimakariri R   664 Otukaikino Stream Tributary   NA docc m35
#>      east   north altitude penet fishmeth effort pass spcode abund number minl
#> 1 2691748 6427557       15    49     <NA>     NA   NA anguil  <NA>      3   NA
#> 2 2691748 6427557       15    49     <NA>     NA   NA chefos  <NA>      1   NA
#> 3 2479366 5751283       10    11      ntc     17   NA angdie  <NA>     18  400
#> 4 2479366 5751283       10    11      ntc     17   NA angaus  <NA>     50  250
#> 5 2479366 5751283       10    11      ntc     17   NA gobcot  <NA>     20   40
#> 6 2479366 5751283       10    11      ntc     17   NA gobbre  <NA>      1   56
#>   maxl  nzreach      form
#> 1   NA  3008300     River
#> 2   NA  3008300     River
#> 3 1100 13043121 Tributary
#> 4  900 13043121 Tributary
#> 5  110 13043121 Tributary
#> 6   NA 13043121 Tributary
```

### Filling gaps and adding species information

``` r
dat3 <- nzffd_fill(dat2, alt = TRUE, maps = TRUE)
head(dat3)
#>   spcode   card  m    y  catchname   catch       locality     time  org map
#> 1 aldfor 104726  5 2015    Taipo S 229.000   Taipo Stream 09:50:00 hbrc v21
#> 2 aldfor  33325  4 2013 Tukituki R 232.000 Tukituki River     <NA> hbrc v21
#> 3 aldfor 111397  8 2012  Waikato R 434.190     Lake Waahi     <NA>  uow S18
#> 4 aldfor 104726  5 2015    Taipo S 229.000   Taipo Stream 09:50:00 hbrc v21
#> 5 aldfor  33321 10 2012    Clive R 231.501    Muddy Creek 23:00:00 hbrc v21
#> 6 aldfor 104726  5 2015    Taipo S 229.000   Taipo Stream 09:50:00 hbrc v21
#>      east   north altitude penet fishmeth effort pass abund number minl maxl
#> 1 2840995 6182554       16     4      fys     NA   NA  <NA>      3   NA   NA
#> 2 2848760 6170923        0     0      unk     NA   NA  <NA>    128   40  100
#> 3 2698224 6402735       20    81      efb     NA    4  <NA>      3   NA   NA
#> 4 2840995 6182554       16     4      fys     NA   NA  <NA>      5   NA   NA
#> 5 2847598 6173371        0     0      spo     NA   NA  <NA>     NA   NA   NA
#> 6 2840995 6182554       16     4      fys     NA   NA  <NA>      1   NA   NA
#>   nzreach   form      common_name             sci_name    family       genus
#> 1 8023537 Stream Yelloweye mullet Aldrichetta forsteri Mugilidae Aldrichetta
#> 2 8025043  River Yelloweye mullet Aldrichetta forsteri Mugilidae Aldrichetta
#> 3 3012906   Lake Yelloweye mullet Aldrichetta forsteri Mugilidae Aldrichetta
#> 4 8023537 Stream Yelloweye mullet Aldrichetta forsteri Mugilidae Aldrichetta
#> 5 8024588  Creek Yelloweye mullet Aldrichetta forsteri Mugilidae Aldrichetta
#> 6 8023537 Stream Yelloweye mullet Aldrichetta forsteri Mugilidae Aldrichetta
#>    species   threat_class native
#> 1 forsteri not threatened native
#> 2 forsteri not threatened native
#> 3 forsteri not threatened native
#> 4 forsteri not threatened native
#> 5 forsteri not threatened native
#> 6 forsteri not threatened native
```

### Adding River Environment Classification data

This function requires an internet connection to query the REC database.

``` r
dat4 <- nzffd_add(dat3)

# sort by date
head(dat4[order(dat4$y, dat4$m),])
#>      nzreach spcode  card m    y         catchname   catch
#> 24         0 galfas 27876 1 2010 Hen And Chicken I  53.000
#> 26         0 galfas 27877 1 2010 Hen And Chicken I  53.000
#> 1865 1026192 parane 30880 1 2010       Oruawharo R 459.111
#> 1866 1026192 parcur 30880 1 2010       Oruawharo R 459.111
#> 1867 1026192 angaus 30880 1 2010       Oruawharo R 459.111
#> 1868 1026192 hyrmen 30880 1 2010       Oruawharo R 459.111
#>                             locality     time  org map    east   north altitude
#> 24         Unnamed Stream South Cove 13:00:00 docx r07 2666600 6588300       20
#> 26   Unnamed Stream Koputotara Point 13:00:00 docx r07 2666100 6588400       28
#> 1865          Hakaru River Tributary 10:00:00 doca q08 2649760 6557736       75
#> 1866          Hakaru River Tributary 10:00:00 doca q08 2649760 6557736       75
#> 1867          Hakaru River Tributary 10:00:00 doca q08 2649760 6557736       75
#> 1868          Hakaru River Tributary 10:00:00 doca q08 2649760 6557736       75
#>      penet fishmeth effort pass abund number minl maxl      form
#> 24      10      gmt      9   NA  <NA>      1  115   NA    Stream
#> 26      10      gmt     10   NA  <NA>      4   95  140    Stream
#> 1865    20      gmt      6   NA     o     NA   NA   NA Tributary
#> 1866    20      gmt      6   NA     c     NA   NA   NA Tributary
#> 1867    20      gmt      6   NA     c     NA   30   45 Tributary
#> 1868    20      gmt      6   NA     p     NA   NA   NA Tributary
#>            common_name             sci_name       family        genus
#> 24       Banded kokopu   Galaxias fasciatus   Galaxiidae     Galaxias
#> 26       Banded kokopu   Galaxias fasciatus   Galaxiidae     Galaxias
#> 1865             Koura    Paranephrops spp. Parastacidae Paranephrops
#> 1866 Freshwater shrimp Paratya curvirostris      Atyidae      Paratya
#> 1867      Shortfin eel   Anguilla australis  Anguillidae     Anguilla
#> 1868 Freshwater mussel   Hyridella menziesi    Unionidae    Hyridella
#>           species   threat_class native OBJECTID FNODE TNODE   LENGTH REACH_ID
#> 24      fasciatus not threatened native       NA    NA    NA       NA       NA
#> 26      fasciatus not threatened native       NA    NA    NA       NA       NA
#> 1865         spp. not threatened native    26085 27471 27344 1745.513    26192
#> 1866 curvirostris not threatened native    26085 27471 27344 1745.513    26192
#> 1867    australis not threatened native    26085 27471 27344 1745.513    26192
#> 1868     menziesi        at risk native    26085 27471 27344 1745.513    26192
#>      FNODE_1 TNODE_1 ORDER CLIMATE SRC_OF_FLW GEOLOGY LANDCOVER NET_POSN
#> 24        NA      NA    NA    <NA>       <NA>    <NA>      <NA>     <NA>
#> 26        NA      NA    NA    <NA>       <NA>    <NA>      <NA>     <NA>
#> 1865   27483   27356     2      WW          L      SS         P       LO
#> 1866   27483   27356     2      WW          L      SS         P       LO
#> 1867   27483   27356     2      WW          L      SS         P       LO
#> 1868   27483   27356     2      WW          L      SS         P       LO
#>      VLY_LNDFRM CSOF   CSOFG    CSOFGL     CSOFGLNP      CSOFGLNPVL SPRING
#> 24         <NA> <NA>    <NA>      <NA>         <NA>            <NA>   <NA>
#> 26         <NA> <NA>    <NA>      <NA>         <NA>            <NA>   <NA>
#> 1865         LG WW/L WW/L/SS WW/L/SS/P WW/L/SS/P/LO WW/L/SS/P/LO/LG      -
#> 1866         LG WW/L WW/L/SS WW/L/SS/P WW/L/SS/P/LO WW/L/SS/P/LO/LG      -
#> 1867         LG WW/L WW/L/SS WW/L/SS/P WW/L/SS/P/LO WW/L/SS/P/LO/LG      -
#> 1868         LG WW/L WW/L/SS WW/L/SS/P WW/L/SS/P/LO WW/L/SS/P/LO/LG      -
#>      NZFNODE NZTNODE  DISTSEA CATCHAREA
#> 24        NA      NA       NA        NA
#> 26        NA      NA       NA        NA
#> 1865 1027471 1027344 20835.72   1748249
#> 1866 1027471 1027344 20835.72   1748249
#> 1867 1027471 1027344 20835.72   1748249
#> 1868 1027471 1027344 20835.72   1748249
```

Using the four functions should result in a cleaned up dataframe of
NZFFD records, along with some missing data and associated REC data.
