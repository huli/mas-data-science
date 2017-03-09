
## Uebung 3 - Classification
## Das MNIST Datenset ist sozusagen das HelloWorld Program wenn es um Classification mit DeepLearning
## geht. Wir missbrauchen hier dieses Datenset für traditionelle Classification.
## 1. Führen Sie u.g. Source Code aus und beantworten Sie folgende Fragen
##a) Wieviele Bilder sind in der Matrix mnist_matrix encodiert
# 42'000

##b) Da es sich um einen Supervised Machine Learning task handelt muss ein Label (Target Variable)
##bereitgestellt sein - welche Spalte der Matrix enthält das Label?
# Spalte: label (1)

##c) Wieviele Pixel haben die Bilder?
# 784
##d) Wie hoch/breit sind die Bilder?
# 28x28

# Imported code
mnist_matrix = read.csv( 'https://github.com/romeokienzler/developerWorks/raw/master/train.csv' )
dim(mnist_matrix)
sort(unique(mnist_matrix[,1]))

View(mnist_matrix[1,])

par( mfrow = c(10,10), mai = c(0,0,0,0))
for(i in 1:100){
  y = as.matrix(mnist_matrix[i, 2:785])
  dim(y) = c(28, 28)
  image( y[,nrow(y):1], axes = FALSE, col = gray(255:0 / 255))
  text( 0.2, 0, mnist_matrix[i,1], cex = 3, col = 2, pos = c(3,4))
}

# First, we make the 
# split the data set training and validation set
# We take 2/3 vs 1/3
training_size <- dim(mnist_matrix)


##2. Nehmen Sie einen Classifier Ihrer Wahl und trainieren Sie Ihn mit der bereitgestellten Matrix.
##a) Teilen Sie die Matrix in ein sinnvolles Training und Test set auf, lesen Sie hierzu diesen
##Thread: http://stats.stackexchange.com/questions/19048/what-is-the-difference-between-test-set-and-validation-set
##(Ein Validation Set wird hier nicht benötigt da nicht erwartet wird Parameter des
##Classifiers zu tunen)
##b) Verwenden Sie nun das Training Set um einen Classifier Ihrer Wahl zu trainieren
##c) Berechnen Sie den Prozentsatz der richtig klassifizierten Daten indem Sie Ihren
##trainierten Classifier auf das Test Set anwenden (Hinweis: Die Qualität des Classifiers
##wird nicht bewertet)