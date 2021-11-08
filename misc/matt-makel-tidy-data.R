library(tidyverse)
library(googlesheets4)
library(janitor)
library(scales)
library(tidygeocoder)
library(leaflet)
library(gt)
library(lubridate)

survey_pre <- read_sheet("https://docs.google.com/spreadsheets/u/1/d/19Ny92IGg0ZzIqiLs7QywaGF-Y85HQZn1iIIXN4I_tpg/edit?usp=forms_web_b#gid=1201619159") %>%
  clean_names() %>% 
  filter(timestamp > ymd("2021-06-01")) %>% 
  select(how_much_have_you_used_r:on_a_scale_from_terrified_to_excited_how_do_you_feel_about_the_process_of_learning_r)

survey_pre %>% 
  select(what_software_do_you_currently_use_for_data_analysis) %>% 
  mutate(id = row_number()) %>% 
  add_row(what_software_do_you_currently_use_for_data_analysis = "DK Stats",
          id = 50) %>% 
  separate_rows(what_software_do_you_currently_use_for_data_analysis, 
                sep = ", ") %>% 
  count(what_software_do_you_currently_use_for_data_analysis) %>% 
  arrange(desc(n))

survey_pre %>% 
  select(what_software_do_you_currently_use_for_data_analysis) %>% 
  mutate(uses_excel = if_else(str_detect(what_software_do_you_currently_use_for_data_analysis, "Excel"), "Y", "N")) %>% 
  mutate(uses_tableau = if_else(str_detect(what_software_do_you_currently_use_for_data_analysis, "Tableau"), "Y", "N")) %>% 
  mutate(uses_spss = if_else(str_detect(what_software_do_you_currently_use_for_data_analysis, "SPSS"), "Y", "N")) %>% 
  mutate(uses_jasp = if_else(str_detect(what_software_do_you_currently_use_for_data_analysis, "SPSS"), "Y", "N")) %>% 
  count(uses_excel)
  summarize(uses_excel_county = sum(uses))
