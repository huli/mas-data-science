# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      15.01.2017
# Aufgaben:   CAS_DA_R_GoF_Aufgaben.pdf 
# ----------------------------------------------------------------------------------------------------

library(MASS)

# Aufgabe: Anpassungstests

## Wieso wird hier lower.tail = F genommen????

# H0: Das Rauchverhalten ist wie angenommen
# Ha: Das Rauchverhalten ist nicht wie angenommen

n <- length(na.omit(survey$Smoke))
actual <- table(survey$Smoke)
expected <- c(.045, .795, .085, .075) * n

# Chi2 berechnen
chi <- sum((actual - expected)^2/expected)
## [1] 0.1074429

# p-Wert berechnen
df <- length(table(survey$Smoke)) -1
pval <- pchisq(chi, df = df, lower.tail = F)
## [1] 0.9909295


# Aufgabe: Unabhängigkeitstests

# H0: keine Abhängigkeit 
# Ha: Abhängigkeit

library(openxlsx)
daten <- read.xlsx("C:\\temp\\RauchenGeschlecht.xlsx")

chisq.test(table(daten$Geschlecht.des.Kindes, 
                 daten$Rauchverhalten.der.Eltern))
## X-squared = 2.9511, df = 2, p-value = 0.2287
## -> p-Value grösser als 0.05 -> wir behalten H0

# oder auch
chisq.test(daten$Geschlecht.des.Kindes, 
           daten$Rauchverhalten.der.Eltern)




