



library(RODBC)
library(data.table)
library(ggplot2)
library(dplyr)

connection <- odbcDriverConnect('driver={SQL Server};server=sqlrem;database=rem_privera_prod_20160628;trusted_connection=true')
persons_and_nationalitaet <- sqlQuery(connection, 
                                      "select count(OID) as count, NationalitaetCD as 
                                        nationalitaet from person p group by NationalitaetCD")
                      

# Anzahl Personen nach Land
persons_and_nationalitaet %>% 
  arrange(desc(count)) %>% 
  top_n(50) %>% 
  ggplot() +
  geom_bar(aes(nationalitaet, count),
           stat = "identity") 

  

# Mahnungen pro Person nach Land
mahnungen_pro_nationalitaeten <- sqlQuery(connection,
                          "select count(p.OID) as [count_mahnungen], p.NationalitaetCD as nationalitaet 
                                from Mahnung m join Person p
                        	  on m.Person1OID = p.OID
                        	  group by NationalitaetCD
                        	  order by [count_mahnungen]")

mahnungen_pro_nationalitaeten %>% 
  top_n(50) %>% 
  ggplot() +
  geom_point(aes(nationalitaet, count_mahnungen))


# Laendercodes lesen
laender <- read.csv2("Data Visualization/countries.csv",
                     encoding = "UTF-8")
laendercodes <- laender[, c(2,4)]
names(laendercodes) <- c("bezeichnung", "nationalitaet")

library(RColorBrewer)
getPalette = colorRampPalette(brewer.pal(9, "YlOrRd"))


persons_and_nationalitaet %>% 
  left_join(mahnungen_pro_nationalitaeten) %>% 
  left_join(laendercodes) %>% 
  mutate(mahnungen_pro_person = count_mahnungen/count) %>% 
  arrange(desc(mahnungen_pro_person)) %>% 
  top_n(10) %>% 
  ggplot() + 
  geom_bar(aes(reorder(nationalitaet, mahnungen_pro_person), mahnungen_pro_person, 
               fill = nationalitaet,
               color = reorder(bezeichnung, mahnungen_pro_person)), 
              fill = getPalette(10),
           stat = "identity")

# Anzahl Personen und Mahnungen als Scatterplot
persons_and_nationalitaet %>% 
  left_join(mahnungen_pro_nationalitaeten) %>% 
  ggplot() + 
  geom_point(aes(count, count_mahnungen))

# Ohne Schweiz
persons_and_nationalitaet %>% 
  left_join(mahnungen_pro_nationalitaeten) %>% 
  filter(nationalitaet != "CH") %>% 
  top_n(15) %>% 
  ggplot() + 
  scale_fill_brewer() + 
  geom_point(aes(count, count_mahnungen, 
                 color = nationalitaet))

# Weitere Kennzahlen:
# - durchschnittliche Mietdauer 
# - offene Posten
# - Zahlungssperre pro Mieter
# (pro Land, Altersgruppe (Oft nicht geführt), Heimatort?)
# - Begehren
# - Fehlbuchungen (falsch ausgefüllte ESR)
# (wahrscheinlichkeit von Insistierung Sekung nach Index)
# PersDebiKrediStatistik




  