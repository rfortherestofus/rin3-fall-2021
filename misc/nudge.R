library(tidyverse)
library(palmerpenguins)
library(scales)
library(hrbrthemes)
library(janitor)


penguins_summary <- penguins %>%
  group_by(island) %>%
  summarize(avg_weight = mean(body_mass_g, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(avg_weight = round_half_up(avg_weight))

ggplot(data = penguins_summary,
       aes(x = avg_weight,
           y = island,
           label = avg_weight,
           fill = island)) +
  geom_col(show.legend = FALSE) +
  geom_text(nudge_x = 1)
