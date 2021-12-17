library(gapminder)
library(gt)
library(tidyverse)


gapminder %>% 
  gt()

oceania_wide <- gapminder %>% 
  filter(continent == "Oceania",
         year < 1967) %>% 
  pivot_wider(values_from = lifeExp:gdpPercap,
              names_from = year)

oceania_wide %>% 
  gt() %>% 
  tab_spanner(label = "1952",
              columns = contains("1952")) %>% 
  tab_spanner(label = "1957",
              columns = contains("1957")) %>% 
  tab_spanner(label = "1962",
              columns = contains("1962")) %>% 
  cols_label(lifeExp_1952 = "Life Expectancy")

oceania_wide %>% 
  select(contains("19"))

dated_column_names <- oceania_wide %>% 
  select(matches("[0-9]{4}")) %>% 
  colnames()

tidy_date_column_names <- function(columns_names){
  
  without_date <- str_remove(columns_names, "_[0-9]{4}")
  
  case_when(without_date == "lifeExp" ~ "Life Expectancy",
            without_date == "pop" ~ "Population",
            without_date == "gdpPercap" ~ "GDP per Capita")
  
}

case_when(without_date == "lifeExp" ~ "Life Expectancy",
          without_date == "pop" ~ "Population",
          without_date == "gdpPercap" ~ "GDP per Capita")

str_remove(dated_column_names, "_[0-9]{4}")

replacement_column_labels <- set_names(str_remove(dated_column_names, "_[0-9]{4}"), dated_column_names)

oceania_wide %>% 
  gt() %>% 
  tab_spanner(label = "1952",
              columns = contains("1952")) %>% 
  tab_spanner(label = "1957",
              columns = contains("1957")) %>% 
  tab_spanner(label = "1962",
              columns = contains("1962")) %>% 
  cols_label(.list = replacement_column_labels)


# ==== cleaner code

library(gapminder)
library(gt)
library(tidyverse)


oceania_wide <- gapminder %>% 
  filter(continent == "Oceania",
         year < 1967) %>% 
  pivot_wider(values_from = lifeExp:gdpPercap,
              names_from = year)

dated_column_names <- oceania_wide %>% 
  select(matches("[0-9]{4}")) %>% 
  colnames()


tidy_date_column_names <- function(columns_names){
  
  without_date <- str_remove(columns_names, "_[0-9]{4}")
  
  case_when(without_date == "lifeExp" ~ "Life Expectancy",
            without_date == "pop" ~ "Population",
            without_date == "gdpPercap" ~ "GDP per Capita")
  
}

replacement_column_labels <- set_names(tidy_date_column_names(dated_column_names), dated_column_names)

oceania_wide %>% 
  gt() %>% 
  tab_spanner(label = "1952",
              columns = contains("1952")) %>% 
  tab_spanner(label = "1957",
              columns = contains("1957")) %>% 
  tab_spanner(label = "1962",
              columns = contains("1962")) %>% 
  cols_label(.list = replacement_column_labels)






