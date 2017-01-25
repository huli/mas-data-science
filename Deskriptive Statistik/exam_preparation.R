






# Unabhängigkeit bei zwei metrischen Variablen
# Sind die beiden Variablen unabhängig
cor.test(faithful$eruptions, faithful$waiting,
         method = "pearson")



# Lineare Regression
# y = (b1 + b2 * x) + e
# ------------------------------------------------------------

# Einfacher Plot von linerarem Modell
library(ggplot2)
ggplot(faithful, aes(x=waiting, y=eruptions)) +
  geom_point() +
  geom_smooth(method = "lm")

# Schätzen eines y-Wertes
# Nächste Eruptionsdauer im Schnitt
model <- lm(eruptions ~ waiting, faithful)
predict(model, data.frame(waiting = 80))

# Bestimmtheitsmass r^2
summary(lm(eruptions ~ waiting, faithful))$r.squared
# -> Anteile in Prozent, welche durch das Modell 
# erklärt werden kann

# Signifikanz?
summary(lm(eruptions ~ waiting, faithful))
# -> p-Wert


# Konfidenzintervall von Steigung und Schnittpunkt

model <- lm(data=Daten_Wachstum, 
            formula = Wachstumsrate ~ Erfahrung)
summary(model)

# y = b1 + b2*x + E
SE1 <- summary(model)$coefficients[1, "Std. Error"]
SE2 <- summary(model)$coefficients[2, "Std. Error"]

alpha <- .05

E1 <- qnorm(1-alpha/2) * SE1
b1 <- model$coefficients[1] + c(-E1, E1)

E2 <-  qnorm(1-alpha/2) * SE2
b2 <- model$coefficients[2] + c(-E2, E2)

# Konfidenzintervall Schnittpunkt
b1

# Konfidenzintervall Steigung
b2
