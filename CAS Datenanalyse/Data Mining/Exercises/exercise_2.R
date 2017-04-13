

# First we set the seed to make it reproducable
set.seed(1234)

# set the working dir to the data folder
setwd("C:/Source/mas-data-science/Data Mining/Lesson 2/HMP_Dataset")

# 1. Initial setup as given by the exercise
# -------------------------------------------------------------------------------

# create a data frame from all files in specified folder
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

# Plot the sample with the 3 axis
ggplot(df1_sample, aes(timestep)) + 
  geom_line(aes(y = x, colour = "x")) + 
  geom_line(aes(y = y, colour = "y")) + 
  geom_line(aes(y = z, colour = "z"))

df2 = create_activity_dataframe("Climb_stairs",2)
df = rbind(df1,df2)

# Function for number of clusters
determine_number_of_clusters = function(df) {
  wss <- (nrow(df)-1)*sum(apply(df,2,var))
  for (i in 2:15) wss[i] <- sum(kmeans(df,
                                       centers=i)$withinss)
  plot(1:15, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares") 
}

number_of_clusters=2
n = nrow(df)

# Plot the centers of k-means
kmeans(df,centers=number_of_clusters)$centers

df_x_y_z = cbind(df$x,df$y, df$z)

# Determine number of clusters
determine_number_of_clusters(df_x_y_z)

# Calculatring k-means
km = kmeans(df_x_y_z,centers=number_of_clusters)

# Determine success rate of initial example
truthVector = km$cluster == df$class
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
good/(good+bad)

# Plot the sample
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

# Plot the clusters
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


# 2. Start with some feature engineering
#  ------------------------------------------------------------------------------------

# The suggested feature of exercise is fundamentally flawed, we cannot
# use class to calculate a mean or anything because we would not have
# the class and this is the whole point of clustering (this is NOT a
# classification problem so we cannot use supervised learning)

# So we are reading all the data from 2 activities in the same dataset, and
# we make the calculation for every activity

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

# Make a combined dataset (as it would be in reality)
df_combined <- rbind(df_climbing, df_brush_teeth)

library(dplyr)

# Calculate some features in the different groups
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
  
summary(df_extended)

# We try to divide our new features into different categories
library(rpart)

rpart_model <- rpart(activity ~ mean_x + mean_y + mean_z, df_extended)
summary(rpart_model)

library(rpart.plot)
rpart.plot(rpart_model)

# 'means_y' seams to be appropriate for our clustering case
km <- kmeans(df_extended$mean_y, 2)
summary(km$centers)

# Adding the clusters to our set
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

# Plotting the clusters again with our new features

# The calculated values of the algorithm
plot_ly(df_sample, x = ~x, y = ~y, z=~z, color = ~cluster)

# The real values where the separation is not strict
plot_ly(df_sample, x = ~x, y = ~y, z=~z, color = ~activity)

# Show calculated and real clusters
ggplot(df_sample) +
  geom_point(aes(mean_y, factor(cluster), color=activity))

# (There would actually be a hard line for dividing the two
# activities, but the clustering does this in another way)

df_with_cluster %>% 
  filter(cluster == 2 & activity == "climbing_stairs") %>% 
  nrow -> count_correct_climbing

df_with_cluster %>% 
  filter(cluster == 1 & activity == "brushing_teeth") %>% 
  nrow -> count_correct_brushing

# Success rate
(count_correct_climbing + count_correct_brushing) / nrow(df_with_cluster)
# [1] 0.9740893

# Note:
# We did set the seed so this should not be nescessary
# (If the value is 0.02591065 then the cluster numbers are the other way
# around because it is random - we need to switch the cluster numbers above)
max((count_correct_climbing + count_correct_brushing) / nrow(df_with_cluster),
         1-(count_correct_climbing + count_correct_brushing) / nrow(df_with_cluster))


 

