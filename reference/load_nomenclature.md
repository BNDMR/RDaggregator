# ORPHAcodes properties

Load all ORPHAcodes properties in a combined data.frame.

## Usage

``` r
load_raw_nomenclature()

load_nomenclature()
```

## Value

The ORPHAcodes properties as a data.frame object.

## Details

The label is the clinical entity name and is returned in the `label`
column. If the displayed language does not meet your needs, you should
consider changing options via
[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md)
or adding a new nomenclature pack using
[`add_nomenclature_pack()`](https://bndmr.github.io/RDaggregator/reference/add_nomenclature_pack.md).

The classification level is the clinical entity name and is returned in
the `level` column. Classification level can either be a group of
disorders, a disorder or a subtype of disorder.

The status of an ORPHAcode is a value contained in the following terms :
"Active", "Inactive: Deprecated", "Inactive: Obsolete", "Inactive: Non
rare disease in Europe".

The disorder type indicates the clinical entity's typology and is
returned by `get_type`.

For more details, please read the full Orphanet description included in
the nomenclature pack (*.pdf*).

## See also

[`get_label()`](https://bndmr.github.io/RDaggregator/reference/orphacode-properties.md),
[`get_classification_level()`](https://bndmr.github.io/RDaggregator/reference/orphacode-properties.md),
[`get_status()`](https://bndmr.github.io/RDaggregator/reference/orphacode-properties.md),
[`get_type()`](https://bndmr.github.io/RDaggregator/reference/orphacode-properties.md)
to access specific properties,
[`load_synonyms()`](https://bndmr.github.io/RDaggregator/reference/load_synonyms.md),
[`get_all_labels()`](https://bndmr.github.io/RDaggregator/reference/get_all_labels.md),
[`load_redirections()`](https://bndmr.github.io/RDaggregator/reference/load_redirections.md),
[`load_redirections()`](https://bndmr.github.io/RDaggregator/reference/load_redirections.md)
to access other pieces of information contained in the nomenclature
file.
