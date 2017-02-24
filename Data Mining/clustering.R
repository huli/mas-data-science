

# Some previous experimentation
# ------------------------------------------------------------

# Normalisierung
normalize <- function(x){
  (x - min(x)) / (max(x) - min(x))
}

df <- iris[1:4]

apply(df, 2, normalize)


# Hiearchical Clustering

# Hierarchisches Cluster erzeugen
cluster <- hclust(dist(scale(mtcars)),
                  method = "complete")
# Plotten
plot(cluster)

# Gruppen zeichnen
rect.hclust(cluster, 5)

#ClusterNr zum Dateframe hinzufügen
data.frame(mtcars, cutree(cluster, 5))


# k-means Clustering

set.seed(1234)
df <- iris[3:4]

# Normalisieren
df_norm <- scale(df)

# Cluster bilden (Anzahl Clusters!)
clusters <- kmeans(df_norm, 3)

# Plot
plot(df, col=clusters$cluster + 1, pch=20)


# Clustering in Action 
# -------------------------------------------------------------------------

data(nutrient, package="flexclust")

head(nutrient)

# Distanzen bestimmen
dists <- dist(nutrient)
as.matrix(dists)[1:3, 1:3]
row.names(nutrient) <- tolower(row.names(nutrient))
nutrient_scaled <- scale(nutrient)

nutrient_dist <- dist(nutrient_scaled)

# Hiearchical cluster analysis
# --------------------------------------------

nutrient_average <- hclust(nutrient_dist, method = "average")
plot(nutrient_average, hang=-1, cex=.8)

# Determine best numbers of clusters
library(NbClust)
nc <- NbClust(nutrient_scaled, distance="euclidean",
              min.nc=2, max.nc=15, method="average")

barplot(table(nc$Best.nc[1,]),
        xlab="Number of clusters", ylab="Number of criteria",
        main="Number of Clusters chosen by 26 Criteria")

# Clustering with recomended number of clusters
clusters <- cutree(nutrient_average, k=5)

# look at the clusters with the means
aggregate(nutrient, by=list(cluster=clusters), median)

# plot cluster in tree
plot(nutrient_average, hang=-1, cex=.8)
rect.hclust(nutrient_average, k=5)


# Partitioning cluster analysis
# --------------------------------------------

# k-means clustering

wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1) * sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)
  }
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab = "Within groups sum of squares")
}

data(wine, package = "rattle")
head(wine)

# Standardize the data
df <- scale(wine[-1])

# Determine number of clusters
wssplot(df)
library(NbClust)
set.seed(1234)
devAskNewPage(ask=T)
nc <- NbClust(df, min.nc = 2, max.nc = 15, method="kmeans")
# * According to the majority rule, the best number of clusters is  3 

table(nc$Best.n[1,])

dev.off()
barplot(table(nc$Best.n[1,]),
        xlab="Number of Clusters", ylab="Number of Criteria",
        main="Number of Clusters Chosen by 26 Criteria")

# Perform k-means analysis
set.seed(1234)
fit_km <- kmeans(df, 3, nstart = 25)
fit_km$size

# Show centers
fit_km$centers
aggregate(wine[-1], by=list(cluster=fit_km$cluster), mean)

# We verify our solution to the given type
ct_km <- table(wine$Type, fit_km$cluster)
ct_km

# -> looks pretty good

# Verify with adjusted Rand index
library(flexclust)
randIndex(ct_km)
# ARI 
# 0.897495 
# -> Not bad :)

# Clustering with medoids
# ----------------------------------------------
library(cluster)
set.seed(1234)
fit_pam <- pam(wine[-1], k=3, stand=T)
fit_pam$medoids
clusplot(fit_pam, main="Bivariat Clustering Plot")

# Clustering might be too good
library(fMultivar)
set.seed(1234)
df <- rnorm2d(500, rho=.5)
df <- as.data.frame(df)
plot(df, main="Bivariate Normal Distribution with rho=.5")

# Try to find some clusters where none exists
wssplot(df)
library(NbClust)
nc <- NbClust(df, min.nc = 2, max.nc = 15, method="kmeans")
dev.new()
barplot(table(nc$Best.n[1,]),
        xlab="Number of Clusters", ylab="Number of Criteria",
        main="Number of Clusters Chosen by 26 Criteria")

library(ggplot2)
library(cluster)
fit <- pam(df, k=2)
df$clustering <- factor(fit$clustering)

ggplot(data=df, aes(x=V1, y=V2, color=clustering, shape=clustering)) +
  geom_point() +
  ggtitle("Clustering of Bivariate Normal Data")

