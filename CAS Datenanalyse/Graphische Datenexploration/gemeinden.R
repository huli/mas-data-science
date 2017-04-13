

library(dplyr)
library(ggplot2)
library(readr)

gemeinden <- read_csv("C:\\temp\\gemeindedaten.csv")


# Anzahl Gemeinden
nrow(gemeinden)

# Mittlere Einwohnerzahl
mean(gemeinden$bev_total)

# Gemeinde mit am wenigsten Einwohner
data %>% 
  arrange(bev_total) %>% 
  head(1)

# Gemeinde mit am meisten Einwohner
data %>% 
  arrange(desc(bev_total)) %>% 
  head(1)

data %>% 
  group_by(kantone) %>% 
  summarise(N = n()) %>% 
  ggplot(aes(x = reorder(kantone, N), y = N)) +
  geom_point(size = 3) +
  geom_segment(aes(xend = kantone, yend = 0), lineend = 1) +
  coord_flip()

# Kanton mit den meisten Einwohner
data %>% 
  group_by(kantone) %>% 
  summarise(bev_kanton = sum(bev_total)) %>% 
  arrange(bev_kanton) %>% 
  head(1)

# Kanton mit den wenigsten Einwohner
data %>% 
  group_by(kantone) %>% 
  summarise(bev_kanton = sum(bev_total)) %>% 
  arrange(desc(bev_kanton)) %>% 
  head(1)
