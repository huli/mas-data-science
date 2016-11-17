# Uebung 16.2.2 - dplyr

library(foreign)

# Daten laden
input.data <- read.dta("http://www.farys.org/daten/allbus2008.dta")

'%notin%' <- function(x,y)!('%in%'(x,y))

# Aufraeumen
clean.data <- 
  input.data %>% 
  select("Geschlecht" = v151, "Alter" = v154, "Einkommen" = v386) %>% 
  filter(Alter %notin% c(99997, 99998, 99999, 999)) %>% 
  group_by(Alter, Geschlecht) %>% 
  summarise(Durchschnittseinkommen = mean(Einkommen))

# Und Plotting
library(ggplot2)

ggplot(clean.data, aes(x=Alter, y=Durchschnittseinkommen, color=Geschlecht)) +
  geom_line()