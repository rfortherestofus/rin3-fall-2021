library(flextable)
library(officer)
library(tidyverse)
library(tigris)
library(tidycensus)
library(palmerpenguins)
library(scales)


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

penguins %>% 
  count(island) %>% 
  mutate(pct = n / sum(n)) %>% 
  mutate(pct = percent(pct, accuracy = 1)) %>% 
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




# Oregon by the Numbers ---------------------------------------------------

obtn_boundaries_oregon_counties <- counties(state = "Oregon", cb = TRUE) %>% 
  rename(geography = NAME) %>% 
  select(geography)

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
}

make_inset_map("Baker")




# tidycensus --------------------------------------------------------------



view_acs_variables <- function(year = 2019) {
  tidycensus::load_variables(year, "acs5", cache = TRUE) %>%
    tibble::view()
}


view_acs_variables()


get_acs(variables = c("B03002_003", 
                      "B03002_004", 
                      "B03002_005",
                      "B03002_006",
                      "B03002_007",
                      "B03002_008",
                      "B03002_009",
                      "B03002_010",
                      "B03002_011",
                      "B03002_012"),
        geography = "state")


get_acs_race_ethnicity <- function() {
  
  get_acs(geography = "state",
          variables = c("White" = "B03002_003",
                        "Black/African American" = "B03002_004",
                        "American Indian/Alaska Native" = "B03002_005",
                        "Asian" = "B03002_006",
                        "Native Hawaiian/Pacific Islander" = "B03002_007",
                        "Other race" = "B03002_008",
                        "Multi-Race" = "B03002_009",
                        "Hispanic/Latino" = "B03002_012")) %>%
    clean_names() %>%
    set_names(c("geoid", "geography", "population_group", "estimate", "moe"))
  
}

get_acs_race_ethnicity()







