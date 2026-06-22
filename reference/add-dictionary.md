# Add a dictionary

**\[experimental\]**

A dictionary is used for the interpretation of Orphanet concepts, given
as ids. Copy the dictionary template then add it to the package after
modification.

Once added, the dictionary will appear among the available options
through the
[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md)
interface. It can also be manually set using the built-in
[`options()`](https://rdrr.io/r/base/options.html) function and the
`"nomenclature_version"` name.

## Usage

``` r
copy_dict_template(dest_path = ".")

add_dictionary(
  filepath,
  default = FALSE,
  destdir = tools::R_user_dir("RDaggregator", "data")
)
```

## Arguments

- dest_path:

  The destination path where the dictionary template should be copied.

- filepath:

  The location of the *.csv* file containing the labels in another
  language. A template of such a dictionary can be saved using
  `copy_dict_template`.

- default:

  If `TRUE`, set the added dictionary as default.

- destdir:

  The destination directory, in which the processed data will be saved.

## See also

[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md)
