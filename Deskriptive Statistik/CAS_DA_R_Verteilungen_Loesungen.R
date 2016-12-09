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

