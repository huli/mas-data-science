
library(foreign)
library(dplyr)
library(stringr)

ebay_data <- read.dta("http://www.farys.org/daten/ebay.dta")

ebay_data %>% 
    filter(sepos >= 12) %>% 
    mutate(rating = sepos/(sepos + seneg)) %>% 
    mutate(makellos = rating > .98) %>% 
    mutate(geraetetyp = str_match(subcat, "\\A(\\w+)")[,1]) -> ebay_clean


str_match("Samsung E700", "\\A(\\w+)")[,1]

boxplot(ebay_clean$price ~ ebay_clean$geraetetyp, ebay_clean)


boxplot(len ~ dose, data = ToothGrowth,
        boxwex = 0.25, at = 1:3 - 0.2,
        subset = supp == "VC", col = "yellow",
        main = "Guinea Pigs' Tooth Growth",
        xlab = "Vitamin C dose mg",
        ylab = "tooth length",
        xlim = c(0.5, 3.5), ylim = c(0, 35), yaxs = "i")
boxplot(len ~ dose, data = ToothGrowth, add = TRUE,
        boxwex = 0.25, at = 1:3 + 0.2,
        subset = supp == "OJ", col = "orange")
legend(2, 9, c("Ascorbic acid", "Orange juice"),
       fill = c("yellow", "orange"))
