

# function to read data file and plot
plot_spectrum = function(slit = 1, response = 1, scanrate = 1){
  filenumber = slit * 100 + response * 10 + scanrate
  filename = paste0("spectra_csv/", as.character(filenumber), ".csv")
  spec = read.csv(file = filename)
  plot(x = spec$wavelength, y = spec$absorbance,
       lwd = 2, col = "blue", type = "l",
       xlab = "wavelength (nm)", ylab = "absorbance",
       main = filename)
}

# check one spectrum
plot_spectrum(1,1,1)

# check plots
for (i in 1:4){
  for (j in 1:4){
    plot_spectrum(i,j,1)
  }
}

# create data file
k = 1
for (i in 1:4){
  for (j in 1:4){
    filenumber = i * 100 + 10 * j + k
    cvsfile = paste0("spectra_csv/", as.character(filenumber), ".csv")
    paste0(as.character(filenumber,".df")) = read.csv(file = cvsfile)
  }
}

for (i in 1:4){
  for (j in 1:4){
    ij = i + j
    ij
  }
}



# function to draw spectrum in real time

plot(x = 1, type = "n", 
     xlim = c(240,290), xlab = "wavelength (nm)",
     ylim = c(-0.1,0.6), ylab = "absorbance",
     lwd = 1, col = "magenta")

for (i in 1:396){
  lines(x = c(std$wavelength[i],std$wavelength[i+1]),
        y = c(std$absorbance[i], std$absorbance[i+1]))
  Sys.sleep(600/397)
}
