#' @title Format table of CPUE into long format
#'
#' @description
#' This function takes a table of Catch Per Unit Effort (CPUE) with species as columns and formats it into long format
#'
#' @param data A data frame of CPUE with species as columns
#' @param first_sp_col The column number of the first species column
#'
#' @return A data frame in long format
#'
#' @export
#'
#' @examples
#' # Create a sample data frame
#' df <- data.frame(
#'   site = c("A", "B", "C", "D"),
#'   gear = c(1, 1, 1, 1),
#'   sp1 = c(2, 3, 5, 6),
#'   sp2 = c(1, 4, 2, 7),
#'   sp3 = c(4, 5, 1, 8))
#'
#' # Format the table of CPUE
#' format_table_cpue(df)
format_table_cpue <- function(data, first_sp_col = 3) {
  data2 <- data %>%
    tidyr::pivot_longer(
      cols = {{first_sp_col}}:tidyr::last_col(),
      names_to = "species",
      values_to = "cpue")

  return(data2)
}

