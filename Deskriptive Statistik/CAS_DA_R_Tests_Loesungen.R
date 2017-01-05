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


n <- length(bulbs)
mu <- 10000

# mit R
library(TeachingDemos)
z.test(bulbs, mu = 10000, stdev = 120, alternative = "less", conf.level = .99)
# Kann nicht gehalten werden. 0-Hypothese wird verworfen.

# Ohne z.test
m0 <- mean(bulbs)
sd <- 120
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

# mit z.test
z.test(cookies, mu = 2, stdev = .25, conf.level = .9, alternative = "greater")
# 0-Hypothese kann gehalten werden

n <- length(cookies)
m0 <- mean(cookies)

# Ueber kritischem Wert
z <- qnorm(1-alpha, sd = .25/sqrt(n), lower.tail = FALSE)
z > m0 
## [1] FALSE -> 0-Hypothese kann behalten werden.



# Aufgabe: Zweiseitiger Test bei µ, σ bekannt
# ----------------------------------------------------------------------------------------------------
penguins <- scan("C:\\temp\\penguins.txt")

# Da fehlt was. Aufgabe kann nicht gelöst werden. Zur Bestimmung einer Veränderung brauchen wir
# eine Grundgrösse.


# Aufgabe: Linksseitiger Test bei µ, σ unbekannt
# ----------------------------------------------------------------------------------------------------

bulbs <- scan("C:\\temp\\lightbulbs.txt")

t.test(bulbs, mu = 10000, conf.level = .99, alternative = "less")
# p-Wert ist kleiner als 1% -> 0-Hypothese verwerfen




# Rechtsseitiger Test bei µ, σ unbekannt
# ----------------------------------------------------------------------------------------------------

# todo