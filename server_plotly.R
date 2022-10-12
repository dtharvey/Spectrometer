
# read in standard spectrum
std = read.csv(file = "spectra_csv/standard.csv")

library(shiny)
library(shinythemes)
library(plotly)

server = function(input, output) {
  
  # read in data and store in object spec
  spec = reactive({
    slit_width = as.numeric(input$slitwidth)
    response_time = as.numeric(input$response)
    scan_rate = as.numeric(input$scanrate)
  
    # determine number for file's title and read in data from .csv file
    filenumber = 100 * slit_width + 10 * response_time + scan_rate
    filename = paste0("spectra_csv/", as.character(filenumber), ".csv")
    out = read.csv(file = filename)
  })
  
  output$standard1 = renderPlotly({
    plot_ly() %>%
    add_trace(type = "scatter",
                    mode = "lines",
                    name = "standard",
                    color = I("magenta"),
                    x = std$wavelength,
                    y = std$absorbance) %>%
    layout(xaxis = list(title = "wavelength (nm)",
                              range = list(240,290)),
                 yaxis = list(title = "absorbance (arbitrary units)",
                              range = list(-0.1,0.6)))

  })
  
  # plot spectrum given choice of slit width, response time, scan rate
  output$spectrum = renderPlot({
    
    # plot spectrum
    plot(x = spec()$wavelength, y = spec()$absorbance,
         lwd = 2, col = "blue", type = "l", 
         xlab = "wavelength (nm)", xlim = c(240,290),
         ylab = "absorbance", ylim = c(-0.1,0.6)
         )
    lines(x = std$wavelength, y = std$absorbance,
          lwd = 2, col = "magenta", lty = 2)
    legend(x = "topright", legend = c("experimental", "standard"),
           lwd = 2, col = c("blue", "magenta"), lty = c(1,2),
           bty = "n")
    grid()
  })
  }
