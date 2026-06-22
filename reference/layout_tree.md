# Plot using a tree-like layout

This layout function was specifically designed to display Orphanet
classifications. Indeed, it only contains from/to relationships, so the
latter must be oriented from top to bottom (or bottom to top if
`reverse_y` is `TRUE`).

The function was designed to be used with
[`plot.igraph()`](https://r.igraph.org/reference/plot.igraph.html)
(`layout` argument).

The associated vertical positions are obtained using
`vertical_positions`.

## Usage

``` r
layout_tree(graph, reverse_y = TRUE)

vertical_positions(graph)
```

## Arguments

- graph:

  The graph to display.

- reverse_y:

  If `TRUE`, display from top to bottom.

## Value

An adapted layout to plot nodes from Orpha classifications

## Examples

``` r
graph = get_ancestors('303', output='graph')

plot(graph)

plot(graph, layout=igraph::layout_as_tree)

plot(graph, layout=layout_tree)


df_y = vertical_positions(graph)
```
