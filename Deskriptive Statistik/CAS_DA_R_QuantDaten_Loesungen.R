# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      11.11.2016
# Aufgaben:   CAS_DA_R_QuantDaten_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------


# Aufgabe: Häufigkeitsverteilung quantitativer Daten
# ----------------------------------------------------------------------------------------------------

# Haufigkeitsverteilung ohne Gruppierung
table(faithful$waiting)

# Intervall mit meisten Eruptionen
waiting.max <- sort(table(faithful$waiting), decreasing = TRUE)[1]
waiting.max

# Range von Wartezeiten bestimmen
range.waiting <- range(faithful$waiting)

# Haeufigkeitsverteilung der Eruptionszeiten
hist(faithful$eruptions)


