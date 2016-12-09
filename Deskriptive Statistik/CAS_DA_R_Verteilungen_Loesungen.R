# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      09.12.2016
# Aufgaben:   CAS_DA_R_Verteilungen_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------

# Fragen: 
# Runden?
# Poissionverteilung geht niemand heraus?
  # Wieso ist die Formulierung plötzlich anwesend?
  # Hinweis korrekt?
# Gleichverteilung!
#   Kann man diese wirklich so Zusammenrechnen? Vermmutlich nicht, es müssten sich die 
#   Wahrscheinlichkeiten ja mal rechnen, resp. verkleinern
#   Aber es gibt ja verschiedene Varianten



# Aufgabe: Binomialverteilung
# ----------------------------------------------------------------------------------------------------

# Wie gross ist bei fünfmaligem Setzen auf „rot“ die
# Wahrscheinlichkeit, dass man öfter gewinnt als verliert?

pbinom(2, size = 5, prob = 18/37, lower.tail = FALSE)
# 0.4746745

# Welche Anzahl der Gewinne wird in 90% der Fälle höchstens
# erreicht?
qbinom(.9, size = 5, prob = 18/ 37)
# 4


# Aufgabe: Poissonverteilung
# ----------------------------------------------------------------------------------------------------

# Hinweis: wir gehen hier davon aus, dass niemand das Restaurant auch verlässt?

# Kurze Darstellung zur Vereinfachung
plot(dpois(0:20, lambda = 12.1), type = "l")

# Es sind genau 8 Gäste im Restaurant.
dpois(8, lambda = 12.1) 
# 0.06335767

# Es sind höchstens 10 Gäste im Restaurant.
ppois(10, lambda = 12.1)
#  0.3368338

# Es sind zwischen 9 und 15 Gäste im Restaurant.
ppois(15, lambda = 12.1) - ppois(8, lambda = 12.1)
# 0.6885025

# Es sind mindestens 11 Gäste anwesend
ppois(10, lambda = 12.1, lower.tail = FALSE)
# 0.6631662

# Aufgabe: Stetige Gleichverteilung
# ----------------------------------------------------------------------------------------------------

# Welche Verteilung hat die Zufallsvariable X, welche die gesamte
# Pendelzeit von Haustür bis ins Büro beschreibt?
s <- seq(0, 40, length = 100)
plot(s, dunif(s, 6+10, 6+5+15), type = "l")
# Sie ist Gleichverteilt über den Minuten 16 bis 26 und

# Mit welcher Wahrscheinlichkeit schaffen Sie es noch rechtzeitig
# ins Büro?
punif(20, 6+10, 6+5+15)
# 0.4

# Problem:
# Es kann nicht 2 mal 0.4 gerechnet werden, weil es ja kummuliert ist und
# die Fälle < als 4min ja dann zu einem längeren möglichen Warten beim andern führen würde.

# oder anders, resp. die Wahrscheinlichkeiten müssten ja addiert werden
# Er hat 14 Minuten für ins Büro und hat mind. 10 Minunten, resp. er
# kann maximal 4 Minuten warten. Diese 4 min können sich verschieden auf
# die beiden Situation 'Warten auf Bus' und 'Warten in Bus' verteilen
# Beispiel 1: max 2min auf Bus warten, max 2 min in Bus warten
punif(2, 0, 5) * punif(2, 0, 5)
# 0.16
# Beispiel 2: max 3min auf Bus warten, max 1 min im Bus warten
punif(3, 0, 5) * punif(1, 0, 5)
# Beispiel 3: max 3min auf Bus warten, max 1 min im Bus warten
punif(2.5, 0, 5) * punif(2.5, 0, 5)
# 0.25

max_wartezeit <- 4
moegliche_wartezeiten <- seq(0, max_wartezeit, length = 10)
plot(wartezeiten_bus, punif(moegliche_wartezeiten, 0, 5) * punif(max_wartezeit-moegliche_wartezeiten, 0, 5))


