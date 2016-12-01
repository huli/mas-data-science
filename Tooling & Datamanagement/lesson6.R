
# rm(list = ls())

# Grafiken / Plotten

# Histogramm von 100 Zufallszahlen erstellen
p <- hist(rnorm(n=100,sd=.8))

# Exportieren
# Generell: Vektoren (svg/pdf) verwenden, ausser bei vielen
# Datenpunkten (dann TIFF/BMP)
svg("c:\\temp\\myhistogram.svg")
hist(rnorm(n=100,sd=.8))
dev.off()

# andere einfache Plots
boxplot(count ~ spray, data = InsectSprays, col = "lightgray")
plot(cars) # Scatterplot

# Summary Statistiken und einfache Tabellen

if(!require("stargazer")) install.packages("stargazer")
library(stargazer)

if(!require("car")) install.packages("car")
library(car)
stargazer(Prestige) #tex
stargazer(Prestige,type="text") #ascii
stargazer(head(Prestige),type="text", summary=FALSE) # blanke Inhalte ausgeben
stargazer(Prestige,type="html") #  html
# Datei schreiben über Option out="path/file"


if(!require("ReporteRs")) install.packages("ReporteRs")
library(ReporteRs)
mydoc = docx() # docx erzeugen
mydoc = addFlexTable(mydoc, FlexTable(head(Prestige))) # Tabelle zufügen
writeDoc(mydoc, file = "c:\\temp\\prestige.docx") # in Datei schreiben

# Regressionstabellen:

# Ein paar Zufallszahlen
x1 <- rnorm(100)
x2 <- rnorm(100)
y <- rnorm(100) + 2*x1 + 1*x2

fit1 <- lm(y~x1)
fit2 <- lm(y~x2)

# install.packages("texreg")
library(texreg)
htmlreg(list(fit1, fit2), file = "meinetabelle.doc") # fake doc file
htmlreg(list(fit1, fit2), file = "meinetabelle.html") # html
texreg(list(fit1, fit2), booktabs = FALSE, dcolumn= FALSE) # tex


# Regressionsanalyse
install.packages("car")
library(car)
scatter3d(Prestige$income,Prestige$prestige,Prestige$education, fit="linear") 

