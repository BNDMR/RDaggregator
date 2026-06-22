# Merge graphs

**\[questioning\]**

Convert a list of graphs into a single merged graph

## Usage

``` r
merge_graphs(graphs_list)
```

## Arguments

- graphs_list:

  The graphs to merge.

## Value

The merged graph

## Examples

``` r
code = '303'
graph_descendants = get_descendants(code, output='graph')
graph_ancestors = get_ancestors(code, output='graph')

merged_graph = merge_graphs(list(graph_descendants, graph_ancestors))
```
