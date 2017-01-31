

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





t.test(Daten_Schulung$Pre, Daten_Schulung$Post, conf.level = .95,
       correct = F, alternative = "greater")

# todo
confint(lm(Daten_Wachstum$Wachstumsrate~Daten_Wachstum$Erfahrung), level = .95)


summary(lm(Daten_Wachstum$Wachstumsrate~Daten_Wachstum$Erfahrung))
sqrt(0.3812)

# Merken
# Paired Test ist mit Differenz

# Merken !!!!!
t.test(Daten_Wachstum$Alter ~Daten_Wachstum$Geschlecht,
       conf.level=.95 )

# TODO
# Varianz, Sd von Anteil -> übersicht ergänzen

# ü 62
prop.test(102, 1200, p = .10, correct = F,
          conf.level = .95, alternative = "less")

# Ü 54
SE <- sqrt(.666*(1-.666)/100)
E <- qt(.975, 99) * SE
.666 + c(-E,E)


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
errorAndMore <- function(values, alpha) {
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


