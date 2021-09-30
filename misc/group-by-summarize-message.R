library(tidyverse)
library(palmerpenguins)

penguins

penguins %>%
  group_by(species, island) %>%
  summarize(avg_bill_length = mean(bill_length_mm, na.rm = TRUE)) %>% 
  ungroup() %>% 
  group_by(species) %>%
  slice_max(order_by = avg_bill_length,
            n = 1)
