library(tidyverse)
library(fivethirtyeight)

bechdel %>% 
  ggplot(aes(x = budget_2013,
             y = domgross_2013)) +
  geom_point(aes(shape = ifelse(domgross_2013 > 1E9, "billionaire movie", "normal movie")),
             size = 6) +
  scale_shape_manual(values = c("billionaire movie" = 42, "normal movie" = 16))
