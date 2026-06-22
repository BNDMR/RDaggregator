# Prepare grouping

This class allows performing hierarchical grouping operations using the
Orphanet classification system. Basically each ORPHAcode group built
with
[`group_by.orpha_df()`](https://bndmr.github.io/RDaggregator/reference/group_by.orpha_df.md)
will also contain rows with descendants ORPHAcodes. This away a row may
belong to several groups.

The `orpha_df` class just needs to know in which column ORPHAcodes are
located to work.

## Usage

``` r
orpha_df(
  x,
  orpha_code_col = "orpha_code",
  df_classif = NULL,
  force_codes = NULL,
  mode = "on"
)
```

## Arguments

- x:

  A data.frame object or data.frame extension.

- orpha_code_col:

  The column name of `x` containing the ORPHAcodes.

- df_classif:

  The classification to consider, in a from/to format.

- force_codes:

  ORPHAcodes to be forced to appear in `groups` attribute after a
  [`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html)
  operation.

- mode:

  Should either be `"on"` (the default) to convert data.frame into
  `orpha_df` object or `"off"` to roll back to previous class and remove
  relevant attributes.

## Value

An `orpha_df` instantiation. Any data.frame extension will be kept.
Former attributes are erased if `orpha_df` is called multiple times.

## Examples

``` r
library(dplyr)

# Build patients data.frame
df_patients = data.frame(
patient_id = c(1,1,2,3,4,5,6),
code = c('303', '158673', '595356', '305', '79406', '79406', '595356'))

df_counts = df_patients %>%
 group_by(code) %>%
 count() %>%
 as.data.frame()

df_counts = df_patients %>%
 orpha_df(orpha_code_col = 'code') %>%
 group_by(code) %>%
 count() %>%
 as.data.frame()
```
