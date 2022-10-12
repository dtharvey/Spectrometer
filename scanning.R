spectrum = read.csv(file = "spectra_csv/222.csv")

plot(x = 1, y = 1, type = "n", xlim = c(240,290), ylim = c(-0.1, 0.6),
     xlab = "wavelength (nm)", ylab = "absorbance (arbitrary units)",
     main = "Scan Rate: 20 nm/min")
grid()
for (i in 1:494){
  lines(x = c(spectrum$wavelength[i],spectrum$wavelength[i+1]),
        y = c(spectrum$absorbance[i], spectrum$absorbance[i+1]),
        lwd = 2, col = "blue", lty = 1)
  Sys.sleep(150/494)
}
