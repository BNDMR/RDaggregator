% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/visualization.R
\name{horizontal_positions}
\alias{horizontal_positions}
\title{Calculate horizontal coordinates for each node of the given graph}
\usage{
horizontal_positions(graph, df_y, h_size, root_node = NULL)
}
\arguments{
\item{graph}{The graph from which nodes positions (x axis) will be calculated.}

\item{df_y}{Y coordinates which are useful to simplify the graph.}

\item{h_size}{Horizontal widths at each graph level are needed to compute X positions.}

\item{root_node}{\code{root_node} is the reference to calculate the X coordinates of
its children. It is a dataframe with a name and a relative_position columns. If NULL,
it considers a SuperNode above the graph roots with relative_position=0.}
}
\description{
Calculate horizontal coordinates for each node of the given graph
}
