source("c:/Source/mas-data-science/Tooling & Datamanagement/Ebay/functions.R")


context("trim_cat_from_subcat")
  test_that("does work with brand only", {
    expect_that(trim_cat_from_subcat("Nokia"),  is_equivalent_to("Nokia"))
})

