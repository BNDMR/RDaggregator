test_that("Load default versions", {
  expect_type(default_dict(), 'character')
  expect_false(default_dict() %>% is.na())
  expect_type(default_pack_version(), 'character')
  expect_false(default_pack_version() %>% is.na())
  expect_type(default_genes_version(), 'character')
  expect_false(default_genes_version() %>% is.na())
})

test_that("Change options", {
  option_dict = getOption('RDaggregator_dict')
  option_pack = getOption('RDaggregator_nomenclature')
  option_genes = getOption('RDaggregator_gene_file')

  f <- file()
  options(RDaggregator.connection = f)
  ans <- paste(c(
    "",
    "1", "",
    "1", "5",
    "1", "1",

    "2", "",
    "2", "5",
    "2", "1",

    "3", "",
    "3", "5",
    "3", "1",

    "4"
    ), collapse = "\n") # set this to the number of tests you want to run
  write(ans, f)

  expect_null(RDaggregator_options())
  expect_null(RDaggregator_options())
  expect_error(RDaggregator_options(), 'Invalid choice.')
  expect_message(RDaggregator_options(), 'option was set')

  expect_null(RDaggregator_options())
  expect_error(RDaggregator_options(), 'Invalid choice.')
  expect_message(RDaggregator_options(), 'option was set')

  expect_null(RDaggregator_options())
  expect_error(RDaggregator_options(), 'Invalid choice.')
  expect_message(RDaggregator_options(), 'option was set')

  expect_error(RDaggregator_options(), 'Invalid choice.')

  # reset options
  options(
    RDaggregator_dict = option_dict,
    RDaggregator_nomenclature = option_pack,
    RDaggregator_gene_file = option_genes,
    RDaggregator.connection = stdin()
    )

  # close the file
  close(f)
})


