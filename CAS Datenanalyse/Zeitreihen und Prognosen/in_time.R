

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
sectors <- factor(columns[3:7], levels=rev(columns[3:7]), ordered = T)
years <- na.omit(data[, "jahr"])

sector <- rep(sectors, each = length(years))
year <-  as.numeric(rep(years, length(sectors)))

value <- c(
  na.approx(data[, 'reife']),
  na.approx(data[, 'schule']),
  na.approx(data[, 'ausbildung']),
  na.approx(data[, 'arbeit']),
  na.approx(data[, 'weiterbildung'])
)





df <- data.frame(sector,year, value)

ggplot(arrange(df, sector), aes(x=year, y=value, fill=sector)) + 
  geom_area(colour="black", size=.1, alpha=.4) +
  scale_fill_brewer(direction = -1,
    palette="RdBu", 
    breaks=rev(levels(df$sector))) +
    geom_vline(aes(xintercept=2017),linetype="dashed")


# radar chart (not finished)
# ----------------------------------------------------------------------------------

#install.packages("ggradar")
library(devtools)
install_github("ricardo-bion/ggradar")
library(ggradar)
library(scales)
library(reshape2)

languages <- c(
df_languages <- data.frame(
  "year"=2017,
  "Csharp"=9,
  "Javascript"=3,
  "R"=6,
  "Python"=3,
  "Ruby"=3,
  "Fsharp" = 3
))


df_languages[2,] <- c(2020, 8, 5, 9, 4, 3, 5)
ggradar(df_languages, grid.min = 1, grid.max = 10,
        legend.text.size = 10)


technologies <- c(
  df_technologies <- data.frame(
    "year"=2017,
    ".NET"=9,
    "Rails"=3,
    ".NET Core"=6
  ))


df_technologies[2,] <- c(2020, 8, 5, 9)
ggradar(df_technologies, grid.min = 1, grid.max = 10,
        legend.text.size = 10)


concepts <- c(
  df_concepts <- data.frame(
    "year"=2017,
    "DDD"=9,
    "TDD"=3,
    "OOD"=6,
    "FP"=6
  ))


df_concepts[2,] <- c(2020, 8, 5, 9, 10)
ggradar(df_concepts, grid.min = 1, grid.max = 10,
        legend.text.size = 10)



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

#install.packages("portfolio")
library("portfolio")

data <- read.xlsx("C:/Users/ch0125/Dropbox/Admin/typical_day.xlsx")

map.market(id = data$action, area = data$time, group = data$category,
           scale = 600,
           lab   = c("group"=T, "id"=T),
           color = max(data$time)-data$time)




