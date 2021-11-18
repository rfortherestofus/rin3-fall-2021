library(palmerpenguins)
library(tidyverse)
library(ggimage)



penguins %>% 
  mutate(image_file = "misc/child-icon.svg") %>% 
  ggplot(aes(x = bill_length_mm,
           y = bill_depth_mm,
           image = image_file)) +
  geom_image()
