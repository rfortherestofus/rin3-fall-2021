#  Recreating this: https://show.rfor.us/cditiy


# Load Packages -----------------------------------------------------------

library(tidyverse)
library(scales)
library(shadowtext)
library(ggchicklet)
library(hrbrthemes)
library(omni)


# Import Data ------------------------------------------------------------

cbem <- read_csv("data/cbem.csv")



# Prep Data ---------------------------------------------------------------



cbem_filtered <- cbem %>% 
  filter(age_group == "Under 18") %>% 
  filter(location == "Oregon") %>%
  filter(group != "All Persons") %>% 
  mutate(plot_label = percent(percent, accuracy = 0.1),
         group_x_pos = c(1, 2, 3, 4, 5.25))

cbem_state_avg <- cbem %>% 
  filter(age_group == "Under 18") %>% 
  filter(location == "Oregon") %>%
  filter(group == "All Persons") %>% 
  select(percent) %>% 
  mutate(plot_label = str_glue("CBEM State Rate\n{percent(percent, accuracy = 0.1)}"))

cbem_race_ethnicity_colors <- c(
  "American Indian or Alaska Native" = "#9CC892",
  "Asian or Pacific Islander" = "#0066cc",
  "Black or African American" = "#477A3E",
  "White" = "#6CC5E9",
  "Hispanic or Latino" = "#ff7400"
)


# Plot --------------------------------------------------------------------



cbem_filtered %>% 
  ggplot(aes(group_x_pos, percent,
             fill = group)) +
  
  # State Average
  geom_hline(yintercept = cbem_state_avg$percent,
             color = "#757575",
             linetype = "dashed") +
  geom_shadowtext(data = cbem_state_avg,
                  aes(x = max(cbem_filtered$group_x_pos), y = percent,
                      label = plot_label),
                  inherit.aes = FALSE,
                  lineheight = 1,
                  bg.color = "white",
                  color = "#757575",
                  vjust = -0.4,
                  size = 8 / .pt) +
  
  # Bars
  geom_chicklet() +
  
  # Text on bars
  geom_text(aes(label = plot_label),
            vjust = 1.5,
            family = "Futura",
            color = "white") +
  
  # Fill colors
  # scale_fill_manual(values = cbem_race_ethnicity_colors) +
  scale_fill_omni_discrete() +
  
  # Theme
  theme_ipsum(
    base_family = "Futura",
    base_size = 9,
    grid_col = "transparent",
    plot_margin = margin(0, 0, 0, 0)
  ) +
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "none"
  )

  