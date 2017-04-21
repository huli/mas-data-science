

# heatmap: skills
# : typical day
# radar chart: skills

library(ggplot2)
library(openxlsx)
library(zoo)
library(dplyr)



# timeline 
# ----------------------------------------------------------------------------------

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
    breaks=rev(levels(df$sector))) +
    geom_vline(aes(xintercept=2017),linetype="dashed")


# radar chart (not finished)
# ----------------------------------------------------------------------------------
library(ggradar)
library(scales)

languages <- c(
           
df_languages <- data.frame(
  "year"=2017,
  "DotNet"=9,
  "Javascript"=3,
  "R"=6,
  "FSharp"=3,
  "Ruby"=3
))


df_languages[2,] <- c(2020, 8, 5, 9, 4, 3)
ggradar(df_languages, grid.min = 1, grid.max = 10)



melted_languages <- melt(df_languages, id.vars = c("year"))

ggplot(arrange(melted_languages, year))+
  aes(x=variable, y=value,color=year, group=year) +
  geom_polygon(fill=NA) + 
  coord_polar() + 
  theme(axis.text.x = element_text(size = 5))+
  theme(legend.position = "none")



df_tech <- data.frame(
                  "group"=2017,
                  "Programming"=8,
                  "DDD"=7, 
                 "TDD"=8, 
                 "Design Patterns"=7, 
                 "Architecture"=6)
ggradar(df_tech, grid.min = 1, grid.max = 10,
        plot.legend = F)

# bar charts
# ----------------------------------------------------------------------------------

data.frame("language"=
  c("DotNet",
  "Javascript",
  "R",
  "FSharp",
  "Ruby"),
  "skill"= c(9,3,6,3,3)) %>% 
  ggplot(aes(x=language, y=skill, fill=language)) +
  geom_bar(stat = "identity",
           size =.2) +
  scale_fill_brewer(palette ="Greens") +
  coord_flip()


# tree map
# ----------------------------------------------------------------------------------

library("portfolio")

data <- read.xlsx("C:/Users/ch0125/Dropbox/Admin/typical_day.xlsx")

map.market(id = data$action, area = data$time, group = data$category,
           scale = 600,
           lab   = c("group"=T, "id"=T),
           color = max(data$time)-data$time)




