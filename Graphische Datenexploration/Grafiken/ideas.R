
# tag cloud
library(tagcloud)
library( extrafont )
library(RColorBrewer)
tags <- sample( fonts(), 50 )
weights <- rgamma( 50, 1 )
colors <- colorRampPalette( brewer.pal( 12, "Paired" ) )( 50 )
tagcloud( tags, weights= weights, col= colors )

## https://www.r-bloggers.com/tagcloud-creating-tag-word-clouds/

# stacked area graph
library(ggplot2)

# DATA
set.seed(345)
Sector <- rep(c("S01","S02","S03","S04","S05","S06","S07"),times=7)
Year <- as.numeric(rep(c("1950","1960","1970","1980","1990","2000","2010"),each=7))
Value <- runif(49, 10, 100)
data <- data.frame(Sector,Year,Value)

ggplot(data, aes(x=Year, y=Value, fill=Sector)) + 
  geom_area()

ggplot(data, aes(x=Year, y=Value, fill=Sector)) +
  geom_area(colour="black", size=.2, alpha=.4) +
  scale_fill_brewer(palette="Greens", breaks=rev(levels(data$Sector)))

# leaflets


#Library
library(leaflet)

# Background 1: NASA
m=leaflet() %>% addTiles() %>% setView( lng = 2.34, lat = 48.85, zoom = 5 ) %>% 
  addProviderTiles("NASAGIBS.ViirsEarthAtNight2012")
m

# Background 2: World Imagery
m=leaflet() %>% addTiles() %>% setView( lng = 2.34, lat = 48.85, zoom = 3 ) %>% 
  addProviderTiles("Esri.WorldImagery")
m


library(leaflet)

# Create 20 markers (Random points)
data=data.frame(long=sample(seq(-150,150),20) ,  lat=sample(seq(-50,50),20) , val=round(rnorm(20),2) , name=paste("point",letters[1:20],sep="_")  ) 

# Show a circle at each position
m=leaflet(data = data) %>% addTiles() %>% addCircleMarkers(~long, ~lat , popup = ~as.character(name))
m

# http://tidytextmining.com/
# http://jason.bryer.org/timeline/
# https://daattali.com/shiny/timevis-demo/

# Clinton
library(RSQLite)

# connect to the sqlite file
library(DBI)
con = dbConnect(RSQLite::SQLite(), dbname="c:\\temp\\database.sqlite")

mails = dbGetQuery( con,'select ExtractedSubject, SenderPersonId from Emails Limit 10000' )

subjects_from_clinton <- mails[mails$SenderPersonId == 80, ]

library(dplyr)

filter_words <- c("fw:","re:", "and", "on", "in", "from", "sid", "of", "the", "a", "h:",
                  "to", "for", "i", "if", "text", "am", "with", "-", "s", "re", "u", "pm", "fm")

subjects_from_clinton[, "ExtractedSubject"] %>% 
  strsplit(" ")  %>% 
  unlist() %>% 
  sapply(tolower) -> 
  words


# myList[which(names(myList) %in% c("two","three"))]

words[which(!words %in% filter_words)] ->
  words

words %>% 
  table() -> 
  word_frequency 

top_x_words <- sort(word_frequency, decreasing = T)[1:100]

words <- rownames(top_x_words)
weights <- top_x_words[words]

library(tagcloud)
library( extrafont )
library(RColorBrewer)

colors <- colorRampPalette( brewer.pal( 12, "Paired" ) )( 100 )
tagcloud( words, weights= weights, col= colors) #, algorithm = "fill" )

