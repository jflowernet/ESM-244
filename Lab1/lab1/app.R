#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

np_visit <- read_csv("np_visit.csv")

ca_np <- np_visit %>% 
  filter(state == "CA" & type == "National Park")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("California NP Visitation"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput(inputId = "Year",
                     label = "Year",
                     min = 1950,
                     max = 2016,
                     value = 2016)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- ca_np$visitors
      Year <- input$Year
      
      ggplot(subset(ca_np, year == Year), aes(x =park_name, y = visitors))+
        geom_col(aes(fill = park_name)) +
        coord_flip()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

