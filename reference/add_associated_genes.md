# Add ORPHAcodes-genes associations to `RDaggregator`.

This function analyzes the file containing associations between
ORPHAcodes and genes and saves them internally in an R-friendly format.

## Usage

``` r
add_associated_genes(
  filepath,
  default = FALSE,
  force = FALSE,
  destdir = tools::R_user_dir("RDaggregator", "data")
)
```

## Arguments

- filepath:

  An xml file published by Orphanet containing the associations between
  ORPHAcodes and genes.

- default:

  If `TRUE`, set the added association file as default.

- force:

  If `TRUE`, adds the association file even if an identical version was
  internally found.

- destdir:

  The destination directory, in which the processed data will be saved.

## Details

Orphanet publishes genes data on a 6-months basis, and is deployed in
english only. The different file versions are available
[here](https://www.orphadata.com/genes/). They must be downloaded
locally to be added to `RDaggregator`.

As a gene mutation may have various effects on individuals health, this
file indicates how genes and clinical entities are related, giving the
association type and status. Genes can be referred through multiple
referentials including HGNC, OMIM, Ensembl, Genatlas, Reactome and
SwissProt.

The added file version will appear among the available options through
the
[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md)
interface. It can also be manually set using the built-in
[`options()`](https://rdrr.io/r/base/options.html) function and the
`"gene_file_version"` name.

## See also

[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md),
[`load_associated_genes()`](https://bndmr.github.io/RDaggregator/reference/load-genes.md),
[`load_genes_synonyms()`](https://bndmr.github.io/RDaggregator/reference/load-genes.md)
