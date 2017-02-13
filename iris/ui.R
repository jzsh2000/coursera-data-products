#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(navbarPage(title = "iris species predictor",

    tabPanel("document"),
    tabPanel("data viewer",
             # Application title
             titlePanel("iris data viewer"),

             # Sidebar with a slider input for number of bins
             sidebarLayout(
                 sidebarPanel(
                     selectizeInput("xvar",
                                    "variable 1",
                                    choices = colnames(iris)[1:4],
                                    selected = "Sepal.Length"),
                     selectizeInput("yvar",
                                    "variable 2",
                                    choices = colnames(iris)[1:4],
                                    selected = "Sepal.Width"),
                     sliderInput("ps",
                                 "point size",
                                 min = 1,
                                 max = 4,
                                 value = 2,
                                 step = 0.5),
                     radioButtons("col",
                                  "color by species",
                                  choices = c("True", "False"),
                                  inline = TRUE)
                 ),

                 # Show a plot of the generated distribution
                 mainPanel(
                     plotlyOutput("irisPlot")
                 )
             )),
    tabPanel("class predictor")
))
