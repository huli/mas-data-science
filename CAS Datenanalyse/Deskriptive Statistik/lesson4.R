

install.packages("ineq", repos = "http://cran.rstudio.com/")

library(ineq)

# Sortiert nach Groesse
einkommen <- c(1000, 1000, 1000, 3000, 4000)

# Lorenz curve
Lc(einkommen, plot = TRUE)

# ?Lc

# Mit Gewichtung
einkommen_kurz <- c(1000, 3000, 4000)
Lc(einkommen_kurz, c(3,1,1), plot = TRUE)

# Ueber plot mit etwas Customization
lcx <- Lc(einkommen)
plot(lcx, 
     main = "Lorenzkurve", 
     xlab = expression(u[i]), 
     ylab = expression(v[i]))

# Gini berechnen
Gini(einkommen)

# Normierte funktion machen die diskrete Merkmale beruecksichtigt
GiniNormiert <- function(x){
  ifelse(length(x) ==1, NA,
  Gini(x)/(1-1/length(x)))
}

HulisGiniNormiert <- function(x){
  if(length(x) == 1)
    NA
  else
    Gini(x)/(1-1/length(x))
}

GiniNormiert(einkommen)
HulisGiniNormiert(einkommen)

# 0.4
# -> 40% der maximalen Ungleichheit ist erreicht

# Maximalkonzentration
GiniNormiert(c(0,0,1000))

# Nullkonzentration
GiniNormiert(c(1000, 1000, 1000))

# Chi-Quadrat bestimmen
#--------------------------------------------------------------------

# Daten erfassen
studis <- matrix(c(110, 120, 20, 30, 20, 90, 60, 30, 10,10),
                 nrow = 2, byrow = TRUE)

rownames(studis) <- c("männlich", "weiblich")
colnames(studis) <- c("BWL","Soz","VWL","SoWi","Stat")

# Chi-Quadrat bestimmen
chisq.test(studis)

# Variablen anschauen die da gerechnet werden
chisq.test(studis)$statistic

# Zusammenhang Cramers V (Hollaendische Variante)
cramersV <- function(x){
  chi.val <- chisq.test(x)$statistic
  sqrt((chi.val/
      (sum(x)*(min(dim(x)) -1))))
}

cramersV(studis)

# Zusammenhang mit Pearson (entspricht aber dem Kontingenzkoeffizient nach Pearson)
# https://de.wikipedia.org/wiki/Kontingenzkoeffizient#Quadratische_Kontingenz

sqrt(chisq.test(studis)$statistic/
       (chisq.test(studis)$statistic+sum(studis)))

pearson <- function(x){
  sqrt(chisq.test(x)$statistic/
         (chisq.test(x)$statistic+sum(x)))
}

pearson(studis)

# Free style
beurteilung <- function(x){
  if(x < 0.2)
    "schwacher Zusammenhang"
  else if(x < 0.6)
    "mittlerer Zusammenhang"
  else
    "starker Zusammenhang"
}

beurteilung(pearson(studis))


# Varianz bestimmen (Durchschnittliche quadrierte Abweichung)
var(faithful$eruptions)

# Standarbweichung
sd(faithful$eruptions)

# s ist Wurzel aus Varianz
sqrt(var(faithful$eruptions)) == sd(faithful$eruptions)

# Kovarianz
# Person bei metrischen
# Spearman bei ordinalen
cov(faithful$eruptions, faithful$waiting)

# Korrelationskoeffizient
cor(faithful$eruptions, faithful$waiting)
