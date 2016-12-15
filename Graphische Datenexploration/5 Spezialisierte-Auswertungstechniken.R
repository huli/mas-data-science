3################################################################
## Skript:      5 Spezialisierte-Auswertungstechniken
## Studiengang: CAS Datenanalyse 16/17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziel:    Visuelle Auswertungstechniken kennenlernern 
##              zur Visualisierung mehrerer Variablen
##
####################################

# Benötigte Libraries
library(ggplot2)

#################
## Visualisation von Korrelationsmatrizen mit einem Correlogram
## Mittels Correlogram lässt sich ein schneller Überblick zu Zusammenhängen in den Daten erhalten


# Daten - mtcars: Motor Trend Car Road Tests
help(mtcars)

# Eine Korrleationsmatrize gibt alle paarweise möglichen Korrelation wieder
# Packen Sie den ganzen Datensatz in die Funktion cor(). Erkennen Sie Korrelationsstrukturen?


# Es ist schwierig zu erkennen, wo die Musik spielt
# Ein Korrelations-Plot kann Abhilfe schaffen 
# Speichern Sie das Resultat im Objekt mcor
# und plotten Sie dieses Objekt mit corrplot()
library(corrplot)


# corrplot verfügt über verschiedene nützliche Optionen. 
# Ergänzen Sie die corrplot mit der Option addCoef.col = "black"

# Mit "number.cex" justiert die Textgrösse 


##################
# Scatterplot-Matrix
# Ähnlich wie eine Korrelationsmatrix visualisiert eine Scatterplot-Matrize 
# bivariate Zusammenhänge in Daten

## Daten: countries - Health and economic data about countries around the world from 1960-2010
library(gcookbook) # Für Daten
library(GGally)
help(countries)

# Wir untersuchen, wie Wirtschaftswachstum (GDP), Erwerbsquote(laborrate)
# Gesundheitsausgaben (healthexp) und Kindersterblichkeit (infmortality)
# korrelieren

# Erneut wird zuerst ein Subset für das Jahr 2009 erstellt
c2009<-countries %>%
  filter(Year==2009) %>%
  select(c(-Code,-Year))

# Die Funktion ggpairs() ist ausgezeichnet für Scatterplot-Matrizen
# Erstellen Sie eine Scatterplot/Korrelations-Matrix aller Variablen des reduzierten 
# Datensatzes c2009 (Achtung: schliessen Sie die Variable "Name" aus)


# Der Plot unterscheidet drei Bereiche: Die Diagonale (diag), den Bereich oberhalb der 
# Diagonale (upper) und den Bereich unterhalb der Diagonale (lower)
# Varieren Sie die Standardeinstellung wie folgt:
# (1) Ersetzen Sie die Dichtfunktion in der Diagonalen mit Bar-Plots
# (2) Ergänzen Sie die Scatterplots mit einer linearen Kurve 


# Zwischen welchen Variablen ist der Zusammenhang am stärksten?
# ist der Zusammenhang überall linear?





###############################################
# Facets oder Trellis-Plots
# 

# Faceting ist eine spezielle ggplot Technik, die es erlaubt Subplots geschichtet nach Gruppen darzustellen
# Deswegen sind Factes besonders für Gruppenvergleiche geeignet
# Diese Art von Plots werden auch Trellis Graphen genannt (weil Sie wie Gitter aussehen)

# Daten: mpg - Fuel economy data from 1999 and 2008 for 38 popular models of car
help(mpg)

# Ausgangsplot ein Scatterplot mit Hubraum (displ) auf der x-Achse und Benzinverbrauch (hwy) auf der y-Achse

# Nutzen Sie die Facets-Funktion indem Sie obige Scatterplots unterschieden nach Antriebssystem darstellen (drv) 
# Stellen die Subplots vertikal dar (+facet_grid(var~.))

# Stellen Sie die Subplots mit horizontaler Anordnung dar (+facet_grid(.~var))


### Nehmen Sie einen zweifache Facet-Splits vor (Zylinderzahl (cyl), + Antriebssystem (drv))



###############################################
# Radar-Charts
# ermöglichen es Profile zu bilden und so erweitere visuelle Vergleiche anzustellen



### Damit wir einen Radarcharts bauen können, müssen die Daten im long-Format sein
###
library(scales)
library(reshape2)

profil_cars <- mtcars %>%
  rownames_to_column( var = "car" ) %>% # Zeilennamen werden als Variable gespeichert
  mutate_each(funs(rescale), -car) %>%  # Reskalieren der Variablen zwecks Vergleichbarkeit
  melt(id.vars=c("car"), measure.vars=colnames(mtcars)) %>% 
  arrange(car)

# Schauen Sie sich den neuen Datensatz an, damit sie verstehen, wie er umgeformt ist


# Zeichne wir aber zuerst nur ein Profil für den "Ferrari Dino"
ferrari<-profil_cars %>%
  filter(car=="Ferrari Dino")

# Zeichnen Sie die Werte für den Ferrari als Linienplot
# Achtung: es braucht group=1 bei den aesthetics, damit ggplot weiss, dass die Werte zusammengehören



# Jetzt transformieren wir das xy-Koordinatensystem einfach in ein polares Koordinatensystem
# coord_polar()



# Fast, die Lücke ist unschön
# wenn wir stattdessen die Linie als Fläche zeichnen (geom_polygon()), sieht es besser aus.
# Wenn wir die Füllfläche leer lassen fill=NA und nur die Linie einfäbren color="black"
# sieht es aus wie eine Linie




# Probieren Sie nun die Systemmatik auf den Datensatz mit allen Autos (profil_cars) zu übertragen
# Damit je Auto ein eigenes Profil gezeichnet wird, bietet sich ein facet_wrap an
# Hinweis: mit theme(legend.position = "none") entfernen sie die Legende, die hier überflüssig ist




##
# vgl. auch http://www.r-chart.com/2016/10/the-grammar-of-graphics-and-radar-charts.html
# oder als Alternative: https://www.ggplot2-exts.org/ggradar.html







