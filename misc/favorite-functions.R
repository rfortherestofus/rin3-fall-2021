

# A Few of My Favorite Functions ------------------------------------------

library(flextable)
library(officer)
library(tidyverse)
library(tigris)
library(tidycensus)
library(palmerpenguins)
library(scales)


# Oregon by the Numbers ---------------------------------------------------

obtn_boundaries_oregon_counties <- counties(state = "Oregon", cb = TRUE) %>%
  rename(geography = NAME) %>% 
  select(geography)

obtn_boundaries_oregon_counties %>% 
  ggplot() +
  geom_sf()

ggplot() +
  geom_sf(data = obtn_boundaries_oregon_counties,
          fill = "#a8a8a8",
          color = "white",
          size = 0.3)

make_inset_map <- function(county) {
  
  highlight_county <- obtn_boundaries_oregon_counties %>% 
    filter(geography == county)
  
  ggplot() +
    geom_sf(data = obtn_boundaries_oregon_counties,
            fill = "#a8a8a8",
            color = "white",
            size = 0.3) +
    geom_sf(data = highlight_county,
            fill = "#283593",
            color = "white") +
    theme_void()
  
  file_name <- str_replace(county, " ", "-")
  
  ggsave(filename = str_glue("inset-maps/{file_name}.pdf"))
  
}

make_inset_map("Baker")
make_inset_map("Hood River")

oregon_counties <- obtn_boundaries_oregon_counties %>% 
  pull(geography)

oregon_counties

walk(oregon_counties, make_inset_map)

library(beepr)

beep()

# omni_table --------------------------------------------------------------

omni_table <- function(df) {
  df %>% 
    flextable() %>%
    theme_zebra(even_body = "#9DAECE",
                odd_body = "#CED6E6") %>%
    fontsize(part = "all", size = 11) %>%
    font(part = "all", fontname = "Lato") %>%
    bold(part = "header", bold = TRUE) %>%
    bold(part = "body", j = 1, bold = TRUE) %>%
    align(part = "all", align = "center") %>%
    bg(part = "header", bg = "#314160") %>%
    color(part = "header", color = "white") %>%
    color(part = "body", color = "#333333") %>%
    bg(part = "body", j = 1, bg = "#314160") %>%
    color(part = "body", j = 1, color = "white") %>%
    height_all(height = 0.4) %>%
    border_inner(part = "body", border = fp_border(color = "white")) %>%
    border(part = "header", border.bottom = fp_border(color = "white")) 
}

pretty_variable_names <- c("Name of Island", "Number of Penguins", "Percent")

pretty_variable_names_tibble <- tribble(~'Name of Island', ~'Number of Penguins', ~'Percent')

pretty_variable_names <- pretty_variable_names_tibble %>% 
  names()

penguins %>% 
  count(island) %>% 
  mutate(pct = n / sum(n)) %>% 
  mutate(pct = percent(pct, accuracy = 1)) %>% 
  set_names(pretty_variable_names) %>% 
  omni_table()

penguins %>% 
  omni_table()

# theme_omni --------------------------------------------------------------


theme_omni <- function() {
  theme_minimal(base_family = "Lato") +
    theme(panel.grid.minor = element_blank(),
          axis.ticks = element_blank(),
          plot.title = element_text(face = "bold"))
}


penguins %>% 
  count(island) %>% 
  mutate(pct = n / sum(n)) %>% 
  mutate(pct = percent(pct, accuracy = 1)) %>% 
  ggplot(aes(x = island, y = n)) +
  geom_col()


penguins %>% 
  count(island) %>% 
  mutate(pct = n / sum(n)) %>% 
  mutate(pct = percent(pct, accuracy = 1)) %>% 
  ggplot(aes(x = island, y = n)) +
  geom_col() +
  theme_omni()







# tidycensus --------------------------------------------------------------



view_acs_variables <- function(year = 2019) {
  load_variables(year, "acs5", cache = TRUE) %>%
    view()
}

load_variables(2019, "acs5", cache = TRUE) %>% 
  glimpse()

view_acs_variables(year = 2017)


get_acs(variables = c("White" = "B03002_003",
                      "Black/African American" = "B03002_004",
                      "American Indian/Alaska Native" = "B03002_005",
                      "Asian" = "B03002_006",
                      "Native Hawaiian/Pacific Islander" = "B03002_007",
                      "Other race" = "B03002_008",
                      "Multi-Race" = "B03002_009",
                      "Hispanic/Latino" = "B03002_012"),
        geography = "state") %>% 
  set_names(c("geoid", "geography", "population_group", "estimate", "moe")) %>% 
  view()


get_acs_race_ethnicity <- function(geography_to_use) {
  
  get_acs(geography = geography_to_use,
          variables = c("White" = "B03002_003",
                        "Black/African American" = "B03002_004",
                        "American Indian/Alaska Native" = "B03002_005",
                        "Asian" = "B03002_006",
                        "Native Hawaiian/Pacific Islander" = "B03002_007",
                        "Other race" = "B03002_008",
                        "Multi-Race" = "B03002_009",
                        "Hispanic/Latino" = "B03002_012")) %>%
    set_names(c("geoid", "geography", "population_group", "estimate", "moe"))
  
}

get_acs_race_ethnicity("county")







