library(tidyverse)
library(palmerpenguins)

penguins %>% 
  ggplot(aes(x = bill_length_mm,
             y = 1)) +
  geom_point(shape = 108,
             size = 10,
             alpha = 0.5,
             color = "red") +
  theme_void()


penguins %>% 
  filter(island == "Dream") %>% 
  ggplot(aes(x = bill_length_mm,
             y = 1)) +
  geom_point(shape = 108,
             size = 10,
             alpha = 0.5,
             color = "red") +
  theme_void() +
  labs(title = "Bill Length in Dream")

bill_length_plot <- function(island_name) {

penguins %>% 
  filter(island == island_name) %>% 
  ggplot(aes(x = bill_length_mm,
             y = 1)) +
  geom_point(shape = 108,
             size = 10,
             alpha = 0.5,
             color = "red") +
  theme_void() +
  labs(title = str_glue("Bill Length in {island_name}"))
  
}

bill_length_plot(island_name = "Dream")

bill_length_plot(island_name = "Biscoe")
