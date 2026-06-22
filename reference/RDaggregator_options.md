# Options for `RDaggregator`

Interface to list and set RDaggregator-related options.

Options are useful to roll back to older versions or to switch between
languages for display.

- `"RDaggregator_dict"` refers to the dictionary used for the
  interpretation of Orphanet concepts ids.

- `"RDaggregator_nomenclature"` refers to a nomenclature pack version
  (extraction date and used language).

- `"RDaggregator_gene_file"` refers to the version of the file used to
  associated genes to ORPHAcodes.

All options can be set manually via the built-in
[`options()`](https://rdrr.io/r/base/options.html) function.

## Usage

``` r
RDaggregator_options()
```

## See also

[`add_dictionary()`](https://bndmr.github.io/RDaggregator/reference/add-dictionary.md),
[`add_nomenclature_pack()`](https://bndmr.github.io/RDaggregator/reference/add_nomenclature_pack.md),
[`add_associated_genes()`](https://bndmr.github.io/RDaggregator/reference/add_associated_genes.md)

## Examples

``` r
if (FALSE) RDaggregator_options() # \dontrun{}
```
