

# heatmap: skills
# : typical day
# radar chart: skills

library(ggplot2)
library(openxlsx)
library(zoo)
library(dplyr)


data <- read.xlsx("C:/Users/ch0125/Dropbox/Admin/events.xlsx")

columns <- colnames(data)
sectors <- factor(columns[3:8], levels=rev(columns[3:8]), ordered = T)
years <- na.omit(data[, "jahr"])

sector <- rep(sectors, each = length(years))
year <-  as.numeric(rep(years, length(sectors)))

value <- c(
  na.approx(data[,sectors[1]]),
  na.approx(data[,sectors[2]]),
  na.approx(data[,sectors[3]]),
  na.approx(data[,sectors[4]]),
  na.approx(data[,sectors[5]]),
  na.approx(data[,sectors[6]])
)

df <- data.frame(sector,year,value)

ggplot(arrange(df, sector), aes(x=year, y=value, fill=sector)) + 
  geom_area(colour="black", size=.2, alpha=.4) +
  scale_fill_brewer(direction = -1,
    palette="RdBu", 
    breaks=rev(levels(df$sector)))


