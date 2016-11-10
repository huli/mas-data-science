
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


