
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

# Handy-Bezeichnungen umbrechen damit diese sauber dargestellt werden
names_narrow <- str_replace(sort(unique(ebay_clean$geraetetyp)), 
                            " ", "\n")


# Gesammtdurchschnitt als Boxplot
boxplot(ebay_clean[ebay_clean$makellos == TRUE, ]$price,
        boxwex = 0.25,
        frame = FALSE,
        notch = F,
        main = "Preise von Mobiltelefonen auf Ebay", 
        xlab = "Gerätetyp",
        ylab = "Preise in $", col = "darkgreen")

boxplot(ebay_clean[ebay_clean$makellos == FALSE, ]$price,
        boxwex = 0.25,
        at = 1 + 0.3,
        notch = F,
        frame = FALSE,
        add = TRUE, col = "red", axes = FALSE)


# 
# # Barplot Durchschnittspreise
# barplot(c(mean(na.omit(ebay_clean[ebay_clean$makellos == TRUE, ]$price)),
#                mean(na.omit(ebay_clean[ebay_clean$makellos == FALSE, ]$price))),
#         ylim = c(200, 300))
# abline(h = mean(na.omit(ebay_clean$price)))


# ggplot Durchschnittspreise
ggplot() +
  geom_bar(aes(x = c(1,2), y = c(mean(na.omit(ebay_clean[ebay_clean$makellos == TRUE, ]$price)),
                            mean(na.omit(ebay_clean[ebay_clean$makellos == FALSE, ]$price)))),
           stat = "identity")

# Boxplots für Gesammtstreuung
ggplot(ebay_clean, aes(x=1, y=price, color=!makellos)) +
  geom_boxplot(position = position_dodge(.8), notch = FALSE, outlier.colour = NULL) +
  ggtitle(label = "Preise von Mobiltelefonen auf Ebay", 
          subtitle = "Verkaufspreis nach Gerätetyp und Verkäuferbewertung") +
  ylab(label = "Verkaufspreis in US-Dollar") +
  xlab(label = "Gerätetypen") +
  ylim(c(0,400)) +
  scale_color_manual(values = c("springgreen4", "red4"), 
                     labels=c("Ja","Nein"), 
                     guide = guide_legend(title = expression("Positive Bewertungen > 98%"))) +
  scale_x_discrete(labels=names_narrow)


# Boxplot zeichnen mit nicht makellosen Bewertungen
boxplot(ebay_clean[ebay_clean$makellos == FALSE, ]$price,
        boxwex = 0.25,
        at = 1 + 0.3,
        notch = TRUE,
        frame = FALSE,
        add = TRUE, col = "red", axes = FALSE)

