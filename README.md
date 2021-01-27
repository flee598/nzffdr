
# nzffdr <img src='man/figures/nzffdr_hex.png' align="right" height="150" /></a>

<!-- badges: start -->
<!-- badges: end -->

The purpose of this package is allow for direct access to the NZ
Freshwater Fish Database ([NZFFD](https://nzffdms.niwa.co.nz/search))
from R and additional functions for cleaning imported data and adding
missing data.

### Installation

``` r
# devtools::install_github("flee598/nzffdr")
library(nzffdr)
```

### Built-in datasets

There are three built-in datasets to assist, these are:

-   `nzffd_data` a subset of 200 rows from the NZFFD, used for examples,
    tutorials etc.

-   `method_nzffd` a dataframe containing all the different fishing
    methods included in the NZFFD, it is possible to search the database
    using these terms so they are provided for reference.

-   `species_nzffd` a dataframe of the scientific and common names of
    all species included in the NZFFD. It is possible to search the
    database by species name (using scientific or common names) so these
    are provided for reference.

### Getting data

Start by importing some data. We have tried to make the search terms
match those you would use directly on the Niwa site. For example leaving
a search field blank will return all records. There are seven search
arguments:

-   `catchment` this refers to the Catchment No. a 6 digit number unique
    to the reach of interest. You can search using the inidviual number
    (e.g. `catchment = "702.500"`), or for all rivers in a catchment you
    can use the wildcard search term (e.g. `catchment = "702%"`), or
    don’t set the arg if you want all catchments in NZ.

-   `river` search for a river by name, to get all records for the
    Clutha (e.g. `river = "Clutha"`).

-   `location` search for river by location
    e.g. (`location = "Nelson"`).

-   `fish_method` search by fishing method used. There are 59 different
    possible options for `fish_method`, if you want to search for a
    specific fishing method use `method_nzffd()` to see a list of all
    possible options, you can then copy/paste from there (e.g. if we
    only wanted fish caught be lures use `fish_meth = "Angling - Lure"`)
    don’t set the arg if you want all fishing methods.

-   `species` search for a particular species. There are 75 different
    possible options for `species`, use `species_nzffd()` to see a list
    of all possible options. You can search using either common or
    scientific names and can search for multiple species at once.
    e.g. to search for Black mudfish use `species = "Black mudfish"` or
    `species = "Neochanna diversus"` and to search for Black mudfish and
    Bluegill bully use `species = c("Black mudfish", "Bluegill bully")`
    etc.

-   `starts` starting search date, 1850 at the earliest.

-   `ends` ending search date.

This function requires an internet connection to query Niwa’s database.

Data citation: Crow S (2017). New Zealand Freshwater Fish Database.
Version 1.2. The National Institute of Water and Atmospheric Research
(NIWA). Occurrence Dataset <https://doi.org/10.15468/ms5iqu>

``` r
# import all records between 2000 and 2010
dat <- import_nzffd(catchment = "", river = "", location = "", 
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
```

### Cleaning data

While the data imported from NZFFD is in pretty good shape there are
some small inconsistencies. The `clean_nzffd()` function aims to deal
with some of these inconsistencies. In particular text strings have been
standardised. The first letter of all words in `catchname` and
`locality` are capitalised and any non-alphanumeric characters are
removed. `time` is converted to a standardised 24 hour format and
nonsesical values converted to `NA`. `org` is converted to all lowercase
and has non-alphanumeric characters removed. `map` is converted to lower
case and has any non-three digit codes converted to `NA`. `catchname`
codes are tidied following the suggested abbreviations, e.g. “Cluth
River”, “Clutha r” and “Clutha river” all become Clutha R. Finally a new
variable `form` is added which defines each observation as from one of
the following systems:
`Creek, River, Tributary, Stream, Lake, Lagoon, Pond, Burn, Race, Dam, Estuary, Swamp, Drain, Canal, Tarn, Wetland, Reservoir, Brook, Spring, Gully`
or `NA`.

``` r
dat2 <- clean_nzffd(dat)
head(dat2)
#>   card m    y catchname   catch                locality time org map    east
#> 1  294 5 2000    Long B 075.000 Unnamed Stream Long Bay   NA arc r10 2664600
#> 2  294 5 2000    Long B 075.000 Unnamed Stream Long Bay   NA arc r10 2664600
#> 3  294 5 2000    Long B 075.000 Unnamed Stream Long Bay   NA arc r10 2664600
#> 4  295 5 2000    Long B 075.000 Unnamed Stream Long Bay   NA arc r10 2664600
#> 5  295 5 2000    Long B 075.000 Unnamed Stream Long Bay   NA arc r10 2664600
#> 6  295 5 2000    Long B 075.000 Unnamed Stream Long Bay   NA arc r10 2664600
#>     north altitude penet fishmeth effort pass spcode abund number minl maxl
#> 1 6499800       30     3      gmt      6   NA galfas            2   95  110
#> 2 6499800       30     3      gmt      6   NA gobhut            2   80   85
#> 3 6499800       30     3      gmt      6   NA parane            1   40   NA
#> 4 6499800       30     3      fyn      3   NA gobgob            1  150   NA
#> 5 6499800       30     3      fyn      3   NA galfas            3  130  135
#> 6 6499800       30     3      fyn      3   NA parane            2   70   75
#>   nzreach   form
#> 1 2004154 Stream
#> 2 2004154 Stream
#> 3 2004154 Stream
#> 4 2004154 Stream
#> 5 2004154 Stream
#> 6 2004154 Stream
# quick check for changes in the number of different catchment names (a 
# reduction means, names have successfully been recoded)
length(unique(dat$catchname))
#> [1] 888
length(unique(dat2$catchname))
#> [1] 791
```

The above changes, while superfical make analysis that, for example
relies on grouping, work as intended.

### Filling gaps.

Some additional useful information can quickly be added to the dataset.
the `fill_nzffd()` function adds columns giving the speices’ common
name, scientific name (genus + species), family, genus, species, threat
classification status and weather the species is native or introduced.

Additionally, both the `map` and `altitude` variables have some `NA`
values, here we can fill most of them with `fill_nzffd()`. To fill `map`
and `altitude` we run the observation coordinates (NZMG) against a
raster projection of the ([NZMS260
MapTiles](https://koordinates.com/layer/413-nzms-260-map-series-index/))
and an 8m digital elevation model
([(DEM)](https://data.linz.govt.nz/layer/51768-nz-8m-digital-elevation-model-2012/))
of NZ. Note the ‘altitude’ values are not exact so we suggest they are
used in an exploratory manner only.

``` r
# number of NA's in input variables map and altitude
sum(is.na(dat2$map))
#> [1] 908
sum(is.na(dat2$altitude))
#> [1] 592
dat3 <- fill_nzffd(dat2, alt = TRUE, maps = TRUE)
# number of NA's in output data
sum(is.na(dat3$maps))
#> [1] 0
sum(is.na(dat3$altitude))
#> [1] 0
```

### Adding River Environment classification data

We can also add associated network topology and environmental
information from the River Environment Classification database
([(REC)](https://data.mfe.govt.nz/layer/51845-river-environment-classification-new-zealand-2010-deprecated/))
using `add_nzffd()`. This function takes the `nzreach` variable and
matches it again the corresponding `NZREACH` variable in the REC
database and imports all the REC data. Note this will add 24 new columns
to your dataframe, with the original REC column names, we suggest
renaming the REC columns as they are a bit fiendish as is.

This function requires an internet connection to query the REC database.

``` r
dim(dat3)
#> [1] 58768    30
dat4 <- add_nzffd(dat3)
dim(dat4)
#> [1] 58768    54
```

You should now have a cleaned up dataframe of NZFFD records available to
you, optionally along with some missing data and associated REC data.
