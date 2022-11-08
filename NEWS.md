# nzffdr 2.1.0
Fixes associated with NZFFD search issue and some small tidying.
At the moment users should download the entire NZFFD, and then filter records from there. See note below.

## NZFFD search issue
 - Following reports of issues associated with using search fields in the NZFFD (see comments on page 4 of the help manual 
   available here: https://niwa.co.nz/information-services/nz-freshwater-fish-database/help), nzffdr_import() now downloads the entire
   NZFFD by default (previously even when no search terms were entered not all results were being downloaded due to changes to the NZFFD portal).
 
 - use any of the following to download the entire NZFFD (do not set additional arguments), and then filter in R as needed: nzffdr_import(download_format = "all"), nzffdr_import(download_format = "essential") or nzffdr_razzle_dazzle().
 

## updated functions
 - nzddr_import() & nzffdr_razzle_dazzle() now generate a warning regarding the NZFFD issue.
 - nzffdr_add_dates() now much faster
 - nzffdr_widen_habitat() no longer produces the "In fun_df(xx2, cl) : NAs introduced by coercion" warning by default.

## Depreciated functions
 - depreciated functions from nzffdr 2.0.0 have been removed (nzffdr_add() & nzffdr_fill())


# nzffdr 2.0.0
Major rework of the nzffdr package following an overhall of the the NZFFD website. Some previous functions are now depreciated.

## Depreciated functions
 - nzffdr_add - no longer relevant following NZFFD updates
 - nzffdr_fill - no longer relevant following NZFFD updates

## Updated functions
 - nzffdr_import - now works with the new NZFFD API
 - nzffdr_clean - clean data imported using nzffdr_import

## New functions
 - nzffdr_add_date - adds, year, month and day columns to NZFFD dataset
 - nzffdr_get_table - find all possible argument options for nzffdr_import
 - nzffdr_razzle_dazzle - wrapper for other functions, imports, cleans and adds information all in one step
 - nzffdr_taxon_threat - adds taxonomic and threat status information to imported NZFFD datasets

# nzffdr 1.0.0
Initial CRAN release

# nzffdr 0.0.0.9000
Initial development version of the nzffdr package on GitHub

