################################################################
## Skript:      Lösung_Gemeindedaten
## Studiengang: CAS Datenanalyse
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## date:        Dezember 2016
#############################################


## Open-Data Daten plus informationen zur Raumgliederung
## Ansonsten unverändert
## Rohdaten sind von hier
## https://opendata.swiss/de/ 
## https://opendata.swiss/de/dataset/regional-portraits-key-data-of-all-communes (Direkter Link funktioniert nicht




#### Teil 1 ################
## Übung:  Daten laden & Begutachten
###


######
# 1.	Laden Sie den Datensatz gemeindedaten.csv
# setwd("WorkingDirectory")
gemeindedaten<-read.csv("c:/temp/gemeindedaten.csv",
                          encoding="UTFA-8") 
######
## 2.	Verschaffen Sie sich einen ersten Überblick zu den Daten? 
## Hat mit dem Einlesen alles geklappt wie erwartet? 
## Sind die Daten so kodiert, wie Sie es erwarten? 
## Stimmen die Datenformate der Variablen? Gibt es fehlende Werte und wie sind diese kodiert?	

summary(gemeindedaten)
str(gemeindedaten)

# Laden Sie benötigte Packete
library(ggplot2)



######
# 3.	Falls nötig, definieren Sie im dataframe fehlende Werte so, 
# dass R diese tatsächlich als fehlende Werte auffasst. 
# Beheben Sie allfällige unerwartete Kodierungen

# Parteienvariable polit_pda ist komisch
str(gemeindedaten$polit_pda)

# Histogram plotten ist nicht möglich mit falscher Kodierung
ggplot(gemeindedaten,aes(x=polit_pda))+
  geom_histogram()

# Kodierung anpassgen
gemeindedaten$polit_pda[gemeindedaten$polit_pda=="*"]<-NA
gemeindedaten$polit_pda<-as.numeric(as.character(gemeindedaten$polit_pda)) # Format anpassen

# So geht es
ggplot(gemeindedaten,aes(x=polit_pda))+
  geom_histogram()


######
# 4. Beantworten Sie folgende Fragen: Wie viele Gemeinden gab es in der Schweiz im Jahr 2014? 
# Was ist die mittlere Einwohnerzahl einer Schweizer Gemeinde? 
# Wie viele Einwohner leben in der grössten Gemeinde? Wie viele in der kleinsten?

summary(gemeindedaten$bev_total)
str(gemeindedaten)
nrow(gemeindedaten)





#### Teil 2 ################
## Übung:   Graphische Datenxploration
######

# Ich mag das black-and-white theme und setze daher dieses theme 
# als Default für die gesamte Session
theme_set(theme_bw())

######
# 5. In welchem Kanton gibt es am meisten Gemeinden? In welchem am wenigsten?
ggplot(gemeindedaten,aes(x=as.factor(kantone)))+
  geom_bar()

# Schauen Sie sich die Verteilung der Einwohnerzahl an
ggplot(gemeindedaten,aes(x=factor(1),y=bev_total))+
  geom_boxplot()

ggplot(gemeindedaten,aes(x=bev_total))+
  geom_histogram()

######
# 6.	Betrachten Sie die Einwohnerzahlen der Gemeinden gruppiert nach Sprachregionen. 
ggplot(gemeindedaten,aes(x=factor(sprachregionen),y=bev_total))+
  geom_boxplot()

# Wie heissen die jeweils grössten Gemeinden?
ggplot(gemeindedaten,aes(x=factor(sprachregionen),y=bev_total))+
  geom_boxplot()+
  geom_text(label=gemeindedaten$gmdename) 

# Was ist die grösste Gemeinde im räterormanischen Sprachgebiet? Das sieht man nicht so gut...
# Probieren wir es mit einem gefilterten Datensatz

library(dplyr)
gemeinde_raet<-gemeindedaten %>%
  filter(sprachregionen=="raetoromanisch") 

ggplot(gemeinde_raet,aes(x=factor(sprachregionen),y=bev_total))+
  geom_boxplot()+
  geom_text(label=gemeinde_raet$gmdename) 

######
# 7.	Betrachten Sie die Veränderung der Einwohnerzahl von 2010 bis 2014 nach Sprachregionen. 
# In welcher Sprachregionen sind die Gemeinden am stärksten gewachsen? 
# In welcher am wenigsten oder gibt es Sprachregionen, in welcher die Einwohnerentwicklung in der Tendenz sogar eher rückläufig ist? 
# Analysieren sie zusätzlich graphisch, ob die Unterscheidung von städtischen und ländlichen Gemeinden dabei eine Rolle spielt?

  
# Schauen Sie sich die Verteilung der Veränderung der Einwohnerzahl von 2010 bis 2014 nach Sprachregionen an
ggplot(gemeindedaten,aes(x=bev_1014))+
  geom_histogram()+
  facet_grid(~sprachregionen)

ggplot(gemeindedaten,aes(x=sprachregionen,y=bev_1014))+
  geom_boxplot()

# Erkennen Sie Tendenzen?

####
# Schauen Sie jetzt nur Mittelwerte an

# Mittelwerte je Sprachregion
ggplot(gemeindedaten,aes(x=factor(sprachregionen),y=bev_1014))+
  geom_bar(position="identity",stat="summary",fun.y="mean")


# Median je Sprachregion
ggplot(gemeindedaten,aes(x=factor(sprachregionen),y=bev_1014))+
  geom_bar(position="identity",stat="summary",fun.y="median")

# Betrachten Sie die mittlere Veränderung der Einwohnerzahl unterschieden nach Sprachregionen und der Stadt-Land Einteilung.
ggplot(gemeindedaten,aes(x=factor(sprachregionen),y=bev_1014))+
  geom_bar(position="identity",stat="summary",fun.y="median")+
  facet_grid(~stadt_land)+
  scale_x_discrete(labels=c("deutsch" = "de", "franzoesisch" = "fr",
                              "italienisch" = "it","raetoromanisch"="rr"))


######
# 8. Untersuchen Sie die Zusammenhangsstruktur folgender Variablen:
# bev_dichte, bev_ausl, alter_0_19, alter_20_64, alter_65.,bevbew_geburt, sozsich_sh, strafen_stgb
# Gibt es Korrelationen? Falls ja, lassen Sie sich erklären oder sind sie eher unerwartet?


# Variante 1
library(corrplot)
corrplot(cor(gemeindedaten[,c(9:13,16,37,49)]))


# Variante 2
library(GGally)
ggpairs(gemeindedaten[,c(9:13,16,37,49)], 
        upper = list(continuous="cor"),
        diag = list(continuous="densityDiag"),
        lower = list(continuous="smooth"))

## Suchen Sie sich eine Ihnen interessant erscheinenden Zusammenhang 
## und schauen Sie sich diesen in einem eigenen Scatterplot an

ggpairs(gemeindedaten[,c(11:13)], 
        upper = list(continuous="cor"),
        diag = list(continuous="densityDiag"),
        lower = list(continuous="smooth_loess",colour="red"))

######
# 9. Visualisieren Sie eine Kontingenztabelle mit den Variablen Stadt_Land und Sprachregionen.
# Welcher Gemeindetyp überwiegt bei deutschsprachigen Gemeinden, welcher bei italienischsprachigen Gemeinden. 
# Gibt es in jeder Sprachregion isolierte Städte?

table<-table(gemeindedaten$sprachregionen,gemeindedaten$stadt_land,dnn=(c("Sprache","Stadt")))
mosaicplot(~Sprache + Stadt,data=table)


######
# 10.	Erstellen Sie ein politisches Profil nach Sprachregionen mit der Hilfe der Variablen 
# zu den Wähleranteilen.


library(dplyr)
library(tidyr) # für gather()
library(ggplot2)



# Daten aufbereiten
# Parteien-Variablen
profil_sprachregionen <- gemeindedaten %>%
  select(sprachregionen,starts_with("polit")) %>%
  group_by(sprachregionen) %>%
  summarise_each(funs(mean(.,na.rm =TRUE))) %>%
  gather(variable,value,-sprachregionen) %>% # Braucht es hier um das spezifisch benötigte Format zu erhalten
  arrange(variable)

# NA führen zu Problem
profil_sprachregionen[is.na(profil_sprachregionen)]<-0

# Nun kommen die Radar-Charts

# Mit einem Facet_wrap
ggplot(profil_sprachregionen) +
  aes(x=variable, y=value, group=sprachregionen, color=sprachregionen) + 
  geom_polygon(fill=NA) + 
  coord_polar() + facet_wrap(~ sprachregionen) + 
  theme(axis.text.x = element_text(size = 5))+
  theme(legend.position = "none")


# Ohne Facet_wrap
ggplot(profil_sprachregionen) +
  aes(x=variable, y=value, group=sprachregionen, color=sprachregionen) + 
  geom_polygon(fill=NA) + 
  coord_polar() + 
  theme(axis.text.x = element_text(size = 5))+
  theme(legend.position = "none")








