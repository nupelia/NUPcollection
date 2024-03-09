#' Relatório de Espécies
#'
#' Cria uma lista de espécies pronta para o relatório, ordenada por ordem, família, gênero e espécie.
#'
#' @param dataset Um dataframe com as colunas "ordem", "familia", "genero" e "especie".
#'
#' @return Uma lista de espécies formatada para o relatório.
#'
#' @examples
#' dataset <- data.frame(
#'   ordem = c("Carnivora", "Carnivora", "Primates", "Primates"),
#'   familia = c("Felidae", "Canidae", "Hominidae", "Cebidae"),
#'   genero = c("Panthera", "Canis", "Homo", "Cebus"),
#'   especie = c("Panthera leo", "Canis familiaris", "Homo sapiens", "Cebus apella")
#' )
#' relatorio_especies(dataset)
#' @export


relatorio_especies <- function(dataset) {

  dataset2 <- dataset %>%
    dplyr::arrange(ordem, familia, genero, especie)

  for (i in unique(dataset2$ordem)) {
    cli::cli_text("{stringr::str_to_upper(i)}")
    teste2 <- dataset2 %>%
      dplyr::filter(ordem == i)
    for (i in unique(teste2$familia)) {
      cli::cli_text("\u00a0{i}")
      teste3 <- teste2 %>%
        dplyr::filter(familia == i)
      for (i in unique(teste3$genero)) {
        # cli::cli_text("\u00a0\u00a0{.emph i}")
        teste4 <- teste3 %>%
          dplyr::filter(genero == i)
        for (i in teste4$especie) {
          cli::cli_text("\u00a0\u00a0\u00a0{cli::style_italic(i)}")
        }
      }
    }
  }
}
