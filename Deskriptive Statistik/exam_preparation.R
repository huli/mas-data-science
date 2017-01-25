


# Erwartete Verteilung ohne chi2

data <- na.omit(survey$Smoke)
n <- length(data)

smoke_expected <- c(.045, .795, .085, .075) * n
smoke_actual <- table(data)
  
# chi2 berechnen mit formel
chi <- sum((smoke_actual - smoke_expected) ^2 /
        smoke_expected)

df <- length(table(data)) -1
pchisq(chi, df, lower.tail = F)  


# Unabhängigkeitstests 
# ------------------------------------------------------------

# Unabhängitkeit mit Tabelle - ACHTUNG -> matrix nehmen!

row1 <- c(110, 120, 20, 30, 20)
row2 <- c(90, 60, 30, 10, 10)
m = matrix(c(row1,row2), byrow = T, nrow = 2)
chisq.test(m, correct = F)

# Unabhängigkeit bei nominalen Variablen
library(readxl)
RauchenGeschlecht <- read_excel("C:/temp/RauchenGeschlecht.xlsx")
View(RauchenGeschlecht)
chisq.test(RauchenGeschlecht$`Geschlecht des Kindes`,
           RauchenGeschlecht$`Rauchverhalten der Eltern`,
           correct = F)


# Unabhängigkeit bei nominalen Variablen
library(MASS)
data <- table(survey$Smoke, survey$Exer)
chisq.test(data,
           correct = F)

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
