
# MASS-Paket laden
library(MASS)

# data frame anzeigen
# View(painters)

# Aufgabe: Häufigkeitsverteilung

# Häufigkeit in Zahlen
composition.freq <- table(painters$Composition)
composition.freq

school.membercount <- table(painters$School)
school.max <- sort(school.membercount, decreasing = TRUE)[1]
school.max

# Schule(n) mit meisten Malern 
school.membercount[school.membercount == school.max]


#Aufgabe: Relative Häufigkeitsverteilung
options.old <- options(digits = 3) # Bestehende Options zwischenspeichern und auf 4 Nachkommastellen setzen

composition.percentage = prop.table(composition.freq) * 100 # Haeufigkeitsverteilung in Prozenten
composition.percentage

addmargins(composition.percentage) # noch mit Totalisierung

options(options.old) # Options zuruecksetzen


#Aufgabe: Balkendiagramm

#Aufgabe: Kuchendiagramm

#Aufgabe 1: Gruppenstatistik

#Aufgabe 2: Gruppenstatistik