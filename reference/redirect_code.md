# Apply ORPHAcodes redirections.

An ORPHAcode is redirected to an active ORPHAcode when it becomes
deprecated or obsolete, respectively with a *moved to* (appropriate
redirection) or *referred to* (suggestion) association type.

There is no redirection when status is *"Inactive: Non rare disease in
Europe"*. Redirection is always provided for deprecated ORPHAcodes, but
not for obsolete ones.

## Usage

``` r
redirect_code(orpha_codes, deprecated_only = TRUE)
```

## Arguments

- orpha_codes:

  ORPHAcodes to redirect.

- deprecated_only:

  If `TRUE`, redirect only deprecated ORPHAcodes.

## Value

The redirected ORPHAcodes. If no redirection is found, ORPHAcodes remain
the same as given, so ORPHAcodes may remain inactive after redirection.

## See also

[`load_redirections()`](https://bndmr.github.io/RDaggregator/reference/load_redirections.md),
[`load_raw_redirections()`](https://bndmr.github.io/RDaggregator/reference/load_redirections.md)

## Examples

``` r
orpha_codes = c(303, 166068, 166457)
redirect_code(orpha_codes)
#> [1] "303"    "166063" "166457"
redirect_code(orpha_codes, deprecated_only=FALSE)
#> [1] "303"    "166063" "97275" 
```
