.onLoad <- function(libname, pkgname) {
  default_dict()
  default_pack_version()
  default_genes_version()
  options(RDaggregator.connection = stdin())
  invisible()
}

