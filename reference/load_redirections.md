# Redirections

Load for each obsolete or deprecated ORPHAcode the corresponding
association (*Moved to* or *Referred to*).

While `load_raw_redirections` keep the original id values for each
Orphanet concept, `load_redirections` translate them according to
`"RDaggregator_dict"` option, which can be set manually using built-in
[`options()`](https://rdrr.io/r/base/options.html) function or through
the
[`RDaggregator_options()`](https://bndmr.github.io/RDaggregator/reference/RDaggregator_options.md)
interface.

## Usage

``` r
load_redirections()

load_raw_redirections()
```

## Value

A data.frame object giving the deprecated or obsolete ORPHAcodes, the
corresponding associations with the association type

## See also

[`redirect_code()`](https://bndmr.github.io/RDaggregator/reference/redirect_code.md)

## Examples

``` r
df_redirections = load_raw_redirections()
df_redirections = load_redirections()
```
