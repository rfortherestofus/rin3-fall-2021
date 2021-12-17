library(tidyverse)
library(fivethirtyeight)
library(ggrepel)

bechdel %>% 
  ggplot(aes(x = budget_2013,
             y = domgross_2013)) +
  geom_point(aes(shape = ifelse(domgross_2013 > 1E9, "billionaire movie", "normal movie")),
             size = 12) +
  scale_shape_manual(values = c("billionaire movie" = 42, "normal movie" = 16))

bechdel %>% 
  ggplot(aes(x = budget_2013,
             y = domgross_2013)) +
  geom_point(aes(shape = ifelse(domgross_2013 > 1E9, "billionaire movie", "normal movie"),
                 size = ifelse(domgross_2013 > 1E9, "billionaire movie", "normal movie"))) +
  scale_shape_manual(values = c("billionaire movie" = 42, "normal movie" = 16),
                     name = NULL) +
  scale_size_manual(values = c("billionaire movie" = 7, "normal movie" = 2)) +
  guides(size = guide_none(),
         shape = guide_legend(override.aes = list(size = c(7, 2))))





billionaire_movies <- bechdel %>% 
  filter(domgross_2013 >= 1E9)

normal_movies <- bechdel %>% 
  filter(domgross_2013 < 1E9)


ggplot() +
  geom_point(data = normal_movies,
             aes(x = budget_2013,
                 y = domgross_2013,
                 alpha = "normal")) +
  geom_point(data = billionaire_movies,
             aes(x = budget_2013,
                 y = domgross_2013,
                 alpha = "billionaire"),
             pch = 42,
             size = 7) +
  geom_label_repel(data = billionaire_movies,
             aes(x = budget_2013,
                 y = domgross_2013,
                 label = title)) +
  scale_alpha_manual(values = c("normal" = 1, "billionaire" = 1)) +
  guides(alpha = guide_legend(override.aes = list(shape = c("normal" = 16, "billionaire" = 42),
                                                  size = c("normal" = 2, "billionaire" = 7)),
                              reverse = FALSE))







