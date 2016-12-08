
# Konfidenzintervall
qnorm(.975)

# Stichproble
# 1 - alpha : Konfidenzniveau
# alpha : Signifikantsniveau

expression(paste("",sigma))

# weiss 10 * 28 , = 283
# schwarz 42
# 42/283

# Praktisches Beispiel mit Reis
library(readxl)
df_reis <- read_excel("c:\\temp\\Reis16.xlsx")

# Daten mal anschauen
head(df_reis)
str(df_reis)
summary(df_reis)

# with(df_reis, {
#   n <- schwarz + weiss
# })

attach(df_reis)
n <- schwarz + weiss
p <- schwarz/n
range(p)

# Konfidenzniveau festlegen

# Signifikantsniveau
alpha <- .05

# SE (Standard error)
SE <- sqrt(p * (1-p)/n) # ist bei jeder Stichprobe anders

# Fehlerbereich (u mal die Wurzel) - Margin of error
E <- qnorm(1- alpha/2) * SE

# Von Schätzung p wird oben und unten das Intervall abgezogen, resp. addiert
grenze_o <- p+E
grenze_u <- p-E

# Konfidenzintervalle anzeigen
plot(1:22, grenze_u, ylim = c(.07, .4), col = "red")
points(1:22, grenze_o, col = "blue")

# Wert mit grossem Konfidenzintervall:
# Kleine Stichprobe führ zu grosser Unsicherheit, resp. grossem Konfidenzintervall

# Fuer beste Schätzung alle vereinen
durchschnitt <- sum(schwarz)/sum(n)

# Linie hinzufuegen (fuer wahren Wert)
abline(h=durchschnitt)

# Interpretation: Nur eine Messung enhält den wahren Wert nicht,
# was unserem Signifikanzniveau von 5% entspricht (5% von 22 Leuten = ca. 1)
points(1:22, p, type = "b")
