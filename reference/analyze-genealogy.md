# Analyze ORPHA classifications

The Orphanet classification system can be seen as a wide genealogy tree,
that's why the following terms will refer to this field.

There two classes of functions:

- Functions applied to a single ORPHAcode:

  - `get_parents`

  - `get_children`

  - `get_ancestors`

  - `get_descendants`

  - `get_siblings`

- Functions applied to a set of ORPHAcodes:

  - `get_ancestors`

  - `get_descendants`

  - `complete_family`

  - `get_LCAs`

When you don't want to analyze to whole Orphanet classification system,
`df_classif` should be set.

When only ORPHAcodes are needed, without the edges information, set
`output='codes_only'`. Alternatively, if you wish to analyze or
visualize ORPHAcodes interactions, set `output='edgelist'` or
`output='graph'`.

## Usage

``` r
get_parents(
  orpha_code,
  output = c("codes_only", "edgelist", "graph"),
  df_classif = NULL
)

get_children(
  orpha_code,
  output = c("codes_only", "edgelist", "graph"),
  df_classif = NULL
)

get_ancestors(
  orpha_codes,
  output = c("codes_only", "edgelist", "graph"),
  max_depth = NULL,
  df_classif = NULL
)

get_descendants(
  orpha_codes,
  output = c("codes_only", "edgelist", "graph"),
  max_depth = NULL,
  df_classif = NULL
)

get_siblings(
  orpha_code,
  output = c("codes_only", "edgelist", "graph"),
  df_classif = NULL
)

complete_family(
  orpha_codes,
  output = c("codes_only", "edgelist", "graph"),
  df_classif = NULL,
  max_depth = 1
)

get_LCAs(orpha_codes, df_classif = NULL)
```

## Arguments

- orpha_code:

  The ORPHAcode to start from.

- output:

  A value specifying the output format. Should be in
  `c("codes_only", "edgelist", "graph")`.

- df_classif:

  The classification data to consider. If NULL, load the whole Orphanet
  classification.

- orpha_codes:

  A vector of ORPHAcodes used to perform operations.

- max_depth:

  The maximum reached depth starting from the given ORPHAcode.

## Value

Results are returned in the format specified in `output` argument :
`'codes_only'`, `'edgelist'`, `'graph'`.

## Examples

``` r
library(dplyr)
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union
all_classif = load_classifications()
orpha_codes = c('303', '305', '595356')
orpha_code = '303'

# ---
# Ancestors
ancestors = get_ancestors(orpha_code)
ancestors_edges = get_ancestors(orpha_code, output='edgelist')
ancestors_graph = get_ancestors(orpha_code, output='graph')

# Get parents only
parents = get_ancestors(orpha_code, max_depth=1)
parents = get_parents(orpha_code)

# Select a specific classification tree
classif1 = all_classif[['ORPHAclassification_156_rare_genetic_diseases_fr']]
ancestors = get_ancestors(orpha_code, df_classif=classif1)

classif2 = all_classif[['ORPHAclassification_146_rare_cardiac_diseases_fr']]
ancestors = get_ancestors(orpha_code, df_classif=classif2)

# ---
# Descendants
descendants_codes = get_descendants(orpha_code)
decendants_edges = get_descendants(orpha_code, output='edgelist')
descendants_graph = get_descendants(orpha_code, output='graph')

# Get children only
children = get_descendants(orpha_code, max_depth=1)
children = get_children(orpha_code)

# ---
# Siblings
siblings = get_siblings(orpha_code)
siblings_edges = get_siblings(orpha_code, output='edgelist')
siblings_graph = get_siblings(orpha_code, output='graph')

# ---
# Lowest common ancestors
lcas = get_LCAs(orpha_codes)

classif = all_classif[['ORPHAclassification_187_rare_skin_diseases_fr']]
lcas = get_LCAs(orpha_codes, df_classif = classif)

# ---
# Complete family
family_codes = complete_family(orpha_codes)
family_codes = complete_family(orpha_codes, df_classif=all_classif[[1]])
#> Warning: The following ORPHAcodes do not belong to the classification : 303.The following ORPHAcodes do not belong to the classification : 305.The following ORPHAcodes do not belong to the classification : 595356.
family_codes = complete_family(orpha_codes, max_depth=2)
family_edges = complete_family(orpha_codes, output = 'edgelist')
family_graph = complete_family(orpha_codes, output='graph')
```
