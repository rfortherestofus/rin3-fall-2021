library(tidyverse)
library(fs)

getwd()

setwd("/Users/davidkeyes/Downloads/")

tsv_files <- dir_ls(path = "ICPSR_37382 2",
                    regex = ".tsv",
                    recurse = TRUE)

all_data <- map_df(tsv_files, read_tsv)
