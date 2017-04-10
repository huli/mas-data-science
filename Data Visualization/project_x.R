



library(RODBC)
library(data.table)
library(ggplot2)
library(dplyr)

connection <- odbcDriverConnect('driver={SQL Server};server=sqlrem;database=rem_privera_prod_20160628;trusted_connection=true')
persons_and_nationalitaet <- sqlQuery(connection, 
                                      "select count(OID) as count, NationalitaetCD as 
                                        nationalitaet from person p group by NationalitaetCD")
                      

persons_and_nationalitaet %>% 
  arrange(desc(count)) %>% 
  top_n(50) %>% 
  ggplot() +
  geom_bar(aes(nationalitaet, count),
           stat = "identity") 
  

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


# Mahnungen pro Person
persons_and_nationalitaet %>% 
  left_join(mahnungen_pro_nationalitaeten) %>% 
  mutate(mahnungen_pro_person = count_mahnungen/count) %>% 
  arrange(desc(mahnungen_pro_person)) %>% 
  top_n(20)
  



  