#' Abbreviate species
#'
#' @param data Species dataset
#' @param species_var Species variable name
#'
#' @importFrom dplyr %>%
#' @importFrom utils head
#'
#' @export

abbr_species <- function(data, species_var = "especie"){

  dados2 <- data %>%
    dplyr::mutate(species_draft = dplyr::case_when(stringr::str_detect(species_var, "sp.") == TRUE ~ species_var,
                                                   stringr::str_detect(species_var, "sp.") == FALSE ~
                                                     stringr::str_replace(species_var, "\\w+", paste0(stringr::str_extract(species_var, "\\w"),".")))) %>%
    dplyr::add_count(species_draft, name = "rep") %>%
    dplyr::mutate(species_var = ifelse(rep > 1,
                                   stringr::str_replace(species_var, "\\w+", paste0(stringr::str_extract(species_var, "\\w{3}"),".")),
                                   species_draft)) %>%
    dplyr::select(-c(rep,species_draft)) %>%
    dplyr::as_tibble()

  return(dados2)

}
