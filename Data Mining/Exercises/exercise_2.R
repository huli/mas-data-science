
# set the working dir to the data folder
setwd("C:/Source/mas-data-science/Data Mining/Lesson 2/HMP_Dataset")

#create a data frame from all files in specified folder
create_activity_dataframe = function(activityFolder,classId) {
  file_names = dir(activityFolder)
  file_names = lapply(file_names, function(x){ paste(".",activityFolder,x,sep = "/")})
  your_data_frame = do.call(rbind,lapply(file_names,function(x){read.csv(x,header = FALSE,sep = " ")}))
  your_data_frame = cbind(data.frame(rep(classId,nrow(your_data_frame))),your_data_frame)
  your_data_frame = cbind(data.frame(1:nrow(your_data_frame)),your_data_frame)
  colnames(your_data_frame) = c("timestep","class","x","y","z")
  your_data_frame
}

df1 = create_activity_dataframe("Brush_teeth",1)


library(ggplot2)
df1_sample = df1[sample(nrow(df1), 500), ]
ggplot(df1_sample, aes(timestep)) + 
  geom_line(aes(y = x, colour = "x")) + 
  geom_line(aes(y = y, colour = "y")) + 
  geom_line(aes(y = z, colour = "z"))

df2 = create_activity_dataframe("Climb_stairs",2)
df = rbind(df1,df2)

#write.csv(df,"dsx_movement_pattern.csv")


# Determine number of clusters
determine_number_of_clusters = function(df) {
  wss <- (nrow(df)-1)*sum(apply(df,2,var))
  for (i in 2:15) wss[i] <- sum(kmeans(df,
                                       centers=i)$withinss)
  plot(1:15, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares") 
}

number_of_clusters=2
n = nrow(df)

kmeans(df,centers=number_of_clusters)$centers

df_x_y_z = cbind(df$x,df$y, df$z)
determine_number_of_clusters(df_x_y_z)
km = kmeans(df_x_y_z,centers=number_of_clusters)


truthVector = km$cluster != df$class
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
good/(good+bad)

library(scatterplot3d)
df_sample = df[sample(nrow(df), 1000), ]

with(df_sample, {
  scatterplot3d(x,y,z)
})

# Adding the calculated and the real clusters together
df_with_cluster <- df
df_with_cluster$cluster <- km$cluster

# taking a sample
df_sample <- df_with_cluster[sample(nrow(df_with_cluster), 1000), ]

# plot the clusters
with(df_sample, {
  scatterplot3d(x,y,z, color = cluster)
})

# with some (more) 3d
library(plotly)

# Plotting the clusters 

# the calculated and somehow artifical values of the algorithm
plot_ly(df_sample, x = ~x, y = ~y, z=~z, color = ~cluster)

# the read values where the separation is not strict
plot_ly(df_sample, x = ~x, y = ~y, z=~z, color = ~class)


# some feature engineering
View(df1)


# The suggested feature of exercise is fundamentally flawed, we cannot
# use class to calculate a mean or anything because we would not have
# the class and this is the whole point of clustering (this is NOT a
# classification problem so we cannot use supervised learning)

# So we are reading all the data from 2 activities in the same dataset


readActivity <- function(folder_name, activity)
{
  file_names = dir(folder_name)  
  df = do.call(rbind,lapply(file_names,function(x){
      inner_df <- read.csv(paste(".", folder_name,x,sep = "/"),header = FALSE,sep = " ")
      inner_df$filename = x
      inner_df
    }))
  df = cbind(data.frame(rep(activity,nrow(df))),df)
  df = cbind(data.frame(1:nrow(df)),df)
  colnames(df) = c("timestep","activity","x","y","z", "filename")
  df
}

library(ggplot2)
df_climbing <- readActivity("Climb_stairs", "climbing_stairs")
summary(df_climbing)
ggplot(df_climbing, aes(timestep)) + 
  geom_line(aes(y = x, colour = "x")) + 
  geom_line(aes(y = y, colour = "y")) + 
  geom_line(aes(y = z, colour = "z"))

df_brush_teeth <- readActivity("Brush_teeth", "brushing_teeth")
summary(df_brush_teeth)
ggplot(df_brush_teeth, aes(timestep)) + 
  geom_line(aes(y = x, colour = "x")) + 
  geom_line(aes(y = y, colour = "y")) + 
  geom_line(aes(y = z, colour = "z"))

df_combined <- rbind(df_climbing, df_brush_teeth)

library(dplyr)

df_combined %>% 
  group_by(filename) %>% 
  mutate(
    mean_x = mean(x),
    mean_y = mean(y),
    mean_z = mean(z),
    range_x = max(x)-max(x),
    range_y = max(y)-max(y),
    range_z = max(z)-max(z)
    ) %>% 
  ungroup -> df_extended
  
df_extended
summary(df_extended)


library(rpart)

rpart_model <- rpart(activity ~ mean_x + mean_y + mean_z, df_extended)
summary(rpart_model)

library(rpart.plot)
rpart.plot(rpart_model)

# means_y seams to be appropriate for clustering
km <- kmeans(df_extended$mean_y, 2)
summary(km$centers)

df_with_cluster <- df_extended
df_with_cluster$cluster <- km$cluster

# taking a sample
df_sample <- df_with_cluster[sample(nrow(df_with_cluster), 1000), ]


library(scatterplot3d)

# plot the clusters
with(df_sample, {
  scatterplot3d(x,y,z, color = cluster)
})

# with some (more) 3d
library(plotly)

# Plotting the clusters 
# the calculated and somehow artifical values of the algorithm
plot_ly(df_sample, x = ~x, y = ~y, z=~z, color = ~cluster)

# the read values where the separation is not strict
plot_ly(df_sample, x = ~x, y = ~y, z=~z, color = ~activity)

# Show calculated and read clusters
ggplot(df_sample) +
  geom_point(aes(mean_y, factor(cluster), color=activity))

ggplot(df_sample) +
  geom_point(aes(mean_y, factor(cluster), color=activity))


df_with_cluster %>% 
  filter(cluster == 2 & activity == "climbing_stairs") %>% 
  nrow -> count_correct_climbing

df_with_cluster %>% 
  filter(cluster == 1 & activity == "brushing_teeth") %>% 
  nrow -> count_correct_brushing

# Success rate
(count_correct_climbing + count_correct_brushing) / nrow(df_with_cluster)
# [1] 0.9740893

df_sample <- df_extended[sample(nrow(df_extended), 1000), ]

t <- dist(df_sample)

#hclust noch verwenden
hclustered <- hclust(t, method="single")

plot(hclustered)


# Gruppen zeichnen
rect.hclust(hclustered, 2)


