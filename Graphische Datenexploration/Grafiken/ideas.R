
# tag cloud
library(tagcloud)
library( extrafont )
library(RColorBrewer)
tags <- sample( fonts(), 50 )
weights <- rgamma( 50, 1 )
colors <- colorRampPalette( brewer.pal( 12, "Paired" ) )( 50 )
tagcloud( tags, weights= weights, col= colors )


# stacked area graph
library(ggplot2)

# DATA
set.seed(345)
Sector <- rep(c("S01","S02","S03","S04","S05","S06","S07"),times=7)
Year <- as.numeric(rep(c("1950","1960","1970","1980","1990","2000","2010"),each=7))
Value <- runif(49, 10, 100)
data <- data.frame(Sector,Year,Value)

ggplot(data, aes(x=Year, y=Value, fill=Sector)) + 
  geom_area()

ggplot(data, aes(x=Year, y=Value, fill=Sector)) +
  geom_area(colour="black", size=.2, alpha=.4) +
  scale_fill_brewer(palette="Greens", breaks=rev(levels(data$Sector)))
