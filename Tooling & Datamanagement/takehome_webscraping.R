

library(rvest)
library(data.table)

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

# Langes Format machen
long_table <- melt(clean_table, id.vars = c("X1"))

# Die beiden Messungen als Spalten abbilden
tidy_table <- dcast(long_table, variable ~ X1)
