# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      27.11.2016
# Aufgaben:   CAS_DA_R_Lorenz_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------

# Frage: 
# Ist nicht der Ginikoeffizient immer schon normiert? Müsste man da nicht eher von korrigieren 
# sprechen - wie es im Script teilweise auch wird? 

# Aufgabe Lorenzkurve und Ginikoeffizient
# ----------------------------------------------------------------------------------------------------

if(!require("ineq")) install.packages("ineq")

# Marktanteile sortiert erfassen
marketshares <- sort(c("ARD-Dritte" = 13.5, 
                       "ARD" = 13.4, 
                       "ZDF" = 12.9, 
                       "RTL" = 12.4, 
                       "Sat.1" = 9.6))

# Lorenzkurve bestimmen
marketshares.lc <- Lc(marketshares)

# Lorenzkurve plotten
plot(marketshares.lc,
     main = "Lorenzkurve",
     lty = 3,
     lwd = 1,
     col = "red",
     sub = "Verteilung der Marktanteile unter den 5 marktstärksten TV-Sender in Deutschland",
     xlab = expression(u[i]),
     ylab = expression(v[i]))

legend("topleft", 
       c("Nullkonzentration", "effektive Konzentration"),
       lty=c(1,3),
       col = c("black", "red"),
       lwd=1)

grid()

# Ginikoeffizienten bestimmen
round(Gini(marketshares), 3)


# Funktion für korrigierten Ginikoeffizienten
Gini.korr <- function(x){
  if(length(x) == 1)
  {
    NA
  }
  else
  {
     Gini(x) / (1-1/length(x))
  }
}

# Korrigierter Ginikoeffizient
round(Gini.korr(marketshares), 3)

# Oder neu auch über die bestehende Funktion mit
# entsprechender Parameterisierung
round(Gini(marketshares, corr = T), 3)


