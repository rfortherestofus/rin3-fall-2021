# Question from Elan Sykes
# See https://rfortherestofus.com/courses/fundamentals/lessons/summarize/

# I got the count function to count the number of rows as assigned, but wanted to figure out a way to figure out the number of rows without an NA/with an answer for hours of sleep per night. I tried to add an argument “na.rm = TRUE” to the n() function in a few places in the code chunk but it didn’t work.

library(tidyverse)
library(janitor)

read_csv("data/nhanes.csv") %>%
  clean_names() %>% 
    mutate(sleep_hrs_night_has_value = case_when(
      is.na(sleep_hrs_night) ~ FALSE,
      TRUE ~ TRUE
    )) %>% 
    count(sleep_hrs_night_has_value)
