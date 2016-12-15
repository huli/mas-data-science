
library(MASS)

# Datensatz: survey

# Konfidenzintervall
t.test(survey$Height)
# 95 percent confidence interval:
#   171.0380 173.7237

# Problem: Bestimmen Sie benötigte Stichprobengrösse für die
# durchschnittliche Körpergrösse bei einem Fehlerbereich von 1:2 cm
# und einem Konfidenzniveau von 95%.

# NA's herausfiltern
height_response <- na.omit(survey$Height)

# Quantil bestimmen
# (habe die Fläche, will die Zahl -> in R ein q-Befehl)
zstar <- qnorm(.975)

# Wert unten wäre
qnorm(.025)

# Soweit die Vorgabe, nun die Standardabweichung berechnen
s <- sd(height_response)
E <- 1.2

# Formel von Seite 25 anwenden
zstar^2 * s^2/E^2
# (Ich müsste mindestens 258 Personen befragen (258.695) 
#           <- Mit Normalverteilung, was nicht korrekt ist bei unbekannter sd)
# Die t-Verteilung kann ich nicht nehmen, weil ich die Stichprobengrösse ja bestimmen will
# und ich diese für den degree of freedom für die die t-Verteilung haben müsste.
# (Deshalb macht man die Mischrechnung - Ab 30 Stichproben ist die Verteilung der 
# Normalverteilung nahe)