
load("C:/Source/mas-data-science/Data Mining/titanic.raw.rdata")
summary(titanic.raw)

library(arules)

# find association rules
rules <- apriori(titanic.raw)
inspect(rules)

# we only want the rules with right hand side of survived
rules <- apriori(titanic.raw,
                   parameter = list(minlen=2, supp=0.005, conf=0.8),
                   appearance = list(rhs=c("Survived=No", "Survived=Yes"),
                                       default="lhs"),
                   control = list(verbose=F))
rules_sorted <- sort(rules, by="lift")
inspect(rules_sorted)


# find redundant rules
subset_matrix <- is.subset(rules_sorted, rules_sorted);subset.matrix
subset_matrix[lower.tri(subset_matrix, diag=T)] <- FALSE

redundant <- colSums(subset_matrix, na.rm=T) >= 1
which(redundant)

# remove redundant rules
rules_pruned <- rules_sorted[!redundant]
inspect(rules_pruned)

# Some visualization
library(arulesViz)

plot(rules)
plot(rules, method="graph", control=list(type="items"))
plot(rules, method="paracoord", control=list(reorder=TRUE))



