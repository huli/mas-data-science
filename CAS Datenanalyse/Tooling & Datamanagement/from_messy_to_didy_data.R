# Wetterdaten
weather <- read.table("https://raw.githubusercontent.com/justmarkham/tidy-data/master/data/weather.txt", header=TRUE)
head(weather) # hier sind Variablen in Zeilen und Spalten

# Daten reshapen (melt) und Missings löschen
# (reshape2 sollte zwar schneller sein, hat aber Probleme mit grossen Daten)
library(reshape2) # für melt()/dcast()
# Es wird angegeben, was ein eindeutiges Element identifiziert und transformiert
# dann von right nach long
weather1 <- melt(weather, id=c("id", "year", "month", "element"), na.rm=TRUE)
head(weather1)

# saubere Spalte für "day" (nicht viel neues im Package, aber vieles einfacher)
library(stringr)    # für str_replace(), str_sub()
weather1$day <- as.integer(str_replace(weather1$variable, "d", ""))
head(weather1)

# die krude Spalte "variable" brauchen wir nicht
weather1$variable <- NULL

# die Spalte element beherbergt zwei unterschiedliche Variablen tmin und tmax. Diese sollen in zwei Spalten:
weather1$element <- tolower(weather1$element) # Kleinbuchstaben
weather.tidy <- dcast(weather1, ... ~ element) # reshapen auf zwei Spalten
head(weather.tidy)

