################################################################
## Skript:      7 Grafiken speichern
## Studiengang: CAS Datenanalyse 16/17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:   (1) Graphiken exportieren
##              (2) Graphiken in PPP oder Word ablegen mit ReportR
##
######################################


## Libraries
library(ReporteRs)
library(ggplot2)

## Erzeugte Grafiken bleiben gespeichert. Über die Pfeile im Plot-Menü kann 
## durch die Grafiksammlung der laufenden Session geblättert werden

## Grafiken lassen sich über die Benutzeroberfläche speichern (Export)
## oder direkt mittels Syntax
## Die Grundstruktur sieht so aus:
## pdf("Name") oder png("Name")
## Grafik
## dev.off()

#####
# Grafiken speichern mit Syntax

# Grafiken speichern
pdf("cars.pdf")
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2,fill="#FF0000",colour="black")+
  ggtitle("Benzinverbrauch von Motorfahrzeugen \n (n=32)")+
  theme(plot.title=element_text(size=rel(2))) +
  xlab("Meilen pro Gallone")+
  ylab("Häufigkeiten")
dev.off()

## PDF ist ideal für die weitere Bearbeitung in einem Grafikprogramm
## und print Dokumente mit professioneller Layout-Software (bspw. LaTeX)
## PDF ist jedoch für Microsoft-Objekte nicht ideal. Für Windows > win.metafile()
## png() ist relativ flexibel
## Andere Formate können verwendet werden (bspw. jpeg(),bmp(),tiff(),xfig, postscript())




###
### Möglich ist es zudem mit dem Package ReporteRs Grafiken in Powerpoint oder Word zu speichern
### Das hat den Vorteil, das Grafiken als editierbare Vektorgrafiken gespeichert werden
### D.h. Grafiken können im Nachhinein "von Hand" angepasst werden.
### Quelle:
### http://davidgohel.github.io/ReporteRs/


# Erstelle Sie ein PowerPoint-Dokument 
doc <- pptx()

# Betrachten Sie die Funktion pptx(), damit Sie einen Überblick zu den möglichen Folientypen haben
pptx()

# Fügen Sie eine neue TitelSeite zum Objekt doc hinzu
doc<-addSlide(doc, "Title Slide")

# Setzen Sie den Titel "CAS Datenanalyse 2016/2017"
doc<-addTitle(doc, "CAS Datenanalyse 2016/2017")

# Fügen Sie eine neue Folienseite hinzu (mit Speichersockel für zwei Inhalte)
doc <- addSlide(doc, "Two Content")

# Beschriften Sie die neue Folie mit dem Titel "Editierbare Vektor Graphik versus (uneditierbares) Raster Format"
doc<- addTitle(doc, "Editierbare Vektor Graphik versus (uneditierbares) Raster Format" )

# Speichern Sie einen Boxplot im objekt bp
bp <- ggplot(data=PlantGrowth, aes(x=group, y=weight, fill=group))+
  geom_boxplot()

# Fügen Sie die Boxplot-Grafik als editierbare Vektor-Graphik hinzu
doc <- addPlot(doc, function() print(bp), vector.graphic = TRUE)

# Fügen Sie die Boxplot Grafik als Raster-Graphik hinzu
doc <- addPlot(doc, function() print(bp), vector.graphic = FALSE )

# Speichere das Dokument ins Arbeitsverzeichnis
writeDoc(doc, file = "editable-ggplot2.pptx")


# Zweite Variante

doc <- pptx()

# Speichern Sie einen Boxplot im objekt bp
bp <- ggplot(data=PlantGrowth, aes(x=group, y=weight, fill=group))+
  geom_boxplot()

# Fügen Sie eine neue TitelSeite zum Objekt doc hinzu
doc %>% 
  addSlide("Title Slide") %>% 
  addTitle("CAS Datenanalyse 2016/2017") %>% 
  addSlide("Two Content") %>% 
  addTitle("Editierbare Vektor Graphik versus (uneditierbares) Raster Format" ) %>% 
  addPlot(function() print(bp), vector.graphic = TRUE) %>% 
  addPlot(function() print(bp), vector.graphic = FALSE ) %>% 
  writeDoc(file = "the-easy-way.pptx")



