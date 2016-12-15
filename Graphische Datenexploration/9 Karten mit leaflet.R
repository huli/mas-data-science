################################################################
## Skript:      9 - Karten mit leaflet
## Studiengang  CAS Datenanalyse 16/17
## Modul:       Graphische Datenexploration und Datenvisualisierung 
## Lernziel:    Mit Hilfe von leaflet einfache interaktive Punktekarten zeichnen
##
####################################


# Libraries
library(leaflet)

############
# leaflet rufen sie mit der Funktion leaflet() auf
# Mit dem Pipe-Operator %>% werden Karten komponentenweise aufgebaut
# Damit eine Karte erscheint, braucht es sogenannte Tiles. addTiles() fügt die OpenStreetMap hinzu
# 
# Ausführliche Beschreibungen der leaflet Funktionen finden Sie hier:
# https://rstudio.github.io/leaflet/



###
# Aufgabe: Zentrieren Sie die Karte auf Bern und platzieren Sie ein Popup-Marker 
# mit der Aufschrift "Hallo Bern"

# Bern
leaflet() %>%
  addTiles() %>%  #



## Ersetzen sie die standardmässig erscheinende OpenStreetMap Karte... 


## ...mit der Stamen.Toner-Karte  
leaflet() %>%

 
## ...mit der CartoDB.Positrion-Karte
leaflet() %>%






###########
## Nun versuchen wir die John Snow Karte nachzubauen
####


##
# Die Daten dazu finden Sie in Robin's Blog
# http://blog.rtwilson.com/john-snows-cholera-data-in-more-formats/
# oder auf Moodle


# Damit die Daten eingezeichnet werden können, müssen sie zunächst ins gewöhnliche
# Längen- und Breitengrad System übertragen werden
library(sp)
library(rgdal)
library(maptools)
setwd("~/SnowGIS/SnowGIS_SHP")
deaths <- readShapePoints("Cholera_Deaths")                      
df_deaths <- data.frame(deaths@coords)                             
coordinates(df_deaths)=~coords.x1+coords.x2                         
proj4string(df_deaths)=CRS("+init=epsg:27700")                      
df_deaths = spTransform(df_deaths,CRS("+proj=longlat +datum=WGS84"))
df<-data.frame(df_deaths@coords)
# Nun sind die Daten ready

# Zuerst zentrieren wir die Karte auf den relevanten Abschnitt (Soho in London)
library(leaflet)
m <- leaflet() %>% 
  addTiles() %>% 
  fitBounds(-.141,  51.511, -.133, 51.516)

# Nun zeichnen wir die Toten als Kreise ein
# Verwenden Sie dafür die AddCircles()-Funktion
# Sie benötigt im Minimum Angaben zu Höhen(coords.x1) und Breitengrade(coords.x2)
# Experimentieren Sie mit den optischen Parametern radius, opacity und col
# Um das Ergebnis zu optimieren
m <- m %>%

m

# Ergänzen Sie die Karte mit einem Pop-Up-Marker, der auf die Pumpe verweist, an der die Cholera-Epidemie ausbrach
# Die Koordinaten sind: 
# lng=-0.1366679, lat=51.51334
# Verlinken Sie gleichzeitig den Wikipedia-Eintrag zur Cholero-Epidemie in der Broad-Street
# https://en.wikipedia.org/wiki/1854_Broad_Street_cholera_outbreak'>Wikipedia Eintrag zu Broad Street Cholera
m <- m %>%
  
  m


###
# Speichern lässt sich die Karte über die Export-Funktion im Viewer.
# Die Karte lässt sich als html-Objekt speichern, d.h. sie können sie mit einem Browser öffnen
# und die Karte so auf ihrer Website einbinden


