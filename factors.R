library(tidyverse)
library(palmerpenguins)
library(janitor)
library(skimr)

penguins_raw %>% 
  clean_names() %>% 
  select(sex) %>% 
  mutate(sex_factor = as.factor(sex)) %>% 
  mutate(sex_numeric = as.numeric(sex_factor))


penguins %>% 
  select(sex)
