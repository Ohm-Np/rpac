library("shiny")
library("leaflet")
library("tidyverse")
library("sf")

# load the datasets
title_list <- read.csv('C:/Users/ombha/OneDrive/Documents/packages/rpac/shiny-newspaper-app/title.csv')
coord_list <- read.csv('C:/Users/ombha/OneDrive/Documents/packages/rpac/shiny-newspaper-app/coordinates.csv')


# create an UI element
ui = fluidPage(

  titlePanel("Newspaper Map"),

  sidebarLayout(

    sidebarPanel = sidebarPanel(

      sliderInput('years', 'Years', min = 1621, max = 2000, value = c(1700, 1750))
    ),
    mainPanel = mainPanel(

      leafletOutput(outputId = 'map')
    )
  )

)


# create the server element
server = function(input, output) {

  map_df = reactive({

    title_list %>%
      filter(first_date_held > input$years[1] & first_date_held < input$years[2]) %>%
      count(coverage_city, name = 'titles') %>%
      left_join(coord_list, by = 'coverage_city') %>%
      filter(!is.na(lng) & !is.na(lat)) %>%
      st_as_sf(coords = c('lng', 'lat')) %>%
      st_set_crs(4326)
  })

  output$map = renderLeaflet({

    leaflet() %>%
      addTiles() %>%
      setView(lng = -5, lat = 54, zoom = 5) %>%
      addCircleMarkers(data = map_df(), radius = ~sqrt(titles))
  })

}

# Run the app
shinyApp(ui, server)






