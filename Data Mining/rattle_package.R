

library(rattle)

loc <- "http://archive.ics.uci.edu/ml/machine-learning-databases/"
ds <- "pima-indians-diabetes/pima-indians-diabetes.data"
url <- paste(loc, ds, sep = "")
diabetes_data <- read.table(url, sep = ",", header = F)
names(diabetes_data) <- c("npregnant", "plasma","bp", "triceps", "insulin",
                          "bmi", "pedigree", "age", "class")
diabetes_data$class <- factor(diabetes_data$class, levels = c(0,1),
                              labels=c("normal", "diabetic"))
rattle()
