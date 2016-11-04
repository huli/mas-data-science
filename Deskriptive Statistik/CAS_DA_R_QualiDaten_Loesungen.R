# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      04.11.2016
# Aufgaben:   CAS_DA_R_QualiDaten_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------

# MASS-Paket laden
library(MASS)

# data frame anzeigen
# View(painters)


# Aufgabe: Häufigkeitsverteilung
# ----------------------------------------------------------------------------------------------------

# Häufigkeit in Zahlen
composition.freq <- table(painters$Composition)
composition.freq

# Maximale Anzahl von Schuelern
school.membercount <- table(painters$School)
school.max <- sort(school.membercount, decreasing = TRUE)[1]
school.max

# Schule(n) mit meisten Malern
school.greatest <- school.membercount[school.membercount == school.max]
labels(school.greatest)


#Aufgabe: Relative Häufigkeitsverteilung
# ----------------------------------------------------------------------------------------------------

# Bestehende Options zwischenspeichern und auf 4 Nachkommastellen setzen
options.old <- options(digits = 3) 

# Haeufigkeitsverteilung in Prozenten
composition.percentage <- prop.table(composition.freq) * 100 
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
barplot(composition.freq, col = colors.gradient, main = "Frequency distribution of composition",
        xlab = "composition", ylab = "number of painters")


#Aufgabe: Kuchendiagramm
# ----------------------------------------------------------------------------------------------------

# Farben des Regenbogens
colors.rainbow <- rainbow(18)

# Kuchendiagramm
pie(composition.freq, col = colors.rainbow, main =  "Frequency distribution of composition")


#Aufgabe 1: Gruppenstatistik
# ----------------------------------------------------------------------------------------------------

# Schule(n) mit höchstem Wert Composition
composition.max <- painters[painters$Composition == max(painters$Composition),]$School
composition.max

# Schule mit durchschnittlich höchstem Wert Composition 
composition.max.mean <- sort(tapply(painters$Composition, painters$School, mean), decreasing = TRUE)[1]
composition.max.mean


#Aufgabe 2: Gruppenstatistik
# ----------------------------------------------------------------------------------------------------

# Alle Maler mit Color >= 14
painters.color.high <- painters[painters$Colour >= 14,]
painters.color.high

# Anzahl von Malern it Color >= 14 
nrow(painters.color.high)

# Anteil von Malern mit Color >= 14 in Prozenten
options.old <- options(digits = 4)

painters.color.high.percentage <- 100 * nrow(painters.color.high) / nrow(painters)
painters.color.high.percentage

# Das Ganze noch mit Data Frame zum Ablesen/Kontrolle 
painters.extended <- painters
painters.extended["High Color"] <- as.numeric(painters.extended$Colour >= 14)
painters.color.table <- table(rownames(painters.extended), painters.extended$`High Color`)
colnames(painters.color.table) <- c("High color","Low color")
addmargins(prop.table(painters.color.table)) * 100

options(options.old) 


# ----------------------------------------------------------------------------------------------------
