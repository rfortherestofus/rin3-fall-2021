library(tidyverse)

faketucky <- read_csv("data/faketucky.csv", 
                      na = "999",
                      col_types = list(enrolled_in_college = col_character(),
                                       free_and_reduced_lunch = col_character(),
                                       male = col_character(),
                                       received_high_school_diploma = col_character()))

faketucky <- read.csv("data/faketucky.csv", 
                      na = "999",
                      col_types = list(enrolled_in_college = col_character(),
                                       free_and_reduced_lunch = col_character(),
                                       male = col_character(),
                                       received_high_school_diploma = col_character()))
