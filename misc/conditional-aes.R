library(tidyverse)
library(fivethirtyeight)

bechdel %>% 
  drop_na() %>% 
  ggplot(aes(x = budget_2013,
             y = domgross_2013)) +
  geom_point(aes(color = domgross_2013 > budget_2013)) +
  coord_fixed() +
  facet_wrap(~ clean_test)

bechdel %>% 
  drop_na() %>% 
  mutate(domgross_greater_than_budget = if_else(domgross_2013 > budget_2013, TRUE, FALSE)) %>% 
  ggplot(aes(x = budget_2013,
             y = domgross_2013)) +
  geom_point(aes(color = domgross_greater_than_budget)) +
  coord_fixed() +
  facet_wrap(~ clean_test)
