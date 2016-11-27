# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      27.11.2016
# Aufgaben:   CAS_DA_R_Lorenz_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------

# Frage: 
# Ist nicht der Ginikoeffizient immer schon normiert? Müsste man da nicht eher von korrigieren 
# sprechen? Und hat das nicht mehr mit der kleinen Anzahl Stichproben zu tun?

# Aufgabe Lorenzkurve und Ginikoeffizient
# ----------------------------------------------------------------------------------------------------

library(ineq)

# Marktanteile sortiert erfassen
marketshares <- sort(c(13.5, 13.4, 12.9, 12.4, 9.6))

# Lorenzkurve bestimmen
marketshares.lc <- Lc(marketshares)

# Lorenzkurve plotten
plot(marketshares.lc,
     main = "Lorenzkurve",
     lty = 3,
     lwd = 1,
     col = "red",
     sub = "Verteilung der Marktanteile unter den 5 stärksten TV-Sender",
     xlab = expression(u[i]),
     ylab = expression(v[i]))

legend("topleft", 
       c("Nullkonzentration", "effektive Konzentration"),
       lty=c(1,3),
       col = c("black", "red"),
       lwd=1)

# Ginikoeffizienten bestimmen
Gini(marketshares)

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
Gini.korr(marketshares)

