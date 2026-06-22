# Orphanet classifications

The functions presented below analyze relationships between ORPHAcodes
and returns results in a convenient format for further analysis or
display.

## Usage

``` r
load_classifications()

load_all_classifications()

is_in_classif(orpha_code, df_classif)
```

## Arguments

- orpha_code:

  An ORPHAcode.

- df_classif:

  A from/to data.frame providing relationships between ORPHAcodes.

## Value

All classifications as a list of data.frame

Returns TRUE if a given ORPHAcode belongs to a given classification,
FALSE else.

## Details

Orphanet organized its classification system around 34 different
hierarchies, which are not completely distinct.

For each hierarchy is listed a set of from/to relationships between
ORPHAcodes. A child is always more specific than its parent.

`load_classifications` Mind using `bind_rows` followed by `distinct` to
merge all classification.

The classification system will change according to the chosen
`"RDaggregator_nomenclature"` option, that you can set via the
[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md)
interface. Add a new available option with
[`add_nomenclature_pack()`](https://bndmr.github.io/RDaggregator/reference/add_nomenclature_pack.md).

## See also

[`add_nomenclature_pack()`](https://bndmr.github.io/RDaggregator/reference/add_nomenclature_pack.md),
[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md)

## Examples

``` r
library(dplyr)

all_classif = load_classifications()
df_all_classif = load_classifications() %>% bind_rows() %>% distinct()

is_in_classif(303, all_classif[[1]])
#> [1] FALSE
is_in_classif(303, all_classif[[6]])
#> [1] TRUE
```
