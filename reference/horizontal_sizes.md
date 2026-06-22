# Compute how large should be the graph at each depth

Compute how large should be the graph at each depth

## Usage

``` r
horizontal_sizes(graph, df_y, root_node = NULL)
```

## Arguments

- graph:

  The graph from which nodes positions (x axis) will be calculated.

- df_y:

  Y coordinates which are useful to simplify the graph.

- root_node:

  `root_node` is the reference to calculate the X coordinates of its
  children. It is a dataframe with a name and a relative_position
  columns. If NULL, it applies the function recursively on each root of
  the graph.
