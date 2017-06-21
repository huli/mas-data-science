

install.packages("http://www.ovgu.de/vwl3/desk/desk_1.0.1.zip", repos = NULL, type = "binary")

rm(list = ls())

y <- c(4,1,3,2,7) 
x1 <- c(3,5,7,4,2) 
x2 <- c(-3,-8,6,-4,10) 

library(desk)
model_est <- ols(y ~ x1 + x2)
t.coef.test(model_est, nh = c(0,1,1), q = 0, dir = "both", sig.level = 0.05)

model_test <- t.coef.test(model_est, nh = c(0,1,1))
plot(model_test)
