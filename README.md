
<!-- README.md is generated from README.Rmd. Please edit that file -->

# NUPcollection <a href="https://nupelia.github.io/NUPcollection/"><img src="man/figures/logo.png" align="right" height="120"/></a>

<!-- badges: start -->
<!-- badges: end -->

The goal of NUPcollection is to make the comparison of morphometric data
faster and more accurate, helping taxonomists compare species.

It was created by the students of Nupélia’s Ichthyology Collection
(NUP).

## Installation

You can install the development version of NUPcollection from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("nupelia/NUPcollection")
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

### Function `format_table()`

This function is an auxiliary tool to transform the table usually
created by taxonomists into a format that the `species_compare()`
function uses.

**R uses `.` as decimal mark, so you have to change it on your table
before importing it.**

For this function, we can use the pre-installed example table from this
package, the `sp_example_data`

``` r
sp_example_data
#> # A tibble: 6 x 6
#>   specie `body depth` `head length` `orbit diameter` interorbital predorsal di~1
#>   <chr>  <chr>        <chr>         <chr>            <chr>        <chr>         
#> 1 sp1    36.6 - 41.8  21.3 - 23.6   32.6 - 38.3      34.5 - 38.3  47.3 - 51.5   
#> 2 sp2    36.5 - 45.4  23.7 - 26.2   34.1 - 38.8      34.8 - 37.8  47.7 - 51.2   
#> 3 sp3    38.2 - 44.7  23.7 - 26.3   32.9 - 37.2      37.9 - 44.5  51.3 - 54.7   
#> 4 sp4    34.1 - 37.9  21.2 - 24.9   28.7 - 31.8      33.2 - 36.7  48.7 - 52.1   
#> 5 sp5    28.3 - 33.4  24.3 - 27.1   33.4 - 36.8      31.7 - 33.1  52.2 - 55.8   
#> 6 sp6    34.8 - 37.9  25.1 - 28.9   33.2 - 37.1      35.5 - 37.8  51.7 - 56.9   
#> # ... with abbreviated variable name 1: `predorsal distance`
```

``` r
table1 <- format_table(sp_example_data)

#formatted table
table1
#> # A tibble: 30 x 4
#>    especie medidas              min   max
#>    <chr>   <chr>              <dbl> <dbl>
#>  1 sp1     body depth          36.6  41.8
#>  2 sp1     head length         21.3  23.6
#>  3 sp1     orbit diameter      32.6  38.3
#>  4 sp1     interorbital        34.5  38.3
#>  5 sp1     predorsal distance  47.3  51.5
#>  6 sp2     body depth          36.5  45.4
#>  7 sp2     head length         23.7  26.2
#>  8 sp2     orbit diameter      34.1  38.8
#>  9 sp2     interorbital        34.8  37.8
#> 10 sp2     predorsal distance  47.7  51.2
#> # ... with 20 more rows
```

### Function `species_compare()`

The `species_compare()` function is used to analyze morphometric data
between different populations by checking for **overlap** in the data.
This function analyzes the values obtained for a particular measure and
compares them with the same measures from other populations, and returns
only the data that do not overlap, together with the name of the
measure, the range of variation of the values, and the population from
which it differs.

This function requires a specially formatted data table, which can be
obtained with the `format_table()` function.

When using this function, it has the following arguments:

- `data`: The dataset to be used in this function.

- `species_target`: The target species to compare.

- `species_var`: The species variable name. Defaults to “especie”.

- `measure_var`: The measure variable name. Defaults to “medidas”.

The returning dataset adds the following variables:

- `species_target`: The target species being compared.

- `min_target`: The minimum value of the **target species**.

- `max_target`: The maximum value of the **target species**.

- `sp_lower`: Is the **species (in the 1st column) value**, lower than
  the **target species**? Returns TRUE or FALSE.

- `sp_higher`: Is the **species (in the 1st column) value**, higher than
  the **target species**? Returns TRUE or FALSE.

``` r
table1 %>% 
  species_compare(species_target = "sp1")
#> # A tibble: 9 x 9
#>   especie medidas              min   max speci~1 min_t~2 max_t~3 sp_lo~4 sp_hi~5
#>   <chr>   <chr>              <dbl> <dbl> <chr>     <dbl>   <dbl> <lgl>   <lgl>  
#> 1 sp5     body depth          28.3  33.4 sp1        36.6    41.8 TRUE    FALSE  
#> 2 sp2     head length         23.7  26.2 sp1        21.3    23.6 FALSE   TRUE   
#> 3 sp3     head length         23.7  26.3 sp1        21.3    23.6 FALSE   TRUE   
#> 4 sp5     head length         24.3  27.1 sp1        21.3    23.6 FALSE   TRUE   
#> 5 sp6     head length         25.1  28.9 sp1        21.3    23.6 FALSE   TRUE   
#> 6 sp5     interorbital        31.7  33.1 sp1        34.5    38.3 TRUE    FALSE  
#> 7 sp4     orbit diameter      28.7  31.8 sp1        32.6    38.3 TRUE    FALSE  
#> 8 sp5     predorsal distance  52.2  55.8 sp1        47.3    51.5 FALSE   TRUE   
#> 9 sp6     predorsal distance  51.7  56.9 sp1        47.3    51.5 FALSE   TRUE   
#> # ... with abbreviated variable names 1: species_target, 2: min_target,
#> #   3: max_target, 4: sp_lower, 5: sp_higher
```

This function aims to provide in a simpler way the visual result found
when plotting the data as in the following figure (using different
data). With this function we can compare several measurements at the
same time, without the risk of visual errors.

![Example figure for
comparison](man/figures/fig_species_compare_withoutsp.jpg)

# MGMS functions

## Function `format_table_cpue()`

The format_table_cpue function is designed to take in a data frame, and
reformat it into a long format. The function uses the pivot_longer
function from the `tidyr` package to reshape the data. The function
takes in two arguments:

- `data`: The data frame that needs to be reformatted.

- `first_sp_col`: The first column of the species column, which will be
  used to reshape the data. This argument has a default value of **3**.

The function returns a data frame in long format, with columns for
`site`, `species` and `cpue.`

``` r
df <- data.frame(
  site = c("A", "B", "C", "D"),
  gear = c(1, 1, 1, 1),
  sp1 = c(2, 3, 5, 6),
  sp2 = c(1, 4, 2, 7),
  sp3 = c(4, 5, 1, 8))

# View the expected dataframe
df
#>   site gear sp1 sp2 sp3
#> 1    A    1   2   1   4
#> 2    B    1   3   4   5
#> 3    C    1   5   2   1
#> 4    D    1   6   7   8
```

``` r
# Format the table of CPUE
df2 <- format_table_cpue(df, first_sp_col = 3)

df2
#> # A tibble: 12 x 4
#>    site   gear species  cpue
#>    <chr> <dbl> <chr>   <dbl>
#>  1 A         1 sp1         2
#>  2 A         1 sp2         1
#>  3 A         1 sp3         4
#>  4 B         1 sp1         3
#>  5 B         1 sp2         4
#>  6 B         1 sp3         5
#>  7 C         1 sp1         5
#>  8 C         1 sp2         2
#>  9 C         1 sp3         1
#> 10 D         1 sp1         6
#> 11 D         1 sp2         7
#> 12 D         1 sp3         8
```

## Function `add_mgms()`

The add_mgms function is designed to take in a data frame, and add a
Multigear Mean Standardization (MGMS) column to it. The function uses
the group_by, mutate, ungroup, and select functions from the dplyr
package to perform the calculations and reshape the data. The function
takes in three arguments:

- `data`: The data frame that needs to be modified.

- `site_var`: The name of the column in data that contains the site
  information. This argument has a default value of “site”.

- `cpue_var`: The name of the column in data that contains the Catch Per
  Unit Effort (CPUE) information. This argument has a default value of
  “cpue”.

The function returns the original dataframe with an additional column
‘mgms’ containing the result of MGMS calculations.

``` r
add_mgms(df2, site_var = "site", cpue_var = "cpue")
#> # A tibble: 12 x 5
#>    site   gear species  cpue   mgms
#>    <chr> <dbl> <chr>   <dbl>  <dbl>
#>  1 A         1 sp1         2 0.167 
#>  2 A         1 sp2         1 0.0833
#>  3 A         1 sp3         4 0.333 
#>  4 B         1 sp1         3 0.25  
#>  5 B         1 sp2         4 0.333 
#>  6 B         1 sp3         5 0.417 
#>  7 C         1 sp1         5 0.417 
#>  8 C         1 sp2         2 0.167 
#>  9 C         1 sp3         1 0.0833
#> 10 D         1 sp1         6 0.5   
#> 11 D         1 sp2         7 0.583 
#> 12 D         1 sp3         8 0.667
```
