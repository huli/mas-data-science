
# Einfuehrung dplyr (Achtung hat oft Fehler) 
# ------------------------------------------------------------------------------------------------------------
titanic <- read.dta("http://www.stata-press.com/data/kkd/titanic2.dta")

# install.packages("dplyr")
library(dplyr)

filter(titanic, class=="1st class", age2<18)

# zusätzlich Spalten selektieren:
titanic %>%
  filter(class=="1st class", age2<18) %>%
  select(sex, age2, survived)

# neue Column hinzufuegen
titanic %>%
  mutate(child=age2<18) %>%
  head()

# Auszählen wer gestorben ist nach Geschlecht und Kind (ja/nein)
titanic %>%
  mutate(child=ifelse(age2<18,"yes","no")) %>%
  group_by(sex, child,survived) %>%
  summarise(n=n()) %>%
  arrange(sex,child, survived)


# Einführung data.table
# ------------------------------------------------------------------------------------------------------------

# sicherheitshalber dplyr entladen, da teilweise Funktionsnamen überlappen können
detach("package:dplyr")

titanic <- read.dta("http://www.stata-press.com/data/kkd/titanic2.dta")

# install.packages("data.table")
library(data.table)

titanic <- as.data.table(titanic) # als data.table definieren

# Ausgabe truncated
titanic 

# filter()
titanic[class=="1st class" & age2 < 18,]

# where and select
titanic[class=="1st class" & age2 < 18, c("sex","age2","survived"),with=FALSE] 
#with=FALSE erlaubt, Vektoren als Input zu verwenden und gibt Daten zurück statt "within" die Daten abzuändern.

# Analog zu dplyr: neue Column hinzfuegen
titanic[,child:=ifelse(age2<18,"yes","no")]

# Auszählen wer gestorben ist nach Geschlecht und Kind (ja/nein)
titanic[,n:=.N, by=list(sex, child, survived)]
setkey(titanic, sex, child, survived)
titanic.summary <- unique(titanic)
setorder(titanic.summary, sex, child, survived)
titanic.summary

# kompakter: statt Variable anzulegen und die Daten zu "collapsen" kann man auch direkt auszählen und ausgeben lassen:
titanic[,.N, by=list(sex, child, survived)][order(sex,child,survived)]