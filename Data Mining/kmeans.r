#@author: Romeo Kienzler
#@version 0.5
#@description: Finding anomalies by using cluster centroids and calculating euclidian distance
#This file is copyright protected - do not redistribute
library(scatterplot3d)
#data = read.csv('/Users/romeokienzler/Documents/romeo/Dropbox/arbeit/r/rkurs/ex1/testdata.csv', header = TRUE, sep = ",")
data = read.csv("/Users/romeokienzler/Documents/romeo/Dropbox/arbeit/r/rkurs/testdata.csv", header = TRUE, sep = ",")
keeps <- c("employeeid","departmentid","clientid","hour")
data_proj=data[keeps]

#uncomment this in order to estimate the correct number of clusters
wss <- (nrow(data_proj)-1)*sum(apply(data_proj,2,var))
for (i in 2:15) { 
  wss[i] <- sum(kmeans(data_proj,centers=i,iter.max = 10)$withinss)
}

plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")  


number_of_clusters = 6

km    <- kmeans(data_proj,number_of_clusters)
centers_normalized<-(scale(km$centers))
data_normalized <- scale(data_proj)

n = nrow(data_proj)
#calculation euclidic distance to nearest centroid
scores <- as.list(numeric(number_of_clusters*n))
dim(scores) <- c(n,number_of_clusters)

for (cluster_id in 1:number_of_clusters) {
	scores[,cluster_id] <- sqrt((centers_normalized[cluster_id,1]-data_normalized[,1])^2)+sqrt((centers_normalized[cluster_id,2]-data_normalized[,2])^2)+sqrt((centers_normalized[cluster_id,3]-data_normalized[,3])^2)+sqrt((centers_normalized[cluster_id,4]-data_normalized[,4])^2)
}

min_scores <- as.list(numeric(n))
for (sample_id in 1:n) {
	min_scores[sample_id] = min(unlist(scores[sample_id,]))
}

anomaly_indices = which(min_scores > 6)
employeeids = c()
for (i in 1:length(anomaly_indices)) {
	index = anomaly_indices[i]
	employeeids = append(employeeids,data[index,"employeeid"])
}

bad_guys = unique(employeeids);

bad_guys
#aggregate
attach(data_proj)
data_proj$employeeid
data_proj$departmentid
data_proj$clientid
data_proj$hour


with(data_proj, {
  scatterplot3d(employeeid,   # x axis
                departmentid,     # y axis
                clientid,    # z axis
                main="Department ID vs Employee ID vs Number of accesses",
                xlab="Employee ID",
                ylab="Department ID",
                zlab="Number of accesses")
})

with(data_proj, {
  scatterplot3d(employeeid,   # x axis
                departmentid,     # y axis
                clientid,    # z axis
                main="Department ID vs Employee ID vs Number of accesses",
                xlab="Employee ID",
                ylab="Department ID",
                zlab="Number of accesses")
})


aggdata <-aggregate(data_proj$employeeid, by=list(hour), FUN=function(x){sum(as.numeric(x))})
plot(aggdata$Group.1,aggdata$x)





aggdata <-aggregate(data_proj$employeeid, by=list(hour,clientid), FUN=function(x){sum(as.numeric(x))})
with(aggdata, {
  scatterplot3d(Group.2,   # x axis
                Group.1,     # y axis
                x,    # z axis
                main="Client ID vs Hour vs Number of accesses",
                xlab="Client ID",
                ylab="Hour",
                zlab="Number of accesses")
})
plot(aggdata$Group.2,aggdata$Group.1)
plot(aggdata$Group.2,aggdata$x)
plot(aggdata$Group.1,aggdata$x)

aggdata <-aggregate(data_proj$hour, by=list(employeeid,clientid), FUN=function(x){sum(as.numeric(x))})
with(aggdata, {
  scatterplot3d(Group.2,   # x axis
                Group.1,     # y axis
                x,    # z axis
                main="Client ID vs Employee ID vs Number of accesses",
                xlab="Client ID",
                ylab="Employee ID",
                zlab="Number of accesses")
})
plot(aggdata$Group.2,aggdata$Group.1)
plot(aggdata$Group.2,aggdata$x)
plot(aggdata$Group.1,aggdata$x)
