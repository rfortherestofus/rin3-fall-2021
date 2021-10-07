library(tidyverse)
library(haven)

# Data file from https://www.thearda.com/Archive/Files/Downloads/GSS1991_DL2.asp
# 
# https://rstudio-pubs-static.s3.amazonaws.com/466787_84982191b86e4591bfcee776e498a6d4.html
# 
# https://www.pipinghotdata.com/posts/2020-12-23-leveraging-labelled-data-in-r/

download.file("https://osf.io/2qphn/download",
              destfile = "data/General Social Survey_1991.SAV")

survey_data <- read_spss("data/General Social Survey_1991.SAV")

survey_data %>%
  mutate(across(where(is.labelled), as_factor))

strip_labels <- function(data) {
  data %>% 
    mutate(across(where(is.labelled), as_factor))
}

survey_data %>% 
  strip_labels()
