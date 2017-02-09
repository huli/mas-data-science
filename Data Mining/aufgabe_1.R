


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

str(ids_with_hours)


