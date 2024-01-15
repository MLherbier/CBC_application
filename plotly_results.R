library(dplyr)
library(rnaturalearth)
library(plotly) 
library(sf)
library(tidyverse)
library(RColorBrewer)

# Get the world map
world <- ne_countries(scale = "medium", returnclass = "sf")

# Select only the countries we have data for (turns out all of them are in Europe)
europe <- world %>% 
  dplyr::filter(iso_a2 %in% results$alpha_2_code)


#adding our results to the data
europe_results <- europe %>% left_join(results, by=c("iso_a2" ="alpha_2_code"))

plot <- ggplot(europe_results) +
  geom_sf() +
  labs(x="Longitude", y="Latitude") +
  ggtitle("Total static biodiversity loss due to land use caused by wheat in 2019") +
  geom_sf(aes(fill = round(static_impact)))

ggplotly(plot)
