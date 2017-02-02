




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

mean_geom <- function (x)
{
  n<-length(x) 
  mittelwert<-prod(x)^(1/n) 
  return (mittelwert)
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



