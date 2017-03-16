
# Uebung 3 - Classification

# Antworten
# a) Es sind 42'000 Bilder in der Matrix encodiert
# b) Die Spalte welche das Laben enthält ist: label (Spalte 1)
# c) 784 Pixel habe die Bilder
# d) Die Bilder haben eine Dimension von 28x28

# Imported code
mnist_matrix = read.csv( 'https://github.com/romeokienzler/developerWorks/raw/master/train.csv' )
dim(mnist_matrix)
sort(unique(mnist_matrix[,1]))

View(mnist_matrix[1,])

par( mfrow = c(10,10), mai = c(0,0,0,0))
for(i in 1:100){
  y = as.matrix(mnist_matrix[i, 2:785])
  dim(y) = c(28, 28)
  image( y[,nrow(y):1], axes = FALSE, col = gray(255:0 / 255))
  text( 0.2, 0, mnist_matrix[i,1], cex = 3, col = 2, pos = c(3,4))
}

# First, we make the flow reproducable
set.seed(1234)

# split the data set training and validation set
train_rows <- sample(nrow(mnist_matrix), .7*nrow(mnist_matrix))
train_df <- mnist_matrix[train_rows,] 
validation_df <- mnist_matrix[-train_rows,]

library(ggplot2)
library(dplyr)

# check out the distributions

train_df %>% 
  ggplot() +
  geom_bar(aes(label))

validation_df %>% 
  ggplot() +
  geom_bar(aes(label))

# Seems ok, now we are trying some methods for classification

# 1. Descision trees -------------------------------------------

library(rpart)

# build the tree
dtree <- rpart(label ~ ., data = train_df, method="class",
               parms = list(split="information"))

# check the classifications
dtree$cptable

# plot the effectivness
plotcp(dtree)

# prune the tree
dtree_pruned <- prune(dtree, .01738)

# show the descision
library(rpart.plot)
prp(dtree_pruned, type = 2, extra = 104, fallen.leaves = T, main = "Descision Tree")

# make prediction
dtree_pred <- predict(dtree_pruned, validation_df, type="class")

# confusion matrix
table(validation_df$label, dtree_pred,
      dnn=c("Actual","Predicted"))

# performance function
checkPerformance = function(prediction, validation){
  good <- sum(prediction == validation$label)
  cat("Correct predictions: ", good)
  all <- length(validation$label)
  cat("\nSuccess percentage: ", (good/all)*100)
}

# have a glance at the peformance
checkPerformance(dtree_pred, validation_df)
## Correct predictions:  7129
## Success percentage:  56.57488


# 2. Conditional interference trees -------------------------------------------
library(party)

# convert label to factors
train_df$label <- as.factor(train_df$label)
validation_df$label <- as.factor(validation_df$label)

# build tree
citree <- ctree(label~., data = train_df)

# make prediction
citree_pred <- predict(citree, validation_df, type="response")

# confusion matrix
table(validation_df$label, citree_pred,
      dnn=c("Actual", "Predicted"))

# check performance
checkPerformance(citree_pred, validation_df)
## Correct predictions:  9411
## Success percentage:  74.68455


# 3. Random forests
library(randomForest)

# growing the forest -------------------------------------------
forest <- randomForest(label ~., data = train_df,
                       importance = T)

# make the prediction
forest_pred <- predict(forest, validation_df)

# confusion matrix
table(validation_df$label, forest_pred,
      dnn=c("Actual","Predicted"))

checkPerformance(forest_pred, validation_df)
## Correct predictions:  12145
## Success percentage:  96.38124

# 4. Support vector machines  -------------------------------------------
library(e1071)


# Building the machine
svm_model <- svm(label~., data = train_df)

# Doing the prediction
svm_pred <- predict(svm_model, validation_df)

# confustion matrix and performance stats
table(validation_df$label, svm_pred,
      dnn=c("Actual","Predicted"))

checkPerformance(svm_pred, validation_df)

