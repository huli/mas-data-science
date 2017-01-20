

# TODO: Grafik speichern

library(MASS)
library(ggplot2)
 
# Deleting Rows where specific column is NA
df <- survey[na.omit(survey$Sex), ]
nrow(df)

# univariant
# ------------------------------------------------------------------------------------------------

# boxplot ------------------------------------

ggplot(data=mtcars, aes(x=factor(""),y=hp))+
  geom_boxplot()

ggplot(mtcars, aes(x="", y=hp)) +
  geom_boxplot() + 
  geom_text(data = mtcars[mtcars$hp > 300,], 
            label=rownames(mtcars[mtcars$hp > 300,]))

# Geschichteter Boxplot
ggplot(data=na.omit(survey), aes(x=factor(""),y=Height, color = Sex)) +
  geom_boxplot()

ggplot(mtcars, aes(x = factor(cyl), y = hp)) +
  geom_boxplot()

# Stabdiagramm ------------------------------------

plot(table(mtcars$cyl))

# Balkendiagramm ------------------------------------

ggplot(data = na.omit(survey)) +
  geom_bar(aes(x = Smoke))

barplot(table(survey$Smoke))

# Mit Faktor wenn diskrete Variable
ggplot(mtcars, aes(factor(cyl))) +
  geom_bar()

# Kuchendiagramm ------------------------------------

pie(table(survey$Smoke))

# Histogramm ----------------------------------------

ggplot(data = mtcars, aes(mpg)) +
  geom_histogram()

ggplot(mtcars, aes(mpg)) +
  geom_histogram(binwidth = 1)

# Dichtefunktion ------------------------------------

ggplot(mtcars, aes(x=mpg))+
  geom_density() +
  xlim(1,45)

ggplot(mtcars, aes(x=mpg))+
  geom_density(adjust = 0.1) +
  xlim(1,45)


# bivariant
# ------------------------------------------------------------------------------------------------

# Liniendiagramm ------------------------------------

ggplot(BOD, aes(x = Time, y = demand)) +
  geom_line()

# Mit Messpunkten
ggplot(BOD, aes(x = Time, y = demand)) +
  geom_line() +
  ylim(0, max(BOD$demand)) +
  geom_point(data = BOD)

# Balkendiagramm ------------------------------------

ggplot(BOD, aes(x = Time, y = demand)) +
  geom_bar(stat = "identity")

# Extra Plots zu Balkendiagram
library(gcookbook)
ggplot(tophitters2001, aes(x=avg,y=name)) +
  geom_point()

tophit<-tophitters2001[tophitters2001$avg>0.30,]

# Sortieren
ggplot(tophit, aes(x=avg,y=reorder(name,avg))) +
  geom_point()

# Cleveland-Dot-Plot 
ggplot(tophit, aes(x=avg,y=reorder(name, avg))) +
  geom_segment(aes(yend=name),xend=0, colour="grey50")+
  geom_point(size=4)+
  xlab("Mittlere Trefferquote je Versuch")+
  ylab("")+
  theme_bw()+
  theme(panel.grid.major.y=element_blank())


# Scatterplot ------------------------------------

ggplot(faithful, aes(waiting, eruptions)) +
  geom_point()

ggplot(heightweight, aes(x = ageYear, y = heightIn)) +
  geom_point() +
  geom_smooth()  

ggplot(heightweight, aes(x = ageYear, y = heightIn)) +
  geom_point() +
  stat_smooth(method=lm, se=FALSE)

# Dichte ist je Bins visualisiert
ggplot(diamonds, aes(x=carat,y=price))+
  stat_bin2d(bins=50)+
  scale_fill_gradient(low="lightblue",high="red",limits=c(0,6000))+
  stat_smooth(method=lm, se=FALSE,colour="black")


# multivariant 
# ------------------------------------------------------------------------------------------------

library(vcd)

# Mosaic-Plot für nominale Variablen ----------------
mosaic(~Admit+Gender, UCBAdmissions)

mosaic(~Dept+Gender+Admit, UCBAdmissions,
       highlighting = "Gender",highlighting_fill=c("lightblue","pink"), 
       direction=c("v","v","h"))
       

# Liniendiagramm -----------------------------------

# Mehrere Linien in einem Plot
library(plyr)
tg<-ddply(ToothGrowth, c("supp","dose"), summarise, length=mean(len))

# Farben
ggplot(tg) +
  aes(x=dose, y=length, color=supp) +
  geom_line()

# Linientyp
ggplot(tg) +
  aes(x=dose, y=length, linetype=supp) +
  geom_point() +
  geom_line()

# Balkendiagramm -----------------------------------
ggplot(cabbage_exp) +
  aes(x=Date, y=Weight, fill=Cultivar) +
  geom_bar(position="dodge",stat="identity")

# Error: stat_count() must not be used with a y aesthetic.
# (Er will auszählen, das verhindern wir mit stat="identity")

# Scatterplot --------------------------------------

# Mit Farben
ggplot(heightweight, aes(x=ageYear,y=heightIn,colour=sex)) +
  geom_point()+
  geom_smooth(method=loess)

# Bubble-Chart -------------------------------------

library(plyr)

countsub<-filter(countries, Year==2009)

ggplot(countsub, aes(x=healthexp, y=infmortality, size=GDP))+
  geom_point()

# Mit entsprechenden Grössen
ggplot(countsub, aes(x=healthexp, y=infmortality, size=GDP))+
  geom_point() +
  scale_size_area(max_size=10)


# Spezialisierte Visualisierungen --------------------------------------------------------------

library(dplyr)
library(corrplot)
library(GGally)


# Korrelationsdiagramm -------------------

corrplot(mcar, addCoef.col = "black", number.cex = .7)

# Scatterplot-Matrix ---------------------

c2009<-countries %>%
  filter(Year==2009) 

ggpairs(c2009[,c(4,6)])

# Ein weniig angepasst
ggpairs(c2009[,c(4,6)], 
        diag = list(continuous="barDiag"),
        lower = list(continuous="smooth"))

# Facets oder Trellis-Plots -----------------

ggplot(mpg, aes(x=displ, y=hwy))+
  geom_point()+
  facet_grid(drv ~.)

# Radar Charts -----------------------------

library(devtools)
#install_github("ricardo-bion/ggradar")

library(ggplot2)
library(ggradar)
suppressPackageStartupMessages(library(dplyr))
library(scales)

mtcars %>%
  add_rownames( var = "group" ) %>%
  mutate_each(funs(rescale), -group) %>%
  tail(4) -> mtcars_radar

ggradar(mtcars_radar)


# themes 
# --------------------------------------------------------------------------------------

library(ggthemes)

ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme_fivethirtyeight()

ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme_tufte()

# Titel
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  ggtitle("Benzinverbrauch von Motorfahrzeugen")

ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  labs(title = "Lore ipsum")

# Untertitel
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  ggtitle("Benzinverbrauch von Motorfahrzeugen", 
          subtitle = "Lore ipsum dolor malet labum")

# Schriftgrössen
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  ggtitle("Titel", subtitle = "Subtitle")+
  theme(plot.title = element_text(size = rel(2)),
        plot.subtitle = element_text(color = "red"))


# Achsenbeschriftung

# Gar keine
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme(axis.title=element_blank())

library(extrafont)
font_import()
loadfonts(device="win")

# ggplot(mtcars, aes(x=mpg))+
#   geom_histogram(binwidth=2)+
#   theme(axis.title.x = element_text("Meilen pro Gallone"), 
#         axis.title.y = element_text("Häufigkeiten"))

ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  xlab("Meilen pro Gallone")+ 
  ylab("Häufigkeiten")


# Legende

ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()

# Loeschen
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  theme(legend.position = "none")

# Oberhalb
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  theme(legend.position = "top")

# Titel legende
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  labs(fill="Behandlung")

# Einzelne Punkte
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  scale_fill_discrete(labels=c("Kontrollgruppe", "Behandlung 1", "Behandlung 2"))


# Auch die Beschriftungen der X-Achse
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  scale_x_discrete(labels=c("Kontrollgruppe", "Behandlung 1", "Behandlung 2"))


# Anmerkungen in Grafiken

ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()+
  annotate("text",x=50,y=2.5,label="Frühstarter")+
  annotate("text",x=67,y=4.5,label="Spätzünder")


# Farben
 
ggplot(cabbage_exp, aes(x=Date,y=Weight, fill = Cultivar))+
  geom_bar(position="dodge",stat="identity")

library(RColorBrewer)

# Alle Farben anzeigen
display.brewer.all()

# Es existieren drei Klassen von Color-Settings, 
# (1) tief-zu-hoch oder sequentielle
# (2) kategoriale oder qualitative
# (3) polarisierte mit "neutral" in der Mitte (divergierend)

# Eine Farbpalette anzeigen lassen 
display.brewer.pal(n=9,name="Greens")

greens <- brewer.pal(n = 3, name = "Greens")
ggplot(cabbage_exp, aes(x=Date,y=Weight,fill=Cultivar))+
  geom_bar(position="dodge",stat="identity")+
  scale_fill_manual(values=greens)+
  theme_bw()


# Grafiken speichern

pdf("cars.pdf")
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2,fill="#FF0000",colour="black")+
  ggtitle("Benzinverbrauch von Motorfahrzeugen \n (n=32)")+
  theme(plot.title=element_text(size=rel(2))) +
  xlab("Meilen pro Gallone")+
  ylab("Häufigkeiten")
dev.off()

# Oder den momentan angezeigten
dev.copy(png,'myplot.png')
dev.off()


# Power-Point

library(ReporteRs)
doc <- pptx()

# Speichern Sie einen Boxplot im objekt bp
bp <- ggplot(data=PlantGrowth, aes(x=group, y=weight, fill=group))+
  geom_boxplot()

# Fügen Sie eine neue TitelSeite zum Objekt doc hinzu
doc %>% 
  addSlide("Title Slide") %>% 
  addTitle("CAS Datenanalyse 2016/2017") %>% 
  addSlide("Two Content") %>% 
  addTitle("Editierbare Vektor Graphik versus (uneditierbares) Raster Format" ) %>% 
  addPlot(function() print(bp), vector.graphic = TRUE) %>% 
  addPlot(function() print(bp), vector.graphic = FALSE ) %>% 
  writeDoc(file = "the-easy-way.pptx")






















