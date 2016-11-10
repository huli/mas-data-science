
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

# 13.2 Übung

# 1
x <- 60
if(x < -50 | x > 50){
  y <- 10
} else {
  y <- 0
}


# 2
for (x in 1:10){
   werte <- rnorm(100)
   print(paste("Mittelwert", round(mean(werte), digits = 2)))
   print(paste("Standartabweichung", round(sd(werte), digits = 2)))
}

showMean <- function(){
  observations <- rnorm(100)
  m <- mean(observations)
  s <- sd(observations)
  print(paste("mean: ", m, " std: ", s))
}

rep(showMean(), 10)


# 3
x = 1
y = 1
while(y < 1000){
  x <- x+1
  y <- x^3
  print(paste("x:", x, " x^3: ", y))
}

x <- matrix(rnorm(1000), ncol = 10)
# E.g., for a matrix 1 indicates rows, 2 indicates columns,
apply(x, 2, mean)

test <- matrix(c(1,2,3,4,5,6,7,8,9), ncol = 3)
apply(test, 2, max)
apply(test, 1, max)


# 14.2

# 1
add2AndSquare <- function(x){
  (x+2)^2
}

add2AndSquare(1:10)

# 2
weightedMean <- function(x, y){
  sum(x*y)/ sum(y)
}

# Scripts laden
#source("C:\pfad\script.R")

weightedMean(c(1,2,3,4,5), c(2,4,5,6,7))
weighted.mean(c(1,2,3,4,5), c(2,4,5,6,7))

# help.search("mean")
# ??mean

# zwei fiktive Vektoren erstellen
x <- c(10,20,30,40,30,10,20,30,40,30,10,20,10)
y <- c(2,5,3,5,3,5,1,6,3,4,5,1,1)

# Tabelle
table(x)
table(x,y)

# Chi2-Test
chisq.test(table(x,y))

# Tabelle in Prozent
100*prop.table(table(x))
100*prop.table(table(x,y))
round(100*prop.table(table(x,y)), 2) # gerundete Werte


# Mean
mean(x)

# Median
median(x) 
sort(x)

# mehrere Statistiken in einem Vektor
c(mean=mean(x), median=median(x), stddev=sd(x), min=min(x), max=max(x))

# gibt es verkürzt über die generische Funktion summary
summary(x)

# Korrelation zwischen Vektoren
cor(x,y)
cor(x,y, method="spearman") #Rangkorrelation
cov(x,y)

# Mittelwertvergleich
t.test(x,y)


