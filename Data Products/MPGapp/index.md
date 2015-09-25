---
title       : MPG Estimation  
subtitle    : Shiny App
author      : Alexander Bruns
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---



# Introduction

### What's the story?

Build a web app which predicts the miles per gallon for a given set of car attributes. 
The prediction was already built in the **linear regression** class. 
Therefore this job adds the graphical interface to the function.

### Requierements

* Interactive prediction of MPG using the mtcars dataset
* Plotting of results in *ggplot*
* Comparison to other cars


--- 

# Implementation

### server.R

1 Fit the model



```r
mtcars<-mtcars[,c("mpg","wt","cyl","hp")]
mtcars$cyl<-factor(mtcars$cyl)
fit<-lm(mpg~wt+cyl+hp,data=mtcars)
```

2 Predict with the data

```r
# The shiny part
shinyServer(function(input, output) {
   
output$text1 <- renderText({
mpg_pred<-predict(fit,newdata=data.frame(wt=input$weight,cyl=input$cylinders,hp=input$horse),
response="prediction")
mpg_pred
                              })
```

---

# Implementation

### server.R

3 Generate the plot

```r
output$graph1<-renderPlot({
mpg_pred<-predict(fit,newdata=data.frame(wt=input$weight,cyl=input$cylinders,hp=input$horse),
                          response="prediction")
    ggplot(data=mtcars,aes(y=mpg,x=wt),color=cyl,geom="point")
    +geom_point(aes(colour=cyl))
    +geom_point(x=input$weight,y=mpg_pred,color="red",size=8,shape=4)
    +theme_minimal()
    +xlab("Weight lbs/1000")+ylab("MPG")+ggtitle("Compare your car")})
```

4 Compare to other cars

```r
    output$click_info <- renderPrint({
        nearPoints(mtcars[,], input$plot_click, addDist = FALSE)})
```

---

# Implementation 

### ui.R

The ui.R had the following requierements:

* numeric input for horsepower and weight
    * numericInput()
* dropdown menu for cylinder number
    * selectInput
* click info for the ggplot plot
    * plotOutput(click="var")

---

# The app in action

### Shiny App

https://albruns.shinyapps.io/MPGapp

### Github Repo

https://github.com/albruns/Portfolio/tree/master/Data%20Products

