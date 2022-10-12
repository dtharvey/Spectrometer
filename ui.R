# user interface

library(shiny)
library(shinythemes)

ui = navbarPage("AC 3.0: Scanning Monochromator",
                theme = shinytheme("cosmo"),
                tags$head(
                  tags$link(rel = "stylesheet", 
                            type = "text/css", 
                            href = "style.css")),
                
  # user interface for about tab
  tabPanel("Introduction",
   fluidRow(
     column(width = 6,
      wellPanel(
        includeHTML("introduction.html")
      )
    ),
     column(width = 6,
            align = "center",
        img(src = "monochromator.png"),
        br(),
        img(src = "slits.png", height = "200px")
            )
   )         
           ),
  
  # user interface for activity 1 tab
  tabPanel("Activity 1",
    fluidRow(
      column(width = 6,
         wellPanel(     
      includeHTML("activity1.html")
        ) # close well panel     
      ), # close column
      column(width = 6,
             plotOutput("standard1", width = "100%", height = "450px"),
             wellPanel(
               sliderInput(inputId = "wavelength", 
                           label = "wavelength (nm)",
                           min = 240,
                           max = 290,
                           value = 265,
                           step = 0.1
               ), # close slider input
               sliderInput(inputId = "absorbance", 
                           label = "absorbance (arbitrary unit)",
                           min = -0.1,
                           max = 0.6,
                           value = 0.25,
                           step = 0.01
               )), # close slider input
          ) # close column
        ) # close fluid row    
      ), # close tab
  
  # user interface for activity 2 tab
  tabPanel("Activity 2",
   fluidRow(
    column(width = 6,
      
        wellPanel(
        includeHTML("activity2.html")
  )),
             
        column(width = 6,
         plotOutput("spectrum", height = "500px"),
         wellPanel(
           radioButtons("slitwidth",
                        label = "slit width (nm)",
                        selected = 1,
                        inline = TRUE,
                        choiceNames = c("0.25", "1.0", "2.0", "4.0"),
                        choiceValues = c(1,2,3,4)),
           radioButtons("response",
                        label = "response time (s)",
                        selected = 1,
                        inline = TRUE,
                        choiceNames = c("0.10", "0.50", "2.0", "10.0"),
                        choiceValues = c(1,2,3,4)),
           radioButtons("scanrate",
                        label = "scan rate (nm/min)",
                        selected = 1,
                        inline = TRUE,
                        choiceNames = c("10", "20", "60", "120","200", "300"),
                        choiceValues = c(1,2,3,4,5,6))),
             )
  )),
  
  # user interface for activity 3 tab
  tabPanel("Activity 3",
    fluidRow(
      column(width = 6,
        wellPanel(
          includeHTML("activity3.html")
        )
        ),
      column(width = 6,
             wellPanel(
               selectInput("questionnumber", 
                           label = NULL, 
                           choices = c("Set 1", "Set 2","Set 3"))
             ),
             plotOutput("questionspectra", height = "650px")
             ) # close column
      
    ) # close fluid row
           ), # close tabpanel
  
  # user interface for wrapping up
  tabPanel("Wrapping Up",
    fluidRow(
      column(width = 6,
        wellPanel(
        includeHTML("wrapup.html")
             )),
      column(width = 6,
             align="center",
             tags$video(src = "scanning.mp4", 
                        type = "video/mp4", 
                        width = "100%", 
                        controls = "controls")
             )
    )       
           )
  
) # close navbarPage

