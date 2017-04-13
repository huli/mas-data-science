

# 2 5-dimensional Vectors
x <- c(1,3,5,7,9)
y <- c(2,4,6,8,10)

# Euclidian distance
# --------------------------------------------------------

# Solution in R
dist(rbind(x, y))
# x
# y 2.236068

euclidianDistance <- function(x, y){
  sqrt(sum((x-y)^2))  
}

euclidianDistance(x, y)
# [1] 2.236068

# Manhattan distance
# --------------------------------------------------------

# Solution in R
dist(rbind(x, y), method = "manhattan")

manhattanDistance <- function(x, y){
  sum(abs(y-x))
}

manhattanDistance(x, y)


# Normalize Data
# --------------------------------------------------------

# Non normalized data frame
df <- iris[1:4]

# the R way (not exactly the same)
apply(df, 2, function(x){
  scale(x, center = F, scale = T)
})


# Writing a function for learning purposes
normalize <- function(x){
  (x-min(x))/(max(x)-min(x))
}

apply(df, 2, normalize)



