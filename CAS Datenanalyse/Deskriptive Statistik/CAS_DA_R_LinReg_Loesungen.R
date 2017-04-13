# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      15.01.2017
# Aufgaben:   CAS_DA_R_LinReg_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------


# Aufgabe: Schätzen eines y-Wertes
# --------------------------------------------------------------------------

# Plot erstellen zur Uebersicht
library(ggplot2)
ggplot(aes(y = wt, x = hp), data = mtcars) +
  geom_point() +
  stat_smooth( method = "lm")

model <- lm(wt ~ hp, data = mtcars)

# Durchschnittlicher Wert bestimmen
predict(model, newdata = data.frame(hp = 200))
# 3'718'439 lbs

# oder mit
coeffs <- model$coefficients
coeffs[1] + coeffs[2] *  200

# Aufgabe: Bestimmtheitsmass
# --------------------------------------------------------------------------
summary(model)$r.squared
## [1] 0.4339488 - Bestimmtsheitsmass r2


# Aufgabe: Signifikanztest für β1
# --------------------------------------------------------------------------
summary(model)$coefficients
## 4.15e-05 -> entspricht einem signifkanten Zusammenhang


# Aufgabe: Konfidenzintervalle für y
# --------------------------------------------------------------------------
predict(model, data.frame(hp = 200), interval = "confidence", 
        level = .95)
#        fit      lwr      upr
#       3.718439 3.374138 4.062739
# Das erwartete, durchschnittliche Gewicht bei 200hp liegt zwischen 3.37klbs und 4.06klbs


# Aufgabe: Prognoseintervalle für y
# --------------------------------------------------------------------------
predict(model, data.frame(hp = 200), interval = "predict", 
        level = .95)
#     fit      lwr      upr
#     3.718439 2.151853 5.285024
# Das erwartete Gewicht bei 200hp liegt zwischen 2.15klbs und 5.29klbs


# Aufgabe: Residuen-Plot
# --------------------------------------------------------------------------
# plot(model, which = 1)

# oder auch
plot(mtcars$hp, model$residuals)
abline(0,0)



# Aufgabe: QQ-Plot
# --------------------------------------------------------------------------
plot(model, which = 2)


