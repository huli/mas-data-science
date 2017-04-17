
library(ggplot2)

# fall ein wuerfel (gleichverteilung)
wuerfe <- sample(1:6, 1000, replace = T)
ggplot(data.frame(wuerfe)) +
  geom_histogram(aes(x=factor(wuerfe)), stat = "count")


# fall zwei wuerfel (normalverteilung um erwartungswert)
wuerfe <- sample(1:6, 10000, replace = T) + sample(1:6, 1000, replace = T)
ggplot(data.frame(wuerfe)) +
  geom_histogram(aes(x=factor(wuerfe)), stat = "count")

# das ganze mit zufallszahlen [-1,1]
zahlen <- runif(100, min = -1, max = 1)
ggplot(data.frame(zahlen)) +
  geom_histogram(aes(x=zahlen))

# vorgehen her
zahlen <- c(runif(100, min = -1, max = 1), 
            runif(100, min = -1, max = 1), 
            runif(100, min = -1, max = 1), 
            runif(100, min = -1, max = 1), 
            runif(100, min = -1, max = 1), 
            runif(100, min = -1, max = 1), 
            runif(100, min = -1, max = 1), 
            runif(100, min = -1, max = 1), 
            runif(100, min = -1, max = 1),
            runif(100, min = -1, max = 1))
ggplot(data.frame(zahlen)) +
  geom_histogram(aes(x=zahlen))

# vorgehen me
zahlen <- runif(100, min = -1, max = 1) + 
  runif(100, min = -1, max = 1) + 
  runif(100, min = -1, max = 1) + 
  runif(100, min = -1, max = 1) + 
  runif(100, min = -1, max = 1) + 
  runif(100, min = -1, max = 1) + 
  runif(100, min = -1, max = 1) + 
  runif(100, min = -1, max = 1) + 
  runif(100, min = -1, max = 1) +
  runif(100, min = -1, max = 1)
ggplot(data.frame(zahlen)) +
  geom_histogram(aes(x=zahlen))



# mit direkt 1000 zahlen geht es nicht
zahlen <- runif(1000, min = -1, max = 1)
ggplot(data.frame(zahlen)) +
  geom_histogram(aes(x=zahlen))


