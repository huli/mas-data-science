# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      28.12.2016
# Aufgaben:   CAS_DA_R_Tests_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------


# Nur Notizen

# Aufgabe: Linksseitiger Test bei µ, σ bekannt
# ----------------------------------------------------------------------------------------------------

rm(list = ls())

bulbs <- scan("C:\\temp\\lightbulbs.txt")

# mit R
library(TeachingDemos)
z.test(bulbs, mu = 10000, stdev = 120, alternative = "less", conf.level = .99)
# Kann nicht gehalten werden. 0-Hypothese wird verworfen.

# Ohne z.test
mu <- 10000
m0 <- mean(bulbs)
sd <- 120
n <- length(bulbs)
alpha <- .01

# Wahrscheinlichkeit von Ergebnis
pnorm(m0, mean = 10000, sd = 120/sqrt(n))
## [1] 3.088019e-05 -> p-Wert kleiner als alpha -> 0-Hypothese verwerfen

# Kritischer Wert bestimmen
z <- qnorm(alpha, mean = 10000, sd = 120/sqrt(n))
m0 < z
## [1] TRUE -> 0-Hypothese verwerfen


# Aufgabe: Rechtsseitiger Test bei µ, σ bekannt
# ----------------------------------------------------------------------------------------------------

cookies <- scan("C:\\temp\\cookies.txt")

sigma <- .25 #g
mu <- 2 #g
alpha <- .1

z.test(cookies, mu = 2, stdev = .25, conf.level = .9, alternative = "greater")

# 0-Hypothese kann gehalten werden - auch hier wieder conf.level?
# Wieso ist hier der confidence intervall 1.96 - Inf? Macht doch keinen Sinn, denn 2.8 wäre
# ja sicher nicht im Rahmen


# Aufgabe: Zweiseitiger Test bei µ, σ bekannt
# ----------------------------------------------------------------------------------------------------
penguins <- scan("C:\\temp\\penguins.txt")

sigma <- .25 #g
# mu Unbekannt, deshalb müssen wir das aus der Stichprobe nehmen, resp. t.test bemühen
alpha <- .05

t.test(penguins, conf.level = .95, alternative = "two.sided")
z.test(penguins, conf.level = .95, stdev = sigma, alternative = "two.sided")

# Da fehlt doch was?? Nimmt man das Durchschnittgewicht von der vorderen Aufgabe?
# 0-Hypothese kann beibehalten werden. t.test verwenden ok?
# Wieso ist hier der p-Wert klein, jedoch ist die Nullhypothese trotzdem richtig?


# Aufgabe: Linksseitiger Test bei µ, σ unbekannt
# ----------------------------------------------------------------------------------------------------

bulbs <- scan("C:\\temp\\lightbulbs.txt")

t.test(bulbs, mu = 10000, conf.level = .99, alternative = "less")

# 0-Hypothese verwerfen. Conf-Level bezieht sich immer auf die Alternative


# Rechtsseitiger Test bei µ, σ unbekannt
# ----------------------------------------------------------------------------------------------------

# todo