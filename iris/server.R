#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

  observeEvent(input$yvar,
    updateSelectizeInput(session, "xvar",
                         choices = setdiff(colnames(iris)[1:4],
                                           input$yvar),
                         selected = input$xvar))

  observeEvent(input$xvar,
    updateSelectizeInput(session, "yvar",
                         choices = setdiff(colnames(iris)[1:4],
                                           input$xvar),
                         selected = input$yvar))

  output$irisPlot <- renderPlotly({
      if (input$col == "True") {
          p = ggplot(iris,
                     aes_string(x = input$xvar, y = input$yvar,
                         color = "Species"))
      }
      else {
          p = ggplot(iris, aes_string(x = input$xvar, y = input$yvar))
      }
      p + geom_point(size = input$ps, alpha = .7) + theme_bw()
  })

})
