
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

# Problem: Die Ergebnisse eines Abschlusstestes folgen einer
# Normalverteilung mit µ = 72 und σ = 15.2. Welcher Anteil der
# Studierenden erreicht mindestens 84 Punkte?

pnorm(84, mean = 72, sd = 15.2, lower.tail = FALSE)

# Faustregel +/- 1 sd 
pnorm(1) - pnorm(-1)

# Faustregel für minus 2 sd und plus 2 sd
pnorm(2) - pnorm(-2)

# Faustregel für minus 3 sd und plus 3 sd
pnorm(3) - pnorm(-3)

# Chi-Quadrat-Verteilung
# Fuer die Auswertung von Kontingenztabellen
# (Normalverteilung ohne negative Seite, da die Abweichungen quadriert wurden)

xv <- seq(0,50,length=100)
degf <- c(5, 10, 20,40)
colors <- c("red", "blue", "darkgreen", "gold")

plot(xv, dchisq(xv, df=1), type = "l", ylab = "Chi2(x)", xlab = "x")
# Degree of freedom (df)
for (i in 1:4){lines(xv, dchisq(xv,degf[i]), lwd=2, col=colors[i])}

# Problem: Bestimmen Sie das 95%-Perzentil der Chi-Verteilung mit
# Freiheitsgrad 7. 
qchisq(.95, df=7)

# Studentsche t-Verteilung
# Brauchen wir dann, wenn die Standardabweichung unbekannt ist und auch
# geschätzt werden muss

x <- seq(-4, 4, length=100)
hx <- dnorm(x)
degf <- sort(c(1, 3, 8, 30), decreasing = TRUE)
colors <- c("red", "blue", "darkgreen", "gold", "black")
labels <- c("df=1", "df=3", "df=8", "df=30", "normal")

plot(x, hx, type="l", lty=2, xlab="t-Verteilungen", ylab="Dichte")
for (i in 1:4){lines(x, dt(x,degf[i]), lwd=1, col=colors[i])}
legend("topright", inset=.05, title="Verteilungen",
       labels, lwd=1, lty=c(1, 1, 1, 1, 2), col=colors)

# Grösserer degree of freedom führt zu grösserer Unsicherheit
# (sd ist ja unklar und wird auch geschätzt)
# Bei t-Verteilung ist Freiheitsgrad die Stichprobengrösse -1

# Problem: Bestimmen Sie das 2.5%- und das 97.5%-Perzentil der
# Studentschen t-Verteilung mit Freiheitsgrad 5.

qt(c(.025, .975), df = 5)
# Interpretation Man muss weiter in die Breite gehen um auch 95% von der
# Bevölkerung abzudecken
