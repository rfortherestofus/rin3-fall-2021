library(tidyverse)
library(haven)

download.file("https://osf.io/2qphn/download",
              destfile = "data/General Social Survey_1991.SAV")

survey_data <- read_spss("data/General Social Survey_1991.SAV")

survey_data %>%
  mutate(across(where(~ c("haven_labelled") %in% attr(., "class")), as_factor))

strip_labels <- function(data) {
  data %>% 
    mutate(across(where(~ c("haven_labelled") %in% attr(., "class")), as_factor))
}

survey_data %>% 
  strip_labels()
