




# Stichprobengrösse fuer Anteil ermitteln
stichprobenGroesseAnteil <- function(E, p0, alpha){
  if(is.na(p0))
  {
    p0 <- .5
  }
  z_star <- qnorm(1-alpha/2)
  cat("z-Wert (Konfidenzniveau): ", z_star)
  n <- (z_star^2 * p0 * (1-p0)) / E^2
  cat("\nn: ", n)
}

# Stichprobengrösse fuer Mittelwert ermitteln
stichprobenGroesse <- function(E, sd, alpha){
  z_star <- qnorm(1-alpha/2)
  cat("z-Wert (Konfidenzniveau): ", z_star)
  cat("\nn = ", ((z_star)^2 * sd^2) / E^2)
}

# Fehlerbereich und t-Value ermitteln
# errorAndMore(survey$Height, .05)
zweiseitigAnalyse <- function(values, alpha) {
  without_nas <- na.omit(values)
  s <- sd(without_nas)
  n <- length(without_nas)
  SE <- s / sqrt(n)
  cat("\nStandardfehler: ", SE)
  E <- qt(1-alpha/2, n-1) * SE
  cat("\nFehler: ", E)
  mu <- mean(without_nas)
  cat("\nFehlerbereich: ", mu + c(-E,E))
}

# Fehlerbereich und t-Value ermitteln
# errorAndMore(survey$Height, .05)
einseitigAnalyse <- function(values, alpha) {
  without_nas <- na.omit(values)
  s <- sd(without_nas)
  n <- length(without_nas)
  SE <- s / sqrt(n)
  cat("\nStandardfehler: ", SE)
  E <- qt(1-alpha, n-1) * SE
  cat("\nFehler: ", E)
  mu <- mean(without_nas)
  cat("\nFehlerbereich: ", mu + c(-E,E))
}



library(TeachingDemos)
library(ineq)
library(ggplot2)
# library(DescTools)
# DescTools::CramerV()
# DescTools::ContCoef()

# RData -> File -> load("C:/temp/Daten_Schulung.RData")
# txt -> penguings <- scan("c:/temp/penguins.txt")
# csv -> File -> gemeindedaten <- read.csv("c:/temp/gemeindedaten.csv")
# excel -> RauchenGeschlecht <- read_excel("C:/temp/RauchenGeschlecht.xlsx")





# zuerst x
m <- lm(eruptions ~ waiting, data = faithful)
plot(faithful$waiting, resid(m))

# Achtung: mit data.frame funktioniert nur wenn ohne faithful$
predict(m, data.frame(waiting = 80), interval = "predict")


# Konfidenzintervall
model <- lm(eruptions ~ waiting, data = faithful)
confint(model)
# 2.5 %      97.5 %
#   (Intercept) -2.18930436 -1.55872761
# waiting      0.07126011  0.07999579


# modellierung
ggplot(aes(waiting, eruptions), data = faithful) +
  geom_point()+
  geom_smooth(method = "lm")


# Unabhängigkeit
cor.test(faithful$waiting, faithful$eruptions,
         method = "pearson")


# Verteilung
chisq.test(table(survey$Smoke), p = c(.045, .795, .085, .075), 
           correct = F)

pchisq(0.10744, df = 3, lower.tail = F)

# Unabhängige Stichproben
t.test(mpg ~ am, data = mtcars)



