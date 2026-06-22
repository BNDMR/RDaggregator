# Dynamic plot

This function uses `visNetwork` library for a better visualization of
larger graphs.

## Usage

``` r
interactive_plot(graph, layout_tree = FALSE)
```

## Arguments

- graph:

  The graph to visualize.

- layout_tree:

  If `TRUE`, use
  [`layout_tree()`](https://bndmr.github.io/RDaggregator/reference/layout_tree.md)
  to set initial nodes position.

## Examples

``` r
if (FALSE) { # \dontrun{
graph = get_descendants('68346', output='graph')
interactive_plot(graph)
} # }
```
