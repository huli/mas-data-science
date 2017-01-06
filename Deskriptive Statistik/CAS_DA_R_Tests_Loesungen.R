# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      28.12.2016
# Aufgaben:   CAS_DA_R_Tests_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------

rm(list = ls())

# TODO
# Intervall angeben bei nicht kompletten zweiseitigen Tests
# ev. Hypothesen formulieren

# Aufgabe: Linksseitiger Test bei µ, σ bekannt
# ----------------------------------------------------------------------------------------------------

bulbs <- scan("C:\\temp\\lightbulbs.txt")

# H0: mu >= 10'000, Ha: mu < 10'000

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

# Antwort:
# Bei einem Konfindenzlevel von 99% muss die Behauptung des Herstellers
# von einer Mindestlebensdauer von 10'000 Stunden verworfen werden.


# Aufgabe: Rechtsseitiger Test bei µ, σ bekannt
# ----------------------------------------------------------------------------------------------------

cookies <- scan("C:\\temp\\cookies.txt")

# H0: mu <= 2, Ha: mu > 2

sigma <- .25 #g
mu <- 2 #g
alpha <- .1

# mit z.test
z.test(cookies, mu = 2, stdev = .25, conf.level = .9, alternative = "greater")
# 0-Hypothese kann nicht verworfen werden

n <- length(cookies)
m0 <- mean(cookies)

# Ueber kritischem Wert
z <- qnorm(1-alpha, sd = .25/sqrt(n), lower.tail = FALSE)
z > m0 
## [1] FALSE -> 0-Hypothese kann nicht verworfen werden

# Antwort:
# Bei einem Konfidenzlevel von 90% muss die Behauptung des Herstellers
# von einem maximalen Anteil von 2g beibehalten werden.


# Aufgabe: Zweiseitiger Test bei µ, σ bekannt
# ----------------------------------------------------------------------------------------------------
penguins <- scan("C:\\temp\\penguins.txt")

# Da fehlt was. Aufgabe kann theoretisch nicht gelöst werden. 
# Zur Bestimmung einer Veränderung brauchen wir eine Grundgrösse.

# H0: mu = m0, Ha: mu != m0

# Variante 1: Wir nehmen das aus vorherigen Übungen bekannte Durchschnittsgewicht
# der Pinguine von 15.4 kg und prüfen aufgrund dieser These
mu = 15.4
z.test(penguins, stdev = 2.5, mu = mu, alternative = "two.sided", conf.level = .95)
## p-value = 0.1389 -> H0 muss behalten werden

# Variante 2: Wir bestimmen den Konfidenzintervall von 95% aus unserer Stichprobe
# mittels Standardisierung

# Standardfehler bestimmen
alpha <- .05
SE <- 2.5/sqrt(length(penguins))
E <- qnorm(1-(alpha/2)) * SE
m0 <- mean(penguins)
m0 + c(-E,E)
## [1] 13.94640 15.60287
# Wenn der fehlende Durchschnittswert innerhalb dieses Konfidenzintervalls ist
# dann muss die 0-Hypothese behaltn werden


# Aufgabe: Linksseitiger Test bei µ, σ unbekannt
# ----------------------------------------------------------------------------------------------------

bulbs <- scan("C:\\temp\\lightbulbs.txt")

t.test(bulbs, mu = 10000, conf.level = .99, alternative = "less")
# p-Wert ist kleiner als 1% -> 0-Hypothese verwerfen

# Antwort:
# Nein, die 0-Hypothese kann mit einem Signifikanzniveau von 1% nicht gehalten werden.
# Der wahre Mittelwert der Grundgesamtheit ist mit 99% Konfidenz kleiner als 10'000 Stunden



# Rechtsseitiger Test bei µ, σ unbekannt
# ----------------------------------------------------------------------------------------------------

cookies <- scan("c:\\temp\\cookies.txt")

t.test(cookies, mu = 2, conf.level = .9, alternative = "greater")
## p-value = 0.3497 -> 0-Hypothese behalten

# Wie kann ich hier das confidence intervall interpretieren?

# Antwort:
# Bei einem Konfidenzlevel von 90% muss die Behauptung des Herstellers
# von einem maximalen Anteil von 2g beibehalten werden.


# Aufgabe: Zweiseitiger Test bei µ, σ unbekannt
# ----------------------------------------------------------------------------------------------------
penguins <- scan("C:\\temp\\penguins.txt")

# Da fehlt was. Aufgabe kann nicht gelöst werden. Zur Bestimmung einer Veränderung brauchen wir
# eine Grundgrösse.

# Aufgabe: Linksseitiger Test des Populationsanteils p
# ----------------------------------------------------------------------------------------------------

### Was ist hier die 0-Hypothese

grocery <- read.csv("C:\\temp\\grocerystore.csv", sep = ";")
grocery_sex <- grocery$gender
n <- length(grocery_sex)
k <- length(grocery_sex[grocery_sex == "F"])

prop.test(k, n, p = .5, conf.level = .95, alternative = "less", correct = FALSE)
# p-value = 0.9938 -> 0-Hypothese muss behalten werden

# Antwort:
# Aufgrund der Stichprobe lässt sich bei einem Konfidenzlevel von 95%
# behaupten, dass die Metzgerei zu einem grösseren Teil von Frauen besucht wird.


# Aufgabe: Rechtsseitiger Test des Populationsanteils p
# ----------------------------------------------------------------------------------------------------

library(data.table)
credit_csv <- read.csv("C:\\temp\\creditcards.csv", sep = ";")
credits <- credit_csv %>% as.data.table()
number_of_credits <- nrow(credits)
number_of_ruptured_credits <- nrow(credits[bounced == "Yes"])

prop.test(number_of_ruptured_credits, number_of_credits, alternative = "greater",
          p = .12, conf.level = .95, correct = FALSE)
## p-value = 0.02581 -> 0-Hypothese muss verworfen werden

# Antwort:
# Die Bank muss bei einer Konfidenz von 95% davon ausgehen, dass der Anteil
# von geplatzten Krediten 12% übersteigt


# Aufgabe: Zweiseitiger Test des Populationsanteils p
# ----------------------------------------------------------------------------------------------------

# Hier ist aus meiner Sicht die Frage nicht korrekt:
# Hier müsste sich die Schätzung doch auf alle Studierenden und nicht auf die Stichprobe beziehen

library(MASS)
hands <- survey %>%  as.data.table()
total_hands <- length(na.omit(hands$W.Hnd))
right_hands <- nrow(hands[W.Hnd == "Right",])

prop.test(right_hands, total_hands, p = .9, conf.level = .99,
          alternative = "two.sided", correct = FALSE)
## p-value = 0.2243 -> 0-Hypothese wird behalten

# Antwort:
# Die Schätzung von 90% Rechtshänder kann bei einer Konfidenz von 99%
# beibehalten werden.

