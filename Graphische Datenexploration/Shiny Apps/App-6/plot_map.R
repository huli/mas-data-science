#plot_map.R

# theme_clean (Damit die Karten schöner aussehen)
theme_clean<-function(base_size=12) {
  require(grid)
  theme_grey(base_size)
  theme(
    axis.title=element_blank(),
    axis.text=element_blank(),
    panel.background=element_blank(),
    panel.border=element_blank(),
    panel.grid=element_blank(),
    axis.ticks.length=unit(0,"cm"),
    panel.spacing=unit(0,"lines"),
    plot.margin=unit(c(0,0,0,0),"lines"),
    complete=TRUE
  )
}

# Mit Hilfe von ggplot2 definieren wir eine Funktion, die Choropleth-Karten zeichnet
plot_map <- function(daten,mediane,var,legend.title) {
  
ggplot(daten) + 
    aes_string("long","lat", group="group",fill=var) + 
    geom_polygon()+
    geom_path(color="black",size=0.1) +
    scale_fill_gradient2(low="#de2d26",mid="grey90",high="#31a354",midpoint=mediane[var])+
    coord_equal() +
    labs(fill=legend.title)+
    theme_clean()
}