setwd("/Users/romeokienzler/Documents/romeo/Dropbox/arbeit/r/rkurs/2017/ex")
df= read.csv("5.tennis_encoded.csv")
#df= read.csv("5.tennis.csv")

model = rpart(play ~ .,method = "class", data=df, control= rpart.control(minsplit=3))
plot(model)
text(model)


View(df)
View(df[df$outlook=="sunny" & df$humidity=="normal",])
library(rpart)
attach(df)
x <- subset(df, select=-play)
y <- play
detach(df)
model = rpart(play ~ .,method = "class", data=df)
print(model)







model = svm(x,y,type = "C")
pred = predict(model,x)
truthVector = pred == y
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
good/(good+bad)


data(Titanic)
fit <- rpart(Survived ~ Class + Sex + Age,
             data=Titanic,
             method="class")
plot(fit)
text(fit)
View(Titanic)

tree <- rpart(Survived ~ ., data=Titanic, cp=.02)
