
library(shiny)
library(plotly)

# Define UI for application that draws a histogram
ui = fluidPage(title = "Scanning Monochromator",
      fluidRow(
        column(width = 6,
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
                       choiceNames = c("10", "20", "60", "120", "200", 
                                      "300", "750", "1500"),
                       choiceValues = c(1,2,3,4,5,6,7,8))
        ),
        
        column(width = 6,
           plotlyOutput("spectrum")
               )
      ))  
  
# Define server logic required to draw a histogram
server = function(input, output) {
  #  create plot of spectrum 
  output$spectrum = renderPlotly({
    
    # convert values as text into values as values as integers
    slit_width = as.numeric(input$slitwidth)
    response_time = as.numeric(input$response)
    scan_rate = as.numeric(input$scanrate)
    
    # determine number for file's title and read in data from .csv file
    filenumber = 100 * slit_width + 10 * response_time + scan_rate
    filename = paste0("spectra_csv/", as.character(filenumber), ".csv")
    spec = read.csv(file = filename)
    
    # plot spectrum
    plot_ly(spec, x = ~wavelength, y = ~absorbance, 
            mode = "lines", 
            lwd = 2, col = "blue", 
            xlab = "wavelength (nm)", ylab = "absorbance", 
            xlim = c(240, 290), ylim = c(-0.1,0.6))
  }) # close output$spectrum
  }


# Run the application 

