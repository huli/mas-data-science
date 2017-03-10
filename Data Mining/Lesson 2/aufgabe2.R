
## Uebung 3 - Classification
## Das MNIST Datenset ist sozusagen das HelloWorld Program wenn es um Classification mit DeepLearning
## geht. Wir missbrauchen hier dieses Datenset für traditionelle Classification.
## 1. Führen Sie u.g. Source Code aus und beantworten Sie folgende Fragen
##a) Wieviele Bilder sind in der Matrix mnist_matrix encodiert
# 42'000

##b) Da es sich um einen Supervised Machine Learning task handelt muss ein Label (Target Variable)
##bereitgestellt sein - welche Spalte der Matrix enthält das Label?
# Spalte: label (1)

##c) Wieviele Pixel haben die Bilder?
# 784
##d) Wie hoch/breit sind die Bilder?
# 28x28

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

# Now we are trying some methods for classification

# 1. Descision trees

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


# 2. Conditional interference trees
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

forest <- randomForest()




##2. Nehmen Sie einen Classifier Ihrer Wahl und trainieren Sie Ihn mit der bereitgestellten Matrix.
##a) Teilen Sie die Matrix in ein sinnvolles Training und Test set auf, lesen Sie hierzu diesen
##Thread: http://stats.stackexchange.com/questions/19048/what-is-the-difference-between-test-set-and-validation-set
##(Ein Validation Set wird hier nicht benötigt da nicht erwartet wird Parameter des
##Classifiers zu tunen)
##b) Verwenden Sie nun das Training Set um einen Classifier Ihrer Wahl zu trainieren
##c) Berechnen Sie den Prozentsatz der richtig klassifizierten Daten indem Sie Ihren
##trainierten Classifier auf das Test Set anwenden (Hinweis: Die Qualität des Classifiers
##wird nicht bewertet)