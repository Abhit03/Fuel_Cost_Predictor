library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Fuel Cost prediction App"),
  
  sidebarLayout(
    sidebarPanel(
       sliderInput("displacement",
                   "Displacement (cu.in.)",
                   min = 50,
                   max = 500,
                   value = 100),
       
       sliderInput("horsepower",
                   "Gross horsepower",
                   min = 50,
                   max = 500,
                   value = 100),
       
       sliderInput("weight",
                   "Weight (1000 lbs)",
                   min = 0,
                   max = 10,
                   value = 2),
       
       selectInput("cylinder",
                   "Number of cylinders", 
                   choices = list("4" = 1, "6" = 2, "8" = 3), 
                   selected = 1),
       
       selectInput("transmission",
                   "Transmission Type", 
                   choices = list("Automatic" = 0, "Manual" = 1), 
                   selected = 1),
      
        helpText("How many miles do you commute daily on an average ?"),
       
        sliderInput("distance",
                   "Daily Distance (miles)",
                   min = 0,
                   max = 100,
                   value = 10),
       
       helpText("Select variables to include in the regression model for prediction"),
       
       checkboxGroupInput("vars", 
                          "Variables to include", 
                          choices = list("Gross horsepower" = 1, 
                                         "Displacement (cu.in.)" = 2, 
                                         "Weight " = 3,
                                         "Number of cylinders" = 4,
                                         "Transmission Type" = 5),
                          selected = c(1, 2, 3, 4, 5))

    ),

    mainPanel(
      h3("What does this App do ?"),
      p("It uses linear models to predict the yearly fuel cost based on your car's specifications like horsepower, weight, transmission type etc"),
      p("souce code - ",a("ui.r and server.r", href = "https://github.com/Abhit03/Fuel_Cost_Predictor")),
      h3("How to use this App ?"),
      p("From the left sidebar panel you can change the car's specs to match your car.
        It will output the predicted yearly fuel cost. You can also select the variables to include in the linear model from the checkbox on bottom left. 
        The diagnostic plot of the selected model compares the fitted values vs Observed values"),
      h3('Output'),
      h4("How much will you spend for your car on fuel in a year (US dollars)?"),
      p('Vary the sliders to match your car specifications to predict yearly fuel expenditure'), 
      verbatimTextOutput("pred_val"),
      p('Prediction Confidence interval - We can say with 95% confidence that the predicted 
        value will lie in this interval for the statistical model used'),
      verbatimTextOutput('conf_int'),
      h4('Diagnostic Plot of selected model'),
      p("select/unselect in checkbox to include desired variables in the prediction model"),
      plotOutput("comp_plot")
    )
  )
))
