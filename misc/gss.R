# remotes::install_github("kjhealy/gssr")
library(gssr)
library(tidyverse)
library(janitor)



# Import Data and Save as CSV ---------------------------------------------



# data(gss_all)

# ?gss_all


# gss_all %>% 
#   filter(year == 2018) %>% 
#   remove_empty(which = c("cols", "rows")) %>% 
#   write_csv("data/gss-2018.csv")


# Open CSV ----------------------------------------------------------------

gss_2018 <- read_csv("data/gss-2018.csv") %>% 
  select(id, marital:widowed)


