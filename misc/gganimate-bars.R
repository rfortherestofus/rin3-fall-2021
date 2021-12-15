library(tidyverse)
library(gganimate)

msleep %>% 
  count(vore) %>% 
  mutate(vore = fct_reorder(vore, n)) %>% 
  ggplot(aes(x = n,
             y = vore)) +
  geom_col() +
  annotate(
    geom = "curve",
    x = 28,
    y = 2,
    xend = 20,
    yend = 3,
    curvature = .3, arrow = arrow(length = unit(2.5, "mm")),
    color="#33A8FF",
    size=0.7) +
  annotate(
    geom = "label",
    label = "20 animals were\n omnivores",
    x = 28,
    y = 2) +
  transition_states(-n, wrap = FALSE) +
  shadow_mark() +
  enter_fade()
