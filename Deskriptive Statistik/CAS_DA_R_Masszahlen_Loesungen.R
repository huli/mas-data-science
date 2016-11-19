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


