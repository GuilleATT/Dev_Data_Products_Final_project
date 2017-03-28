
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotrix)

shinyServer(function(input, output) {

                
        
  output$myPlot <- renderPlot({
        the_seed<-input$seed
        set.seed(the_seed)
        number_of_points<-input$cantidad
        dataX<-runif(number_of_points,0,100)
        dataY<-runif(number_of_points,0,100)
        puntos<-data.frame(x=dataX,y=dataY)
        plot(dataX,dataY,xlim=c(0,100),ylim=c(0,100),xlab="",ylab="")
        radio<-input$radiocirculo
        draw.circle(50,50,radio,border="purple",lty=1,lwd=1)
        areacalculada<-mean((puntos[1]-50)^2+(puntos[2]-50)^2<=radio^2)*100

  })
  
  
  
  output$myPlot2 <- renderPlot({
          the_seed<-input$seed
          set.seed(the_seed)
          number_of_points<-input$cantidad
          dataX<-runif(number_of_points,0,100)
          dataY<-runif(number_of_points,0,100)
          puntos<-data.frame(x=dataX,y=dataY)
          radio2<-10:50
          PropArea<-round(pi*radio2^2,0)/10000
          AreaReal<-round(pi*radio2^2,0)
          puntos<-data.frame(x=dataX,y=dataY)
          AreaCalc<-sapply(radio2,function(x) mean((puntos[1]-50)^2+(puntos[2]-50)^2<=x^2)*10000)
          #AreaCalc<-mean((puntos[1]-50)^2+(puntos[2]-50)^2<=radio2[i]^2)*100
          #AreaCalc<-mean((puntos[1]-50)^2+(puntos[2]-50)^2<=radio2^2)*100
          Error<-sqrt((AreaReal-AreaCalc)^2)/AreaReal*100
          plot(PropArea,Error,ylim=c(0,40),xlab="Proportion of Areas (All posible Circles / Square)",ylab="% Error MonteCarlo",type="l")
          abline(h=0,col="red")
          abline(h=1/sqrt(number_of_points)*100,col="blue")
          legend("topright",lty=1,col="blue",legend="Theoretical Error")
          #line(x=PropArea,y=rep(1/sqrt(number_of_points),length))
          
          
          
          
  })
  
  calc_areaTeorica<-reactive({
          radio<-input$radiocirculo
          round(pi*radio^2,0)
  }) 
  
  output$areaTeorica<-renderText({paste("Geometric Circle Area:   ",calc_areaTeorica())})
  
  calc_areaMontecarlo<-reactive({
          the_seed<-input$seed
          set.seed(the_seed)
          number_of_points<-input$cantidad
          dataX<-runif(number_of_points,0,100)
          dataY<-runif(number_of_points,0,100)
          puntos<-data.frame(x=dataX,y=dataY)
          radio<-input$radiocirculo
          round(mean((puntos[1]-50)^2+(puntos[2]-50)^2<=radio^2)*10000,0)
  }) 
  
  output$areaMonteCarlo<-renderText({paste("MonteCarlo Circle Area: ",calc_areaMontecarlo())})
  
  calc_theoreticalError<-reactive({
          the_seed<-input$seed
          samples<-input$cantidad
          round((1/sqrt(samples))*100,1)
  }) 
  
  output$theoreticalError<-renderText({paste("MonteCarlo Theoretical Error: ",calc_theoreticalError(),"%")})
  
  calc_trueError<-reactive({
          radio<-input$radiocirculo
          areateo<-round(pi*radio^2,0)
          the_seed<-input$seed
          set.seed(the_seed)
          number_of_points<-input$cantidad
          dataX<-runif(number_of_points,0,100)
          dataY<-runif(number_of_points,0,100)
          puntos<-data.frame(x=dataX,y=dataY)
          radio<-input$radiocirculo
          areacalc<-mean((puntos[1]-50)^2+(puntos[2]-50)^2<=radio^2)*10000
          
          round(((sqrt((areateo-areacalc)^2))/areateo)*100,1)
  }) 
  
  #calc_trueError2(radio2){
        #  areateo<-round(pi*radio2^2,0)
       #   the_seed<-input$seed
      #    set.seed(the_seed)
      #    number_of_points<-input$cantidad
      #    dataX<-runif(number_of_points,0,100)
      #    dataY<-runif(number_of_points,0,100)
      #    puntos<-data.frame(x=dataX,y=dataY)
     #     radio<-input$radiocirculo
    #      areacalc<-mean((puntos[1]-50)^2+(puntos[2]-50)^2<=radio^2)*10000
          
   #       round(((sqrt((areateo-areacalc)^2))/areateo)*100,1)
  #}
  
  output$trueError<-renderText({paste("MonteCarlo True Error: ",calc_trueError(),"%")})
  
  output$mylist<-renderUI(HTML("<ul>
                                <li>
                                <strong>Number of random points </strong>
                                        <p>Slide the point through the bar to determine the number of point to be generated in the experimentation area from 10 to 1000 points. </p>
                               </li>
                               <li>
                                <strong>Radius of the circle </strong>
                               <p>Slide the point through the bar to determine the radius of the circle in the experimentation area from 10 to 50 units. </p>
                               </li>
                               <li>
                                <strong>Change the seed for random number generation </strong>
                               <p> Use the arrows or introduce by hand the number used for the seed to generate pseudo-random points. Values accepted go from 1 to 9999. </p>
                               </li>
                               </ul>"))
})
