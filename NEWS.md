
# nzffdr 2.0.0
Major rework of the package following an overhall of the the NZFFD website. Some previous functions are now depreciated.

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

