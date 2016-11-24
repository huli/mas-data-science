# install.packages("WDI") 
library(WDI)
WDIsearch(string="gdp", field="name", cache=NULL)
DF <- WDI(country="all", indicator="NY.GDP.PCAP.PP.CD", start=2013, end=2014) # GDP per Capita kaufkraftbereinigt

# was sind die reichsten Länder 2013?
library(dplyr)
filter(DF, year==2013) %>%
  arrange(-NY.GDP.PCAP.PP.CD) %>%
  head()

# und wie sieht es 2014 aus?
filter(DF, year==2014) %>%
  arrange(-NY.GDP.PCAP.PP.CD) %>%
  head()

  # install.packages("Quandl")
  install.packages("devtools")
library(devtools)
install_github('quandl/R-package')
library(Quandl)

# Authentifizieren (bitte eigenen Account anlegen)
Quandl.api_key("WQoTGqsPCVdpwhtS3xzt")

# Suche nach "Swiss market index" auf quandl.com. Rechts oben "export data" -> R
smi <- Quandl("YAHOO/INDEX_SSMI", trim_start="1990-11-08", trim_end="2015-10-29")
head(smi)

# Inflationsrate
i <- Quandl("RATEINF/INFLATION_CHE", trim_start="1984-01-30", trim_end="2015-09-29")
head(i)