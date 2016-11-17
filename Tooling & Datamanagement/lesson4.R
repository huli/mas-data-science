
# Damit dta verstanden wird
library(foreign)

titanic <- read.dta("http://www.stata-press.com/data/kkd/titanic2.dta")

# Daten kennenernen
head(titanic)
summary(titanic)

# Vergelich von subset und über Indizes
x <- titanic[titanic$survived == "yes", "age2"]
y <- subset(titanic, survived == "yes")$age2
identical(x, y)

# Kreuztablle
addmargins(round(prop.table(table(titanic$class, titanic$survived)), 4))

# Median fuer Alter von Gestorbenen
people.survived <- subset(titanic, survived == "yes")
people.dead <- subset(titanic, survived == "no")

# Mittelwert bestimmen
mean(people.dead$age2)
mean(people.survived$age2)

# Median bestimmen
median(people.dead$age2)
median(people.survived$age2)

t.test(people.dead$age2, people.survived$age2)

# Mit tapply (tapply(werte, gruppierung, funktion))
tapply(titanic$age2, titanic$survived, mean)
tapply(titanic$age2, titanic$survived, median)

# Scope binden (sollte nicht verwendet werden)
attach(titanic, warn.conflicts = TRUE)
median(age2)
detach(titanic)

# Besatzung entfernen welches nicht verwendet wird
titanic$class <-droplevels(titanic$class)

# Welche Klassen sind abgekratzt
addmargins(round(prop.table(table(titanic$class, titanic$survived), 1), 4))

# Uebung 16.2.2 - dplyr

library(foreign)

# Daten laden
input.data <- read.dta("http://www.farys.org/daten/allbus2008.dta")

# Aufraeumen
clean.data <- 
  input.data %>% 
    select("Geschlecht" = v151, "Alter" = v154, "Einkommen" = v386)



