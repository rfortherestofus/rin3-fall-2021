library(tidyverse)

# Before March 2020, ie before ggplot2 version 3.0

gss_cat %>% 
  count(marital) %>% 
  mutate(n = n / sum(n)) %>% 
  ggplot(aes(x = marital,
             y = n)) +
  geom_col() +
  coord_flip() +
  scale_y_continuous(labels = scales::percent_format())

# Now coord_flip is unnecessary

gss_cat %>% 
  count(marital) %>% 
  mutate(n = n / sum(n)) %>% 
  ggplot(aes(x = n,
             y = marital)) +
  geom_col() +
  scale_x_continuous(labels = scales::percent_format())
