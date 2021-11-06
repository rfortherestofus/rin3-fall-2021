library(tidyverse)

household_data <- read_csv("data/household_data3-1.csv")

household_data %>% 
  glimpse()

household_data %>% 
  mutate(across(where(is.double), as.character)) %>% 
  glimpse()

household_data %>% 
  mutate(radio = case_when(
    radio == 0 ~ "N",
    radio == 1 ~ "Y"
  ))

recode_to_y_n <- function(data, variable_name) {
  
  data %>% 
    mutate({{ variable_name }} = if_else({{ variable_name }} == 0, "N", "Y"))
  
}

household_data %>% 
  recode_to_y_n(radio)
