

library(TeachingDemos)
library(ineq)
library(ggplot2)



# Stichprobengrösse ermitteln (Hier mit t-Verteilung)
# stichprobenGroesse(1.2, sd(heights), .05, length(heights))
stichprobenGroesse <- function(E, sd, alpha, df){
   t_alpha <- qt(1-alpha/2, df = df)
   cat("t_vaue: ", t_alpha)
   cat("\nn = ", ((t_alpha)^2 * sd^2) / E^2)
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


