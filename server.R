library(shiny)

library(datasets)
data(mtcars)
cars <- mtcars[, c('hp', 'disp', 'wt', 'cyl', 'am', 'mpg')]

shinyServer(function(input, output) {
  
  selected_vals <- reactive({
    data.frame(hp = as.integer(input$horsepower), disp = as.integer(input$displacement), 
               wt = as.integer(input$weight), cyl = as.integer(input$cylinder), 
               am = as.integer(input$transmission))
  })
  
  fit_model <- reactive({
    selected_vars <- as.integer(input$vars)
    lm(mpg ~ ., data = cars[, c(6, selected_vars)])
  })
  
  output$comp_plot <- renderPlot({ 
    plot(cars$mpg, fitted.values(fit_model()), xlim = c(0, 40), ylim = c(0, 40), 
         xlab = 'Observed values (mpg)', ylab = 'Fitted Values (mpg)')
    abline(0, 1, col = 'blue', lwd = 1.5)
  })
  
  output$pred_val <- renderText({
    milesperyear <- as.integer(input$distance) * 365
    mpg <- predict.lm(fit_model(), newdata = selected_vals(), interval = 'predict')
    total_cost <- milesperyear * 2.5/mpg 
    c('Prediction:', as.integer(total_cost)[1], '$')
  })
  
  output$conf_int <- renderText({
    milesperyear <- as.integer(input$distance) * 365
    mpg <- predict.lm(fit_model(), newdata = selected_vals(), interval = 'predict')
    total_cost <- milesperyear * 2.5/mpg 
    c(as.integer(total_cost)[3], as.integer(total_cost)[2])
  })
  
}
)
  