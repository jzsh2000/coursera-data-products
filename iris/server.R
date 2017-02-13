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
library(caret)
library(rpart)
library(rattle)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    genData <- reactive({
        set.seed(input$seed)
        createDataPartition(iris$Species, p = input$train_p,
                            list = FALSE)
    })

    trainModel <- reactive({
        withProgress(message = "generate model", value = 0,{
            incProgress(0.2, detail = "get training set")
            train_data = iris[genData(),]
            incProgress(0.2, detail = "train model")
            model =
                train(Species~.,
                      data = train_data,
                      method = "rpart",
                      trControl =
                          trainControl(method = "cv",
                                       number = input$cv_fold))
            setProgress(1)
        })
        model
    })

    output$irisPlot <- renderPlotly({
        if (input$col == "True") {
            p = ggplot(iris, aes_string(x = input$xvar,
                                        y = input$yvar,
                                        color = "Species"))
        }
        else {
            p = ggplot(iris, aes_string(x = input$xvar,
                                        y = input$yvar))
        }
        p + geom_point(size = input$ps, alpha = .7) + theme_bw()
    })

    output$rpartTree <- renderPlot({
        fancyRpartPlot(trainModel()$finalModel)
    })

    output$rpartSummary <- renderPrint({
        test_data = iris[-genData(),]
        model = trainModel()
        confusionMatrix(predict(model, newdata = test_data),
                        test_data$Species)
    })

})
