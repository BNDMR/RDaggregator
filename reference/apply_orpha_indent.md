# Indentation

In order to make it easier to visualize which ORPHAcodes contain the
others in a data.frame, this function apply indentation, which means the
associated ORPHAcode is one level lower in Orphanet classification than
the ORPHAcode above.

ORPHAcodes may appear in multiple rows because they can be child of
several parents.

## Usage

``` r
apply_orpha_indent(df, indented_cols = NULL, prefix = "indent")
```

## Arguments

- df:

  An
  [`orpha_df()`](https://bndmr.github.io/RDaggregator/reference/orpha_df.md)
  instantiation.

- indented_cols:

  The columns that need to be shifted.

- prefix:

  The prefix of the indented columns. Default is `"indent"`.

## Value

A matrix with the right indentations applied on the requested columns

## Examples

``` r
if (FALSE) { # \dontrun{
  library(dplyr)
  orpha_codes = get_descendants('307711', output='codes_only')

  df = orpha_df(data.frame(orpha_code=orpha_codes), orpha_code_col='orpha_code') %>%
    left_join(load_nomenclature(), by='orpha_code')
  df_indented = apply_orpha_indent(df, indented_cols='label')
} # }
```
