#' Species compare
#'
#' @param data data
#' @param species_target species_target
#' @param measure_var measure_var
#'
#' @export
species_compare <- function(data, species_target, measure_var = "medidas") {

  data2 <- data %>%
    group_by(medidas) %>%
    mutate(species_target = species_target,
           min_target = ifelse(especie == species_target, min, NA),
           max_target = ifelse(especie == species_target, max, NA)) %>%
    arrange(min_target, .by_group = TRUE) %>%
    fill(min_target) %>%
    arrange(max_target, .by_group = TRUE) %>%
    fill(max_target) %>%
    mutate(sp_lower = ifelse(max <= min_target, TRUE, FALSE),
           sp_higher = ifelse(min >= max_target, TRUE, FALSE)) %>%
    filter(sp_lower == TRUE|sp_higher == TRUE)

  return(data2)

}
