library(tidyverse)
library(readxl)
library(janitor)


enrollment_18_19 <- read_excel(path = "data/enrollment-18-19.xlsx",
                               sheet = "Sheet 1")

enrollment_18_19 %>%
  select(-contains("grade")) %>% 
  select(-contains("kindergarten")) %>% 
  select(-contains("percent")) %>% 
  pivot_longer(cols = -district_id,
               names_to = "race_ethnicity",
               values_to = "number_of_students") %>%
  mutate(number_of_students = na_if(number_of_students, "-")) %>% 
  mutate(number_of_students = replace_na(number_of_students, 0)) %>% 
  mutate(number_of_students = as.numeric(number_of_students)) %>%
  mutate(race_ethnicity = str_remove(race_ethnicity, "x2018_19_")) %>%
  mutate(race_ethnicity = case_when(
    race_ethnicity == "american_indian_alaska_native" ~ "American Indian Alaska Native",
    race_ethnicity == "asian" ~ "Asian",
    race_ethnicity == "black_african_american" ~ "Black/African American",
    race_ethnicity == "hispanic_latino" ~ "Hispanic/Latino",
    race_ethnicity == "multiracial" ~ "Multi-Racial",
    race_ethnicity == "native_hawaiian_pacific_islander" ~ "Pacific Islander",
    race_ethnicity == "white" ~ "White"
  )) %>% 
  group_by(district_id) %>%
  mutate(pct = number_of_students / sum(number_of_students)) %>%
  ungroup()
  