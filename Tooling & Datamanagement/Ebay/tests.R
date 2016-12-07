
library(testthat)

string <- "testin is fun"
expect_that(string, matches("Te"))
