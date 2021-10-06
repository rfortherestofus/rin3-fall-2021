library(tidyverse)
library(palmerpenguins)


penguins_summary <- penguins %>% 
  count(island) %>% 
  mutate(pct = n / sum(n))

palette.pals()

ggplot(data = penguins_summary,
       aes(x = island,
           y = pct,
           fill = island)) +
  geom_col() +
  scale_fill_manual(values = palette.colors(palette = "Okabe-Ito"))
  scale_fill_brewer(palette = "Dark2")
