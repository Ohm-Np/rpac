## plot_country_map.R

library("maps")
library("ggplot2")
library("labeling")
library("farver")

plot_country_map <- function(country_name) {

  # check if the country exists in the map database
  if (!(country_name %in% map("world", plot = FALSE)$names)) {
    stop("Country not found. Please provide a valid country name.")
  }

  # Get the map data for the specific country
  map_data <- map_data("world", region = country_name)

  # Plot the map using ggplot2
  ggplot(map_data, aes(x = long, y = lat, group = group)) +
    geom_polygon(fill = "lightblue", color = "black") +
    coord_fixed(1.3) +
    theme_minimal() +
    labs(title = paste0("Map of ", country_name),
        x = "Longitude",
        y = "Latitude")
}

# Example usage:
# plot_country_map("Nepal")
# plot_country_map("Germany")
