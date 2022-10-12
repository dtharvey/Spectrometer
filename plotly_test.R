library(plotly)

std = read.csv(file = "spectra_csv/standard.csv")
samp = read.csv(file = "spectra_csv/122.csv")

fig <-  plot_ly()

fig <- add_trace(
  fig,
  type = 'scatter',
  mode = "lines",
  name = "standard",
  color = I("magenta"),
  linetype = I("dash"),
  x = std$wavelength,
  y = std$absorbance
)

fig <- add_trace(
  fig,
  type = 'scatter',
  mode = "lines",
  color = I("blue"),
  name = "experiment",
  x = samp$wavelength,
  y = samp$absorbance
)

fig = layout(fig,
             xaxis = list(title = "wavelength (nm)", 
                          range = list(240,290)),
             yaxis = list(title = "absorbance (arbitrary unit", 
                          range = list(-0.1, 0.6)),
             legend = list(title = list(text = "<b>spectra</b>")))

fig



fig = plot_ly()
fig = add_trace(fig,
                type = "scatter",
                mode = "lines",
                name = "standard",
                color = I("magenta"),
                x = std$wavelength,
                y = std$absorbance)
fig = layout(fig,
             xaxis = list(title = "wavelength (nm)",
                          range = list(240,290)),
             yaxis = list(title = "absorbance (arbitrary units)",
                          range = list(-0.1,0.6)))
fig
