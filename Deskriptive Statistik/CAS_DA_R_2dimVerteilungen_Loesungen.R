# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      11.11.2016
# Aufgaben:   CAS_DA_R_2dimVerteilungen_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------


# Daten laden
load("C:\\Users\\ch0125\\Dropbox\\BFH\\Deskriptive Statistik\\Daten_WachstumX.RData")

attach(Daten_Wachstum)

# Aufgabe: zweidimensionale Haeufigkeitsverteilung

gender.motiv.freq <- table(Geschlecht, Motiv)
gender.motiv.freq

# Aufgabe: Randverteilungen
addmargins(gender.motiv.freq)

# Aufgabe: Relative Zweidimensionale Verteilung
gender.motiv.relfreq <- prop.table(table(Geschlecht, Motiv))
gender.motiv.relfreq

# Aufgabe: Bedingte Verteilung 1
addmargins(prop.table(gender.motiv.freq, 1))

# Aufgabe: Bedingte Verteilung 2
addmargins(prop.table(gender.motiv.freq, 2))

