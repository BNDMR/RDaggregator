# Associated genes

Load all needed information to explore associations between ORPHAcodes
and genes.

`load_associated_genes` loads the association tables.

`load_gene_synonyms` loads genes synonyms in case your available data
refers to genes in a different way.

## Usage

``` r
load_associated_genes()

load_genes_synonyms()
```

## Value

A data frame containing for each ORPHAcode the kind of association (if
any). with a related gene and all known information (symbol, name,
references, locus) about the latter.

## Details

The loaded dataframes directly depend on the `"RDaggregator_gene_file"`
option that you can set via the
[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md)
interface. You can add an available option with
[`add_associated_genes()`](https://bndmr.github.io/RDaggregator/reference/add_associated_genes.md).

## See also

[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md),
[`add_associated_genes()`](https://bndmr.github.io/RDaggregator/reference/add_associated_genes.md),
[`specify_code()`](https://bndmr.github.io/RDaggregator/reference/orpha-genes.md)

## Examples

``` r
df_associated_genes = load_associated_genes()
df_genes_synonyms = load_genes_synonyms()
```
