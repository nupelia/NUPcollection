
<!-- README.md is generated from README.Rmd. Please edit that file -->

# NUPcollection <a href="https://nupelia.github.io/NUPcollection/"><img src="man/figures/logo.png" align="right" height="120" /></a>

<!-- badges: start -->
<!-- badges: end -->

The goal of NUPcollection is to …

## Installation

You can install the development version of NUPcollection from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("nupelia/NUPcollection")
```

## Use

### Function `abbr_species()`

This function is intended to abbreviate the genus in scientific names to
make them easier to read later. If the abbreviated names are identical
(like *A. lacustris* for *Acestrorhynchus lacustris* and *Astyanax
lacustris*, for example), the first 3 letters of the genus are used.

| species                   |
|:--------------------------|
| Acestrorhynchus lacustris |
| Aequidens plagiozonatus   |
| Ageneiosus inermis        |
| Ageneiosus ucayalensis    |
| Astyanax lacustris        |

The table presented above would look like this:

| species          |
|:-----------------|
| Ace. lacustris   |
| A. plagiozonatus |
| A. inermis       |
| A. ucayalensis   |
| Ast. lacustris   |
