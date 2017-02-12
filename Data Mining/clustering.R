



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


