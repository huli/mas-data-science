


library(ggplot2)
library(readxl)

library(readxl)
Geburten_Todesfaelle_1993_2016 <- read_excel("C:/Users/ch0125/Dropbox/BFH/CAS Data Visualization/03-DARSTELLUNGSMODELLE_HAHN/Geburten_Todesfaelle_1993_2016.xlsx")
View(Geburten_Todesfaelle_1993_2016)


ggplot(Geburten_Todesfaelle_1993_2016) + 
  geom_point(aes(Geburten_Todesfaelle_1993_2016$Geburten, Geburten_Todesfaelle_1993_2016$Todesfälle)) + 
  geom_smooth(aes(Geburten_Todesfaelle_1993_2016$Geburten, Geburten_Todesfaelle_1993_2016$Todesfälle), 
              method = "lm")




df <- Geburten_Todesfaelle_1993_2016

serie <- df[df$X__1 == "Affoltern", ]


install.packages("shape")


library(shape)

emptyplot(main = "Arrowhead")
Arrowhead(x0 = runif(10), y0 = runif(10), angle = runif(10)*360,
          arr.length = 0.3, arr.type = "circle", arr.col = "green")
Arrowhead(x0 = runif(10), y0 = runif(10), angle = runif(10)*360,
          arr.length = 0.4, arr.type = "curved", arr.col = "red")
Arrowhead(x0 = runif(10), y0 = runif(10), angle = runif(10)*360,
          arr.length = runif(10), arr.type = "triangle",
          arr.col = rainbow(10))


plot(serie$Geburten)
arrows(serie$Geburten)


plot(c(1:10))
arrows(0,0,10,10)


x <- stats::runif(12); y <- stats::rnorm(12)
i <- order(x, y); x <- x[i]; y <- y[i]
plot(x,y, main = "arrows(.) and segments(.)")
## draw arrows from point to point :
s <- seq(length(x)-1)  # one shorter than data
arrows(x[s], y[s], x[s+1], y[s+1], col = 1:3)
s <- s[-length(s)]
segments(x[s], y[s], x[s+2], y[s+2], col = "pink")



install.packages("flowfield")
library(flowfield)
library(SemiPar)
data(lidar)
t <- lidar$range
y <- lidar$logratio
steps <- 10 # number of forecast steps (steps must be 10 or less)
flowfield(t,y,steps,TRUE)






