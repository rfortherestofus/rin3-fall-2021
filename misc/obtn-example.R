library(tidyverse)
library(tfff)

tfff_dark_green <- "#265142"

race_ethnicity <- read_csv("data/race-ethnicity.csv") %>%
  filter(geography == "Multnomah") %>%
  filter(year == 2020)


