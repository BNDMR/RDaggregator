# ORPHAcodes and genes

Analyze possible specifications from given ORPHAcode and genes.

If such specifications are found, then the ORPHAcode-genes combinations
are considered as consistent.

Symbols (see
[`load_genes_synonyms()`](https://bndmr.github.io/RDaggregator/reference/load-genes.md)
to find them all) and HGNC codes are supported, let the function know
which you chose with the `mode` argument.

## Usage

``` r
specify_code(
  orpha_codes,
  genes = NULL,
  mode = "HGNC",
  .by = 1:length(orpha_codes)
)

check_orpha_gene_consistency(
  orpha_codes,
  genes = NULL,
  mode = "HGNC",
  .by = 1:length(orpha_codes)
)
```

## Arguments

- orpha_codes:

  The ORPHAcodes to update. If length is greater than 1, the full set of
  genes will be applied to each vector element.

- genes:

  The mutated genes. If given as a list, it should be length-compatible
  with `orpha_code`, so that each list element corresponds to one
  `orpha_codes` entry. Set the `.by` argument properly to apply the
  right set of genes on each ORPHAcode.

- mode:

  Character constant, whether the given genes are `"symbol"` or `"HGNC"`
  codes.

- .by:

  Optionally, the set of mutated genes. The default is to consider each
  row as independent. Set it to NULL or a constant value to apply the
  full set of `genes` to each element of `orpha_codes`. A warning will
  be raised if any of the considered sets contains more than 10
  elements.

## Value

The updated ORPHAcodes, the same length as `orpha_codes`.

## Details

Potential specifications will be searched among the descendants of the
given ORPHAcode. They must be associated to one of the mutated genes
given in the `genes` argument. This kind of association is necessarily
`"Assessed"` and `"Disease-causing"` according to Orphanet.

In `specify_code`, specification is applied if and only if a unique
potential replacement ORPHAcode was found.

For both functions, each row is considered as independent by default.
You have a couple of options to deal cases where an individual genes are
spread over multiple rows :

- Set the `.by` argument instead of `group_by`.

- Use `group_by` to
  [`chop()`](https://tidyr.tidyverse.org/reference/chop.html) mutated
  genes into a list-column and `ungroup` to make your data row-wise
  compatible.

## Examples

``` r
library(dplyr)

#### Basic usage ####
orpha_code_cmt1 = 65753
orpha_code_cmtX = 64747

## Specification possible
# CMT1B is the only ORPHAcode both associated with CMT1 and MPZ
specify_code(orpha_code_cmt1, 'MPZ', mode='symbol')
#> [1] "101082"
check_orpha_gene_consistency(orpha_code_cmt1, 'MPZ', mode='symbol')
#> [1] TRUE

# CMT1B is the only ORPHAcode both associated with CMT1 and MPZ and/or POMT1
specify_code(orpha_code_cmt1, c('MPZ', 'POMT1'), mode='symbol')
#> [1] "101082"
check_orpha_gene_consistency(orpha_code_cmt1, c('MPZ', 'POMT1'), mode='symbol')
#> [1] TRUE

## Specification impossible
# No ORPHAcode is associated both to CMTX and MPZ
specify_code(orpha_code_cmtX, 'MPZ', mode='symbol')
#> [1] "64747"
check_orpha_gene_consistency(orpha_code_cmtX, 'MPZ', mode='symbol')
#> [1] FALSE

# Several ORPHAcodes are associated both to CMT1 and PMP22 (CMT1A and CMT1E)
specify_code(orpha_code_cmt1, 'PMP22', mode='symbol')
#> [1] "65753"
check_orpha_gene_consistency(orpha_code_cmt1, 'PMP22', mode='symbol') # TRUE
#> [1] TRUE

# Several ORPHAcodes are associated both to CMT1 and PMP22 (CMT1A and CMT1E)
# or MPZ (CMT1B), but none with both PMP22 and MPZ.
specify_code(orpha_code_cmt1, c('MPZ', 'PMP22'), mode='symbol')
#> [1] "65753"
check_orpha_gene_consistency(orpha_code_cmt1, c('MPZ', 'PMP22'), mode='symbol') # Is it consistent ?
#> [1] TRUE

## Alternatively with HGNC codes (the default mode)
# CMT1B is the only ORPHAcode both associated with CMT1 and MPZ
specify_code(orpha_code_cmt1, 7225)
#> [1] "101082"

#### Using dataframes ####
df = tibble(
  patient_id=c('A', 'A', 'B', 'C', 'D', 'D'),
  symbol = c("MPZ", "LITAF", "VWF", "LITAF", "MPZ", "VWF"),

  # CMT1 (ORPHA:65753) and von Willebrand (ORPHA:903)
  initial_orpha_code = c("65753", "65753", "903", "65753", "65753", "65753"))

## Basic call : each row is independent
df_spec = df %>% mutate(assigned_orpha_code =
    specify_code(initial_orpha_code, genes=symbol, mode='symbol'))

## Grouping may be preferable
df_spec = df %>% mutate(assigned_orpha_code = specify_code(
    initial_orpha_code, genes=symbol, mode='symbol', .by=patient_id))

## Equivalent method with genes in a list-column
df = tibble(
  patient_id=c('A', 'B', 'C', 'D'),
  initial_orpha_code = c("65753", "903", "65753", "65753"),
  symbol = list(c("MPZ", "LITAF"), "VWF", "LITAF", c("MPZ", "VWF")))

df_spec = df %>% mutate(assigned_orpha_code =
  specify_code(initial_orpha_code, genes=symbol, mode='symbol'))
```
