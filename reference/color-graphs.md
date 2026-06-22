# Color graphs

`color_codes` colors the given ORPHAcodes to emphasize them among the
others.

`color_classif_levels` colors all vertices of the given graph to
distinguish classification levels.

## Usage

``` r
color_codes(graph, orpha_codes)

color_class_levels(graph)
```

## Arguments

- graph:

  The graph to color.

- orpha_codes:

  The nodes to color.

## Value

The colored graph

## Examples

``` r
# Build graph
init_codes = c(303, 305)
graph = get_descendants(init_codes, output='graph')
plot(graph)


# Emphasize some specific ORPHAcodes
graph = color_codes(graph, init_codes)
plot(graph)


# Distinguish classification levels
graph = color_class_levels(graph)
plot(graph)
```
