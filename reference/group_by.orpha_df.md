# Build group using Orphanet classifications

This is a method for the dplyr
[`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html)
generic. It extends initial groups by adding rows containing descendants
ORPHAcodes. This way any row may belong to several groups.

The function will force the creation of groups (they may be empty) for
any ORPHAcode provided in `force_codes` argument when
[`orpha_df()`](https://bndmr.github.io/RDaggregator/reference/orpha_df.md)
is called.

## Usage

``` r
# S3 method for class 'orpha_df'
group_by(.data, ...)
```

## Arguments

- .data:

  An
  [`orpha_df()`](https://bndmr.github.io/RDaggregator/reference/orpha_df.md)
  instantiation.

- ...:

  \<[`data-masking`](https://rlang.r-lib.org/reference/args_data_masking.html)\>
  In
  [`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html),
  variables or computations to group by. Computations are always done on
  the ungrouped data frame. To perform computations on the grouped data,
  you need to use a separate
  [`mutate()`](https://dplyr.tidyverse.org/reference/mutate.html) step
  before the
  [`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html).
  Computations are not allowed in
  [`nest_by()`](https://dplyr.tidyverse.org/reference/nest_by.html). In
  [`ungroup()`](https://dplyr.tidyverse.org/reference/group_by.html),
  variables to remove from the grouping.

## Examples

``` r
library(dplyr)

# Build patients data.frame
df_patients = data.frame(
  patient_id = c(1,2,3,4,5,6),
  group = c('A','A','A','B','B','B'),
  code = c('158673', '595356', '305', '79406', '79406', '595356'))

df_counts = df_patients %>% group_by(code)
attr(df_counts, 'groups')
#> # A tibble: 4 × 2
#>   code         .rows
#>   <chr>  <list<int>>
#> 1 158673         [1]
#> 2 305            [1]
#> 3 595356         [2]
#> 4 79406          [2]

df_counts = df_patients %>% orpha_df(orpha_code_col = 'code') %>% group_by(code)
attr(df_counts, 'groups')
#> # A tibble: 4 × 2
#>   code   .rows    
#>   <chr>  <list>   
#> 1 158673 <int [1]>
#> 2 305    <int [3]>
#> 3 595356 <int [3]>
#> 4 79406  <int [2]>

df_counts = df_patients %>% orpha_df(orpha_code_col = 'code') %>% group_by(code, group)
attr(df_counts, 'groups')
#> # A tibble: 6 × 3
#> # Groups:   code [4]
#>   code   group .rows    
#>   <chr>  <chr> <list>   
#> 1 158673 A     <int [1]>
#> 2 305    A     <int [1]>
#> 3 305    B     <int [2]>
#> 4 595356 A     <int [2]>
#> 5 595356 B     <int [1]>
#> 6 79406  B     <int [2]>
```
