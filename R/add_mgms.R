#' @title Add MGMS to a dataframe
#'
#' @description
#' This function adds a Multigear Mean Standardization (MGMS) column to a dataframe
#'
#' @param data A dataframe
#' @param site_var The name of the column in \code{data} that contains the site information
#' @param cpue_var The name of the column in \code{data} that contains the Catch Per Unit Effort (CPUE) information
#'
#' @return A dataframe with an additional column containing the MGMS
#'
#' @export
#'
#' @examples
#' data <- data.frame(site = c("A", "A", "B", "B"),
#'                    cpue = c(5, 10, 15, 20))
#' add_mgms(data)
add_mgms <- function(data, site_var = "site", cpue_var = "cpue") {

  data2 <- data %>%
    group_by(across(.cols = {{site_var}})) %>%
    mutate(sum_cpue = sum(across(.cols = {{cpue_var}}))) %>%
    ungroup() %>%
    mutate(mean_sum_cpue = mean(sum_cpue),
           mgms = .data[[cpue_var]]/mean_sum_cpue) %>%
    select(-c(sum_cpue, mean_sum_cpue))

  return(data2)
}
