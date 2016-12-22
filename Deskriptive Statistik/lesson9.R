
# Problem: Ein Hersteller von Glühbirnen behauptet eine
# Mindestlebensdauer von 100000 Stunden für seine Glühbirnen. Der
# Mittelwert einer Stichprobe aus 30 Glühbirnen ergab einen
# Stichprobenmittelwert von 90900 Stunden. Die Standardabweichung
# der Population beträgt 120 Stunden. Können wir bei einem
# Signifikanzniveau von 5% die Behauptung des Herstellers verwerfen?


# Wie gross müsste kritische, untere Grenze sein

# Ich will den z-Wert
qnorm(.05, mean = 10000, sd=120/sqrt(30)) # sqrt(30) ist in dieser Hinsicht den Standardfehler

# (Ich muss daran denken, dass es hier um eine Normalverteilung von Mittelwerten geht und
# ich den Standardfehler abziehen muss)

# [1] 9963.963
# (Wenn ich eine Stichprobe von n Birnen untersuche und der Mittelwert ist unterhalb dieses
# Wert, dann muss ich die Nullhypothese verwerfen)

# Wahrscheinlichkeit rechen wir mit pnorm aus
pnorm(9900, mean = 10000, sd = 120/sqrt(30))
# [1] 2.505166e-06   (Dieses Ergebnis hat die Wahrscheinlichkeit von ca. 2.5 Millionstel)

library(TeachingDemos)
z.test(9900, mu = 10000, stdev = 120, n = 30, alternative = "less")

# alternative hypothesis: true mean is less than 10000
# R nimmt an, der Mittelwert wäre 9900 und berechnet für diesen den Konfidenzintervall
# und wenn unser Wert nicht darin ist, wird abgelehnt
# Es ist eigentlich das Konfidenzintervall für die mittlere Brenndauer ausgehend
# von der Stichprobe 




