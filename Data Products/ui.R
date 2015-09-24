shinyUI(fluidPage(
    
    # Application title
    titlePanel("MPG Predction"),
    
    # Sidebar
    sidebarLayout(
        sidebarPanel(
            helpText("MPG Prediction based on Coursera's Linear Regression Class"),
            p("Just type in the weight of your car, the number of cylinders and the horsepower"),
            br(),
            p("This little app will estimate your MPGs"),
            numericInput("weight",
                        "Weight of your car in lbs/1000:",
                        min = 1,
                        max = 3,
                        value = 2,
                        step=0.01),
            
            numericInput("horse",
                         "Horsepower:",
                         min = 50,
                         max = 250,
                         value = 100,
                         step=5),
            
            selectInput("cylinders", label=p("Number of cylinders"), choices = setNames(as.numeric(c(4,6,8)), c("4","6","8")), selected = 1)
            
),
        
        # Show a plot and the predicted value
        mainPanel(
            p("The estimated MPG is"),
            textOutput("text1"),
            br(),
            br(),
            plotOutput("graph1",click="plot_click"),
            br(),
            p("Click on the datapoints near of the red cross to compare with other cars from the data set"),
            br(),
            verbatimTextOutput("click_info")
        )# mainPanel
        


) # sidebarLayout
) # fluidpage
) # shiny UI
