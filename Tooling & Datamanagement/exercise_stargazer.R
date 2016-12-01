
library(foreign)
library(stargazer)
library(data.table)

bmi.data <- read.dta("http://www.farys.org/daten/bmi.dta")

#?stargazer

bmi.data.part <- as.data.table(bmi.data)[,
                                         .("Alter"=alter, "Einkommen"=einkommen, "BMI"=bmi)]

# Print summary
stargazer(bmi.data.part, type="text", summary = TRUE)

# Only special columns
stargazer(bmi.data.part, type="text", summary = TRUE,
          summary.stat = c("Mean","Median","N"))

stargazer(bmi.data.part, type="latex", summary = T,
          summary.stat = c("Mean","Median","N"), out = "c:\\temp\\bmi.tex")


stargazer(bmi.data.part, type="text", summary = T,
          summary.stat = c("Mean","Median","N"),
          covariate.labels = c("Alter2","Einkommen2","BMI2"))


# library(magrittr)
# for %>% 

as.data.table(bmi.data)[!is.na(bmi)][order(-bmi)][c(1:5, (.N-4):.N)]

# Mit dpylr
library(dplyr)

stargazer(bmi.data %>% 
            select(bmi, alter, einkommen),
          type = "text"
          )

bmi.data %>%
  filter(!is.na(bmi)) %>%
  select(bmi, alter, einkommen) %>%
  arrange(-bmi) %>%
  filter(row_number()<5 | row_number()>n()-4)
