library(png)

# function to calculate brightness values
brightness <- function(hex) {
  v <- col2rgb(hex)
  sqrt(0.299 * v[1]^2 + 0.587 * v[2]^2 + 0.114 * v[3]^2) /255
}

# given a color ramp, map brightness to ramp also taking into account 
# the alpha level. The defaul color ramp is grey
#
img_to_colorramp <- function(img, ramp=grey) {
  cv <- as.vector(img)
  b <- sapply(cv, brightness)
  g <- ramp(b)
  a <- substr(cv, 8,9)     # get alpha values
  ga <- paste0(g, a)       # add alpha values to new colors
  img.grey <- matrix(ga, nrow(img), ncol(img), byrow=TRUE)  
}

# read png and modify
img <- readPNG(system.file("img", "Rlogo.png", package="png"))
img <- as.raster(img)           # raster multilayer object
r <- nrow(img) / ncol(img)      # image ratio
s <- 2                        # size

plot(c(0,10), c(0,3.5), type = "n", xlab = "", ylab = "", asp=1)

rasterImage(img, 0, 0, 0+s/r, 0+s)  # original
img2 <- img_to_colorramp(img)       # modify using grey scale
rasterImage(img2, 5, 0, 5+s/r, 0+s)

# load file from web
# download.file("http://i.imgur.com/A14ntCt.png", "C:/temp/glass.png")

img <- readPNG("C:/temp/glass.png")
img <- as.raster(img)
r <- nrow(img) / ncol(img)
s <- 1

# let's create a function that returns a ramp function to save typing
ramp <- function(colors) 
  function(x) rgb(colorRamp(colors)(x), maxColorValue = 255)

# create dataframe with coordinates and colors
set.seed(1)
x <- data.frame(x=rnorm(16, c(2,2,4,4)), 
                y=rnorm(16, c(1,3)), 
                colors=c("black", "darkred", "garkgreen", "darkblue"))

plot(c(1,6), c(0,5), type="n", xlab="", ylab="", asp=1)
for (i in 1L:nrow(x)) {
  colorramp <- ramp(c(x[i,3], "white"))
  img2 <- img_to_colorramp(img, colorramp)
  rasterImage(img2, x[i,1], x[i,2], x[i,1]+s/r, x[i,2]+s)
}
