
library(foreign)
library(dplyr)
library(stringr)

# todos:
# - comments
# - ev. mit data.table
# - regression machen
# - labels werden noch nicht alle sauber dargestellt

ebay_data <- read.dta("http://www.farys.org/daten/ebay.dta")

ebay_data %>% 
    filter(sepos >= 12) %>% 
    mutate(rating = sepos/(sepos + seneg)) %>% 
    mutate(makellos = rating > .98) %>% 
    mutate(geraetetyp = str_match(subcat, "[A-Za-z0-9]*\\s[A-Za-z0-9]*")[,1]) -> ebay_clean


pdf("boxplot_ebay.pdf")

names_narrow <- str_replace(sort(unique(ebay_clean$geraetetyp)), 
                            " ", "\n")
boxplot(price ~ geraetetyp, data = ebay_clean,
        boxwex = 0.25,
        frame = FALSE,
        notch = TRUE,
        main = "Preise von Mobiltelefonen auf Ebay", 
        xlab = "Gerätetyp",
        ylab = "Preise in $",
        subset = makellos, col = "darkgreen",
        cex.axis = .8, names = names_narrow)

boxplot(price ~ geraetetyp, data = ebay_clean,
        boxwex = 0.25,
        at = 1:7 + 0.3,
        notch = TRUE,
        frame = FALSE,
        add = TRUE,
        subset = !makellos, col = "red", axes = FALSE)

legend("topright", c("makellos", "nicht makellos"),
       inset = .01,
       fill = c("darkgreen", "red"))

dev.off()

# regression

model_1 <- lm(price ~ geraetetyp + rating, ebay_clean)
summary(model_1)


model_2 <- lm(price ~ geraetetyp + rating + listpic, ebay_clean)
summary(model_1)

