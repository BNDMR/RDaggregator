# Extract a graph from a set of ORPHAcodes

The extracted graph contains all the ORPHAcodes specified in the `vs`
argument. It may include other ORPHAcodes inside, but all the roots and
leaves are part of `vs`.

## Usage

``` r
in_between_graph(vs, df_classif = NULL)
```

## Arguments

- vs:

  A set of ORPHAcodes used to extract the graph.

- df_classif:

  The classification to consider. If NULL, loads the whole Orphanet
  classification.

## Value

The extracted graph as an *igraph* object.
