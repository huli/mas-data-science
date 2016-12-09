
trim_cat_from_subcat <- function(subcat){
  str_match(subcat, "[A-Za-z]")
    #str_match(subcat, "[A-Za-z0-9]*\\s[A-Za-z0-9]*")
}