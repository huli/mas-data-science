
library(readr)
library(ggplot2)
library(dplyr)

f_gdp <- read_csv(
                paste0("C:/Source/mas-data-science/CAS Data Visualization/Project/",
                    "footprint-nfa-2017-edition/EF_GDP(constant2010USD).csv"))

# View some data
summary(f_gdp)
f_gdp[1,]
# Country   EF2013   EF2009     GDP2013     GDP2009 EFDelta   GDPDelta     
# DDelta EFDelta_P GDPDelta_P DDelta_P DDelta_Rank EFDelta_Rank GDPDelta_Rank Dec_Flag GDP_std

# sort by name
f_gdp %>% 
  ggplot() +
  geom_bar(aes(Country, EF2013), stat = "identity") 

# sort by size
f_gdp %>% 
  ggplot() +
  geom_bar(aes(reorder(Country, EF2013), EF2013),
                 stat = "identity")


# range(f_gdp$EF2013)
#[1]     161736.1 5009653687.3

# histogramm
breaks <- cut(f_gdp$EF2013, breaks = 100)

# frequency distribution
f_gdp %>% 
  ggplot() +
  geom_histogram(aes(breaks), stat = "count")


# Scatterplot
f_gdp %>% 
  ggplot() +
  geom_point(aes(GDP2013, EF2013)) +
  geom_text(aes(GDP2013, EF2013, 
                label=ifelse(EF2013>2e9,as.character(Country),'')),hjust=0, vjust=0)



