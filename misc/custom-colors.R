library(tidyverse)

spotify_songs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv')

# palette from https://coolors.co/3f3f4a-c87153-f3e36e-416feb-e4c9d1-93ccf7
colors_genre <- c("edm" = "#3F3F4A",
                   "latin" = "#C87153",
                   "pop" = "#F3E36E",
                   "r&b" = "#416FEB",
                   "rap" = "#E4C9D1",
                   "rock" = "#93CCF7")

spotify_songs %>% 
  group_by(playlist_genre) %>% 
  summarise(mean_duration = mean(duration_ms),
            mean_danceability = mean(danceability)) %>% 
  ggplot(aes(x = mean_duration,
             y = mean_danceability)) +
  geom_point(aes(color = playlist_genre)) +
  scale_color_manual(values = colors_genre) +
  theme_bw()


janitor::make_clean_names("Charlie R for the Rest of Us")
