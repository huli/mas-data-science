
# install.packages("xlsx")

download.file("https://www.bfs.admin.ch/bfsstatic/dam/assets/159578/master",
              destfile = "C:\\temp\\population_ch.xls",
              mode="wb")

library(xlsx)
population.xls <- read.xlsx("C:\\temp\\population_ch.xls", 1, sheetName = "2014",
                              startRow = 7, endRow = 33,
                              colIndex = c(1,2), as.data.frame = TRUE,
                              encoding = "UTF-8")

colnames(population.xls) <- c("Kanton", "Bevoelkerung")

download.file("https://www.bfs.admin.ch/bfsstatic/dam/assets/81048/master",
                            destfile = "C:\\temp\\forests_ch.xls",
                            mode="wb")

forests.xls <- read.xlsx("C:\\temp\\forests_ch.xls", 1, sheetName = "2014",
                         startRow = 11, endRow = 46,
                         colIndex = c(1,3), as.data.frame = TRUE,
                         encoding = "UTF-8")

colnames(forests.xls) <- c("Kanton", "Waldflaeche (ha)")


library(dplyr)
library(stringr)
library(data.table)
# forests.tidy <- forests.xls %>%
#                     mutate("Kanton" =  str_trim(Kanton), `Waldflaeche (ha)`)

forests.tidy <- as.data.table(forests.xls)
forests.tidy[, Kanton := str_trim(Kanton)]

population.tidy <- as.data.table(population.xls)

# Beide Daten joinen
result <- merge(population.tidy, forests.tidy, by = "Kanton")



