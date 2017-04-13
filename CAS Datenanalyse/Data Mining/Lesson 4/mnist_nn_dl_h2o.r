library(h2o)


#localH2O =  h2o.init(nthreads = -1, port = 54321, startH2O = FALSE)
localH2O =h2o.init(nthreads = -1)
MNIST_DIGITS = read.csv( 'https://github.com/romeokienzler/developerWorks/raw/master/train.csv' )
par( mfrow = c(10,10), mai = c(0,0,0,0))
for(i in 1:100){
  y = as.matrix(MNIST_DIGITS[i, 2:785])
  dim(y) = c(28, 28)
  image( y[,nrow(y):1], axes = FALSE, col = gray(255:0 / 255))
  text( 0.2, 0, MNIST_DIGITS[i,1], cex = 3, col = 2, pos = c(3,4))
}
mfiletrain = 'https://github.com/romeokienzler/developerWorks/raw/master/train.csv'
mfiletest =  'https://github.com/romeokienzler/developerWorks/raw/master/train.csv'

MDIGtrain = h2o.importFile(path = mfiletrain,sep=',')
MDIGtest = h2o.importFile(path = mfiletest,sep=',')

model = h2o.deeplearning(x = 2:785, y = 1, training_frame = MDIGtrain, 
                         activation = "Tanh", hidden=rep(160,5),
                         epochs = 20)

predictions = h2o.predict(object = model, newdata = MDIGtest[,-1])
predictions.df <- as.data.frame(predictions)
test.df <- as.data.frame(MDIGtest)


truthVector = test.df$label == as.integer(round(predictions.df[,1]))
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
good/(good+bad)

#SPLIT
sample <- sample.int(nrow(MNIST_DIGITS), floor(.75*nrow(MNIST_DIGITS)), replace = F)
MNIST_DIGITStrain <- MNIST_DIGITS[sample, ]
MNIST_DIGITStest <- MNIST_DIGITS[-sample, ]
#write.csv(MNIST_DIGITStrain,"train.csv")
#write.csv(MNIST_DIGITStest,"test.csv")

