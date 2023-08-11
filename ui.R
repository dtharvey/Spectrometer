# user interface for spectrometer

library(shiny)
library(shinythemes)

ui = navbarPage("AC 3.0: Scanning Monochromator",
                theme = shinytheme("journal"),
                header = tags$head(
                  tags$link(rel = "stylesheet", 
                            type = "text/css", 
                            href = "style.css")),
                
  # user interface for about tab
  tabPanel("Introduction",
   fluidRow(
     column(width = 6,
      wellPanel(
        includeHTML("text/introduction.html")
      )
    ),
     column(width = 6,
            align = "center",
        img(src = "monochromator.png", height = "450px"),
        br(),
        br(),
        br(),
        img(src = "slits.png", height = "200px")
            )
   )         
           ),
  
  # user interface for activity 1 tab
  tabPanel("Absorbance Spectrum",
    fluidRow(
      column(width = 6,
         wellPanel(     
      includeHTML("text/abs_spectrum.html")
        ) # close well panel     
      ), # close column
      column(width = 6,
             align = "center",
             splitLayout(
               sliderInput(inputId = "wavelength", 
                           label = "wavelength (nm)",
                           min = 240, max = 290, value = 265,
                           step = 0.1, width = "200px", ticks = FALSE
               ), # close slider input
               sliderInput(inputId = "absorbance", 
                           label = "absorbance (arbitrary unit)",
                           min = -0.1, max = 0.6, value = 0.25,
                           step = 0.01, width = "200px", ticks = FALSE
               ),
               downloadButton("stdspect","download standard spectrum")),
             plotOutput("standard1", height = "600px"),
          
          ) # close column
        ) # close fluid row    
      ), # close tab
  
  # user interface for explore variables tab
  tabPanel("Exploring Variables",
   fluidRow(
    column(width = 6,
      
        wellPanel(
        includeHTML("text/explore.html")
  )),
             
        column(width = 6,
               align = "center",
               splitLayout(
                 radioButtons("slitwidth",
                              label = "slit width (nm)",
                              selected = 1,
                              inline = FALSE,
                              choiceNames = c("0.25", "1.0", "2.0", "4.0"),
                              choiceValues = c(1,2,3,4)),
                 radioButtons("response",
                              label = "response time (s)",
                              selected = 1,
                              inline = FALSE,
                              choiceNames = c("0.10", "0.50", "2.0", "10.0"),
                              choiceValues = c(1,2,3,4)),
                 radioButtons("scanrate",
                              label = "scan rate (nm/min)",
                              selected = 1,
                              inline = FALSE,
                              choiceNames = c("10", "20", "60", "120","200", "300"),
                              choiceValues = c(1,2,3,4,5,6)),
                 downloadButton("spec", "download spectrum")
               ),
         plotOutput("spectrum", height = "500px"),
             )
  )),
  
  # user interface for optimize variables tab
  tabPanel("Optimizing Variables",
    fluidRow(
      column(width = 6,
        wellPanel(
          includeHTML("text/optimize.html")
        )
        ),
      column(width = 6,
             align = "center",
             splitLayout(
               selectInput("questionnumber", 
                           label = NULL, 
                           choices = c("Set 1: Slit Width", 
                                       "Set 2: Response Time",
                                       "Set 3: Scan Rate"),
                           selectize = FALSE)
             ),
             plotOutput("questionspectra", height = "650px")
             ) # close column
      
    ) # close fluid row
           ), # close tabpanel
  
  # user interface for wrapping up
  tabPanel("Wrapping Up",
    fluidRow(
      column(width = 6,
        wellPanel(id = "wrapuppanel",
                  style = "overflow-y:scroll; max-height: 750px",
        includeHTML("text/wrapup.html")
             )),
      column(width = 6,
             align="center",
             plotOutput("resptime", width = "60%"),
             tags$video(src = "scanning.mp4", 
                        type = "video/mp4", 
                        width = "60%", 
                        controls = "controls")
             )
    )       
           )
  
) # close navbarPage

