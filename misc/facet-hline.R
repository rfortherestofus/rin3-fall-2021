library(tidyverse)

msleep %>% 
  ggplot(aes(x = sleep_rem,
             y = sleep_total)) +
  geom_point() + 
  facet_wrap(~ vore)
