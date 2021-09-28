library(tidyverse)
library(palmerpenguins)
library(scales)


# Decimal places ----------------------------------------------------------

penguins

penguins_summary <- penguins %>% 
  count(island) %>% 
  mutate(pct = n / sum(n)) %>% 
  mutate(pct_formatted = percent(pct, accuracy = 0.1))


ggplot(data = penguins_summary,
       aes(x = island,
           y = pct,
           label = pct_formatted)) +
  geom_col() +
  geom_text()
