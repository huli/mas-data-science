# XML Beispiel
library(XML)
u <- "http://www.w3schools.com/xml/simple.xml"
roh <- xmlParse(u)
liste <- xmlToList(roh)
df <- xmlToDataFrame(roh)

# HTML Beispiel
doc <- "http://www.switzerland.org/schweiz/kantone/index.de"
roh <- htmlParse(doc)
tabelle <- getNodeSet(htmlParse(doc),"//table")[[6]]
readHTMLTable(tabelle)

# Alternativ mit rvest:
# Kann auch https-Seiten holen
library(rvest)
roh<-read_html("http://www.switzerland.org/schweiz/kantone/index.de")
tabelle <- html_table(roh,fill=TRUE,header=TRUE)[[6]]

# json
library(jsonlite)

# Mini Beispiel aus dem Package
json <-
  '[
  {"Name" : "Mario", "Age" : 32, "Occupation" : "Plumber"}, 
  {"Name" : "Peach", "Age" : 21, "Occupation" : "Princess"},
  {},
  {"Name" : "Bowser", "Occupation" : "Koopa"}
]'
mydf <- fromJSON(json)
mydf

# editieren wir die Daten ein bisschen
mydf$Ranking <- c(3, 1, 2, 4)

# und wandeln es zurück nach JSON
toJSON(mydf, pretty=TRUE)


# Beispiel aus dem "echten Leben"
library(httr)
data.json <- fromJSON("http://maps.googleapis.com/maps/api/directions/json?origin=Bern,Fabrikstrasse&destination=Bern,Wankdorffeldstrasse")
data.json <- unlist(data.json)
lat1 <- data.json["routes.legs.start_location.lat"]
lon1 <- data.json["routes.legs.start_location.lng"]
lat2 <- data.json["routes.legs.end_location.lat"]
lon2 <- data.json["routes.legs.end_location.lng"]
distanz <- data.json["routes.legs.distance.value"]
list(lat1,lon1,lat2,lon2,distanz)

