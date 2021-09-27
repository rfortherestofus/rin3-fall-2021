# Question from Mandy Varley
# See https://rfortherestofus.com/courses/fundamentals/lessons/the-tidyverse/

# Hello! When we run the clean_names function is there a way to save the changes made to variables names into the actual data .csv file?

library(tidyverse)
library(janitor)

original_variable_names <- read_csv("data/nhanes.csv") %>%
  names()

clean_variable_names <- read_csv("data/nhanes.csv") %>%
  clean_names() %>% 
  names()

data_dictionary <- tibble(original_variable_names, clean_variable_names)

write_csv(data_dictionary,
          file = "data/data_dictionary.csv")
