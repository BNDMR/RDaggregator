# Add a nomenclature pack to `RDaggregator`

This function analyzes the nomenclature pack files and saves them
internally in an R-friendly format.

## Usage

``` r
add_nomenclature_pack(
  zip_filepath,
  default = FALSE,
  force = FALSE,
  destdir = tools::R_user_dir("RDaggregator", "data")
)
```

## Arguments

- zip_filepath:

  The location of the *.zip* file containing the nomenclature pack.

- default:

  If `TRUE`, set the added pack as default.

- force:

  If `TRUE`, adds the pack even if an identical version was internally
  found.

- destdir:

  The destination directory, in which the processed data will be saved.

## Details

Orphanet publishes the nomenclature pack on a yearly basis, and is
deployed in different language versions. The different nomenclature pack
versions are available
[here](https://www.orphacode.org/pack-nomenclature/). They must be
downloaded locally and uncompressed to be added to `RDaggregator`.

The uncompressed Orphanet nomenclature pack contains a set of *.xml* and
*.xlsx* files for coding, including the nomenclature file (e.g.
*ORPHAnomenclature_fr_2023.xml*) and a set of more than 30
classifications (usually contained in *Classifications* folder).

The nomenclature file contains for each ORPHAcode the associated
properties, like their associated label (and synonyms), status (active
or not), classification levels (group of disorder, disorder or subtype
of disorder), and redirections to another ORPHAcode (for deprecated or
obsolete only).

Each classification contains numerous from/to relationships between
clinical entities, depicting the global Orphanet classification system.

Once added, the nomenclature pack will appear among the available
options through the
[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md)
interface. It can also be manually set using the built-in
[`options()`](https://rdrr.io/r/base/options.html) function and the
`"nomenclature_version"` name.

## See also

[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md)
to switch from a pack to another,
[`load_nomenclature()`](https://bndmr.github.io/RDaggregator/reference/load_nomenclature.md),
[`load_raw_nomenclature()`](https://bndmr.github.io/RDaggregator/reference/load_nomenclature.md),
[`load_classifications()`](https://bndmr.github.io/RDaggregator/reference/classifications.md),
[`load_synonyms()`](https://bndmr.github.io/RDaggregator/reference/load_synonyms.md),
[`load_redirections()`](https://bndmr.github.io/RDaggregator/reference/load_redirections.md)
to load the data added through this function.
