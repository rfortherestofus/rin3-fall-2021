library(tidyverse)
library(httr)
library(jsonlite)
library(tidygeocoder)
library(rnaturalearth)
library(sf)
library(ggfx)
library(lubridate)




# All participants --------------------------------------------------------



key <- Sys.getenv("WOOCOMMERCE_KEY")
secret <- Sys.getenv("WOOCOMMERCE_SECRET")

total_orders <- 4000

offset_numbers <- seq(0, total_orders, by = 100)

get_wc_orders <- function(offset_number) {
  GET(str_glue("https://www.rfortherestofus.com/wp-json/wc/v3/orders?per_page=100&offset={offset_number}"),
      authenticate(user = key,
                   password = secret)) %>% 
    content(as = "text") %>% 
    fromJSON()
}

orders <- map_df(offset_numbers, get_wc_orders)


rin3_orders <- orders %>% 
  unnest(line_items,
         names_repair = "universal") %>% 
  mutate(date_created = ymd_hms(date_created)) %>% 
  filter(date_created > ymd("2021-06-01")) %>% 
  filter(str_detect(name, "R in 3 Months")) %>% 
  pull(billing) %>% 
  select(city, state, country) %>% 
  unite("address", city:country, sep = " ") %>% 
  geocode(address = address,
          method = "mapbox") %>% 
  drop_na(lat) %>% 
  st_as_sf(coords = c("long", "lat")) %>% 
  st_set_crs(4326)



country_shapefiles <- ne_countries(returnclass='sf') %>% 
  filter(sovereignt != "Antarctica") %>% 
  st_set_crs(4326)


ggplot(country_shapefiles) + 
  geom_sf(fill = "#6CABDD",
          color = "#eeeeee",
          size = 0.1) +
  with_shadow(geom_sf(data = rin3_orders,
          color = "#FFC659",
          size = 2),
          colour = "#806E6E",
          x_offset = 1,
          y_offset = 1) +
  coord_sf(datum = NA) +
  theme_void() +
  theme(text = element_text(family = "Inter",
                            color = "white"),
        plot.title = element_text(size = 19,
                                  margin = margin(t = 10, b = 10),
                                  face = "bold",
                                  hjust = 0.5),
        plot.caption = element_text(size = 13,
                                    family = "Inter"),
        plot.background = element_rect(fill = "#6CABDD",
                                       color = "#6cabdd"),
        plot.margin = margin(10, 10, 10, 10, "pt")) +
  labs(title = "R in 3 Months Fall 2021 Participants")
  # labs(title = "Users from around the world have signed up for R in 3 Months",
  #      caption = "Learn more at rfor.us/3months")

ggsave("misc/rin3-signups.png",
       dpi = 300)

