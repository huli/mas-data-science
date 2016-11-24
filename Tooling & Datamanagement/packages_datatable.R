
library(foreign)

titanic <- read.dta("http://www.stata-press.com/data/kkd/titanic2.dta")

class(titanic)

# install.packages("data.table")
library(data.table)

titanic <- as.data.table(titanic) # als data.table definieren
class(titanic) # wurde jetzt mit der Funktionalitaet von data.table ergaenzt
titanic  # man beachte die andere Darstellung. data.table erlaubt sicherheitshalber niemals alle Zeilen auf den Workspace zu knallen

# Alternativ zu filter()
titanic[class=="1st class" & age2 < 18,]

# Alternative zum Filtern+Selektieren
titanic[class=="1st class" & age2 < 18, c("sex","age2","survived"), with=FALSE] 
#with=FALSE erlaubt, Vektoren als Input zu verwenden und gibt Daten zurück statt "within" die Daten abzuändern.

# Analog zu dplyr: neue Variable "child" bauen
# Hier ist data.table start: Die Daten werden nicht ins Memory geladen
titanic[, child:=ifelse(age2<18,"yes","no")]

# Auszählen wer gestorben ist nach Geschlecht und Kind (ja/nein)
titanic[,n:=.N, by=list(sex, child, survived)]

# Schluessel setzen welche ich dann mit unique verwenden kann
setkey(titanic, sex, child, survived)

# Nach Key aggregieren
titanic.summary <- unique(titanic)
setorder(titanic.summary, sex, child, survived)
titanic.summary


# kompakter: statt Variable anzulegen und die Daten zu "collapsen" 
# kann man auch direkt auszählen und ausgeben lassen:
titanic[,.N, by=list(sex, child, survived)][order(sex,child,survived)]


