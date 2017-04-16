library(h2o)
localH2O =  h2o.init(nthreads = -1)


mfile = 'https://github.com/romeokienzler/developerWorks/raw/master/train.csv'

MDIG = h2o.importFile(path = mfile,sep=',')

# Show the data objects on the H2O platform
h2o.ls()

NN_model = h2o.deeplearning(
  x = 2:785,
  training_frame = MDIG,
  hidden = c(400, 200, 3, 200, 400 ),
  epochs = 600,
  activation = 'Tanh',
  autoencoder = TRUE
)

train_supervised_features2 = h2o.deepfeatures(NN_model, MDIG, layer=3)

plotdata2 = as.data.frame(train_supervised_features2)
plotdata2$label = as.character(as.vector(MDIG[,1]))

library(ggplot2)
qplot(DF.L3.C1, DF.L3.C2, data = plotdata2, color = label, main = 'Neural network: 400 - 200 - 2 - 200 - 400')
x = cbind(plotdata2$DF.L3.C1,plotdata2$DF.L3.C2)
y = plotdata2$label
svm_model <- svm(x,y,type = "C")
pred <- predict(svm_model,x)

table(pred,y)
truthVector = pred == y
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
good/(good+bad)


# apply PCA - scale. = TRUE is highly 
# advisable, but default is FALSE.
df = read.csv(mfile)
dfpca = prcomp(df[2:785]) 


library(xgboost)
xgboostmodel = xgboost(data = df[2:785], label = y, max_depth = 2, eta = 1, nthread = 2, nrounds = 2, objective = "binary:logistic")
