
library(foreign)
library(dplyr)
library(stringr)

ebay_data <- read.dta("http://www.farys.org/daten/ebay.dta")

ebay_data %>% 
    filter(sepos >= 12) %>% 
    mutate(rating = sepos/(sepos + seneg)) %>% 
    mutate(makellos = rating > .98) %>% 
    mutate(geraetetyp = str_match(subcat, "\\w+")[,1]) -> ebay_clean


boxplot(price ~ geraetetyp, data = ebay_clean,
        boxwex = 0.35,
        at = 1:4 - 0.3,
        notch = TRUE,
        main = "Preise von Mobiltelefonen auf Ebay",        
        xlab = "Gerätetypen",
        ylab = "Preise in $",
        subset = makellos, col = "gold")

boxplot(price ~ geraetetyp, data = ebay_clean,
        boxwex = 0.35,
        at = 1:4 + .1,
        notch = TRUE,
        add = TRUE,
        subset = !makellos, col = "darkgreen", names = c("","",""))

legend(2, 9, c("makellos", "nicht makellos"),
       fill = c("gold", "darkgreen"))
