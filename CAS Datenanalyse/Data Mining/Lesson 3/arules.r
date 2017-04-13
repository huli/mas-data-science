library(arules)

# ETL START

# set working directory
setwd('/Users/romeokienzler/Documents/romeo/Dropbox/arbeit/r/rkurs/2017/arules')

# read file
transactions <- readLines("groceries.csv")

# turn comma into array separator
out <- strsplit(transactions, split = ',')

# create unique list of articles
articles <- data.frame(unique(unlist(out)))

# set meta information on data frame
names(articles) <- c("articles'")

# creation of a matrix having item names as columns

# creating matrix with 0 as Default with dim (transactions, number_of_items)
m <- matrix(c(0), nrow=length(transactions), ncol=nrow(articles))
colnames(m) <- articles[,]

# fill in the file contents to the matrix

fill_matrix <- function(matrix, transactions) {
  tx_id = 1
  for (tr in transactions) {
    item <- strsplit(tr, split = ',')
    for (i in item) {
      matrix[tx_id, i] = 1
    }
    tx_id = tx_id + 1
  }
  return(matrix)
}


binary_matrix <- fill_matrix(m, transactions)

str(binary_matrix)
dim(binary_matrix)
head(binary_matrix)

# ETL STOP

# APRIORI
rules <- apriori(binary_matrix, parameter = list(supp = 0.05, conf = 0.1, target = "rules", maxlen=2))
inspect(rules)

# ECLAT
rawRules  <- eclat(binary_matrix, parameter = list(support = 0.0008))
rules <- ruleInduction(rawRules)
inspect(rules)
