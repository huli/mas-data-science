# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      19.11.2016
# Aufgaben:   CAS_DA_R_Masszahlen_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------


# Aufgabe: arithmetischer Mittelwert
# ----------------------------------------------------------------------------------------------------

mean(faithful$waiting)


# Aufgabe: Median
# ----------------------------------------------------------------------------------------------------

median(faithful$waiting)


# Aufgabe: Quartile
# ----------------------------------------------------------------------------------------------------

quantile(faithful$waiting)


# Aufgabe: Quantile
# ----------------------------------------------------------------------------------------------------

quantile(faithful$waiting, c(0.17, 0.43, 0.67, 0.85))


# Aufgabe: Spannweite
# ----------------------------------------------------------------------------------------------------

# Funktion definieren
stat.span <- function(x){
    stopifnot(class(x) ==  "numeric")
    max(x) - min(x)
}

# Spannweite bestimmen
stat.span(faithful$waiting)

# oder einfacher (aber weniger wiederverwendbar)
# max(faithful$waiting)- min(faithful$waiting)


# Aufgabe: Interquartilsabstand
# ----------------------------------------------------------------------------------------------------

IQR(faithful$waiting)


# Aufgabe: Boxplot
# ----------------------------------------------------------------------------------------------------

boxplot(faithful$waiting, 
        horizontal = TRUE,
        main = "Boxplot of faithful waitings", col = "bisque")


# Aufgabe: Varianz
# ----------------------------------------------------------------------------------------------------

# Stichprobenvarianz
var(faithful$waiting)

# Populationsvarianz
var.pop <- function(x){
  stopifnot(class(x) == "numeric")
  var(x) * (length(x)-1) / length(x)
}

var.pop(faithful$waiting)


# Aufgabe: Standardabweichung
# ----------------------------------------------------------------------------------------------------

# Hinweis: Die Aufgabe heissst Standardabweichung, jedoch sollen noch einmal beide Varianzen
# bestimmt werden. Ich gehe davon aus, hier müssen korrekterweise beide Standardabweichungen ausgegeben
# werden.

# Stichprobenstandardabweichung
sd(faithful$waiting)

# Populationsstandardabweichung
sd.pop <- function(x){
  stopifnot(class(x) == "numeric")
  sqrt(var.pop(x))
}

sd.pop(faithful$waiting)


# Aufgabe: Korrelationskoeffizient
# ----------------------------------------------------------------------------------------------------

# Korrelationskoeffizient nach Pearson (wäre auch der Default)
cor(swiss$Fertility, swiss$Education, 
    method = "pearson")

# Interpretation: Das heisst, die Korrelation ist stark und gegensinnig
# (Siehe plot(swiss$Fertility, swiss$Education))


