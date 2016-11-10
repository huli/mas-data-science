
# Faktoren

object.size(c("test","test2","test"))
object.size(as.factor(c("test","test1","test")))

object.size(rep(c("test","test2","test"),10000))
object.size(rep(as.factor(c("test","test2","test")),10000))

# Erst installieren
# library(ggplot2)      

library(foreign)
            
# fertige Daten sind oft data frames:
titanic <- read.dta("http://www.stata-press.com/data/kkd/titanic2.dta")
is.data.frame(titanic)
            
head(titanic)

# Structure
str(titanic)

# Data frame ist ein hierarchisches Objekt welches Vektoren enthaelt
titanic$age2

summary(titanic)
          
# Alles ist eigentlich ein Vektor
# Die Frage ist die Anzahl der Dimensionen
dim(titanic)

# Namen von Datensaetzen
names(titanic)

# Koennen auch ueberschrieben werden
# names(titanic) <- c("a", "b")
# names(titanic)[3] <- "age"

# Wir wollen kein offenes Fenster, aber es wuerde geben:
# View(titanic)

# man kann sich auch leicht selber einen bauen
obst <- c("Apfel","Apfel","Birne")
gemuese <- c("Tomate","Karotte","Karotte")
id <- 1:3
df <- data.frame(id, obst, gemuese)
df

# $ = gehe in dem Objekt eine Ebene tiefer


# Ansteuern von Zeilen und Spaltenpositionen
df$obst 
df[,"obst"]     
df[3,"gemuese"]
df[3,3]     # Zeilen zuerst, Spalte später

# auch mehrere Spalten moeglich
df[,c("gemuese","obst")]

# Namen
row.names(df)

# which
# which(LETTERS == "R")

# If Argument
x <- -5
x
if(x <= 0) {
  y <- 1
} else {
  y <- 0
}
y

# Kombinierte Bedingungen
x <- 1
if(x == 0 | x == 1) { #oder
  y <- 1
} else {
  y <- 0
}
y

# ifelse
ifelse(1 <= 2, 1, 0)


x <- 10
if(x<= -10 &  x>= 10) { #und
  y <- 1 } else {
    y <- 0
  }
y

# For Schleife
for (x in 1:10) print(sqrt(x)) 

AA <- "bar"
switch(AA, 
       "foo"={
         # case 'foo' here...
         print('foo')
       },
       "bar"={
         # case 'bar' here...
         print('bar')    
       },
       {
         print('default')
       }
)

# For Schleife
x <- 0
for(i in 1:10) {
  x <- x+i
  print(x)
}
# x wird immer weiter inkrementiert

for(x in seq(1,100, .2))
{
    print(x)
}

# Sequenzen können auch Character sein:
namen <- c("Alfred","Jakob","Peter")
for (name in namen) {
  print(paste("Hallo",name))
}


# While Schleife
x <- 0
while(x<13) {
  x <- x+1
  print(x)
} # solange x<13=TRUE

# Durch Spalten loopen
for (column in 2:6) { # this loop runs through 2 to 6
  print(names(swiss)[column])
  print(mean(swiss[,column]))
}


#Durch Datensätze loopen
for (dataset in c(data1, data2, data3)) {
  # Anweisungen, 
  # z.B. Datenbereinigung, Appending (rbind), Modellschätzungen, etc.
}

# Viel performanter
apply(swiss[,2:6],2,mean) 

mean(titanic$age2[titanic$sex == "man"])
mean(titanic$age2[titanic$sex == "women"])

