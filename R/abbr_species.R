#' Abbreviate species
#'
#' @param data Species dataset
#' @param species_var Current species variable name. Defalts to "species"
#'
#' @export

abbr_species <- function(data, species_var = "species"){


  data2 <- data %>%
    dplyr::rename(species = .data[[species_var]]) %>%
    dplyr::mutate(species_draft = dplyr::case_when(stringr::str_detect(species, "sp\\.") == TRUE ~ species,
                                                   stringr::str_detect(species, "sp\\.") == FALSE ~
                                                     stringr::str_replace(species,
                                                                          "\\w+",
                                                                          paste0(stringr::str_extract(species, "\\w"),".")))) %>%
    dplyr::add_count(species_draft, name = "rep") %>%
    dplyr::mutate(species_draft = ifelse(rep > 1,
                                   stringr::str_replace(species,
                                                        "\\w+",
                                                        paste0(stringr::str_extract(species, "\\w{3}"),".")),
                                   species_draft),
                  species = species_draft) %>%
    dplyr::select(-c(rep,species_draft)) %>%
    dplyr::as_tibble()

  return(data2)

}
