
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

library(dplyr)

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

df_climbing <- readActivity("Climb_stairs", "climbing_stairs")

library(stringr)

# adding user and time stamp as column

getDateAndVolunteer("Accelerometer-2012-06-07-10-48-08-climb_stairs-f1.txt")$vol

getDateAndVolunteer <- function(filename){
  index_of <- str_locate(filename, "-")+1
  time_stamp <- str_sub(filename, index_of[1], index_of[1]+18)
  date_time <- strptime(time_stamp,format='%Y-%m-%d-%H-%M-%S')
  volunteer <- str_sub(filename, str_length(filename)-5, str_length(filename)-4)
  list(vol=volunteer, dat=date_time)
}

Get




??stringr

