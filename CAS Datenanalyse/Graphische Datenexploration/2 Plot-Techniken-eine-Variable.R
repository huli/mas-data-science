################################################################
## Skript:      2 Plot-Techniken-eine-Variable
## Studiengang: CAS Datenanalyse 16/17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:   (1) Univarite Techniken der Datenexploration mit R
##              (2) Unterschiede konventionelle Plot-Methode und ggplot erkennen 
##
####################################



## Libraries
library(ggplot2)


###
# Daten - Motor Trend Car Road Tests - mtcars
# Führen Sie eine erste Datenbegutachtung durch, damit Sie eine grundlegende Vorstellung
# der verwendeten Daten haben
help(mtcars)



###############
# Stabdiagramme
# Frage: Welche Zylinderzahl kommt am häufigsten vor?
plot(table(mtcars$cyl))



###############
# Balken-Diagramme

# Erstellen Sie ein Balken-Diagramm für die Zylinderzahl mit der konventionellen Plot Funktion
barplot(table(mtcars$cyl))

# Erstellen Sie ein Balken-Diagramm mit ggplot 
# Übergeben Sie die Varialbe cyl einmal als kategoriales Merkmal (factor) 
# und einmal als metrisches Merkmal (numeric)

# kategorial - da es ja eigentlich diskret ist
ggplot(mtcars, aes(factor(cyl))) +
  geom_bar()

# metrisch
ggplot(mtcars, aes(cyl)) +
  geom_bar()


###############
# Kuchendiagramme

# Zeichnen Sie ein Kuchendiagram mit der konventionellen Plot Funktion
pie(table(mtcars$cyl))


## In ggplot gibt es keine direkte Umsetzung eines Kuchendiagrammes, weil Hadley Wickham, wie viele andere Statistiker
## glaubt, dass Kuchendiagramme ungenau sind
## Mit ein bisschen Arbeit lässt sich jedoch ein Kuchendiagramm über einen Barchart und der Funktion coord_polar()
## erstellen
## vgl. http://www.r-chart.com/2010/07/pie-charts-in-ggplot2.html


###############
# Histogramme

# Untersuchen Sie die Verteilung der Variable mpg (miles per gallon)
# Die Variable gibt Auskunft zum Benzinverbrauch
# (eine Meile ~1.6 KM, eine Gallone ~ 3.8 liter)
plot(mtcars$mpg)

# Erstellen Sie ein Histogramm mit der konventionellen Plot Funktion
# In welche Kategorie fallen am meisten Fahrzeuge?
hist(mtcars$mpg)

# Verändern Sie die Zahl der Klassen über die Option breaks 
# Wie sieht das Histogram aus mit 5,7,10 Unterteilungen aus?
# Ändert sich etwas in Bezug auf die Aussage, welch Kategorie von Benzinverbrauch am häufigsten vorkommt?
hist(mtcars$mpg, breaks = seq(0,35, 2.5))

# Erstellen Sie ein Histogramm mit ggplot
# Wie geht ggplot bei der Bestimmung der Breite der Intervalle vor?
ggplot(mtcars, aes(cyl)) +
  geom_histogram()


# Mit ggplot lässt sich die Breite der Klassen über "binwidth" steuern 
# Justieren Sie die Intervallbreite so, dass sie ungefähr der Einteilung von breaks=10 mit der konvetionellen Plot-Funktion entspricht.
ggplot(mtcars, aes(mpg)) +
  geom_histogram(binwidth = 1)




#####
# EXTRA
# Alternativ lässt sich für metrische Variablen eine WahrschenlichkeitsDichte-Funktion schätzen.
# Sie zeigt an, in welchen Bereiche viele und und in welchen
# Bereichen wenige Wahrscheinlichkeits"Masse" vorliegt
ggplot(mtcars, aes(x=mpg))+
  geom_density()

# Die Linien am Rand sind etwas unschön, vergrössern wir doch einfach die x-Achse
ggplot(mtcars, aes(x=mpg))+
  geom_density() +
  xlim(1,45)

# Mit adjust, lässt sich die Glättung kontrollieren
# Standard ist adjust=1, grössere Werte=stärkere Glättung und umgekehrt
# Testen Sie verschiedene Parameter für adjust und beobachten Sie, wie sich die 
# Dichtefunktion verändert
ggplot(mtcars, aes(x=mpg))+
  geom_density(adjust = 0.1) +
  xlim(1,45)
# EXTRA
#####



###############
# Boxplot
# 

# Erstellen Sie ein Boxplot für die Pferdestärke (hp=horsepower) mit der konventionellen Plotfunktion
ggplot(mtcars, aes(x="", y=hp)) +
  geom_boxplot() + 
  geom_text(data = mtcars[mtcars$hp > 300,], label=rownames(mtcars[mtcars$hp > 300,]))


# Erstellen Sie ein Boxplot für die Pferdestärke (hp=horsepower) mit ggplot


# Gibt es ein Auto, dass Aufgrund der Daten als Ausreiser bezeichnet werden kann? Um welches Auto handelt es sich?

########
# Wrap-Up: Funktionsweise von ggplot2
######
# ggplot benötigt im Minimum 
# (1) Daten(data), 
# (2) eine Definition der zu visualisierenden Variablen (aes)
# und (3) eine Anweisung zur visuellen Repräsentation der Daten (geom_)
# Die Grafik wird Komponentenweise aufgebaut (+)

# Es gibt unterschiedliche Schreibweisen und Möglichkeiten zur Spezifikation der Parameter
# Untenstehende Varianten führen alle zum selben Ergebnis
# Im Rahmen des Kurses wird in der Regel die erste Schreibweise verwendet


# Variante 1
ggplot(data=mtcars, aes(x=factor(""),y=hp))+
  geom_boxplot()

# Variante 2
ggplot(data=mtcars)+
  aes(x=factor(""),y=hp)+
  geom_boxplot()

# Variante 3
ggplot()+
  geom_boxplot(data=mtcars,aes(x=factor(""),y=hp))

# ggplot-Graphiken können als eigene Objekte gespeichert (und erweitert) werden

boxplot<-ggplot()
boxplot<-boxplot+geom_boxplot(data=mtcars,aes(x=factor(""),y=hp))
boxplot

# Was passiert hier?
ggplot(data=mtcars, aes(x=factor(""),y=disp))+
  geom_boxplot(aes(x=factor(""),y=hp))

# Einmal definierte Parameter werden "nach unten" vererbt... bis sie überschrieben werden















