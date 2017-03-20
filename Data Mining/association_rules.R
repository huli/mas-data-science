
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

#http://www.rdatamining.com/examples/association-rules
