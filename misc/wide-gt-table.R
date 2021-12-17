library(gapminder)
library(gt)
library(tidyverse)


gapminder %>% 
  gt()



























# ==== ADVANCED

replace_col_names <- gapminder_wide %>% 
  select(matches("[0-9]")) %>% 
  colnames() %>% 
  set_names(str_remove_all(., "_[0-9]{4}"), .)

gapminder_wide %>% 
  gt() %>% 
  tab_spanner(label = "1952",
              columns = contains("1952")) %>%
  tab_spanner(label = "1962",
              columns = contains("1962")) %>%
  tab_spanner(label = "1972",
              columns = contains("1972")) %>%
  tab_spanner(label = "1982",
              columns = contains("1982")) %>%
  cols_label(.list = replace_col_names)