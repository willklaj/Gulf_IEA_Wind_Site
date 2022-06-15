# packages ----
if (!require(librarian)){
  install.packages("librarian")
  library(librarian)
}
shelf(
  dplyr, glue, highcharter, knitr, purrr, readr, rmarkdown, stringr, tibble, tidyr, tidyselect)

# variables ----
icons_to_data_csv <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vSAROGVpYB58Zkr8P0iwJdTMRPNLZtJ07IyUn-dQ62C2HMuCEScyl8x7urCD7QbRXQYSIJwDn_wku9G/pub?gid=0&single=true&output=csv"

# create modals ----
icons_to_data <- read_csv(icons_to_data_csv, col_types = cols()) %>% 
  mutate(across(is_logical, replace_na, F)) %>% 
  filter(!manual_modal) %>% 
  arrange(icon)

expand_modal <- function(icon, title, data, provider_link, caption, source, y_label, ...){

  out   <- glue::glue("modals/{icon}.html")
  message(out)

  knitr::knit_expand(
    file    = "_infographic_modal_template.html", 
    title = title) %>% 
    writeLines(out) 
}

icons_to_data %>% pwalk(expand_modal)
  
