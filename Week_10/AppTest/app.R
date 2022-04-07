### Introduction to Shiny app
### Created by Ashlee Ochoa 
### Created on 2022-04-07 

### Must save script as "app.R" 
library(shiny)
library(tidyverse)

ui <- fluidPage(
  sliderInput(inputId = "num", # ID name for the input # Input need to end in Input and Output
              label = "Choose a number", # Label above the input 
              value = 25, min = 1, max = 100 # values for the slider 
              ),
  textInput(inputId = "title", # New ID is title. Input needs to be capitalized 
            label= "Write a title",
            value = "Histogram of Random Normal Values"), # Starting title 
  plotOutput("hist"), # Creates space for our histogram plot  
  verbatimTextOutput("stats") # creates space for "stats" after plot 
) # user interface. Input or Output that user will interact with 

server <- function(input, output) {  # R code goes here to create plot 
  
  data <- reactive({ # Creating a reactive object, creating a data frame. Will "catch" data frame 
    tibble(x= rnorm(input$num))
  })
  
  output$hist <- renderPlot({ 
 
    
    ggplot(data(), aes(x=x))+ # create a histogram 
      geom_histogram()+ 
      labs(title = input$title) # add a new title 
    # where r code goes 
  })
  
  output$stats <- renderPrint({
    summary(data()) # Calculates summary stats based on numbers 
  })
}
## Names MUST stay consistent 

shinyApp(ui = ui, server = server)
### Building app around inputs and outputs 