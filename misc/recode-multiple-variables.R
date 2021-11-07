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



# Attempt #1 --------------------------------------------------------------

recode_to_y_n <- function(data, variable_name) {
  
  data %>% 
    mutate({{ variable_name }} = if_else({{ variable_name }} == 0, "N", "Y"))
  
}

household_data %>% 
  recode_to_y_n(radio)


# Attempt #2 (Vector) -----------------------------------------------------

household_data$radio

if_else(household_data$radio == "1", "Y", "N")

recode_to_y_n_v2 <- function(vector) {
  if_else(vector == "1", "Y", "N") %>% as_factor()
}

recode_to_y_n_v2(household_data$radio)

household_data %>% 
  mutate(radio = recode_to_y_n_v2(radio))

household_data %>% 
  mutate(across(c(ever_married, radio), recode_to_y_n_v2))
