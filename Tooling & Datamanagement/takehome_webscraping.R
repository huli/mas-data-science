

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

head(temp_table)


# Wie geht dieser Code nicht?
# temp_table <- url %>% 
#   read_html() %>% 
#   html_node(xpath = 
#               "//*[@id='mw-content-text']/table[4]/tbody/tr/td/table[1]") %>%
#   html_table(fill = TRUE) %>% 
#   as.data.table()

# Und wieso geht mein super Xpath-Quer nicht
# "//*/b[text() = 'Monatliche Durchschnittstemperaturen und -niederschläge für Bern 1981–2010']/ancestor::td/*[2]"

