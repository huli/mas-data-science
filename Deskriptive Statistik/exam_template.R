

library(TeachingDemos)
library(ineq)
library(ggplot2)




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


