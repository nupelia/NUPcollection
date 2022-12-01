#' Species compare
#'
#' @param data data
#' @param species_target species_target
#' @param measure_var measure_var
#'
#' @export
species_compare <- function(data, species_target, measure_var = "medidas") {

  data2 <- data %>%
    dplyr::group_by_at(measure_var) %>%
    dplyr::mutate(species_target = species_target,
           min_target = ifelse(especie == species_target, min, NA),
           max_target = ifelse(especie == species_target, max, NA)) %>%
    dplyr::arrange(min_target, .by_group = TRUE) %>%
    tidyr::fill(min_target) %>%
    dplyr::arrange(max_target, .by_group = TRUE) %>%
    tidyr::fill(max_target) %>%
    dplyr::mutate(sp_lower = ifelse(max <= min_target, TRUE, FALSE),
           sp_higher = ifelse(min >= max_target, TRUE, FALSE)) %>%
    dplyr::filter(sp_lower == TRUE|sp_higher == TRUE) %>%
    dplyr::ungroup()

  return(data2)

}
