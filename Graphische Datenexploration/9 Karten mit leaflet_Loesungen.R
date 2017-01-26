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
  addMarkers(lng=7.4474470, lat=46.9479740, popup="Hallo Bern!") 


## Ersetzen sie die standardmässig erscheinende OpenStreetMap Karte... 


## ...mit der Stamen.Toner-Karte  
leaflet() %>%
  addProviderTiles("Stamen.Toner") %>%
  addMarkers(lng=7.4474470, lat=46.9479740, popup="Hallo Bern!")
 
## ...mit der CartoDB.Positrion-Karte
leaflet() %>%
  addProviderTiles("CartoDB.Positron") %>%
  addMarkers(lng=7.4474470, lat=46.9479740, popup="Hallo Bern!")





###########
## Nun versuchen wir die John Snow Karte nachzubauen
####


##
# Die Daten dazu finden Sie in Robin's Blog
# http://blog.rtwilson.com/john-snows-cholera-data-in-more-formats/
# oder auf Moodle
setwd("~/SnowGIS/")
snowdf <- read.csv("c:/temp/Snowdf.csv")                      


# Zuerst zentrieren wir die Karte auf den relevanten Abschnitt (Soho in London)
library(leaflet)
m <- leaflet() %>% 
  addTiles() %>%
  fitBounds(-.141,  51.511, -.133, 51.516)
m

# Nun zeichnen wir die Toten als Kreise ein
# Verwenden Sie dafür die AddCircles()-Funktion
# Sie benötigt im Minimum Angaben zu Höhen(coords.x1) und Breitengrade(coords.x2)
# Experimentieren Sie mit den optischen Parametern radius, opacity und col
# Um das Ergebnis zu optimieren
m<-m  %>% 
  addCircles(lng=snowdf$coords.x1,lat=snowdf$coords.x2, radius = 0.5,opacity=0.8,col="red")
m


# Ergänzen Sie die Karte mit einem Pop-Up-Marker, der auf die Pumpe verweist, an der die Cholera-Epidemie ausbrach
# Die Koordinaten sind: 
# lng=-0.1366679, lat=51.51334
# Verlinken Sie gleichzeitig den Wikipedia-Eintrag zur Cholero-Epidemie in der Broad-Street
# https://en.wikipedia.org/wiki/1854_Broad_Street_cholera_outbreak'>Wikipedia Eintrag zu Broad Street Cholera

m<-m %>% 
  addMarkers(lng=-0.1366679,lat=51.51334, 
popup="<b>Der verseuchte Brunnen in der Broad-Street<br> Ursprung der Cholera-Epidemie von 1854</b><br>
<a href='https://en.wikipedia.org/wiki/1854_Broad_Street_cholera_outbreak'>Wikipedia Eintrag zu Broad Street Cholera</a>")
m

###
# Speichern lässt sich die Karte über die Export-Funktion im Viewer.
# Die Karte lässt sich als html-Objekt speichern, d.h. sie können sie mit einem Browser öffnen
# und die Karte so auf ihrer Website einbinden

