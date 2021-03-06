
# Schätzen eines y-Wertes

# Problem: Wir modelieren den Zusammenhang 
# zwischen den Eruptionsdauern und den Wartezeiten 
# aus faithful mit einem lineare Modell. Wie lange 
# dauert die nächste Eruptions im Schnitt, wenn die 
# Wartezeit 80 Minuten beträgt?

faithful_lm <- lm(eruptions ~ waiting, data = faithful)
coeffs <- coefficients(faithful_lm)

waiting <- 80
expected_erutpion <- coeffs[1] + coeffs[2] * waiting
## (Intercept)
## 4.17622

# Oder mit R
predict(faithful_lm, data.frame( waiting = 80))
## 4.17622 -> Erwartete Eruptionsdauer ungefähr 4min

# Bestimmtheitsmass r^2

# Problem: Bestimmen Sie das Bestimmtheitsmass r2 des 
# linearen Modells zu faithful.

eruptions_lm <- lm(eruptions ~ waiting, data = faithful)
summary(eruptions_lm)$r.squared
## [1] 0.8114608 

# Signifikanztests

# Signifikanztest für β1

# Problem: Untersuchen Sie, ob zwischen den Grössen 
# eruptions und waiting aus faithful ein signifikanter 
# Zusammenhang besteht

eruptions_lm <- lm(eruptions ~ waiting, data = faithful)
summary(eruptions_lm)
# Antwort: Der p-Wert ist nahezu gleich 0. Die Nullhypothese β1 = 0
# wird verworfen. Offenbar besteht ein signifikanter Zusammenhang
# zwischen der Wartezeit und den Eruptiondauer

## Konfidenzintervalle für y

# Problem: Bestimmen Sie ein 95%-Konfidenzintervall 
# für die durchschnittliche Eruptionsdauer bei einer 
# Wartezeit von 80 Minuten.


eruptions_lm <- lm(eruptions ~ waiting, data = faithful)
waitings_df <- data.frame(waiting = 80)
predict(eruptions_lm, waitings_df, interval = "confidence")
# fit      lwr      upr
# 1 4.17622 4.104848 4.247592

# Antwort: Die durchschnittliche Eruptionszeit beträgt bei 
# einer Wartezeit von 80 Minuten zwischen 4.10 und 4.24 Minuten, 
# bei einem Signifikanzniveau von 95%.

# Prognoseintervalle für y

# Problem: Bestimmen Sie ein 95%-Prognoseintervall für 
# die Eruptionsdauer bei einer Wartezeit von 80 Minuten.

eruptions_lm <- lm(eruptions ~ waiting, data = faithful)
waitings_df <- data.frame(waiting = 80)
predict(eruptions_lm, waitings_df, interval = "predict")

# fit      lwr      upr
# 1 4.17622 3.196089 5.156351

# Die Eruptionszeit beträgt bei einer Wartezeit von 80 Minuten zwischen
# 3.20 und 5.16 Minuten, bei einem Signifikanzniveau von 95%

# Residuen-Plot

# Problem: Stellen Sie die Residuen des linearen Modells 
# zwischen der Eruptionsdauer und der Wartezeit aus 
# faithful grafisch dar.

eruptions_lm <- lm(eruptions ~ waiting, data = faithful)
eruptions_resids <- resid(eruptions_lm)

plot(faithful$waiting, eruptions_resids, ylab="Residuen",
     xlab="Wartezeit", main="Eruptionen von Old Faithful")
abline(0, 0)

# Oder auch
plot(eruptions_lm, which = 1)

# QQ-Plot

# Problem: Erstellen Sie das Normal-Wahrscheinlichkeits-Diagramm 
# der Residuen aus dem Datensatz faithful

eruptions_lm <- lm(eruptions ~ waiting, data = faithful)
plot(eruptions_lm, which = 2)

