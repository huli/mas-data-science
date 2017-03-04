

# Supervised learning with classification methods

# pkgs <- c("rpart","rpart.plot","party", "randomForest", "e1071")
# install.packages(pkgs, depend = T)

# Preparing breast cancer data
site <- "http://archive.ics.uci.edu/ml/machine-learning-databases/"
data <- "breast-cancer-wisconsin/breast-cancer-wisconsin.data"
url <- paste(site, data, sep="")

breast_data <- read.table(url, sep=",", header = F, na.strings = "?")
names(breast_data) <- c(
    "id",
    "clump_thickness",
    "size_uniformity",
    "shape_uniformity",
    "maginal_adhesion",
    "single_epithelial_cellsize",
    "bare_nuclei",
    "bland_chromatin",
    "normal_nucleoli",
    "mitosis",
    "class"
)

df <- breast_data[-1]
df$class <- factor(df$class, levels = c(2,4), labels = c("bening", "malignant"))

set.seed(1234)
train_rows <- sample(nrow(df), .7*nrow(df))
train_df <- df[train_rows,]
validation_df <- df[-train_rows,]

table(train_df$class)
table(validation_df$class)

# Method 1: Logistic regression

# make generalized linear model
model_breast <- glm(class~., data = train_df, family = binomial())
summary(model_breast)

# removing unsignificant coeffizients
model_breast <- step(model_breast)
summary(model_breast)

# classifiy new values
prob <- predict(model_breast, validation_df, type="response")
prediction <- factor(prob > .5, levels = c(FALSE, TRUE),
                     labels = c("benign","malignant"))

# Evaluate predictive accuracy
performance <- table(validation_df$class, 
                     prediction, dnn = c("Actual","Predicted"))

# confusion matrix
fourfoldplot(performance, color = c("#CC6666", "#99CC99"),
             conf.level = 0, margin = 1, main = "Confusion Matrix")

# Method 2: Descision trees

# Method 2.1: classical descision tree
library(rpart)
set.seed(1234)

# growing the tree
dtree <- rpart(class ~ ., data = train_df, method="class",
               parms = list(split="information"))
dtree$cptable
plotcp(dtree)

# prune the tree - to handle overfitting
dtree_pruned <- prune(dtree, cp=.0125)

library(rpart.plot)
prp(dtree_pruned, type = 2, extra = 104,
    fallen.leaves = T, main = "Descision Tree")
# classifiy new cases
dtree_predict <- predict(dtree_pruned, validation_df, 
                         type = "class")

# confusion matrix
confusion_matrix <- table(validation_df$class, dtree_predict, 
                     dnn = c("Actual","Predicted"))
fourfoldplot(confusion_matrix, color = c("#CC6666", "#99CC99"),
             conf.level = 0, margin = 1, main = "Confusion Matrix")

# Method 2.2: conditional inference trees
library(party)

# growing the tree
ctree_model <- ctree(class ~ ., data = train_df)
plot(ctree_model, main="Conditional Inference Tree")

# classify new vlaues
ctree_prediction <- predict(ctree_model, validation_df, type = "response")

confusion_matrix <- table(validation_df$class, ctree_prediction,
      dnn = c("Actual", "Predicted"))
fourfoldplot(confusion_matrix, color = c("#CC6666", "#99CC99"),
             conf.level = 0, margin = 1, main = "Confusion Matrix")

# Method 3: Random forests

library(randomForest)
set.seed(1234)

# grow trees
forest_model <- randomForest(class ~ ., data = train_df,
                             na.action=na.roughfix,
                             importance = T)

# determine variable importance
importance(forest_model, type = 2)

# classify new cases
forest_pred <- predict(forest_model, validation_df)

confusion_matrix <- table(validation_df$class, forest_pred,
                          dnn=c("Actual", "Predicted"))

fourfoldplot(confusion_matrix, color = c("#CC6666", "#99CC99"),
             conf.level = 0, margin = 1, main = "Confusion Matrix")


# Method 4: Support vector machine

library(e1071)
set.seed(1234)

# try different models and make a proposition
svm_tuned <- tune.svm(class ~ ., data = train_df,
                      gamma=10^(-6:1),
                      cost=10^(-10:10))

# build support vector machine with proposed values
svm_model <- svm(class ~ ., data = train_df,
                  gamma=.01,
                  cost=1
                 )

# classify new values
svm_prediction <- predict(svm_model, na.omit(validation_df))

# confusion matrix
confusion_matrix <- table(na.omit(validation_df)$class, svm_prediction,
      dnn = c("Actual","Predicted"))
fourfoldplot(confusion_matrix, color = c("#CC6666", "#99CC99"),
             conf.level = 0, margin = 1, main = "Confusion Matrix")


