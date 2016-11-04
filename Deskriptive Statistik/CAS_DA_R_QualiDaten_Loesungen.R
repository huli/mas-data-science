
# MASS-Paket laden
library(MASS)

# data frame anzeigen
# View(painters)

# Aufgabe: Häufigkeitsverteilung
# ----------------------------------------------------------------------------------------------------

# Häufigkeit in Zahlen
composition.freq <- table(painters$Composition)
composition.freq

school.membercount <- table(painters$School)
school.max <- sort(school.membercount, decreasing = TRUE)[1]
school.max

# Schule(n) mit meisten Malern 
school.membercount[school.membercount == school.max]


#Aufgabe: Relative Häufigkeitsverteilung
# ----------------------------------------------------------------------------------------------------

# Bestehende Options zwischenspeichern und auf 4 Nachkommastellen setzen
options.old <- options(digits = 3) 

# Haeufigkeitsverteilung in Prozenten
composition.percentage = prop.table(composition.freq) * 100 
composition.percentage

# noch mit Totalisierung
addmargins(composition.percentage) 

# Options zuruecksetzen
options(options.old) 


#Aufgabe: Balkendiagramm
# ----------------------------------------------------------------------------------------------------

# Verlaufsfarben erstellen
colors.gradient <- gray(seq(0, .9, length.out = 18))

# Balkendiagramm
barplot(composition.freq, col = colors.gradient, xlab = "composition", ylab = "number of painters")


#Aufgabe: Kuchendiagramm
# ----------------------------------------------------------------------------------------------------

#Aufgabe 1: Gruppenstatistik
# ----------------------------------------------------------------------------------------------------

#Aufgabe 2: Gruppenstatistik
# ----------------------------------------------------------------------------------------------------