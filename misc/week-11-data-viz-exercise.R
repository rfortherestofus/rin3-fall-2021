# Sample Report: https://housing-profiles.s3.amazonaws.com/2020/Hartford.pdf

# Your task is decipher how I made this graph: https://share.rfor.us/v1ub7qWe

# Some questions for discussion:
# Why is the y aesthetic property set to 1?
# What does shape = 124 do?
# What does geom_hline() do in this viz?
# Why do I have to specifically adding x axis text using the line theme(axis.text.x = element_text(color = "grey80"))?

library(tidyverse)
library(scales)

ct_towns_population <- read_csv("https://gist.githubusercontent.com/dgkeyes/8e6ae05003dac8fc6a928a9d1230f955/raw/b9d8d1252d5269a3f89f48a3e6dbc5cb9aa0bf7f/ct-towns.csv")

hartford_population <- ct_towns_population %>%
  filter(town == "Hartford")

ct_blue <- "#15397f"
light_grey <- "grey80"

ggplot(data = ct_towns_population,
       aes(x = population,
           y = 1)) +
  geom_hline(
    yintercept = 1,
    color = light_grey,
    size = 0.25
  ) +
  geom_point(shape = 124,
             color = light_grey,
             alpha = 0.5,
             size = 8) +
  geom_point(data = hartford_population,
             shape = 124,
             color = ct_blue,
             size = 12) +
  geom_text(data = hartford_population,
            aes(label = town),
            fontface = "bold",
            color = ct_blue,
            nudge_y = 1.5,
            hjust = -0.25) +
  scale_x_continuous(limits = c(0, 160000),
                     labels = comma_format()) +
  scale_y_continuous(limits = c(-1, 3)) +
  theme_void() +
  theme(axis.text.x = element_text(color = "grey80"))


ggsave(width = 8,
       height = 4,
       "misc/dot-plot.png")
