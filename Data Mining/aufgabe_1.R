

# todo:
# columns ueberpruefen

# 1. Datenaufbereitung
library(readr)
library(data.table)
library(stringr)
library(dplyr)

log <- read_log("https://raw.githubusercontent.com/romeokienzler/developerWorks/master/log")
log_filtered <- log[!(1:nrow(log)%%2),6]

# epartmentid, employeeid, clientid
log_filtered$X6 %>% 
  str_split_fixed(",", n = 3) %>% 
  as.data.frame() ->
  ids_as_table

# Spalten umsortieren
# Spalte 1> employeeid, Spalte 2> departmentid, Spalte 3> clientid
df <- ids_as_table[,c(2,1,3)]

# Datum hinzufuegen
hoursAndDates <- log[!(1:nrow(log)%%2),4]

hoursAndDates$X4 %>% 
  str_sub(13, 14) -> hours

# combining tables
df[,4] <- hours

ids_with_hours <- df[, c(4,1,2,3)]
names(ids_with_hours) <- c("hour","employeeid","departmentid","clientid") 

# 2. Analyse
data <- read_csv("https://raw.githubusercontent.com/romeokienzler/developerWorks/master/testdata.csv")

View(data)
library(ggplot2)

# Histogramm erstellen der Stunden
ggplot(data = data, aes(x=factor(hour))) +
  geom_bar()

ggplot(data = data, aes(x=factor(employeeid))) +
  geom_bar()

ggplot(data = data, aes(x=factor(clientid))) +
  geom_bar()

ggplot(data = data, aes(x=factor(departmentid))) +
  geom_bar()

# some experiments
ggplot(data = data[1:10000,], aes(x=departmentid, y=clientid, color=employeeid)) +
  geom_point()






