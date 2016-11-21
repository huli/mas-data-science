# ----------------------------------------------------------------------------------------------------
# Modul:      Deskriptive Statistik
# Author:     Christoph Hilty
# Datum:      19.11.2016
# Aufgaben:   CAS_DA_R_Zusammenhang_Aufgaben.pdf
# ----------------------------------------------------------------------------------------------------


# Aufgabe: Zusammenhang nominaler Merkmale
# ----------------------------------------------------------------------------------------------------

# Daten in Matrix erfassen
absatzwachstum <- matrix(c(19, 27, 4, 
                            7,  8, 5,
                            1, 13, 16), byrow = TRUE, nrow = 3)

colnames(absatzwachstum) <- c("stark", "mittel", "schwach")
rownames(absatzwachstum) <- c("A", "B", "C")

# Chi-Quadrat-Test duchführen
chisq.test(absatzwachstum)

# Pearson's Chi-squared test
# X-squared = 25.129, df = 4, p-value = 4.738e-05

# Interpretation
# Da der p-value kleiner als der Signifikationslevel (.05) ist, wird die Nullhypothese abgelehnt
# und es scheint eine Abhängigkeit zwischen den beiden Variablen vorzuliegen.

# Wir verifizieren diese Hypothese mittels dem normierten Cramerschen Zusammenhangsmass
# Funktion fuer Cramer V definieren
cramerV.test <- function(x){
  chisq.val <- chisq.test(x)$statistic
  cramerV.val <- sqrt(chisq.val /
              (sum(x) * min(dim(x) -1)))
  
  stopifnot(0 <= cramerV.val &  cramerV.val <= 1)
  if(cramerV.val > .6){
    intpretation = "strong"
  } else if(cramerV.val > .2){
    intpretation = "medium"
  }
  else{
    intpretation = "weak"
  }
  cat("\n", "Cramer's v", "\n\n")
  cat("data:", deparse(substitute(x)), "\n")
  cat("V = ", cramerV.val, "\n")
  cat("Statistical dependency:", intpretation, "\n")
  names(cramerV.val) <- "V"
  result <- list("statistic"= cramerV.val)
  return(result)
}
 
# Cramer V bestimmen
cramerV.test(absatzwachstum)$statistic

# Cramer's v 
# 
# data: absatzwachstum 
# V =  0.3544671 
# Statistical dependency: medium 

# Intpretation
# Die Faustregel besagt, dass dieser Wert (da > 0.2) einem mittleren, 
# statistischem Zusammenhang entspricht und wir bestaetigen somit unsere
# Aussage von dem Chiquadrat-Test


# Aufgabe: Statistischer Zusammenhang: Metrische Merkmale#
# ----------------------------------------------------------------------------------------------------

load("C:\\temp\\StorchBabies.RData")

# Berechnung des Korrelationskoeffizienten nach Pearson
cor(StorchBabies$Storchenpaare, StorchBabies$Geburtenrate, method = "pearson")

# Interpretation
# Der Wert 0.6088695 ist zu intpretieren als einen starken, gleichsinnig gerichteten 
# statistischen Zusammenhang
# (Gleichsinnig da > 0 und stark, da > .6)


# Aufgabe: Statistischer Zusammenhang: Ordinale Merkmale
# ----------------------------------------------------------------------------------------------------
 
# Daten in das richtige Format bringen (Beobachtungseinheiten auf Y-Achse und Merkmale auf X-Achse)
tasting <- matrix(c(9, 1, 10, 6, 5, 8,
                    7, 5, 12, 10, 8, 3), ncol = 2, byrow = FALSE)
colnames(tasting) <- c("Tasting-Master", "Whisky-Friend")
rownames(tasting) <- c("Whisky 1", "Whisky 2", "Whisky 3", "Whisky 4", "Whisky 5", "Whisky 6")

cor(tasting[,1], tasting[,2], method = "spearman")

# Interpretation
# Der Wert 0.3714286 ist zu interpretieren als einen mittleren, gleichsinnig gerichteten Zusammenhang

# Das ganze noch als data frame
tasting.frame <- data.frame(
  whiskys = c(1,2,3,4,5,6),
  "Tasting-Master" = c(9, 1, 10, 6, 5, 8),
  "Whisky-Friend" = c(7, 5, 12, 10, 8, 3)
)

cor(tasting.frame$Tasting.Master, tasting.frame$Whisky.Friend, method = "spearman")

# Interpretation bleibt wie der Wert auch die gleiche ;)


