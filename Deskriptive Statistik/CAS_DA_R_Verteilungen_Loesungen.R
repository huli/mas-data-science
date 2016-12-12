# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      09.12.2016
# Aufgaben:   CAS_DA_R_Verteilungen_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------


# Aufgabe: Binomialverteilung
# ----------------------------------------------------------------------------------------------------

# Wie gross ist bei fünfmaligem Setzen auf „rot“ die
# Wahrscheinlichkeit, dass man öfter gewinnt als verliert?

pbinom(2, size = 5, prob = 18/37, lower.tail = FALSE)
# 0.4746745

# Welche Anzahl der Gewinne wird in 90% der Fälle höchstens
# erreicht?

qbinom(.9, size = 5, prob = 18/ 37)
# 4 (Gewinne)


# Aufgabe: Poissonverteilung
# ----------------------------------------------------------------------------------------------------

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


# Aufgabe: Exponentialverteilung
# ----------------------------------------------------------------------------------------------------

# Welche Verteilung hat die Zufallsvariable X, welche die Dauer der
# Telefongespräche in Minuten beschreibt?

# Eine Exponentialverteilung
plot(0:30, pexp(0:30, rate = 1/3), type = "l")


# Das Telefon klingelt. Wie gross ist die Wahrscheinlichkeit, dass
# dieses Gespräch höchstens eine Minute dauert?

pexp(1, rate = 1/3)
# 0.2834687

# Wie gross ist die Wahrscheinlichkeit, dass das Gespräch länger
# als eine Minute dauert?

pexp(1, rate = 1/3, lower.tail = FALSE)
# 0.7165313

# Mit welcher Wahrscheinlichkeit dauert das Gespräch zwischen
# einer und drei Minuten?

pexp(3, rate = 1/3) - pexp(1, rate = 1/3)
# 0.3486519

# Berechnen und interpretieren Sie das 25%-Quantil dieser
# Verteilung

qexp(.25, rate = 1/3)
# 0.8630462
# Interpretation: 25% der Gespräche sind kürzer als 0.86 Minuten (ca 52 Sekunden) 


# Aufgabe: Normalverteilung
# ----------------------------------------------------------------------------------------------------

# um weniger als 2 g vom Mittelwert abweicht?

sd_chips <- 4
mean_chips = 200
pnorm(q = mean_chips + 2, mean = mean_chips, sd = sd_chips) -
  pnorm(q = mean_chips - 2, mean = mean_chips, sd = sd_chips)
# 0.3829249

# über 205 g liegt?

pnorm(205, mean = mean_chips, sd = sd_chips, lower.tail = FALSE)
# 0.1056498

# Welches Gewicht wird von 95% der Tüten überschritten?

qnorm(.05, mean = mean_chips, sd = sd_chips)
# 193.4206 (Gramm)


# Aufgabe: Chi-Quadrat-Verteilung
# ----------------------------------------------------------------------------------------------------

# Problem: Mit welcher Wahrscheinlichkeit liegt der Wert einer χ^2
# Verteilung mit df = 11 über 15?

pchisq(15, df = 11, lower.tail = FALSE)
# 0.1824969


# Aufgabe: Studentsche t-Verteilung
# ----------------------------------------------------------------------------------------------------

# Problem: Mit welcher Wahrscheinlichkeit liegt der Wert der
# Studentschen t-Verteilung unter −0.5, respektive unter 1? Der
# Freiheitsgrad sei 7.

pt(c(-.5, 1), df = 7)
#  0.3162036 0.8246917 (x < -0.5 :  0.3162036 und x < 1 = 0.8246917)

