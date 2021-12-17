library(tidyverse)
library(ggtext)

sleep_total_mean <- msleep %>% 
  pull(sleep_total) %>% 
  mean()

msleep %>% 
  ggplot(aes(x = sleep_rem,
             y = sleep_total)) +
  geom_point() + 
  geom_hline(yintercept = sleep_total_mean,
             color = "cornflowerblue") +
  labs(subtitle = str_glue("<span style='color:cornflowerblue'>Mean sleep total was {round(sleep_total_mean)} hours</span>")) +
  facet_wrap(~ vore) +
  theme(plot.subtitle = element_markdown())



msleep %>% 
  group_by(vore) %>% 
  mutate(mean_total_sleep = mean(sleep_total, na.rm = TRUE)) %>% 
  ungroup() %>% 
  mutate(vore = fct_explicit_na(vore, na_level = "Unknown diet")) %>% 
  mutate(vore = fct_reorder(vore, mean_total_sleep),
         vore = fct_rev(vore)) %>%
  ggplot(aes(x = sleep_rem,
             y = sleep_total)) +
  geom_point() + 
  geom_hline(aes(yintercept = mean_total_sleep),
             color = "cornflowerblue") +
  facet_wrap(~ vore) +
  theme(plot.subtitle = element_markdown())
