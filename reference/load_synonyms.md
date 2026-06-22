# Synonyms

Any disease can be named in multiple ways. For each ORPHAcode, Orphanet
provides a unique preferential label. Any other name is then called
synonym.

This function returns in a data.frame the ORPHAcodes, their preferential
label and synonyms if any.

## Usage

``` r
load_synonyms()
```

## Value

A 3-columns data.frame indicating for each ORPHAcode its preferential
label and synonyms. `NA` is set if no synonyms was found.

## See also

[`get_all_labels()`](https://bndmr.github.io/RDaggregator/reference/get_all_labels.md)
to directly extract all the names associated to the given ORPHAcode.
