

str(HyperHuli)


cor(HyperHuli)


model <- lm(data = HyperHuli, a ~ gr)

summary(model)

library(ggplot2)

ggplot(HyperHuli) +
  geom_point(aes(gew, rrs0)) +
  geom_smooth(aes(gew, rrs0))


library(corrplot)
mcar <- cor(HyperHuli)
corrplot(mcar)

