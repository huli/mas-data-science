#12.3.2

#2
x <- c(rep(1:5, 10))
x

#3
y <- c(x[12],x[20],x[50])
y

y2 <- x[c(12, 20, 50)]
y2

identical(c(x[12],x[20],x[50]), x[c(12, 20, 50)])

#4
freunde <- c("Herbert", "Stefan", "Roland")
freunde

#identical(c(rep(1:5, 10)),rep(1:5, 10))
x <- c(a=10, b=20, c=30)
cbind(x,x)
rbind(x,x)

x = 1:100
x

y = x[0:10]
y

z = x[91:100]
z

cbind(y,z)

class(cbind(y,z))

x.sub <- x[x<11 | x >91]
x.sub

as.character(c(1,2,3,4))

