


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



