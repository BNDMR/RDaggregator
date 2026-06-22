# Calculate horizontal coordinates for each node of the given graph

Calculate horizontal coordinates for each node of the given graph

## Usage

``` r
horizontal_positions(graph, df_y, h_size, root_node = NULL)
```

## Arguments

- graph:

  The graph from which nodes positions (x axis) will be calculated.

- df_y:

  Y coordinates which are useful to simplify the graph.

- h_size:

  Horizontal widths at each graph level are needed to compute X
  positions.

- root_node:

  `root_node` is the reference to calculate the X coordinates of its
  children. It is a dataframe with a name and a relative_position
  columns. If NULL, it considers a SuperNode above the graph roots with
  relative_position=0.
