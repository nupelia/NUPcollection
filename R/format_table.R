#' Format table
#'
#' @param data Species dataset
#' @param species_var The species variable name. Defaults to "especie"
#' @param sep Separator of measures. Defaults to " - "
#'
#' @export
format_table <- function(data, species_var = "especie", sep = " - ") {

data2 <- data %>%
  tidyr::pivot_longer(
    cols = 2:tidyr::last_col(),
    names_to = "measure",
    values_to = "values"
  ) %>%
  tidyr::separate(col = "values", into = c("min", "max"), sep = sep) %>%
  dplyr::mutate(min = as.double(min),
                max = as.double(max)) %>%
  dplyr::rename(species_var = 1)

return(data2)

}
