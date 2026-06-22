# ORPHAcode specific properties

Get specific properties of given ORPHAcodes.

## Usage

``` r
get_label(orpha_codes)

get_classification_level(orpha_codes)

get_status(orpha_codes)

is_active(orpha_codes)

get_type(orpha_codes)
```

## Arguments

- orpha_codes:

  The ORPHAcodes as a vector from which properties should be returned.

## Value

The corresponding properties of the given ORPHAcodes.

## Details

The label is the clinical entity name and is returned by `get_label`. As
multiple synonyms can be associated to a clinical entity, this function
only returns the preferential labels. To get all synonyms instead, use
`get_synonyms`. Besides, if the displayed language does not meet your
needs, you should consider changing options via
[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md)
or adding a new nomenclature pack using
[`add_nomenclature_pack()`](https://bndmr.github.io/RDaggregator/reference/add_nomenclature_pack.md).

The classification level is the clinical entity name and is returned by
`get_classification_level`. Classification level can either be a group
of disorders, a disorder or a subtype of disorder.

The status of an ORPHAcode is a value contained in the following terms :
"Active", "Inactive: Deprecated", "Inactive: Obsolete", "Inactive: Non
rare disease in Europe". It is returned by `get_status`, while
`is_active` just returns TRUE if status is "Active" and FALSE else.

The disorder type indicates the clinical entity's typology and is
returned by `get_type`.

For more details, please read the full Orphanet description included in
the nomenclature pack (*.pdf*).

## Note

All properties described above are accessible in a combined format
through the `load_nomenclature` function.

## See also

[`load_nomenclature()`](https://bndmr.github.io/RDaggregator/reference/load_nomenclature.md),
[`load_raw_nomenclature()`](https://bndmr.github.io/RDaggregator/reference/load_nomenclature.md)

## Examples

``` r
orpha_codes = c('303', '595356', '79410')
get_label(orpha_codes)
#> [1] "Dystrophic epidermolysis bullosa"                          
#> [2] "Localized dystrophic epidermolysis bullosa"                
#> [3] "Localized dystrophic epidermolysis bullosa, pretibial form"
get_classification_level(orpha_codes)
#> [1] "Group"    "Disorder" "Subtype" 
get_status(orpha_codes)
#> [1] "Active" "Active" "Active"
is_active(orpha_codes)
#> [1] TRUE TRUE TRUE
get_type(orpha_codes)
#> [1] "Clinical group"   "Disease"          "Clinical subtype"
```
