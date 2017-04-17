
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


# Scatterplot of current situation
f_gdp %>% 
  ggplot() +
  geom_point(aes(GDP2013, EF2013, colour=GDP2013, size=EF2013)) +
  geom_text(aes(GDP2013, EF2013, 
                label=ifelse(EF2013>1e9,as.character(Country),'')),hjust=1, vjust=1)


# Calculate some additional numbers
f_gdp %>% 
  mutate(
    gdp_growth_in_percent = (GDPDelta/GDP2009),
    ef_growth_in_percent = (EFDelta/EF2009)) -> 
  global_foodprint


global_foodprint %>% 
  ggplot() +
  geom_point(aes(gdp_growth_in_percent, ef_growth_in_percent,
                 size=GDP2013, colour = EF2013,
                 shape=EFDelta< 0)) +
  scale_colour_gradient(low = "yellow", high = "darkred") +
  scale_size_continuous(range = c(1,10))  + 
  theme(panel.background = element_blank(),
        panel.grid.minor = element_line(colour = "#FFFEBA"),
        panel.grid.major = element_line(colour = "#E5E4A7")) +
  geom_text(aes(gdp_growth_in_percent, ef_growth_in_percent, 
                label=ifelse(EF2013>1e9 | Country == "Switzerland",
                             as.character(Country),'')),hjust=1.1, vjust=1.1)
  
  
# Printing some time series
nfa_2017_edition <- read_csv(
  paste0("C:/Source/mas-data-science/CAS Data Visualization/",
         "Project/footprint-nfa-2017-edition/NFA 2017 Edition.csv"))


# total capacity versus foodprint
nfa_2017_edition %>% 
  filter(country == "Switzerland" &
           (record == "BiocapTotGHA" | record == "EFConsTotGHA")) %>% 
  ggplot() +
  geom_contour(aes(year, total/1000000, colour = (record != "EFConsTotGHA")),
           stat = "identity") +
  ylab("hectares (millions)") +
  scale_colour_manual("",
                      labels=c("foodprint","biocapacity"), 
                      values = c("red", "darkgreen")) +
  ggtitle("Switzerlands Foodprint vs. Biocapacity")




printCountry(global_foodprint, "Switzerland")

printCountry <- function(df, name){
  values <- df[df$Country == name,
     c("Country",
       "EF2009","EF2013",
       "ef_growth_in_percent",
       "GDP2009", "GDP2013", 
       "gdp_growth_in_percent")]
  
  print(paste("Country: " , values[1]))
  print(paste("EF2009: " , round(values[2], 2)))
  print(paste("EF2013: " , round(values[3], 2)))
  print(paste("Growth: " , 100*round(values[4], 5), "%"))
  print(paste("GDP2009: " , round(values[5], 2)))
  print(paste("GDP2013: " , round(values[6], 2)))
  print(paste("Growth: " , 100*round(values[7], 5), "%"))
}





