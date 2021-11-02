library(tidyverse)
library(sf)
library(readxl)
library(janitor)
library(mapview)

air_routes_seat_kms <-
  read_excel("data/air-routes.xlsx",
             sheet = "seat-kilometers") %>%
  clean_names()

journeys_to_sf <- function(journeys_data,
                           start_long = start.long,
                           start_lat = start.lat,
                           end_long = end.long,
                           end_lat = end.lat,
                           segmentize_in_km = 400) {
  journeys_data %>%
    select(
      {{ start_long }},
      {{ start_lat }},
      {{ end_long }},
      {{ end_lat }}
    ) %>%
    transpose() %>%
    map( ~ matrix(flatten_dbl(.), nrow = 2, byrow = TRUE)) %>%
    map(st_linestring) %>%
    st_sfc(crs = 4326) %>%
    st_sf(geometry = .) %>%
    bind_cols(journeys_data) %>%
    select(everything(), geometry) %>%
    st_segmentize(units::set_units(segmentize_in_km, "km")) %>%
    st_wrap_dateline(options = c("WRAPDATELINE=YES", "DATELINEOFFSET=180"))
}

air_routes_seat_kms %>%
  journeys_to_sf(airport_1_long,
                 airport_1_lat,
                 airport_2_long,
                 airport_2_lat) %>%
  mapview()
