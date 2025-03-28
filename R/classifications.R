#' Orphanet classifications
#'
#' @description
#' The functions presented below analyze relationships between ORPHAcodes and returns
#' results in a convenient format for further analysis or display.
#'
#' @details
#' Orphanet organized its classification system around 34 different hierarchies,
#' which are not completely distinct.
#'
#' For each hierarchy is listed a set of from/to relationships between ORPHAcodes.
#' A child is always more specific than its parent.
#'
#' `load_classifications`
#' Mind using `bind_rows` followed by `distinct` to merge all classification.
#'
#' The classification system will change according to the chosen `"RDaggregator_nomenclature"`
#' option, that you can set via the [RDaggregator_options()] interface. Add a new available option
#' with [add_nomenclature_pack()].
#'
#' @seealso [add_nomenclature_pack()], [RDaggregator_options()]
#' @examples
#' library(dplyr)
#'
#' all_classif = load_classifications()
#' df_all_classif = load_classifications() %>% bind_rows() %>% distinct()
#'
#' is_in_classif(303, all_classif[[1]])
#' is_in_classif(303, all_classif[[6]])
#'
#' @name classifications
NULL

#' @rdname classifications
#' @return All classifications as a list of data.frame
#' @export
load_classifications = function()
{
    v = getOption('RDaggregator_nomenclature', default_pack_version())
  nomenclature_path = get_pack_versions() %>% filter(version==v) %>% pull(location)

  #internal pack_data is silently loaded
  if(file.exists(nomenclature_path))
    load(nomenclature_path) # Load other pack_data
  else if(nomenclature_path != 'internal')
    stop(simpleError(
    'Loading of classifications failed. Internal files might be broken.
    See `RDaggregator_options`, `add_nomenclature_pack` or consider reisntalling RDaggregator package.'))

  return(pack_data$classifications)
}

#' @rdname classifications
#' @export
load_all_classifications = function(){
  return(load_classifications() %>% bind_rows() %>% distinct())
}


#' @rdname classifications
#' @param orpha_code An ORPHAcode.
#' @param df_classif A from/to data.frame providing relationships between ORPHAcodes.
#'
#' @return
#' Returns TRUE if a given ORPHAcode belongs to a given classification, FALSE else.
#' @export
is_in_classif = function(orpha_code, df_classif)
{
  all_codes = unique(c(df_classif$from, df_classif$to)) %>% as.character()
  return(orpha_code %in% all_codes)
}


#' Analyze ORPHA classifications
#'
#' @description
#' The Orphanet classification system can be seen as a wide genealogy tree, that's why
#' the following terms will refer to this field.
#'
#' There two classes of functions:
#'
#' - Functions applied to a single ORPHAcode:
#'   - `get_parents`
#'   - `get_children`
#'   - `get_ancestors`
#'   - `get_descendants`
#'   - `get_siblings`
#'
#' - Functions applied to a set of ORPHAcodes:
#'   - `get_ancestors`
#'   - `get_descendants`
#'   - `complete_family`
#'   - `get_LCAs`
#'
#' When you don't want to analyze to whole Orphanet classification system, `df_classif` should be set.
#'
#' When only ORPHAcodes are needed, without the edges information, set `output='codes_only'`.
#' Alternatively, if you wish to analyze or visualize ORPHAcodes interactions,
#' set `output='edgelist'` or `output='graph'`.
#'
#' @param orpha_code The ORPHAcode to start from.
#' @param orpha_codes A vector of ORPHAcodes used to perform operations.
#' @param output A value specifying the output format. Should be in `c("codes_only", "edgelist", "graph")`.
#' @param max_depth The maximum reached depth starting from the given ORPHAcode.
#' @param df_classif The classification data to consider. If NULL, load the whole Orphanet classification.
#'
#' @return
#' Results are returned in the format specified in `output` argument :
#' `'codes_only'`, `'edgelist'`, `'graph'`.
#'
#' @importFrom dplyr filter pull bind_rows distinct arrange first
#' @importFrom igraph graph_from_data_frame as_data_frame all_simple_paths induced_subgraph V
#' @importFrom stats na.omit
#' @importFrom purrr keep is_empty
#' @importFrom stringr str_equal
#' @importFrom rlang arg_match
#'
#' @examples
#' library(dplyr)
#' all_classif = load_classifications()
#' orpha_codes = c('303', '305', '595356')
#' orpha_code = '303'
#'
#' # ---
#' # Ancestors
#' ancestors = get_ancestors(orpha_code)
#' ancestors_edges = get_ancestors(orpha_code, output='edgelist')
#' ancestors_graph = get_ancestors(orpha_code, output='graph')
#'
#' # Get parents only
#' parents = get_ancestors(orpha_code, max_depth=1)
#' parents = get_parents(orpha_code)
#'
#' # Select a specific classification tree
#' classif1 = all_classif[['ORPHAclassification_156_rare_genetic_diseases_fr']]
#' ancestors = get_ancestors(orpha_code, df_classif=classif1)
#'
#' classif2 = all_classif[['ORPHAclassification_146_rare_cardiac_diseases_fr']]
#' ancestors = get_ancestors(orpha_code, df_classif=classif2)
#'
#' # ---
#' # Descendants
#' descendants_codes = get_descendants(orpha_code)
#' decendants_edges = get_descendants(orpha_code, output='edgelist')
#' descendants_graph = get_descendants(orpha_code, output='graph')
#'
#' # Get children only
#' children = get_descendants(orpha_code, max_depth=1)
#' children = get_children(orpha_code)
#'
#' # ---
#' # Siblings
#' siblings = get_siblings(orpha_code)
#' siblings_edges = get_siblings(orpha_code, output='edgelist')
#' siblings_graph = get_siblings(orpha_code, output='graph')
#'
#' # ---
#' # Lowest common ancestors
#' lcas = get_LCAs(orpha_codes)
#'
#' classif = all_classif[['ORPHAclassification_187_rare_skin_diseases_fr']]
#' lcas = get_LCAs(orpha_codes, df_classif = classif)
#'
#' # ---
#' # Complete family
#' family_codes = complete_family(orpha_codes)
#' family_codes = complete_family(orpha_codes, df_classif=all_classif[[1]])
#' family_codes = complete_family(orpha_codes, max_depth=2)
#' family_edges = complete_family(orpha_codes, output = 'edgelist')
#' family_graph = complete_family(orpha_codes, output='graph')
#'
#' @name analyze-genealogy
NULL

#' @rdname analyze-genealogy
#' @export
get_parents = function(orpha_code, output=c('codes_only', 'edgelist', 'graph'), df_classif=NULL){
  output = arg_match(output)

  # Use specified classification or all of them if NULL was given
  if(is.null(df_classif))
    df_classif = load_classifications() %>% bind_rows() %>% distinct()

  # Check if the code belongs to the given classification
  if(!is_in_classif(orpha_code, df_classif)){
    warning('The given ORPHAcode does not belong to the classification.')
    return(NULL)
  }

  # Search parents
  df_parents = df_classif %>% filter(to == orpha_code)
  parents = df_parents %>% pull(from) %>% unique()

  # Return results in the specified format
  if(output == 'edgelist')
    return(df_parents)
  else if(output == 'graph')
    return(graph_from_data_frame(df_parents))
  else if(output == 'codes_only')
    if(length(parents) == 0)
      return(NULL)
    else
      return(parents)
  else{
    warning('No valid output format was given. `output` value should be in `c("codes_only", "edgelist", "graph")`')
    return(NULL)
  }
}


#' @rdname analyze-genealogy
#' @export
get_children = function(orpha_code, output=c('codes_only', 'edgelist', 'graph'), df_classif=NULL){
  output = arg_match(output)

  # Use specified classification or all of them if NULL was given
  if(is.null(df_classif))
    df_classif = load_classifications() %>% bind_rows() %>% distinct()

  # Check if the code belongs to the given classification
  if(!is_in_classif(orpha_code, df_classif)){
    warning('The given ORPHAcode does not belong to the classification.')
    return(NULL)
  }

  # Search children
  df_children = df_classif %>% filter(from == orpha_code)
  children = df_children %>% pull(to) %>% unique()

  # Return results in the specified format
  if(output == 'edgelist')
    return(df_children)
  else if(output == 'graph')
    return(graph_from_data_frame(df_children))
  else if(output == 'codes_only')
    if(length(children) == 0)
      return(NULL)
    else
      return(children)
  else{
    warning('No valid output format was given. `output` value should be in `c("codes_only", "edgelist", "graph")`')
    return(NULL)
  }
}


#' @rdname analyze-genealogy
#' @export
get_ancestors = function(orpha_codes, output=c('codes_only', 'edgelist', 'graph'), max_depth=NULL, df_classif=NULL)
{
  output = arg_match(output)

  if(!is.null(max_depth) && max_depth < 1)
    stop(simpleError('`max_depth` argument must be NULL or greater than 0.'))

  orpha_codes = as.character(orpha_codes)
  # Use specified classification or all of them if NULL was given
  if(is.null(df_classif))
    df_classif = load_classifications() %>% bind_rows() %>% distinct()

  graph_classif = graph_from_data_frame(df_classif)

  # Check if the codes belong to the given classification
  belonging = sapply(orpha_codes, is_in_classif, df_classif)
  if(any(!belonging)){
    missing_codes = orpha_codes[!belonging]
    missing_codes_str = paste0(missing_codes, collapse=', ')
    warning(sprintf('The following ORPHAcodes do not belong to the classification : %s.', missing_codes))
    orpha_codes = setdiff(orpha_codes, missing_codes)
  }

  # Find all paths from the given ORPHAcode and extract elements
  roots = find_roots(graph_classif)
  ancest_paths = roots %>%
    lapply(function(root){all_simple_paths(graph_classif, from=root, to=intersect(orpha_codes, names(V(graph_classif))))}) %>%
    unlist(recursive=FALSE)

  if(!is.null(max_depth))
    ancest_paths = ancest_paths%>%
      lapply(\(x) rev(x)[2:min((max_depth+1), length(x))] %>% na.omit() %>% rev())

  ancestors = ancest_paths %>% unlist() %>% names() %>% unique()

  if(is.null(max_depth))
      ancestors = setdiff(ancestors, orpha_codes)

  # Build graph
  graph_ancestors = induced_subgraph(graph_classif, unique(c(orpha_codes, ancestors)))

  # Return results in the specified format
  if(output=='graph')
    return(graph_ancestors)
  else if(output=='edgelist')
    return(as_data_frame(graph_ancestors, what = 'edges'))
  else if(output=='codes_only')
    if(length(ancestors) == 0)
      return(NULL)
    else
      return(ancestors)
  else
    return(NULL)
}


#' @rdname analyze-genealogy
#' @export
get_descendants = function(orpha_codes, output=c('codes_only', 'edgelist', 'graph'), max_depth=NULL, df_classif=NULL){
  output = arg_match(output)
  orpha_codes = as.character(orpha_codes)

  if(!is.null(max_depth) && max_depth < 1)
    stop(simpleError('`max_depth` argument must be NULL or greater than 0.'))

  # Use specified classification or all of them if NULL was given
  if(is.null(df_classif))
    df_classif = load_classifications() %>% bind_rows() %>% distinct()

  # Check if the codes belong to the given classification
  belonging = sapply(orpha_codes, is_in_classif, df_classif)
  if(any(!belonging)){
    missing_codes = orpha_codes[!belonging]
    missing_codes_str = paste0(missing_codes, collapse=', ')
    warning(sprintf('The following ORPHAcodes do not belong to the classification : %s.', missing_codes))
    orpha_codes = setdiff(orpha_codes, missing_codes)
  }

  graph_classif = graph_from_data_frame(df_classif)
  df_remaining = graph_classif %>%
    vertical_positions() %>%
    filter(name %in% orpha_codes) %>%
    arrange(y)

  # Find all paths from the given ORPHAcode and extract elements
  descendants = NULL
  while(nrow(df_remaining)){
    orpha_code = first(df_remaining$name)
    desc_paths = all_simple_paths(graph_classif, from=orpha_code)

    if(!is.null(max_depth))
      desc_paths = desc_paths %>%
        lapply(\(x) x[2:min((max_depth+1), length(x))] %>% na.omit())

    new_descendants = desc_paths %>% unlist() %>% names() %>% unique()

    if(is.null(max_depth))
      new_descendants = setdiff(new_descendants, orpha_codes)

    descendants = unique(c(descendants, new_descendants))
    df_remaining = df_remaining %>% filter(!name %in% c(orpha_code, new_descendants))
  }

  # Build graph
  graph_descendants = induced_subgraph(graph_classif, unique(c(orpha_codes, descendants)))

  # Return results in the specified format
  if(output == 'graph')
    return(graph_descendants)
  else if(output == 'edgelist')
    return(as_data_frame(graph_descendants, what='edges'))
  else if(output == 'codes_only')
    if(length(descendants) == 0)
      return(NULL)
    else
      return(descendants)
  else
    return(NULL)
}


#' @rdname analyze-genealogy
#' @export
get_siblings = function(orpha_code, output=c('codes_only', 'edgelist', 'graph'), df_classif=NULL)
{
  output = arg_match(output)
  if(is.null(df_classif))
    df_classif = load_classifications() %>% bind_rows() %>% distinct()

  # Find parents
  parents = get_parents(orpha_code, df_classif, output='codes_only')

  # Find the children of parents (=siblings)
  df_siblings = df_classif %>% filter(from %in% parents, to != orpha_code)
  siblings = setdiff(unique(df_siblings$to), orpha_code)

  # Return results in the specified format
  if(output == 'edgelist')
    return(df_siblings)
  else if(output == 'graph')
    return(graph_from_data_frame(df_siblings))
  else if(output == 'codes_only'){
    if(length(siblings) == 0)
      return(NULL)
    else
      return(siblings)
  }
  else{
    warning('No valid output format was given. `output` value should be in `c("codes_only", "edgelist", "graph")`')
    return(NULL)
  }
}


#' @rdname analyze-genealogy
#' @export
complete_family = function(orpha_codes, output=c('codes_only', 'edgelist', 'graph'), df_classif=NULL, max_depth=1)
{
  output = arg_match(output)

  if(is.null(df_classif))
    df_classif = load_classifications() %>% bind_rows() %>% distinct()

  # Build graph from the found ancestors
  if(max_depth == 0)
    ancestors=NULL
  else if(max_depth == 1)
    ancestors = df_classif %>% filter(to %in% orpha_codes) %>% pull(from) %>% unique()
  else
    ancestors = get_ancestors(orpha_codes, df_classif = df_classif, max_depth=max_depth)

  new_orpha_codes = unique(c(orpha_codes, ancestors))
  graph_family = get_descendants(new_orpha_codes, output='graph', df_classif=df_classif)

  # Return results in the expected format
  if(is.null(graph_family))
    return(NULL)
  else if(output == 'codes_only')
    return(V(graph_family) %>% names())
  else if(output == 'edgelist')
    return(as_data_frame(graph_family, what='edges'))
  else if(output == 'graph')
    return(graph_family)
  else
    return(NULL)
}


#' @rdname analyze-genealogy
#' @export
get_LCAs = function(orpha_codes, df_classif=NULL)
{
  get_paths_LCA = function(pathsPair)
  {
    pathsPair = lapply(pathsPair, unlist) %>% unname()
    inter = Reduce(intersect, pathsPair) # Find all common nodes (ancestors) for both paths
    index = max(match(inter, pathsPair[[1]]), na.rm=TRUE) # Find the LCA among the common ancestors
    if(is.na(index))
      return(NULL)
    else
      return(pathsPair[[1]][index])
  }

  if(is.null(df_classif))
    df_classif = load_classifications() %>% bind_rows() %>% distinct()

  graph = merge_graphs(list(
    get_ancestors(orpha_codes, output='graph', df_classif=df_classif),
    get_descendants(orpha_codes, output='graph', df_classif=df_classif)
  )) %>% add_superNode()

  # Find all paths going from the root to the codes in the given list
  all_paths = orpha_codes %>%
    as.character() %>%
    lapply(function(current_child) all_simple_paths(graph, from='SuperNode', to=current_child) %>%
                                      lapply(function(path) path %>% names()))

  # Find all possible pairs for the calculated paths
  combs = expand.grid(all_paths)

  # Find potential LCAs by computing the apparent LCA for each pair of paths
  LCAs = apply(combs, 1, get_paths_LCA) %>% unique()
  LCAs_combs = expand.grid(LCAs, LCAs)

  # Remove common ancestors which are not LCAs
  to_rem = LCAs_combs %>%
    # Try to find a path between two ancestors
    apply(1, function(x) all_simple_paths(graph, x[1], x[2])) %>%

    # If a path is found, parent is discarded
    keep(function(path) length(path) > 0) %>%

    # Clean results
    sapply(function(path) path[[1]][1]) %>% names %>% unique()

  # Remove ancestors to be discarded to keep LCAs only
  LCAs = setdiff(LCAs, c(to_rem, 'SuperNode'))
  return(LCAs)
}


#' Find specific ancestors
#'
#' @description
#' These functions helps you to find key ORPHAcodes which are located above the given ORPHAcode
#' in the classification system.
#'
#' @param orpha_code A vector of ORPHAcodes.
#' @param df_classif The classification to consider. If NULL, loads the whole Orphanet classification.
#'
#' @return
#' `subtype_to_disorder` returns the associated disorder, or the ORPHAcode itself if it
#' is already a disorder, or NULL if it is a group of disorders.
#' If a vector of ORPHAcodes is provided, function is applied on each element,
#' and the associated vector is returned.
#'
#' `get_lowest_groups` returns the closest groups from the given ORPHAcode,
#' or the ORPHAcode itself if it is a group of disorders already.
#'
#' @importFrom dplyr bind_rows distinct filter pull left_join semi_join
#' @importFrom igraph graph_from_data_frame
#' @importFrom purrr keep
#'
#' @examples
#' subtype_to_disorder(orpha_code = '158676')
#' # ORPHA:158676 is a subtype of disorder
#'
#' subtype_to_disorder(orpha_code = '303')
#' # ORPHA:303 is a group of disorder
#'
#' get_lowest_groups(orpha_code = '158676')
#'
#' @name upper-classification-levels

#' @rdname upper-classification-levels
#' @export
subtype_to_disorder = function(orpha_code, df_classif=NULL)
{
  if(is.null(df_classif))
    df_classif = load_classifications() %>% bind_rows() %>% distinct()

  df_nomenclature = load_raw_nomenclature()

  # If several ORPHAcodes are given, apply function on each element
  if(length(orpha_code) > 1)
    return(sapply(orpha_code, subtype_to_disorder, df_classif, USE.NAMES = F))

  # Find ancestors of the subtype code
  ancestors = get_ancestors(orpha_code, output='codes_only', df_classif=df_classif)

  # Find the disorder among ancestors (there should be only one)
  disorder_code = df_nomenclature %>%
    filter(orpha_code %in% ancestors,
           level == 36547) %>%
    pull(orpha_code)

  return(disorder_code)
}


#' @rdname upper-classification-levels
#' @export
get_lowest_groups = function(orpha_code, df_classif=NULL)
{
  if(is.null(df_classif))
    df_classif = load_classifications() %>% bind_rows() %>% distinct()

  df_nomenclature = load_raw_nomenclature()

  if(length(orpha_code) > 1)
    stop(simpleError('`get_lowest_groups` accepts only single ORPHAcode as an input.'))

  # Check if it isn't a group already
  classLevel = df_nomenclature %>% filter(orpha_code == .env$orpha_code) %>% pull(level)
  if(classLevel == '36540')
    return(orpha_code)

  # Find groups of disorders containing the given ORPHAcode
  ancestors = get_ancestors(orpha_code, output='codes_only', df_classif=df_classif)
  df_ancestors = get_ancestors(orpha_code, output='edgelist', df_classif=df_classif)
  df_groups = data.frame(orpha_code=ancestors) %>%
    left_join(df_nomenclature, by='orpha_code') %>%
    filter(level == '36540')

  # Get the lowest
  lowest_groups = df_ancestors %>%
    semi_join(df_groups, by=c('to'='orpha_code')) %>%
    graph_from_data_frame() %>%
    find_leaves()

  return(lowest_groups)
}

#' Extract a graph from a set of ORPHAcodes
#'
#' @description
#' The extracted graph contains all the ORPHAcodes specified in the `vs` argument.
#' It may include other ORPHAcodes inside, but all the roots and leaves are part of `vs`.
#'
#' @param vs A set of ORPHAcodes used to extract the graph.
#' @param df_classif The classification to consider. If NULL, loads the whole Orphanet classification.
#'
#' @importFrom igraph intersection
#'
#' @return
#' The extracted graph as an _igraph_ object.
#'
#' @export
in_between_graph = function(vs, df_classif=NULL){
  Ga = get_ancestors(vs, output='graph', df_classif=df_classif)
  Gd = get_descendants(vs, output='graph', df_classif=df_classif)
  G = intersection(Ga, Gd, keep.all.vertices=FALSE)

  return(G)
}


#' Merge graphs
#'
#' @description
#' `r lifecycle::badge('questioning')`
#'
#' Convert a list of graphs into a single merged graph
#'
#' @param graphs_list The graphs to merge.
#'
#' @return The merged graph
#' @importFrom igraph as_data_frame graph_from_data_frame
#' @importFrom dplyr bind_rows distinct group_by summarize
#'
#' @export
#' @examples
#' code = '303'
#' graph_descendants = get_descendants(code, output='graph')
#' graph_ancestors = get_ancestors(code, output='graph')
#'
#' merged_graph = merge_graphs(list(graph_descendants, graph_ancestors))
merge_graphs = function(graphs_list)
{
  graphs_list = graphs_list[!sapply(graphs_list, is.null)]

  if(!is_empty(graphs_list))
    {
    # Merge nodes
    df_nodes = graphs_list %>%
      lapply(function(graph) as_data_frame(graph, what='vertices')) %>%
      bind_rows() %>%
      distinct()

    # Merge edges
    df_edges = graphs_list %>%
      lapply(function(graph) as_data_frame(graph, what='edges')) %>%
      bind_rows() %>%
      distinct(from, to)

    # Merge graphs
    merged_graph = graph_from_data_frame(df_edges, vertices=df_nodes)
    return(merged_graph)
  }
}


#' Add an extra node above the roots of the graph
#'
#' @param graph The graph to which the extra node should be added.
#'
#' @return The new graph with the added node
#' @importFrom igraph add_vertices add_edges
add_superNode = function(graph)
{
  roots = find_roots(graph)
  graph = graph %>% add_vertices(1, name='SuperNode')

  for(root in roots)
    graph = graph %>% add_edges(c('SuperNode', root))

  return(graph)
}


#' Operations on graphs
#'
#' @description
#' Orphanet classification system can be depicted by oriented graphs as it is a wide list of
#' parent/child relationships.
#'
#' The `igraph` package provides useful tools for graphs analysis that we can use for the
#' study of rare diseases.
#'
#' The roots are the ORPHAcodes without any parent,
#' like the heads of classification. The leaves are the ORPHAcodes without any children.
#' They are usually disorders or subtypes of disorders (see [get_classification_level()]).
#'
#' @param graph An igraph object.
#'
#' @importFrom igraph degree
#'
#' @return The extrem nodes of a graph.
#'
#' @examples
#' graph = get_ancestors('303', output='graph')
#'
#' roots = find_roots(graph)
#' leaves = find_leaves(graph)
#'
#' @name graph-operations
NULL

#' @rdname graph-operations
#' @export
find_roots = function(graph)
{
  # Roots are the only nodes having no arcs going in
  D = degree(graph, mode='in')
  D = D[D==0]
  roots = names(D)
  return(roots)
}


#' @rdname graph-operations
#' @export
find_leaves = function(graph)
{
  # Leaves are the only nodes having no arcs going out
  d = degree(graph, mode='out')
  d = d[d==0]
  leaves = names(d)

  return(leaves)
}
