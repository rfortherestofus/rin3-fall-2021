library(tidyverse)
library(httr)
library(jsonlite)

# This doesn't work so I abandoned it and use a plugin to export orders

key <- Sys.getenv("WOOCOMMERCE_KEY")
secret <- Sys.getenv("WOOCOMMERCE_SECRET")

total_orders <- 3500

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
  unnest_longer(line_items) %>% 
    select(id, line_items) %>% 
    tibble() 

rin3_orders <- orders %>%
  unnest_longer(line_items) %>% 
  select(id, line_items) %>% 
  pluck("line_items") %>% 
  filter(str_detect(name, "R in 3 Months"))
