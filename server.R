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
  
  # plot for absorbance spectrum tab
  output$standard1 = renderPlot({
    plot(x = std$wavelength, y = std$absorbance,
         lwd = 4, col = 6, type = "l",
         xlab = "wavelength (nm)", xlim = c(240,290),
         ylab = "absorbance (arbitrary units)", ylim = c(-0.1,0.6),
         main = "standard spectrum: slit width 1.0 nm, response time 0.5 s, scan rate 5.0 nm/min"
         )
    abline(v = input$wavelength, lty = 2, lwd = 2, col = 3)
    abline(h = input$absorbance, lty = 2, lwd = 2, col = 3)
    grid()
  })
  
  # plot for explore
  # plot spectrum given choice of slit width, response time, scan rate
  output$spectrum = renderPlot({
    plot(x = spec()$wavelength, y = spec()$absorbance,
         lwd = 4, col = 6, type = "l", 
         xlab = "wavelength (nm)", xlim = c(240,290),
         ylab = "absorbance (arbitrary units)", ylim = c(-0.1,0.6)
         )
    lines(x = std$wavelength, y = std$absorbance,
          lwd = 3, col = 2, lty = 3)
    legend(x = "topright", 
           legend = c("experimental spectrum", "standard spectrum"),
           lwd = c(4,3), col = c(6, 2), lty = c(1,3),
           bty = "n")
    grid()
  })
  
  # plot spectra for optimize
  output$questionspectra = renderPlot({
    if (input$questionnumber == "Set 1: Slit Width"){
      old.par = par(mfrow = c(2,2))
      plot(x = Q1a$wavelength, y = Q1a$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 4,
           main = "sw: 0.25 nm; rt: 0.1 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 3, col = 2, lty = 3)
      legend(x = "topright", 
             legend = c("experimental spectrum", "standard spectrum"),
             lwd = c(4,3), col = c(6, 2), lty = c(1,3),
             bty = "n")
      grid()
      plot(x =Q1b$wavelength, y = Q1b$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 4,
           main = "sw: 1.0 nm; rt: 0.1 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 3, col = 2, lty = 3)
      legend(x = "topright", 
             legend = c("experimental spectrum", "standard spectrum"),
             lwd = c(4,3), col = c(6, 2), lty = c(1,3),
             bty = "n")
      grid()
      plot(x =Q1c$wavelength, y = Q1c$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 4,
           main = "sw: 2.0 nm; rt: 0.1 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 3, col = 2, lty = 3)
      legend(x = "topright", 
             legend = c("experimental spectrum", "standard spectrum"),
             lwd = c(4,3), col = c(6, 2), lty = c(1,3),
             bty = "n")
      grid()
      plot(x =Q1d$wavelength, y = Q1d$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 4,
           main = "sw: 4.0 nm; rt: 0.1 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 3, col = 2, lty = 3)
      legend(x = "topright", 
             legend = c("experimental spectrum", "standard spectrum"),
             lwd = c(4,3), col = c(6, 2), lty = c(1,3),
             bty = "n")
      grid()
      par(old.par)
    } else if (input$questionnumber == "Set 2: Response Time"){
      old.par = par(mfrow = c(2,2))
      plot(x = Q2a$wavelength, y = Q2a$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 4, 
           main = "sw: 1.0 nm; rt: 0.10 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 3, col = 2, lty = 3)
      legend(x = "topright", 
             legend = c("experimental spectrum", "standard spectrum"),
             lwd = c(4,3), col = c(6, 2), lty = c(1,3),
             bty = "n")
      grid()
      plot(x = Q2b$wavelength, y = Q2b$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 4,
           main = "sw: 1.0 nm; rt: 0.50 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 3, col = 2, lty = 3)
      legend(x = "topright", 
             legend = c("experimental spectrum", "standard spectrum"),
             lwd = c(4,3), col = c(6, 2), lty = c(1,3),
             bty = "n")
      grid()
      plot(x = Q2c$wavelength, y = Q2c$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 4,
           main = "sw: 1.0 nm; rt: 2.0 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 3, col = 2, lty = 3)
      legend(x = "topright", 
             legend = c("experimental spectrum", "standard spectrum"),
             lwd = c(4,3), col = c(6, 2), lty = c(1,3),
             bty = "n")
      grid()
      plot(x = Q2d$wavelength, y = Q2d$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 4,
           main = "sw: 1.0 nm; rt: 10.0 s; sr: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 3, col = 2, lty = 3)
      legend(x = "topright", 
             legend = c("experimental spectrum", "standard spectrum"),
             lwd = c(4,3), col = c(6, 2), lty = c(1,3),
             bty = "n")
      grid()
      par(old.par)
    } else if (input$questionnumber == "Set 3: Scan Rate"){
      old.par = par(mfrow = c(2,2))
      plot(x = Q3a$wavelength, y = Q3a$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 4, 
           main = "sw: 1.0 nm; rt: 0.50 s; s5: 60 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 3, col = 2, lty = 3)
      legend(x = "topright", 
             legend = c("experimental spectrum", "standard spectrum"),
             lwd = c(4,3), col = c(6, 2), lty = c(1,3),
             bty = "n")
      grid()
      plot(x = Q3b$wavelength, y = Q3b$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 4,
           main = "sw: 1.0 nm; rt: 0.50 s; s5: 120 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 3, col = 2, lty = 3)
      legend(x = "topright", 
             legend = c("experimental spectrum", "standard spectrum"),
             lwd = c(4,3), col = c(6, 2), lty = c(1,3),
             bty = "n")
      grid()
      plot(x = Q3c$wavelength, y = Q3c$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 2,
           main = "sw: 1.0 nm; rt: 0.50 s; s5: 200 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 3, col = 2, lty = 3)
      legend(x = "topright", 
             legend = c("experimental spectrum", "standard spectrum"),
             lwd = c(4,3), col = c(6, 2), lty = c(1,3),
             bty = "n")
      grid()
      plot(x = Q3d$wavelength, y = Q3d$absorbance,
           xlim = c(240,290), xlab = "wavelength (nm)",
           ylim = c(-0.1,0.6), ylab = "absorbance (arbitrary units)",
           type = "l", col = 6, lwd = 4,
           main = "sw: 1.0 nm; rt: 0.50 s; s5: 300 nm/min")
      lines(x = std$wavelength, y = std$absorbance,
            lwd = 3, col = 2, lty = 3)
      legend(x = "topright", 
             legend = c("experimental spectrum", "standard spectrum"),
             lwd = c(4,3), col = c(6, 2), lty = c(1,3),
             bty = "n")
      grid()
      par(old.par)
  }
  })
  
  output$stdspect = downloadHandler(
    filename = "std_spec.csv",
    content = function(file){
      write.csv(std,file)
    })
  
  output$spec = downloadHandler(
    filename = function(){
      paste0("spectrum",input$slitwidth,input$response,input$scanrate,".csv")
    },
    content = function(file){
      write.csv(spec(),file)
    })
  
  output$resptime = renderPlot({
    x1 = seq(0,2,0.01)
    x2 = seq(2.01,10,0.01)
    y1 = rep(0,length(x1))
    y2 = rep(1,length(x2))
    plot(x = c(x1,x2), y = c(y1,y2), 
         type = "l", lwd = 3, col = 6, 
         xlab = "", xaxt = "n", xlim = c(-1,10),
         ylab = "", yaxt = "n", ylim = c(-0.1,1))
    lines(x = (x2), y = (1 - exp(-(x2-2)/1.5) ), 
          col = 2, lty = 3, lwd = 3)
    points(x = 3.5, y = 0.632, pch = 19, cex = 1.25)
    text(x = -0.7, y = 0, expression(S[0]), cex = 1.25)
    text(x = 1.5, y = 1, expression(S[1]), cex = 1.25)
    text(x = 2, y = -0.05, expression(t[0]), cex = 1.25)
    text(x = 6, y = -0.025, "time", cex = 1.25)
    text(x = 1.5, y = 0.5, "signal", srt = 90, cex = 1.25)
    legend(x = "right", 
           legend = c("ideal response", "actual response"),
           lwd = 3, col = c(6,2), lty = c(1,3), bty = "n", cex = 1.25)
    grid()
  })
  
}
