

# 1. Data cleansing
# -----------------------------------------------------------------------------------------------

library(readr)
library(data.table)
library(stringr)
library(dplyr)

log <- read_log("https://raw.githubusercontent.com/romeokienzler/developerWorks/master/log")
log_filtered <- log[!(1:nrow(log)%%2),6]

# epartmentid, employeeid, clientid
log_filtered$X6 %>% 
  str_split_fixed(",", n = 3) %>% 
  as.data.frame() ->
  ids_as_table

# Reorder columns
# Spalte 1> employeeid, Spalte 2> departmentid, Spalte 3> clientid
df <- ids_as_table[,c(2,1,3)]

# add date
hoursAndDates <- log[!(1:nrow(log)%%2),4]

hoursAndDates$X4 %>% 
  str_sub(13, 14) -> hours

# combining tables
df[,4] <- hours

ids_with_hours <- df[, c(4,1,2,3)]
names(ids_with_hours) <- c("hour","employeeid","departmentid","clientid") 

# result
ids_with_hours

# 2. Analysis
# -----------------------------------------------------------------------------------------------
data <- read_csv("https://raw.githubusercontent.com/romeokienzler/developerWorks/master/testdata.csv")

# View data
View(data)

library(ggplot2)
library(reshape2)

# Clean columns without value
data %>% 
  select(-X1) -> df

# View distributions
df %>% 
  reshape2::melt(value.name = "value", variable.name = "id") %>% 
  ggplot(aes(x=factor(value))) +
  geom_bar() +
  facet_wrap(~id, scale = "free")


# View departments over time
ggplot(data =  df[,c(1,3)], aes(x=factor(departmentid), y=hour)) +
  geom_point()

df %>% 
  group_by(hour, departmentid) %>% 
  summarise(n = n()) ->
  departments_per_hour

# Clustering
k <- kmeans(departments_per_hour, 2)

departments_per_hour %>% 
  dplyr::ungroup() %>% 
  dplyr::mutate(cluster = k$cluster %>% as.integer) ->
  departments_with_cluster

# Visualize Clusters
departments_with_cluster %>% 
    ggplot(aes(hour, departmentid, size=n, color=factor(cluster))) +
    geom_point()+
    geom_text(aes(0,23,label="whats happening here?"), size=4,
          color="black",
          vjust=0, hjust=-0.05)

# We found an anomaly..

# Suspicious department
departments_with_cluster %>% 
  filter(hour == 0, cluster == 1)

# Examine deparment over hours
df %>% 
  filter(departmentid == 23) %>% 
  ggplot(aes(factor(hour))) +
  geom_bar()

# a Heatmap of this
df %>% 
  filter(departmentid == 23) %>% 
  group_by(employeeid, hour) %>% 
  summarise(n = n()) %>% 
  ggplot(aes(factor(hour), y=factor(employeeid))) +
  theme_minimal() +
  geom_tile(aes(fill = n))

# Only one employee is active during this hour in
# that deparment
df %>% 
  filter(departmentid == 23, hour == 0) %>% 
  group_by(employeeid) %>% 
  summarise(n = n())

# -------------------------------------------
# suspicious employee: 7
# -------------------------------------------

# futher examination of employee
df %>% 
  filter(employeeid == 7) %>% 
  ggplot(aes(hour))+
  geom_bar()






