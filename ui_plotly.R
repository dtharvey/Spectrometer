# user interface

library(shiny)
library(shinythemes)
library(plotly)

ui = navbarPage("AC 3.0: Scanning Monochromator",
                theme = shinytheme("cosmo"),
                
  # user interface for about tab
  tabPanel("About",
   fluidRow(
     column(width = 6,
      wellPanel(
        includeHTML("about.html")
      )
    ),
     column(width = 6,
        img(src = "monochromator.png"),
        includeHTML("spec_fig_cap.html")
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
             plotlyOutput("standard1")
          ) # close column
        ) # close fluid row    
      ), # close tab
  
  # user interface for activity 2 tab
  tabPanel("Activity 2",
   fluidRow(
    column(width = 6,
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
        wellPanel(              
        includeHTML("activity2.html")
  )),
             
        column(width = 6,
         plotOutput("spectrum", height = "600px")
             )
  )),
  
  tabPanel("Assessment",
    fluidRow(
      column(width = 6,
        wellPanel(
          includeHTML("assessment.html")
        )     
             ),
      column(width = 6
             
             )
    )
           )
  
)
