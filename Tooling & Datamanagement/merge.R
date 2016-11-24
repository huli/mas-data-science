
name <- c("Rudi","Simon","Daniela","Viktor")
geschlecht <- c("Mann", "Mann", "Frau","Mann")
daten1 <- data.frame(name, geschlecht)

name <- c("Johanna","Rudi","Simon","Daniela")
alter <- c(33,32,38,45)
daten2 <- data.frame(name, alter)

daten1
daten2

# klassisch
merge(daten1, daten2, by="name") # entspricht inner_join)

# oder über match()
# daten1$alter <- daten2$alter[match(daten1$name,daten2$name)] # entspricht left_join

library(dplyr)

# mit dplyr
inner_join(daten1,daten2,by="name")
left_join(daten1,daten2,by="name")
right_join(daten1,daten2,by="name")
full_join(daten1,daten2,by="name")

# mit data.table
daten1 <- as.data.table(daten1)
daten2 <- as.data.table(daten2)
setkey(daten1, name)
setkey(daten2, name)
daten1[daten2]
daten2[daten1]

# rbind / zeilenweise verknüpfen von Daten
name <- c("Rudi","Simon","Daniela","Viktor")
geschlecht <- c("Mann", "Mann", "Frau","Mann")
daten1 <- data.frame(name, geschlecht)

name <- c("Johanna","Ralf")
geschlecht <- c("Frau","Mann")
daten2 <- data.frame(name, geschlecht)

rbind(daten1,daten2)

# rbind() ist sehr langsam. Besser ist rbindlist() aus data.table
rbindlist(list(daten1,daten2))
