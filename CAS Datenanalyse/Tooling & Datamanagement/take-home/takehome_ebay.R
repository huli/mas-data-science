
library(foreign)
library(dplyr)
library(stringr)

# todos:
# - comments
# - ev. mit data.table
# - regression machen
# - labels werden noch nicht alle sauber dargestellt

# Dta-File laden
ebay_data <- read.dta("http://www.farys.org/daten/ebay.dta")

# Daten bereinigen
ebay_data %>% 
    filter(sepos >= 12) %>% 
    mutate(rating = sepos/(sepos + seneg)) %>% 
    mutate(makellos = rating > .98) %>% 
    mutate(geraetetyp = str_match(subcat, "[A-Za-z0-9]*\\s[A-Za-z0-9]*")[,1]) -> ebay_clean

# Handle auf Pdf-File oeffnen
pdf("boxplot_ebay.pdf")

# Handy-Bezeichnungen umbrechen damit diese sauber dargestellt werden
names_narrow <- str_replace(sort(unique(ebay_clean$geraetetyp)), 
                            " ", "\n")

# Boxplot zeichnen mit makellosen Bewertungen
boxplot(price ~ geraetetyp, data = ebay_clean,
        boxwex = 0.25,
        frame = FALSE,
        notch = TRUE,
        main = "Preise von Mobiltelefonen auf Ebay", 
        xlab = "Gerätetyp",
        ylab = "Preise in $",
        subset = makellos, col = "darkgreen",
        cex.axis = .8, names = names_narrow)

# Boxplot zeichnen mit nicht makellosen Bewertungen
boxplot(price ~ geraetetyp, data = ebay_clean,
        boxwex = 0.25,
        at = 1:7 + 0.3,
        notch = TRUE,
        frame = FALSE,
        add = TRUE,
        subset = !makellos, col = "red", axes = FALSE)

# Legende ergaenzen
legend("topright", c("makellos", "nicht makellos"),
       inset = .01,
       fill = c("darkgreen", "red"),
       cex = .8)

# Grafik exportieren mit Angabe von Dimensionen
dev.copy(pdf, "boxplot_ebay.pdf", width = 16, height = 10)
dev.off()

# Interpretation:
# Nein, die Verkäufer mit makellosem Rating erzeugen nicht grundsätzlich einen
# höheren Verkaufspreis.  

# Regressionmodelle fuer den Preis erstellen

# Modell 1 mit Prädikatoren Modelltyp und Rating
model_1 <- lm(price ~ geraetetyp + rating, ebay_clean)
summary(model_1)

# Modell 2 mit zusätzlichem Praedikat listpic
model_2 <- lm(price ~ geraetetyp + rating + listpic, ebay_clean)
summary(model_2)

library(ggplot2)
library(ggfortify)

# Keine Ahnung wie das zu interpretieren ist
autoplot(model_1, label.size = 3)

library(stargazer)

# Beide Modelle exportieren
stargazer(model_1, model_2, type = "text", 
          covariate.labels = c("Nokia 6230","Nokia 6310i", "Samsung E700", "Samsung E800", 
                               "Sony T610", "Sony T630", "rating", "auction-has-picture", 
                               "auction-has-thumbnail"))

