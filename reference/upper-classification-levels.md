# Find specific ancestors

These functions helps you to find key ORPHAcodes which are located above
the given ORPHAcode in the classification system.

## Usage

``` r
subtype_to_disorder(orpha_code, df_classif = NULL)

get_lowest_groups(orpha_code, df_classif = NULL)
```

## Arguments

- orpha_code:

  A vector of ORPHAcodes.

- df_classif:

  The classification to consider. If NULL, loads the whole Orphanet
  classification.

## Value

`subtype_to_disorder` returns the associated disorder, or the ORPHAcode
itself if it is already a disorder, or NULL if it is a group of
disorders. If a vector of ORPHAcodes is provided, function is applied on
each element, and the associated vector is returned.

`get_lowest_groups` returns the closest groups from the given ORPHAcode,
or the ORPHAcode itself if it is a group of disorders already.

## Examples

``` r
subtype_to_disorder(orpha_code = '158676')
#> [1] "595356"
# ORPHA:158676 is a subtype of disorder

subtype_to_disorder(orpha_code = '303')
#> character(0)
# ORPHA:303 is a group of disorder

get_lowest_groups(orpha_code = '158676')
#> [1] "303"
```
