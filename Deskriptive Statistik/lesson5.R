# apropos("frame")

# Wahrscheinlichkeitsrechnung

# Fakultaet
factorial(5)

# Kombinationen (ohne Zuruecklegen, ohne Beachtung Reihenfolge)
choose(42, 6)
combn(4, 2)

# Permutation (ohne Zuruecklegen, mit Beachtung Reihenfolge)
choose(4, 2) * factorial(2)

perm <- function(n, k){
  factorial(n) / (factorial(n-k))
}

perm(4,2)

# oder ueber das Package 'combinat'
install.packages("combinat")
require(combinat)
permn(3)
combn(3,2)

# etwas Formatierungen
format(1234567.891011, digits=15, decimal.mark=",",
       big.mark="'", small.mark=" ", small.interval=3)


# Aufgabe:
# Eine Multiple-Choise-Prüfungen besteht aus 12 Fragen. Jede
# Fragen gibt 5 verschiedenen Antworten, von denen aber nur jeweils
# eine Antwort richtig ist. Ein Student löst die Aufgaben nach dem
# Zufallsprinzip. Bestimmen Sie die Wahrscheinlichkeit dafür, dass der
# Student maximal vier korrekte Antworten gibt.

# ?pbinom
# d=density (Hoehe Saeule), p=kumuliert (von 0 bis Zahl), q=(Quantil, Umkehrung, resp. Invers), 
# r=(random, Zufallszahlen nach dieser Methode)

# Genau 4 Fragen richtig
dbinom(4, size = 12, prob = 0.2)


# Maximal 4 Fragen richtig
dbinom(4, size = 12, prob = 0.2) +
  + dbinom(3, size = 12, prob = 0.2)+
  + dbinom(2, size = 12, prob = 0.2)+
  + dbinom(1, size = 12, prob = 0.2)+
  + dbinom(0, size = 12, prob = 0.2)

# oder eben
pbinom(4, size = 12, prob = .2)

# Wie gross ist die Wahrscheinlichkeit 6 und mehr richtig zu haben
# resp. die Prüfung zu bestehen?
1- pbinom(5, size = 12, prob = .2)
# (entspricht dem rechten Teil des Säulendiagramms)

# oder mit lower Tail
pbinom(5, size = 12, .2, lower.tail = FALSE)

# Wahrscheinlichkeitsverteilung plotten
xwerte <- 0:12
plot(xwerte, dbinom(xwerte, size = 12, prob = .2), type = "b")

# Poissionverteilung
# Bei sehr kleinen Wahrscheinlichkeiten die über einen 
# Zeitraum betrachet werden wir das Poission-Modell verwendet

# Aufgabe:
# Eine Brücke wird durchschnittlich von sieben Autos pro
# Minute passiert. Wie gross ist die Wahrscheinlichkeit, dass sich in
# einer Minute mehr als 17 Autos auf der Brücke befinden?

ppois(16, lambda = 7, lower.tail = FALSE)
plot(1:17, dpois(1:17, lambda = 7), type = "b")

