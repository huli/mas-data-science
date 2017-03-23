

# 1. Data cleansing
# -----------------------------------------------------------------------------------------------

library(readr)
library(data.table)
library(stringr)
library(dplyr)

log <- read_log("https://raw.githubusercontent.com/romeokienzler/developerWorks/master/log")
log_filtered <- log[!(1:nrow(log)%%2),6]

# departmentid, employeeid, clientid
log_filtered$X6 %>% 
  str_split_fixed(",", n = 3) %>% 
  apply(2, str_trim) %>% 
  apply(2, as.integer) %>% 
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

library(ggplot2)
library(reshape2)

data <- read_csv("https://raw.githubusercontent.com/romeokienzler/developerWorks/master/testdata.csv")

# View data and controlling the work with our previous result
View(data)
range(data$employeeid)
range(data$departmentid)

# He mixed up the columns empoloyeeid and departementid so we fix it 
colname <- colnames(data)[3]
colnames(data)[3] <- colnames(data)[4]
colnames(data)[4] <- colname

#View(df)

# Clean columns without value
data %>% 
  select(-X1) -> df

# View distributions
df %>% 
  reshape2::melt(value.name = "value", variable.name = "id") %>% 
  ggplot(aes(x=factor(value))) +
  geom_bar() +
  facet_wrap(~id, scale = "free")

df %>% 
  group_by(hour, employeeid) %>% 
  summarise(n = n()) ->
  employees_per_hour

# Clustering
k <- kmeans(employees_per_hour, 2)

employees_per_hour %>% 
  dplyr::ungroup() %>% 
  dplyr::mutate(cluster = k$cluster %>% as.integer) ->
  employees_with_cluster

# Visualize Clusters
employees_with_cluster %>% 
    ggplot(aes(hour, employeeid, size=n, color=factor(cluster))) +
    geom_point()+
    geom_text(aes(0,23,label="outlier"), size=4,
          color="black",
          vjust=0, hjust=-0.05)

# We found an anomaly..lets look closer

# Suspicious employee
employees_with_cluster %>% 
  filter(hour == 0, cluster == 1)

# Examine employee over hours
df %>% 
  filter(employeeid == 23) %>% 
  ggplot(aes(factor(hour))) +
  geom_bar()

# Examining his activity in different appartments
df %>% 
  filter(employeeid == 23) %>% 
  group_by(departmentid, hour) %>% 
  summarise(n = n()) %>% 
  ggplot(aes(factor(hour), y=factor(departmentid))) +
  theme_minimal() +
  geom_tile(aes(fill = n))


# 3. Conclusion
# -----------------------------------------------------------------------------------------------

# Suspicious employee 23 in department 7 found (1000 requests in the middle of the night - hour 0)







