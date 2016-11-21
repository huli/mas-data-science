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
  cat("Statistical dependency:", intpretation, "\n")
  return(cramerV.val)
}
 
# Cramer V bestimmen
cramerV.test(absatzwachstum)

chisq.test(absatzwachstum)$statistic

# Cramer's v 
# 
# data: absatzwachstum 
# Statistical dependency: medium 
# X-squared 
# 0.3544671 

# Intpretation
# Die Faustregel besagt, dass dieser Wert (da > 0.2) einem mittleren, 
# statistischem Zusammenhang entspricht

