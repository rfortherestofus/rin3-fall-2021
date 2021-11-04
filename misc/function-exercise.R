library(tidyverse)
library(palmerpenguins)

# The code below will make a scatterplot showing bill length on the x axis and bill depth on the y axis.

penguins %>% 
  ggplot(aes(bill_length_mm,
             bill_depth_mm)) +
  geom_point()

# This code does the same thing, but only for penguins in 2007.

penguins %>% 
  filter(year == 2007) %>% 
  ggplot(aes(bill_length_mm,
             bill_depth_mm)) +
  geom_point()

# Add to the code below to make a function that will make a scatterplot for any year.

penguin_scatterplot <- function() {
  
 
  
}

