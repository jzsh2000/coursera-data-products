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
library(markdown)

# Define UI for application that draws a histogram
shinyUI(navbarPage(title = "iris species predictor",

    tabPanel("document",
             fluidRow(
                 column(width = 8,
                        includeMarkdown("doc.md"),
                        offset = 2)
             )),
    tabPanel("data viewer",
             # Application title
             titlePanel("iris data viewer"),

             # Sidebar with a slider input for number of bins
             sidebarLayout(
                 sidebarPanel(
                     selectizeInput("xvar",
                                    "variable 1",
                                    choices = colnames(iris)[1:4],
                                    selected = "Petal.Length"),
                     selectizeInput("yvar",
                                    "variable 2",
                                    choices = colnames(iris)[1:4],
                                    selected = "Petal.Width"),
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
    tabPanel("class predictor",
             titlePanel("iris class predictor"),
             sidebarLayout(
                 sidebarPanel(
                     numericInput("seed",
                                  "random seed",
                                  value = 2017,
                                  min = 0),
                     sliderInput("train_p",
                                 "training percentage",
                                 min = 0.2,
                                 max = 0.9,
                                 value = 0.7,
                                 step = 0.05),
                     sliderInput("cv_fold",
                                 "cross-validation fold",
                                 min = 2,
                                 max = 20,
                                 value = 10,
                                 step = 1),
                     radioButtons("train_method",
                                  "classification method",
                                  choices = c("rpart"),
                                  inline = TRUE)
                 ),
                 mainPanel(
                     tabsetPanel(
                         tabPanel("decision tree",
                                  plotOutput("rpartTree")),
                         tabPanel("confusion matrix",
                                  verbatimTextOutput("rpartSummary"))
                     )
                 )
             ))
))
