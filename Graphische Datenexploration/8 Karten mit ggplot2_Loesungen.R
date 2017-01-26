################################################################
## Skript:      8 - Karten mit ggplot2
## Studiengang  CAS Datenanalyse 16/17
## Modul:       Graphische Datenexploration und Datenvisualisierung 
## Lernziel:    Auf der Basis von shapefile-Daten Choroplethen-Karten mit ggplot erstellen
##
####################################


# Libraries
library(ggplot2)  # Für die Darstellung von Karten
library(rgdal)    # Damit shapefile Daten geladen werden können
library(dplyr)    # Für die Datenaufbereitung
library(rgeos)    # Für fortify
library(maptools) # Für fortify

# if (!require(gpclib)) install.packages("gpclib", type="source") ohne rgeos
# gpclibPermit()


############
# Geodaten laden (shapefile)
# setwd("WorkingDirectory")
schweiz<-readOGR("c:/temp/GGG_15_V161025/shp",layer="g1g15")


# Kleine Inspektion der shapefile-Daten
plot(schweiz)
str(schweiz)
summary(schweiz)
head(schweiz,2)
names(schweiz)

# Das shapefile lässt sich mit fortify() ins klassische dataframe Format pressen
schweiz <- fortify(schweiz, region = "GMDNR")
str(schweiz)


############
# Karten mit ggplot

# Zeichnen sie die Schweiz mit Punkten
ggplot(schweiz)+
  geom_point(aes(x=long,y=lat))

# Vielleicht doch besser mit Polygonen
ggplot(schweiz)+
  geom_polygon(aes(x=long,y=lat,group=group))

######
# Bringen wir etwas Farbe in die Sache
# Zeichnen Sie die Schweiz mit roter Fläche und weissen Gemeindegrenzen
# Verwenden Sie dabei untenstehende Vorlage und theme_clean()

# Ein Plot der Schweiz inkl. Gemeindegrenzen
ggplot(schweiz) + 
  aes(long,lat, group=group)+
  geom_polygon(fill="red")+
  geom_path(color="white")

# theme_clean um den "Balast" los zu werden
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

# Et voilà
ggplot(schweiz) + 
  aes(long,lat, group=group)+
  geom_polygon(fill="red")+
  geom_path(color="white")+
  theme_clean()

# Die Projektion ist nicht ideal
# probieren Sie coord_equal()
ggplot(schweiz) + 
  aes(long,lat, group=group)+
  geom_polygon(fill="red")+
  geom_path(color="white")+
  coord_equal()+
  theme_clean()

# So ist's besser


#####################
# Lasst uns eine Choroplethen-Karte zeichnen!

## Wohnen junge und alte Menschen in unterschiedlichen Regionen?
##


###############
# Zuerst müssen wir die Shapefile-Daten mit Kennzahlen der Gemeinden kombinieren (Open-Data Übung)

##
# Gemeindedaten Regionalporträit der Schweiz laden

gemeindedaten<-read.csv("c:/temp/gemeindedaten.csv")



##
# Daten zusammenführen
schweiz$id<-as.numeric(schweiz$id)
schweiz<-arrange(schweiz,id) 
schweiz.df<-left_join(schweiz,gemeindedaten,by=c("id"="bfsid"))
schweiz.df<-arrange(schweiz.df,as.numeric(schweiz.df$order))


# Alternatives Datenladen (Daten bereits vorbereitet)
schweiz.df<-read.csv("c:/temp/schweizGeo.csv")





# Aufgabe: Finden Sie eine passende farbliche Darstellung für die räumlichen Unterschiede 
# mit Hilfe von scale_fill_gradient2() 
# Die Lösung verwendet eine divergierende Farbskala mit einem neutralen Farbwert in der Mitte
# und roter Einfärbung für unterdurchschnittliche Werte sowie grüner Einfärbung für überdurchschnittliche Werte

# 0 bis 19 Jahre
ggplot(schweiz.df) + 
  aes(long,lat, group=group,fill=alter_0_19) + 
  geom_polygon()+
  geom_path(color="black") +
  scale_fill_gradient2(low="#de2d26",mid="grey90",high="#31a354",midpoint=median(schweiz.df$alter_0_19,na.rm=TRUE))+
  coord_equal() +
  labs(fill="Altersgruppe \n 0 bis 19 Jahre \n (in %)")+
  theme_clean()

 # 20 bis 64 Jahre
ggplot(schweiz.df) + 
  aes(long,lat, group=group,fill=alter_20_64) + 
  geom_polygon()+
  geom_path(color="black") +
  scale_fill_gradient2(low="#de2d26",mid="grey90",high="#31a354",midpoint=median(schweiz.df$alter_20_64,na.rm=TRUE))+
  coord_equal() +
  labs(fill="Altersgruppe \n 20 bis 64 Jahre \n (in %)")+
  theme_clean()

# 65+
ggplot(schweiz.df) + 
  aes(long,lat, group=group,fill=alter_65.) + 
  geom_polygon()+
  geom_path(color="black") +
  scale_fill_gradient2(low="#de2d26",mid="grey90",high="#31a354",midpoint=median(schweiz.df$alter_65.,na.rm=TRUE))+
  coord_equal() +
  labs(fill="Altersgruppe \n 65 plus \n (in %)")+
  theme_clean()


####
# Wählen sie einen Kanton und untersuchen Sie den Anteil Kinder und Jugendlicher je Gemeinde
# im Vergleich zu den nationalen Werten
# Tipp: Arbeiten Sie mit den BFS-ID's um ihre Auswahl einzugrenzen.
# https://de.wikipedia.org/wiki/Gemeindenummer

bern<-schweiz.df %>%
  filter(id>300&id<997)

ggplot(bern) + 
  aes(long,lat, group=group,fill=alter_0_19) + 
  geom_polygon()+
  geom_path(color="black") +
  scale_fill_gradient2(low="#de2d26",mid="grey90",high="#31a354",midpoint=median(schweiz.df$alter_0_19,na.rm=TRUE))+
  coord_equal() +
  labs(fill="Altersgruppe \n 0 bis 19 Jahre \n (in %)")+
  theme_clean()

#####
# Eine komplette Liste von R-Packages zur räumlichen Analyse finden Sie hier:
# https://cran.r-project.org/web/views/Spatial.html


