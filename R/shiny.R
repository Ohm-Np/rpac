# shiny.R

library("shiny")
library("sass")

# define the user interface
ui <- fluidPage(
  titlePanel("Simply Shiny App"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),

    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# define the server logic
server <- function(input, output) {
  output$distPlot <- renderPlot({
    x <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    hist(x, breaks = bins, col = 'darkgray', border = 'white',
         xlab = 'Waiting time to next eruption (in mins)',
         ylab = 'Histogram of waiting times')
  })
}

# Run the application
shinyApp(ui = ui, server = server)



