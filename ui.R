
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("MonteCarlo method: Calculating a circle area"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("cantidad",
                  "Number of random points",
                  min = 10,
                  max = 1000,
                  value = 50),
      sliderInput("radiocirculo",
                  "Radius of the circle",
                  min = 10,
                  max = 50,
                  value = 20),
      numericInput("seed","Change the seed for random number generation",value=1234,min=1,max=9999,step=1)
    ),

    # Show a plot of the generated distribution
    mainPanel(
            tabsetPanel(type="tabs",
                tabPanel("Readme",br(),
                        h3("Introduction"),
                        p("The purpose of this app is to allow users to discover in a intuitive way the principles of MonteCarlo method. This method relies on repeated random sampling to obtain numerical results (often a deterministic problem).", a("Further reading",href="https://en.wikipedia.org/wiki/Monte_Carlo_method")),
                        p("In this case, the user will be able to determine the", strong("area of a circle."), "The areas are calculated in two different ways",strong("(1) Geometrical:"), "using the formula of the circle area,",strong("(2) Monte Carlo:"),"counting the number of points that landed inside the circle and dividing it by the total number of points drawn and then multipling it by the area of the experimentation surface (100x100 units^2)."),
                        p("Then, the ",strong("associated error")," of the Monte Carlo method is pointed out using two methods.",strong("(a)Empirically:"),"where the percentage of the difference of the two areas is calculated and ",strong("(b)Theoretically:"),"Where the formula 1/sqrt(n) from the",a("Central Limit Theorem",href="https://en.wikipedia.org/wiki/Central_limit_theorem")," is used being n the number of random points drawn"),
                        h3("Side Bar interaction buttons"),
                        uiOutput("mylist"),
                        h3("Tabs: Experimentation and Asymptotics"),
                        p("The Experimentation tab allows you to visually comprehend through a plot the results from the different settings of the two slider bars and the change of the seed for the random generation algorithm. Take a look at how the error values differ depending on the radius of the circle and the number of generated points. Furthermore, at the Asymptotics tab you may find that the bigger the circle, the more accurate the MonteCarlo approximation is.")
                        
                ),
                        
                        
                tabPanel("Experimentation", br(),     
                        plotOutput("myPlot",width = "350px", height = "390px"),
                        h4(textOutput("areaTeorica")),
                        h4(textOutput("areaMonteCarlo")),
                        h4(textOutput("theoreticalError")),
                        h4(textOutput("trueError"))
                ),
                
                tabPanel("Asymptotes",br(),       
                        plotOutput("myPlot2",width = "350px", height = "390px") 
                )
        
    )
  )
)))
