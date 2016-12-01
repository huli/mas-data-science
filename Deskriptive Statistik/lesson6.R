
# Binominalverteilung
# -------------------------------------------------------------------------------------------

# Wahrscheinlichkeit bleibt immer gleich
yprob <- dbinom(0:12, size=length(0:12)-1, prob = 1/5)
names(yprob)  <- 0:12
barplot(yprob)


# Hypergeometrische Verteilung
# -------------------------------------------------------------------------------------------
# Wahrscheinlichkeit verändert sich 
# (Befrage Person wird nicht mehr befragt, M&M's wird gegessen, Lotto)
# Problem: Beim Schweizer Zahlenlotto sind 6 Zahlen aus 42 zu ziehen.
# Wir bezeichnen mit x die Anzahl der richtig angekreutzten Zahlen.
# Bestimmen Sie die Wahrscheinlichkeitsverteilung und stellen Sie diese
# grafisch dar

# Achtung: 0:6 (entspricht 7, da man auch 0 Fragen richtig haben kann)
yprob <-dhyper(0:6, m=6, n=36, k=6) 
names(yprob) <- 0:6
barplot(yprob)

# Fall aus den Folien (Beispiel 18: Rechnen mit Wahrscheinlichkeiten (Urnenmodell ohne Z.))
yprob <- dhyper(0:3, m=4, n=6, k=3)
names(yprob) <- 0:3
barplot(yprob)

# Poissionverteilung
# Näherungsmodell für Wahrscheinlichkeiten pro Zeit (Grenzfall des Binomialmodells)
# -------------------------------------------------------------------------------------------

# Man will unendlich fein unterteilen damit man noch auf ein Ja/Nein-Modell kommt (Bernouille-Prozess)

# Problem: Eine Brücke wird durchschnittlich von 12 Autos pro Minute
# passiert. Wie gross ist die Wahrscheinlichkeit, dass sich in einer
# Minute mehr als 17 Autos auf der Brücke befinden?

# Eine Achse ist die Zeit und diese ist beliebig fein unterteilbar
ppois(16, lambda = 12) # lower tail (Wahrscheinlichkeit für 16 Autos und weniger)

# die Wahrscheinlichkeit das mehr als 16 Autos
1-ppois(16, lambda = 12)

# oder auch 
ppois(16, lambda = 12, lower.tail = FALSE)

# Aufgabe wir wissen es kommen im Schnitt pro Minute 12
# wir wollen sehen wie gross die Wahrscheinlichkeit für 20 Autos
yprob <- dpois(0:20, lambda = 12)
names(yprob) <- 0:20
barplot(yprob)

# Wieso sind beide Balken gleich hoch (11, 12)
dpois(12, 12)
dpois(11, 12)

# -> nobody knows

# Stetige Modelle
# -------------------------------------------------------------------------------------------

# Wir wechseln von Säulenhöhe zu Fläche und somit Dichte

# Beispiel 21: Funktionsdauer von Taschenrechnern
# Die Funktionsdauer x ist normalverteilt mit Erwartungswert m = 120 h und
# theoretischer Varianz s2 = 100.
# Wie wahrscheinlich ist es, dass die Funktionsdauer

# a) höchstens 135 h
# von bis in R heisst mit p beginnen (d = dichte)
pnorm(135, mean = 120, sd = 10)

# b) mehr als 135 h
pnorm(135, mean = 120, sd = 10, lower.tail = FALSE)

# stetige Gleichverteilung
# Alle Wahrscheinlichkeiten sind gleich Wahrscheinlich
# (Warten auf den Bus, Zufallszahlen -> horizontale Linie)

xv <- seq(0, 5,length=100)
plot(xv, dunif(xv, min = 1, max = 3), type = "l", ylab = "Uni(x)", xlab = "x")

# für Fläche p
punif(2.5, 1, 3)

?punif

# r für Random, d für density, q für quantile
runif(10, min = 1, max = 3)

# Wieviel Zeit vergeht bis?
# Exponentialverteilung (das Pendant zur Poissonverteilung)
# (Anzahl Pizzas pro Zeit wäre Poission, Zeit bis Pizza ist Exponential)
# (Lebensdauer von Bauteilen ohne Altererscheinung, Lebensdauer von Atomen,
# Anzahl Zeit zwischen Versicherungsfällen)

#  Ereignis tritt einmal pro Minute auf
xv <- seq(0,5,length=100)
plot(xv, dexp(xv, rate=1), type = "l", ylab = "Exp(x)",
     xlab = "x")

# Problem: Die durchschnittliche Abfertigungszeit an der Kasse eines
# Supermarktes betrage 3 Minuten. Mit welcher Wahrscheinlichkeit wird
# ein Kunde in weniger als 2 Minuten bedient?

# Zeit die vergeht bis -> Exontentialverteilung
pexp(2, rate = 1/3)

# Wie lange müssten wir warten, bis die Wahrscheinlichkeit 50 % ist
# Wert auf x-Achse suchen ist immer q..
qexp(.5, rate = 1/3)


# Normalverteilung
# Alle Dinge die aus vielen Dingen zustande kommen sind Normalverteilt
# Bei allen Verteilungen kann ich mit einer hohen Anzahl Wiederholungen
# auf eine Normalverteilung kommen (Ausnahme Gleichverteilung)
# (Normalverteilung heisst auch immer Zufall)
xv <- seq(-5,5, length = 200)
plot(xv, dnorm(xv), type = "l")







