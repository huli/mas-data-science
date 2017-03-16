#set the working directory specific to my machine
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

View(df1)

library(ggplot2)
df1_sample = df1[sample(nrow(df1), 500), ]
ggplot(df1_sample, aes(timestep)) + 
  geom_line(aes(y = x, colour = "x")) + 
  geom_line(aes(y = y, colour = "y")) + 
  geom_line(aes(y = z, colour = "z"))

df2 = create_activity_dataframe("Climb_stairs",2)
df = rbind(df1,df2)
View(df)

write.csv(df,"dsx_movement_pattern.csv")


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

# with colors
df_with_cluster$cluster <- df$cluster
df_with_cluster$cluster <- df$class

df_sample <- df_with_cluster[sample(nrow(df_with_cluster), 1000), ]

with(df_sample, {
  scatterplot3d(x,y,z, color = cluster)
})


# with some 3d
library(plotly)

# Clusters
plot_ly(df_sample, x = ~x, y = ~y, z=~z, color = ~cluster)

# Real values
plot_ly(df_sample, x = ~x, y = ~y, z=~z, color = ~class)


# mit einem Mean über die verschiedenen Probanden kann 90% erreicht weerden
# einfach aus den files die namen (probanden) lesen und beei denen mittelwert berechnen
