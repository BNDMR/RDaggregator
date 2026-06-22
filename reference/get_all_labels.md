# Disease labels

Extract the synonyms of the given ORPHAcode as well as its preferential
label, given in first position.

## Usage

``` r
get_all_labels(orpha_code)
```

## Arguments

- orpha_code:

  An ORPHAcode.

## Value

A character vector containing all labels associated to the given
ORPHAcode.

## See also

[`load_synonyms()`](https://bndmr.github.io/RDaggregator/reference/load_synonyms.md)
to load the synonyms table.

## Examples

``` r
get_all_labels(65753) # Possible names for CMT1
#> [1] "Charcot-Marie-Tooth disease type 1"                          
#> [2] "Autosomal dominant demyelinating Charcot-Marie-Tooth disease"
#> [3] "CMT1"                                                        
#> [4] "Charcot-Marie-Tooth neuropathy type 1"                       
#> [5] "Hereditary motor and sensory neuropathy type 1"              
```
