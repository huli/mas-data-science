

library(ggplot2)

qplot(wt, mpg, data = mtcars)

transmission = factor(mtcars$am)