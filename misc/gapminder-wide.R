library(tidyverse)

gapminder_wide <- read_csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_wide.csv")

# Tidy the gapminder_wide data using pivot_longer() and possibly separate()

# Create the following data frames:
# 1. continent_country: has just the continents and country observations
# Hint: You may need to use the distinct() function to create the continent_country data frame

# 2. gdp: has just country, year, and gdp variables
# 3. life_expectancy: has just country, year, and life_expectancy variables
# 4. population: has just country, year, and population variables

population <- gapminder_wide %>%
  select(continent, country, contains("pop_")) %>% 
  pivot_longer(cols = contains("pop_"),
               names_to =  "year",
               values_to = "population") %>% 
  separate(col = year, into = c("pop", "year")) %>% 
  select(-pop) %>% 
  view()

population %>% 
  distinct(country)

separate()
population
  

# Create a gist and send me the link to your code via chat

# Bonus: If you finish early, see if you can make a function with a single argument (measure_name) that automatically creates the gdp, life_expectancy, and population data frames rather than copying your code three times
