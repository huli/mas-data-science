

# Noetige Bibliotheken laden
library(rvest)
library(data.table)
library(stargazer)

# Url definieren
url <- "https://de.wikipedia.org/wiki/Bern"

# Tabelle von Site holen und in data.table umwandeln
# (Dabei gehen wir von letzen Element mit ID aus um den Code robuster zu machen)

temp_table <- url %>% 
  read_html() %>% 
  html_node(xpath = 
               "//*[@id='mw-content-text']/table[4]") %>%
  html_table(fill = TRUE) %>% 
  as.data.table()

# Ueberfluessige Zeilen und Spalten entfernen
clean_table <- 
    temp_table[3:4, 1:13]

# Und Spalten bereinigen
colnames(clean_table) <- c("Temp", as.character(temp_table[2, 2:13]))

# Langes Format machen
long_table <- melt(clean_table, id.vars = c("Temp"))

# Die beiden Messungen als Spalten abbilden
tidy_table <- dcast(long_table, variable ~ Temp)

# Bezeichnungen von Spalten und Zeilen bereinigen
colnames(tidy_table) <- c("Monat", "Max","Min")

# Und nun noch korrekte Datentypen und gemäss Vorgabe mit 3 Nachkommastellen
char_to_numeric <- function(number_as_char)
{
  format(as.numeric(sub(",", ".", number_as_char, fixed = TRUE)), nsmall = 3)
}

tidy_table[, Min:=char_to_numeric(Min)][
              , Max:=char_to_numeric(Max)]

# Die Tabelle anständig ausgeben
stargazer(tidy_table, type = "text", summary = FALSE)





