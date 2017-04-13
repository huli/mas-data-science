# 1.
library(xlsx)

# Datei runterladen als binary
download.file("https://www.bfs.admin.ch/bfsstatic/dam/assets/159578/master", 
              "c:/temp/bevoelkerung.xls", 
              mode="wb")

# einlesen als UTF-8 kodiertes File. Sheet 2014, Zeile 8-33, 
# ohne Header (den setzen wir besser manuell). über colIndex 
# nehmen wir nur die Spalten 1 (A) und 2 (B)

bevoelkerung <- read.xlsx("c:/temp/bevoelkerung.xls", 
                          sheetName = "2014", 
                          colIndex = c(1,2), 
                          startRow = 8, endRow = 33, 
                          encoding = "UTF-8", 
                          header=FALSE)


# ein bisschen labeln
names(bevoelkerung) <- c("Kanton", "Einwohner")

# 2.
download.file("https://www.bfs.admin.ch/bfsstatic/dam/assets/81048/master",
              "c:/temp/wald.xls", 
              mode="wb")
wald <- read.xlsx("c:/temp/wald.xls", 
                  sheetName = "2014", 
                  colIndex = c(1,3), 
                  startRow = 13, endRow = 48, 
                  encoding = "UTF-8", 
                  header=FALSE)

names(wald) <- c("Kanton", "Waldflaeche")

# säubern
library(stringr)
wald$Kanton <- str_trim(wald$Kanton, side="both")

# 3. / 4.
# z.B. über dplyr
library(dplyr)
left_join(bevoelkerung,wald,by="Kanton")

# St.Gallen und die beiden Appenzells werden nicht gematcht 
# da die Schreibweise minimal anders ist, fix:

wald$Kanton <- str_replace(wald$Kanton, pattern = "\\. ", replacement = ".") 

# der Punkt wird hier escaped, da es sich normal um einen
# Platzhalter für reguläre Ausdrücke handelt
# besser ist normalerweise über das Kantonskürzel oder
# Nummer zu matchen, dann stört die unterschiedliche Schreibweise nicht.

waldranking <- left_join(bevoelkerung,wald,by="Kanton") %>%
  mutate(bpp = Waldflaeche*400/Einwohner) %>%
  arrange(-bpp)

# 5. 
write.csv(waldranking, "c:/temp/waldranking.csv")
