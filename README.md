
# nzffdr <img src='man/figures/nzffdr_hex.png' align="right" height="150" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/flee598/nzffdr/workflows/R-CMD-check/badge.svg)](https://github.com/flee598/nzffdr/actions)
<!-- badges: end -->

The purpose of this package is to allow for direct access to the NZ
Freshwater Fish Database ([NZFFD](https://nzffdms.niwa.co.nz/search))
from R and additional functions for cleaning imported data and adding
missing data.

For a detailed guide to using the package see the [help
page](https://flee598.github.io/nzffdr/).

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
#> 5 2479366 5751283       10    11      ntc     17   NA gobgob            1  125
#> 6 2479366 5751283       10    11      ntc     17   NA gobcot           20   40
#>   maxl  nzreach
#> 1   NA  3008300
#> 2   NA  3008300
#> 3 1100 13043121
#> 4  900 13043121
#> 5   NA 13043121
#> 6  110 13043121

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
#> 5 2479366 5751283       10    11      ntc     17   NA gobgob  <NA>      1  125
#> 6 2479366 5751283       10    11      ntc     17   NA gobcot  <NA>     20   40
#>   maxl  nzreach      form
#> 1   NA  3008300     River
#> 2   NA  3008300     River
#> 3 1100 13043121 Tributary
#> 4  900 13043121 Tributary
#> 5   NA 13043121 Tributary
#> 6  110 13043121 Tributary
```

### Filling gaps and adding species information

``` r
dat3 <- nzffd_fill(dat2, alt = TRUE, maps = TRUE)
head(dat3)
#>   spcode   card  m    y   catchname   catch         locality     time  org map
#> 1 aldfor 104726  5 2015     Taipo S 229.000     Taipo Stream 09:50:00 hbrc v21
#> 2 aldfor 104396  4 2013 Ngaruroro R 231.000 Waitangi Estuary 13:30:00 hbrc v21
#> 3 aldfor  33330  1 2011 Ngaruroro R 231.000  Ngaruroro River     <NA> hbrc v21
#> 4 aldfor  33321 10 2012     Clive R 231.501      Muddy Creek 23:00:00 hbrc v21
#> 5 aldfor  30982  4 2010      Whau R  80.060  Avondale Stream 10:15:00  bml r11
#> 6 aldfor 104726  5 2015     Taipo S 229.000     Taipo Stream 09:50:00 hbrc v21
#>      east   north altitude penet fishmeth effort pass abund number minl maxl
#> 1 2840995 6182554       16     4      fys     NA   NA  <NA>      5   NA   NA
#> 2 2847218 6174038       16     0      sen     NA   NA  <NA>     27   NA   NA
#> 3 2846262 6174474        2     2      fyn     NA   NA  <NA>      6   42  105
#> 4 2847598 6173371        0     0      spo     NA   NA  <NA>     NA   NA   NA
#> 5 2661200 6475000        5     1      nfc     50    1  <NA>      2  250  270
#> 6 2840995 6182554       16     4      fys     NA   NA  <NA>      4   NA   NA
#>   nzreach    form      common_name             sci_name    family       genus
#> 1 8023537  Stream Yelloweye mullet Aldrichetta forsteri Mugilidae Aldrichetta
#> 2 8024600 Estuary Yelloweye mullet Aldrichetta forsteri Mugilidae Aldrichetta
#> 3 8024599   River Yelloweye mullet Aldrichetta forsteri Mugilidae Aldrichetta
#> 4 8024588   Creek Yelloweye mullet Aldrichetta forsteri Mugilidae Aldrichetta
#> 5 2006167  Stream Yelloweye mullet Aldrichetta forsteri Mugilidae Aldrichetta
#> 6 8023537  Stream Yelloweye mullet Aldrichetta forsteri Mugilidae Aldrichetta
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
#> 4          0 galfas 27876 1 2010 Hen And Chicken I  53.000
#> 42         0 galfas 27877 1 2010 Hen And Chicken I  53.000
#> 1855 1026192 angaus 30880 1 2010       Oruawharo R 459.111
#> 1856 1026192 hyrmen 30880 1 2010       Oruawharo R 459.111
#> 1857 1026192 gobhut 30880 1 2010       Oruawharo R 459.111
#> 1858 1026192 gobcot 30880 1 2010       Oruawharo R 459.111
#>                             locality     time  org map    east   north altitude
#> 4          Unnamed Stream South Cove 13:00:00 docy r07 2666600 6588300       20
#> 42   Unnamed Stream Koputotara Point 13:00:00 docy r07 2666100 6588400       28
#> 1855          Hakaru River Tributary 10:00:00 doca q08 2649760 6557736       75
#> 1856          Hakaru River Tributary 10:00:00 doca q08 2649760 6557736       75
#> 1857          Hakaru River Tributary 10:00:00 doca q08 2649760 6557736       75
#> 1858          Hakaru River Tributary 10:00:00 doca q08 2649760 6557736       75
#>      penet fishmeth effort pass abund number minl maxl      form
#> 4       10      gmt      9   NA  <NA>      1  115   NA    Stream
#> 42      10      gmt     10   NA  <NA>      4   95  140    Stream
#> 1855    20      gmt      6   NA     c     NA   30   45 Tributary
#> 1856    20      gmt      6   NA     p     NA   NA   NA Tributary
#> 1857    20      gmt      6   NA  <NA>      7   40   50 Tributary
#> 1858    20      gmt      6   NA  <NA>      2   40   70 Tributary
#>            common_name                sci_name      family        genus
#> 4        Banded kokopu      Galaxias fasciatus  Galaxiidae     Galaxias
#> 42       Banded kokopu      Galaxias fasciatus  Galaxiidae     Galaxias
#> 1855      Shortfin eel      Anguilla australis Anguillidae     Anguilla
#> 1856 Freshwater mussel      Hyridella menziesi   Unionidae    Hyridella
#> 1857      Redfin bully    Gobiomorphus huttoni  Eleotridae Gobiomorphus
#> 1858      Common bully Gobiomorphus cotidianus  Eleotridae Gobiomorphus
#>         species   threat_class native OBJECTID FNODE TNODE   LENGTH REACH_ID
#> 4     fasciatus not threatened native       NA    NA    NA       NA       NA
#> 42    fasciatus not threatened native       NA    NA    NA       NA       NA
#> 1855  australis not threatened native    26085 27471 27344 1745.513    26192
#> 1856   menziesi        at risk native    26085 27471 27344 1745.513    26192
#> 1857    huttoni not threatened native    26085 27471 27344 1745.513    26192
#> 1858 cotidianus not threatened native    26085 27471 27344 1745.513    26192
#>      FNODE_1 TNODE_1 ORDER CLIMATE SRC_OF_FLW GEOLOGY LANDCOVER NET_POSN
#> 4         NA      NA    NA    <NA>       <NA>    <NA>      <NA>     <NA>
#> 42        NA      NA    NA    <NA>       <NA>    <NA>      <NA>     <NA>
#> 1855   27483   27356     2      WW          L      SS         P       LO
#> 1856   27483   27356     2      WW          L      SS         P       LO
#> 1857   27483   27356     2      WW          L      SS         P       LO
#> 1858   27483   27356     2      WW          L      SS         P       LO
#>      VLY_LNDFRM CSOF   CSOFG    CSOFGL     CSOFGLNP      CSOFGLNPVL SPRING
#> 4          <NA> <NA>    <NA>      <NA>         <NA>            <NA>   <NA>
#> 42         <NA> <NA>    <NA>      <NA>         <NA>            <NA>   <NA>
#> 1855         LG WW/L WW/L/SS WW/L/SS/P WW/L/SS/P/LO WW/L/SS/P/LO/LG      -
#> 1856         LG WW/L WW/L/SS WW/L/SS/P WW/L/SS/P/LO WW/L/SS/P/LO/LG      -
#> 1857         LG WW/L WW/L/SS WW/L/SS/P WW/L/SS/P/LO WW/L/SS/P/LO/LG      -
#> 1858         LG WW/L WW/L/SS WW/L/SS/P WW/L/SS/P/LO WW/L/SS/P/LO/LG      -
#>      NZFNODE NZTNODE  DISTSEA CATCHAREA
#> 4         NA      NA       NA        NA
#> 42        NA      NA       NA        NA
#> 1855 1027471 1027344 20835.72   1748249
#> 1856 1027471 1027344 20835.72   1748249
#> 1857 1027471 1027344 20835.72   1748249
#> 1858 1027471 1027344 20835.72   1748249
```

Using the four functions should result in a cleaned up dataframe of
NZFFD records, along with some missing data and associated REC data.
