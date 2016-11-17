

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


