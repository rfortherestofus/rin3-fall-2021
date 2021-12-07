# https://www.youtube.com/watch?v=EIOo6T-Z1Qw


library(tidyverse)
library(palmerpenguins)
library(scales)
library(hrbrthemes)
library(janitor)

# Make sure to install these packages
# install.packages("ragg")
library(ragg)
# install.packages("systemfonts")
library(systemfonts)

penguins_summary <- penguins %>%
  group_by(island) %>%
  summarize(avg_weight = mean(body_mass_g, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(avg_weight = round_half_up(avg_weight))

ggplot(data = penguins_summary,
       aes(x = island,
           y = avg_weight,
           label = avg_weight,
           fill = island)) +
  geom_col(show.legend = FALSE) +
  geom_text(family = "Inter-Regular") +
  theme_ipsum(base_family = "Inter-Regular")

ggsave(width = 8,
       height = 10,
       device = cairo_pdf,
       filename = "misc/penguins-plot.pdf")

ggsave(width = 8,
       height = 10,
       filename = "misc/penguins-plot.png")

# You can use this method to save to a PNG using the ragg package
# Only necessary if ggsave() isn't working for you
# Source: https://ragg.r-lib.org/reference/agg_png.html
agg_png(filename = "misc/penguins-plot-agg.png")

ggplot(data = penguins_summary,
       aes(x = island,
           y = avg_weight,
           label = avg_weight,
           fill = island)) +
  geom_col(show.legend = FALSE) +
  geom_text() +
  theme_ipsum(base_family = "Inter")

dev.off()
