

rm(list=ls())

library(ggplot2)
library(dplyr)

randomWalk <- function(n, start = 10){
  white <- rnorm(n)
  t <- 1:n
  y <- vector(mode = "double")
  y[1] <- start #start
  for (i in 2:n) {
    y[i] <- y[i-1] + white[i]
  }
  data.frame(noise = white, y = y, t = 1:n)
}

walks <- list()
for(i in 1:4) walks[[i]] <- randomWalk(20)

bind_rows(walks, .id = "id") %>% 
  mutate(walk = paste("Random Walk", id)) %>% 
  ggplot(aes(x=t,y=y,group=1)) +
  geom_point() + 
  geom_line() +
  facet_wrap(~walk)
