
library(readr)
library(ggplot2)
library(dplyr)

# TODO; 
# - Identify stories
# - Worst Tendency has to be done with per capita or in percent
# - Quiz



# Laender mit HDI und Groesse der Population
country_metrics <- read_csv(
  paste0("C:/Source/mas-data-science/CAS Data Visualization/Project/",
         "country_metrics.csv"))

country_deltas <- read_csv(
  paste0("C:/Source/mas-data-science/CAS Data Visualization/Project/",
         "EF_GDP(constant2010USD).csv"))

left_join(country_deltas, country_metrics, 
          by = c("Country" = "Country Name")) -> country_metrics_with_impact  

country_metrics_with_impact %>% 
  ggplot() + 
  scale_size(range = c(1, 20)) +
  geom_point(aes(HDI, EFConsPerCap, size = EF2013, colour = EFDelta_P)) +
  scale_colour_gradient(low = "white", high = "black") +
  geom_hline(aes(yintercept=1.74), 
             linetype = 3) +
  geom_text(aes(y=1.74, x=.45, label="Word Biocapacity per Person (1.74)"),
            vjust=-1.2) +
  # geom_text(aes(x = HDI, EFConsPerCap, label = Country)) +
  geom_vline(aes(xintercept = .7), linetype = 4) +
  geom_text(aes(x=.7, y=10, label = "High human development"),
            hjust = -.1)+
  ylab("Ecological foodprint per person")+
  ggtitle("World Foodprints and human developments")

limit <- 10

# Countries with highest EF
# (Mongolia is interesting - why?)
country_metrics_with_impact %>% 
  select(Country, EFConsPerCap) %>% 
  arrange(desc(EFConsPerCap)) %>% 
  head(10) %>% 
  ggplot() +
  geom_bar(aes(reorder(Country, -EFConsPerCap), EFConsPerCap),
           stat = "identity")

# Countries with lowest EF
country_metrics_with_impact %>% 
  select(Country, EFConsPerCap) %>% 
  arrange(EFConsPerCap) %>% 
  head(10)%>% 
  ggplot() +
  geom_bar(aes(reorder(Country, EFConsPerCap), EFConsPerCap),
           stat = "identity")

# Countries with best tendency
country_metrics_with_impact %>% 
  select(Country, EFDelta, EF2009, EF2013) %>% 
  arrange(EFDelta) %>% 
  head(10)%>% 
  ggplot() +
  geom_bar(aes(reorder(Country, EFDelta), EFDelta),
           stat = "identity")

# Countries with worst tendency 
country_metrics_with_impact %>% 
  select(Country, EFDelta, EF2009, EF2013) %>% 
  arrange(desc(EFDelta)) %>% 
  head(10) %>% 
  ggplot() +
  geom_bar(aes(reorder(Country, -EFDelta), EFDelta),
           stat = "identity")


# Plot some history for specific Countries of interest
# (better search for interessting patterns)
country_history <- read_csv(
   paste0("C:/Source/mas-data-science/CAS Data Visualization/Project/",
          "NFA 2017 Edition.csv"))

country_history %>% 
  filter(record == "EFConsPerCap") %>%
  arrange(desc(total)) %>% 
  select(country) %>% 
  unique() -> sorted_countries


country_of_interest <- c(
  "Luxembourg",       # highest EF per capita
  "Haiti",            # lowest EF per capita
  "United Kingdom",   # best tendency??
  "China"             # worst tendency
  )

country_history %>% 
  filter(country %in% country_of_interest) %>% 
  select(country, total, record, year) %>% 
  arrange(desc(total)) %>% 
  filter(record == "EFConsPerCap") %>%
  ggplot() +
  geom_line(aes(year, total)) +
  facet_grid(country ~ .)





