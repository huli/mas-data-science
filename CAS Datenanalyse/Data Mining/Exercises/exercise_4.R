
# 
# Aufgabe 4
# 
# 1. Implement a function calculating the weighted empirical error for the MNIST classification exercise
# 2. Have a look at the 1st slide titeled "In this lecture, we will cover..." of decision trees and list reasons why the presented flow chart is not a arborescence tree.
#    https://en.wikipedia.org/wiki/Tree_(graph_theory)
# 3. Implement an MNIST classifier using either RandomForrest or Gradient Boosted Trees (XGBOOST)
# 4.
#   a) Reduce the dimensionality of the MNIST data set using a neural network autoencoder and call it R
#   
#   b) train a ML model on R' and compare precision to the full dimensional data set
#   
#   c) what is the optimal number of reduced dimensions to maximise precision? (e.g. implement a loop over dimensions (or other relevant hyper-parameters) in e.g. "monte-carlo" style)



mnist_matrix = read.csv( 'https://github.com/romeokienzler/developerWorks/raw/master/train.csv' )

empiricalError <- function(){
  
}