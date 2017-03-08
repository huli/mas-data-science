

library(ggplot2)
library(openxlsx)
library(dplyr)


assessments <- read.xlsx("C:/Users/ch0125/Dropbox/Assessments/assessments.xlsx")

assessments_df <- assessments[2:nrow(assessments),]
names(assessments_df) <- c("bewerber","tests_done","minutes")

assessments_df %>% 
  dplyr::mutate(tests_per_minute = as.numeric(tests_done)/as.numeric(minutes)) %>% 
  dplyr::mutate(minutes_per_test = as.numeric(minutes)/as.numeric(tests_done)) -> 
  assessments_eval

assessments_eval %>% 
  ggplot(aes(factor(bewerber), tests_per_minute*10, fill=bewerber)) +
  geom_bar(stat = "identity") +
  geom_hline(yintercept = mean(assessments_eval$tests_per_minute)*10, color="darkgray") +
  geom_hline(yintercept = median(assessments_eval$tests_per_minute)*10,
                                 linetype="dotdash", color="darkgray") +
  scale_fill_brewer(palette = 2) +
  geom_text(aes(.6,median(assessments_eval$tests_per_minute)*10+.01), label = "median",
            color="darkgray", size=3)+
  geom_text(aes(.6,mean(assessments_eval$tests_per_minute)*10+.01), label = "mean",
            color="darkgray", size=3)  ->
  overview

overview 

pdf("C:/Users/ch0125/Dropbox/Assessments/overview.pdf")
overview
dev.off()

