# Operations on graphs

Orphanet classification system can be depicted by oriented graphs as it
is a wide list of parent/child relationships.

The `igraph` package provides useful tools for graphs analysis that we
can use for the study of rare diseases.

The roots are the ORPHAcodes without any parent, like the heads of
classification. The leaves are the ORPHAcodes without any children. They
are usually disorders or subtypes of disorders (see
[`get_classification_level()`](https://bndmr.github.io/RDaggregator/reference/orphacode-properties.md)).

## Usage

``` r
find_roots(graph)

find_leaves(graph)
```

## Arguments

- graph:

  An igraph object.

## Value

The extreme nodes of a graph.

## Examples

``` r
graph = get_ancestors('303', output='graph')

roots = find_roots(graph)
leaves = find_leaves(graph)
```
