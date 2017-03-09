library("e1071")
head(iris,5)
attach(iris)
x <- subset(iris, select=-Species)
y <- Species
x
y
svm_model <- svm(x,y)
summary(svm_model)

pred <- predict(svm_model,x)
table(pred,y)


