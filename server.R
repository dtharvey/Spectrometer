# server for spectrometer

library(shiny)
library(shinythemes)

# set colors
palette("Okabe-Ito")

# read in standard spectrum and spectra for activity 3
std = read.csv(file = "spectra_csv/standard.csv")

Q1a = read.csv(file = "spectra_csv/113.csv")
Q1b = read.csv(file = "spectra_csv/213.csv")
Q1c = read.csv(file = "spectra_csv/313.csv")
Q1d = read.csv(file = "spectra_csv/413.csv")

Q2a = read.csv(file = "spectra_csv/213.csv")
Q2b = read.csv(file = "spectra_csv/223.csv")
Q2c = read.csv(file = "spectra_csv/233.csv")
Q2d = read.csv(file = "spectra_csv/243.csv")

Q3a = read.csv(file = "spectra_csv/223.csv")
Q3b = read.csv(file = "spectra_csv/224.csv")
Q3c = read.csv(file = "spectra_csv/225.csv")
Q3d = read.csv(file = "spectra_csv/226.csv")



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
  
  # plot for activity 1
  output$standard1 = renderPlot({
    plot(x = std$wavelength, y = std$absorbance,
         lwd = 2, col = 8, type = "l",
         xlab = "wavelength (nm)", xlim = c(240,290),
         ylab = "absorbance (arbitrary units)", ylim = c(-0.1,0.6),
         main = "standard spectrum"
         )
    abline(v = input$wavelength, lty = 2, col = 1)
    abline(h = input$absorbance, lty = 2, col = 1)
    grid()
  })
  
  # plot for activity 2
  # plot spectrum given choice of slit width, response time, scan rate
  output$spectrum = renderPlot({
    plot(x = spec()$wavelength, y = spec()$absorbance,
         lwd = 2, col = 6, type = "l", 
         xlab = "wavelength (nm)", xlim = c(240,290),
         ylab = "absorbance (arbitrary units)", ylim = c(-0.1,0.6)
         )
    lines(x = std$wavelength, y = std$absorbance,
          lwd = 2, col = 8, lty = 2)
    legend(x = "topright", 
           legend = c("experimental spectrum", "standard spectrum"),
           lwd = 2, col = c(6, 8), lty = c(1,2),
           bty = "n")
    grid()
  })
  
  # plot spectra for activity 3
  output$questionspectra = renderPlot({
    if (input$questionnumber == "Set 1: Slit Width"){
      old.par = par(mfrow = c(2,2))
      plot(x = Q1a$wavelength, y = Q1a$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2,
           main = "sw: 0.25 nm; rt: 0.1 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 2, col = 8, lty = 2)
      grid()
      plot(x =Q1b$wavelength, y = Q1b$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2,
           main = "sw: 1.0 nm; rt: 0.1 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 2, col = 8, lty = 2)
      grid()
      plot(x =Q1c$wavelength, y = Q1c$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2,
           main = "sw: 2.0 nm; rt: 0.1 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 2, col = 8, lty = 2)
      grid()
      plot(x =Q1d$wavelength, y = Q1d$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2,
           main = "sw: 4.0 nm; rt: 0.1 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 2, col = 8, lty = 2)
      grid()
      par(old.par)
    } else if (input$questionnumber == "Set 2: Response Time"){
      old.par = par(mfrow = c(2,2))
      plot(x = Q2a$wavelength, y = Q2a$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2, 
           main = "sw: 1.0 nm; rt: 0.10 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 2, col = 8, lty = 2)
      grid()
      plot(x = Q2b$wavelength, y = Q2b$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2,
           main = "sw: 1.0 nm; rt: 0.50 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 2, col = 8, lty = 2)
      grid()
      plot(x = Q2c$wavelength, y = Q2c$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2,
           main = "sw: 1.0 nm; rt: 2.0 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 2, col = 8, lty = 2)
      grid()
      plot(x = Q2d$wavelength, y = Q2d$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2,
           main = "sw: 1.0 nm; rt: 10.0 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 2, col = 8, lty = 2)
      grid()
      par(old.par)
    } else if (input$questionnumber == "Set 3: Scan Rate"){
      old.par = par(mfrow = c(2,2))
      plot(x = Q3a$wavelength, y = Q3a$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2, 
           main = "sw: 1.0 nm; rt: 0.50 s; s5: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 2, col = 8, lty = 2)
      grid()
      plot(x = Q3b$wavelength, y = Q3b$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2,
           main = "sw: 1.0 nm; rt: 0.50 s; s5: 120 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 2, col = 8, lty = 2)
      grid()
      plot(x = Q3c$wavelength, y = Q3c$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2,
           main = "sw: 1.0 nm; rt: 0.50 s; s5: 200 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 2, col = 8, lty = 2)
      grid()
      plot(x = Q3d$wavelength, y = Q3d$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2,
           main = "sw: 1.0 nm; rt: 0.50 s; s5: 300 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 2, col = 8, lty = 2)
      grid()
      par(old.par)
  }
  
  })
}
