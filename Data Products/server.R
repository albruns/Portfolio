#server.R

library(ggplot2)
library(shiny)
data(mtcars)
# Some pre-processing based on a previous project
mtcars<-mtcars[,c("mpg","wt","cyl","hp")]
mtcars$cyl<-factor(mtcars$cyl)

# Linear Model generation
fit<-lm(mpg~wt+cyl+hp,data=mtcars)

# The shiny part
shinyServer(function(input, output) {
   
    output$text1 <- renderText({
        mpg_pred<-predict(fit,newdata=data.frame(wt=input$weight,cyl=input$cylinders,hp=input$horse),response="prediction")
        mpg_pred
                               })
    output$graph1<-renderPlot({
        mpg_pred<-predict(fit,newdata=data.frame(wt=input$weight,cyl=input$cylinders,hp=input$horse),response="prediction")
        ggplot(data=mtcars,aes(y=mpg,x=wt),color=cyl,geom="point")+geom_point(aes(colour=cyl))+geom_point(x=input$weight,y=mpg_pred,color="red",size=8,shape=4)+theme_minimal()+xlab("Weight lbs/1000")+ylab("MPG")+ggtitle("Compare your car")})

    ### this is from the shiny apps gallery http://shiny.rstudio.com/gallery/plot-interaction-selecting-points.html
    
    output$click_info <- renderPrint({
        nearPoints(mtcars[,], input$plot_click, addDist = FALSE)
        })
    
})




