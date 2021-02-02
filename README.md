
# nzffdr <img src='man/figures/nzffdr_hex.png' align="right" height="150" /></a>

<!-- badges: start -->
<!-- badges: end -->

The purpose of this package is allow for direct access to the NZ
Freshwater Fish Database ([NZFFD](https://nzffdms.niwa.co.nz/search))
from R and additional functions for cleaning imported data and adding
missing data.

For a detailed guide to using the package see: ADD URL HERE

### Installation

``` r
# devtools::install_github("flee598/nzffdr")
library(nzffdr)
```

### Import data from the NZFFD

This function requires an internet connection to query the NZFFD
database.

``` r
# import all records between 2000 and 2010
dat <- nzffd_import(catchment = "", river = "", location = "", 
  fish_method = "", species = "", starts = 2000, ends = 2010)
head(dat)
#>   card m    y catchname   catch                locality time org map    east
#> 1  294 5 2000    Long B 075.000 Unnamed stream Long Bay      arc r10 2664600
#> 2  294 5 2000    Long B 075.000 Unnamed stream Long Bay      arc r10 2664600
#> 3  294 5 2000    Long B 075.000 Unnamed stream Long Bay      arc r10 2664600
#> 4  295 5 2000    Long B 075.000 Unnamed stream Long Bay      arc r10 2664600
#> 5  295 5 2000    Long B 075.000 Unnamed stream Long Bay      arc r10 2664600
#> 6  295 5 2000    Long B 075.000 Unnamed stream Long Bay      arc r10 2664600
#>     north altitude penet fishmeth effort pass spcode abund number minl maxl
#> 1 6499800       30     3      gmt      6   NA galfas            2   95  110
#> 2 6499800       30     3      gmt      6   NA gobhut            2   80   85
#> 3 6499800       30     3      gmt      6   NA parane            1   40   NA
#> 4 6499800       30     3      fyn      3   NA gobgob            1  150   NA
#> 5 6499800       30     3      fyn      3   NA galfas            3  130  135
#> 6 6499800       30     3      fyn      3   NA parane            2   70   75
#>   nzreach
#> 1 2004154
#> 2 2004154
#> 3 2004154
#> 4 2004154
#> 5 2004154
#> 6 2004154

# To import the entire NZFF database:
# dat <- nzffd_import()
```

### Cleaning data

``` r
dat2 <- nzffd_clean(dat)
head(dat2)
#>   card m    y catchname   catch                locality time org map    east
#> 1  294 5 2000    Long B 075.000 Unnamed Stream Long Bay   NA arc r10 2664600
#> 2  294 5 2000    Long B 075.000 Unnamed Stream Long Bay   NA arc r10 2664600
#> 3  294 5 2000    Long B 075.000 Unnamed Stream Long Bay   NA arc r10 2664600
#> 4  295 5 2000    Long B 075.000 Unnamed Stream Long Bay   NA arc r10 2664600
#> 5  295 5 2000    Long B 075.000 Unnamed Stream Long Bay   NA arc r10 2664600
#> 6  295 5 2000    Long B 075.000 Unnamed Stream Long Bay   NA arc r10 2664600
#>     north altitude penet fishmeth effort pass spcode abund number minl maxl
#> 1 6499800       30     3      gmt      6   NA galfas  <NA>      2   95  110
#> 2 6499800       30     3      gmt      6   NA gobhut  <NA>      2   80   85
#> 3 6499800       30     3      gmt      6   NA parane  <NA>      1   40   NA
#> 4 6499800       30     3      fyn      3   NA gobgob  <NA>      1  150   NA
#> 5 6499800       30     3      fyn      3   NA galfas  <NA>      3  130  135
#> 6 6499800       30     3      fyn      3   NA parane  <NA>      2   70   75
#>   nzreach   form
#> 1 2004154 Stream
#> 2 2004154 Stream
#> 3 2004154 Stream
#> 4 2004154 Stream
#> 5 2004154 Stream
#> 6 2004154 Stream
```

### Filling gaps

``` r
dat3 <- nzffd_fill(dat2, alt = TRUE, maps = TRUE)
head(dat3)
#>   spcode   card  m    y    catchname   catch                locality time  org
#> 1 aldfor  30488  3 2009       Avon R 666.000          Bexley Wetland   NA docc
#> 2 aldfor 111010 11 2003  Whanganui R 333.000         Whanganui River   NA  uow
#> 3 aldfor  30382  5 2009 Ruamahanga R 292.000              Lake Onoke   NA wnrc
#> 4 aldfor   7689  9 2001     Wairoa R 085.000            Wairoa River   NA niwa
#> 5 aldfor  21454  2 2002       Long B 075.000 Unnamed Stream Long Bay   NA nscc
#> 6 aldfor 105767  4 2005    Waimapu S 144.000          Waimapu Stream   NA  uow
#>   map    east   north altitude penet fishmeth effort pass abund number minl
#> 1 m35 2487482 5742964        5     1      ntc     32   NA  <NA>     36   95
#> 2 R10 2687692 6143373        9    11      efb    324    1  <NA>      1   NA
#> 3 r28 2686241 5978218        5     7      sen     NA   NA     a     NA   NA
#> 4 s11 2692300 6465800        5     7      ntc      7   NA     a     15  275
#> 5 r10 2665859 6500387       10     1      han     NA   NA  <NA>      6   NA
#> 6 u14 2787148 6379884       10     2      efb   1522   NA  <NA>      1   NA
#>   maxl  nzreach    form      common_name             sci_name    family
#> 1  271 13045924 Wetland Yelloweye mullet Aldrichetta forsteri Mugilidae
#> 2   NA  7029252   River Yelloweye mullet Aldrichetta forsteri Mugilidae
#> 3   NA  9016280    Lake Yelloweye mullet Aldrichetta forsteri Mugilidae
#> 4  345  2007061   River Yelloweye mullet Aldrichetta forsteri Mugilidae
#> 5  150  2004122  Stream Yelloweye mullet Aldrichetta forsteri Mugilidae
#> 6   NA  4001685  Stream Yelloweye mullet Aldrichetta forsteri Mugilidae
#>         genus  species   threat_class native
#> 1 Aldrichetta forsteri not threatened native
#> 2 Aldrichetta forsteri not threatened native
#> 3 Aldrichetta forsteri not threatened native
#> 4 Aldrichetta forsteri not threatened native
#> 5 Aldrichetta forsteri not threatened native
#> 6 Aldrichetta forsteri not threatened native
```

### Adding River Environment Classification data

This function requires an internet connection to query the REC database.

``` r
dat4 <- nzffd_add(dat3)
head(dat4)
#>   nzreach spcode  card  m    y     catchname   catch                locality
#> 1       0 anguil 21007  2 2001     Waimea In 573.000            Unnamed Pond
#> 2       0 gobcot 18737  3 2001  Rangitikei R 327.000            Unnamed Lake
#> 3       0 perflu 10733  1 2002 Waimakariri R 664.010            Unnamed Pond
#> 4       0 parane 23626 10 2006     Pareora R 701.000 Pareora River Tributary
#> 5       0 galfas 23766  8 2004    Punaruku S 044.000         Unnamed Wetland
#> 6       0 angaus 26464  3 2004     Kakanui R 717.000            Unnamed Pond
#>       time  org map    east   north altitude penet fishmeth effort pass abund
#> 1     <NA> docn n27 2524900 5983300       40     5      gin      1   NA     c
#> 2 10:30:00 docz s23 2704400 6103400        5    12      ntc     14   NA  <NA>
#> 3     <NA> docc m35 2475400 5745900       25    28      ntc      9   NA  <NA>
#> 4     <NA> doco j39 2361596 5636960       55     9      efp     15    1     n
#> 5     <NA> docx q05 2629800 6647500        5     2      gmt     20   NA  <NA>
#> 6 11:15:00  orc j41 2338000 5565000       40    18      efp      2    3  <NA>
#>   number minl maxl      form      common_name                sci_name
#> 1     NA   NA   NA      Pond Unidentified eel           Anguilla spp.
#> 2     35   30   60      Lake     Common bully Gobiomorphus cotidianus
#> 3      1   NA   NA      Pond            Perch       Perca fluviatilis
#> 4     NA   NA   NA Tributary            Koura       Paranephrops spp.
#> 5      2   55  133   Wetland    Banded kokopu      Galaxias fasciatus
#> 6      1  560   NA      Pond     Shortfin eel      Anguilla australis
#>         family        genus     species   threat_class     native OBJECTID
#> 1  Anguillidae     Anguilla        spp.           <NA>       <NA>       NA
#> 2   Eleotridae Gobiomorphus  cotidianus not threatened     native       NA
#> 3     Percidae        Perca fluviatilis     introduced introduced       NA
#> 4 Parastacidae Paranephrops        spp. not threatened     native       NA
#> 5   Galaxiidae     Galaxias   fasciatus not threatened     native       NA
#> 6  Anguillidae     Anguilla   australis not threatened     native       NA
#>   FNODE TNODE LENGTH REACH_ID FNODE_1 TNODE_1 ORDER CLIMATE SRC_OF_FLW GEOLOGY
#> 1    NA    NA     NA       NA      NA      NA    NA    <NA>       <NA>    <NA>
#> 2    NA    NA     NA       NA      NA      NA    NA    <NA>       <NA>    <NA>
#> 3    NA    NA     NA       NA      NA      NA    NA    <NA>       <NA>    <NA>
#> 4    NA    NA     NA       NA      NA      NA    NA    <NA>       <NA>    <NA>
#> 5    NA    NA     NA       NA      NA      NA    NA    <NA>       <NA>    <NA>
#> 6    NA    NA     NA       NA      NA      NA    NA    <NA>       <NA>    <NA>
#>   LANDCOVER NET_POSN VLY_LNDFRM CSOF CSOFG CSOFGL CSOFGLNP CSOFGLNPVL SPRING
#> 1      <NA>     <NA>       <NA> <NA>  <NA>   <NA>     <NA>       <NA>   <NA>
#> 2      <NA>     <NA>       <NA> <NA>  <NA>   <NA>     <NA>       <NA>   <NA>
#> 3      <NA>     <NA>       <NA> <NA>  <NA>   <NA>     <NA>       <NA>   <NA>
#> 4      <NA>     <NA>       <NA> <NA>  <NA>   <NA>     <NA>       <NA>   <NA>
#> 5      <NA>     <NA>       <NA> <NA>  <NA>   <NA>     <NA>       <NA>   <NA>
#> 6      <NA>     <NA>       <NA> <NA>  <NA>   <NA>     <NA>       <NA>   <NA>
#>   NZFNODE NZTNODE DISTSEA CATCHAREA
#> 1      NA      NA      NA        NA
#> 2      NA      NA      NA        NA
#> 3      NA      NA      NA        NA
#> 4      NA      NA      NA        NA
#> 5      NA      NA      NA        NA
#> 6      NA      NA      NA        NA
```

You should now have a cleaned up dataframe of NZFFD records available to
you, optionally along with some missing data and associated REC data.
