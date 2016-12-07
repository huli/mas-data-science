
library(foreign)
library(dplyr)
library(stringr)

ebay_data <- read.dta("http://www.farys.org/daten/ebay.dta")

ebay_data %>% 
    filter(sepos >= 12) %>% 
    mutate(rating = sepos/(sepos + seneg)) %>% 
    mutate(makellos = rating > .98) %>% 
    mutate(geraetetyp = str_match(subcat, "[A-Za-z0-9]*\\s[A-Za-z0-9]*")[,1]) -> ebay_clean

opar <- par()      # make a copy of current settings

boxplot(price ~ geraetetyp, data = ebay_clean,
        boxwex = 0.35,
        frame = FALSE,
        notch = TRUE,
        main = "Preise von Mobiltelefonen auf Ebay", 
        xlab = "Preise in $",
        subset = makellos, col = "darkgreen",
        cex.axis = .8)


boxplot(price ~ geraetetyp, data = ebay_clean,
        boxwex = 0.35,
        at = 1:7 -.4,
        notch = TRUE,
        frame = FALSE,
        add = TRUE,
        subset = !makellos, col = "red", axes = FALSE)

legend("topright", c("makellos", "nicht makellos"),
       inset = .01,
       fill = c("darkgreen", "red"))
