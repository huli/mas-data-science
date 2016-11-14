# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      11.11.2016
# Aufgaben:   CAS_DA_R_QuantDaten_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------


# Aufgabe: Häufigkeitsverteilung quantitativer Daten
# ----------------------------------------------------------------------------------------------------

# Haufigkeitsverteilung ohne Gruppierung
table(faithful$waiting)

# alternativ die Haeufigkeitsverteilung mit einer Einteilung in Gruppen
waitings.gruppiert <- cut(faithful$waiting, breaks = seq(40, 100, by = 10), include.lowest = TRUE, right = FALSE)
table(waitings.gruppiert)

# Intervall mit meisten Eruptionen
eruptions <- table(faithful$eruptions)
subset(eruptions, eruptions == max(eruptions))

# Range von Eruptionen bestimmen
eruptions.range <- range(faithful$eruptions)

# Haeufigkeitsverteilung der Eruptionszeiten (mit Defaults)
hist(faithful$eruptions, right = FALSE)

# Haeufigkeitsverteilung der Eruptionszeiten (ohne Defaults)
hist(faithful$eruptions, right = FALSE, breaks =  seq(1.5, 5.2, by = .2),
     xlab = "duration of eruption in seconds", ylab = "number of eruptions",
     main = "Frequency distribution of eruption durations",
     col = rainbow(18))


# Aufgabe: Histogramm
# ----------------------------------------------------------------------------------------------------

hist(faithful$waiting, right = FALSE,
     main = "Waiting times of old faithful", xlab = "waiting duration in seconds", ylab = "eruptions", 
     col = rainbow(12))


# Aufgabe: Relative Häufigkeitsverteilung stetiger Daten
# ----------------------------------------------------------------------------------------------------

# Ungruppierter Vergleich
round(prop.table(table(faithful$waiting)), 4)

# Gruppenbrueche bestimmen
waiting.breaks <- seq(40, 100, by = 5)

# Effektive Wartezeiten in Gruppen verteilen
waitings.cuts <- cut(faithful$waiting, waiting.breaks, right = FALSE, include.lowest = TRUE)
waitings.freq <- table(waitings.cuts)
waitings.relfreq <- prop.table(waitings.freq)

# Relative Haeufigkeitsverteilung gruppiert
prop.table(waitings.freq)

# Gerundet und in Prozenten
waitings.percentage <- round(waitings.relfreq, digits = 4) * 100

# Und noch absolute Haeufigkeiten und relative Haeufigeiten gegenuebergestellt
cbind(waitings.freq, waitings.percentage)


# Aufgabe: Kumulierte Häufigkeitsverteilung
# ----------------------------------------------------------------------------------------------------

# Summierte absolute Haeufigkeitsverteilung
waitings.freq.cum <- cumsum(waitings.freq)

# Und noch als Spalten
cbind(waitings.freq.cum)


# Aufgabe: Kumulierte Häufigkeitsverteilungskurve
# ----------------------------------------------------------------------------------------------------

waitings.freq.cum0 <- c(0, waitings.freq.cum)

# Absolute, kumulierte Haeufigkeitsverteilung plotten
plot(waiting.breaks, waitings.freq.cum0,
     main = "old faithful eruptions",
     xlab = "cumulative waiting frequency", ylab = "waiting duration in seconds"
)

# Kurve hinzufuegen
lines(waiting.breaks, waitings.freq.cum0)


# Aufgabe: Kumulierte relative Häufigkeitsverteilung
# ----------------------------------------------------------------------------------------------------

# Zu diese Zweck brauchen wir die relativen Zahlen
waitings.relfreq.cum <- cumsum(waitings.relfreq)

# 0-Punkt hinzufuegen
waitings.relfreq.cum0 <- c(0, waitings.relfreq.cum)

# Kummulierte Haeufigkeitsverteilung plotten
plot(waiting.breaks, waitings.relfreq.cum0, 
     main = "old faithful eruptions",
     ylab = "cumulative waiting proportion", xlab = "waiting duration in seconds"
)

# Aufgabe: Kumulierte relative Häufigkeitsverteilungskurve
# ----------------------------------------------------------------------------------------------------

# Kurve hinzufuegen
lines(waiting.breaks, waitings.relfreq.cum0)



# Variation der beiden Kurven ohne Gruppierung, resp. implizite Gruppierung auf Sekunden
# ----------------------------------------------------------------------------------------------------

# absolut
plot(cumsum(table(faithful$waiting)), main = "old faithful eruptions",
     ylab = "cumulative waiting proportion", xlab = "waiting difference between shortest and longest eruption in seconds")
lines(cumsum(table(faithful$waiting)))

# relativ
plot(cumsum(table(faithful$waiting)/nrow(faithful)), main = "old faithful eruptions",
     ylab = "cumulative waiting proportion", xlab = "waiting difference between shortest and longest eruption in seconds")
lines(cumsum(table(faithful$waiting)/nrow(faithful)))



