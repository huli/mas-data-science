
# Auflösen von linearem Gleichungssystem

# Koeffizientenmatrix
# [ 3  1 ]
# [ 1 -4 ]
a.mat <- matrix(c(3,1,1,-4), nrow = 2, byrow = TRUE)

# Lösungsmatrix
# [ -7 ]
# [ 3 ]
b.mat <- matrix(c(-7,2), nrow = 2, byrow = TRUE)

# Auflösen
solve(a.mat, b.mat)


# Deskriptive Statistik
head(faithful)

# Nicht sinnvoll
barplot(faithful$eruptions)

# Abkürzen
duration <- faithful$eruptions

# Range bestimmen
range(duration)

# Stops/Breite bestimmen
breaks <- seq(1.5, 5.5, by=.5)

# Auszählen, resp. aufteilen in die Segmente
duration.cut <- cut(duration, breaks, right = FALSE)

# Tabelle erstellen
table(duration.cut)

#cbind(table(duration.cut))

# Histogramm erstellen
hist(duration, right = FALSE)

# Vektoren mitliefern
hist(duration, right = FALSE, breaks = seq(1.5, 5.5, by=.2))

# Farben
farben <- rainbow(8)
hist(duration, right = FALSE, col = farben)

# Heat
hist(duration, right = FALSE, col = heat.colors(8))

# Tabelle speichern
duration.freq <- table(duration.cut)

# Prozente bestimmen
duration.relfreq <- duration.freq/nrow(faithful)

# Option zwischenspeichern
old = options(digits = 3)

duration.percentage <- duration.relfreq * 100

# Options zurücksetzen
options(old)

# Oder ohne Options
round(duration.relfreq * 100, digits = 1)

# Summenhäufigkeit
duration.cum <- cumsum(duration.percentage)

# Plot machen nachem beide Spalten gleich
plot(breaks, c(0, duration.cum))

# Linien hinzufügen
lines(breaks, c(0, duration.cum))

plot(breaks, c(0,duration.cum), xlab = "Eruptionsdauer", 
      ylab = "Kummulierte Häufigkeiten", main = "Eruptionen von Old Faithful")

lines(breaks, c(0, duration.cum))

cumfreq0 <- c(0, duration.cum)

# Das Ganze in Prozenten anzeigen
# Exercise

# Empirical Cumulative Distribution Function
fn <- ecdf(duration)
plot(fn)

# Dauer der Eruptionen mit Wartedauer gegenüberstellen
waiting <- faithful$waiting

plot(duration, waiting) # Gleichsinnig gerichtete, lineare Abhängigkeit

# Lineares Modell erzeugen
abline(lm(waiting ~ duration))



