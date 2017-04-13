
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

# Problem: Ein Produzent von Keksen behauptet, dass seine Produkte
# ein Höchstanteil an gesättigten Fettsäuren von 2 g pro Keks enthalten.
# In einer Stichprobe von 35 Keksen wurde ein Mittelwert von 2:1 g
# gemessen. Nehmen Sie eine Standardabweichung von 0:25 g an.
# Kann die Behauptung bei einem Signifikanzniveau von 5% verworfen
# werden?

# Ohne Standardisierung
qnorm(.95, mean = 2, sd = 0.25/sqrt(35))
# [1] 2.069508

# Wie wahrscheinlich ist das Testergebnis
# p-Wert -> 0.009
pnorm(2.1, mean = 2, sd = .25/sqrt(35), lower.tail = FALSE)

# Ueber Konfidenzintervall der Stichprobe
z.test(2.1, stdev = .25, mu = 2, n = 35, alternative = "greater")


# Zweiseitiger Test -> Veränderung -> alpha/2

# Problem: Das durchschnittliche Gewicht von antarktischen
# Königspinguinen einer bestimmten Kolonie betrug im letzten Jahr
# 15:4 kg. Eine Stichprobe von 35 Pinguinen derselben Kolonie zeigte
# ein Durchschnittsgewicht von 14.6 kg. Die Standardabweichung der
# Population beträgt 2.5 kg. Lässt sich die Behauptung, dass sich das
# Durchschnittsgewicht nicht verändert hat, bei einem Signifikanzniveau
# von 5% verwerfen?

qnorm(c(.025, .975), mean = 15.4, sd = 2.5/sqrt(n))

pnorm(14.6, mean = 15.4, sd = 2.5/sqrt(n))
# [1] 0.02916926 (allerdings mal zwei, da beidseitig)
# lower.tail = FALSE hätte man nehmen müssen wenn man oben vergleicht

# automatisierter p-Wert
# pval = 2*ifelse(z < 0, pnorm(z), pnorm(z, lower.tail=FALSE))
# pval = 2*ifelse((xbar < 15.4) < 0, pnorm(z), pnorm(z, lower.tail=FALSE))

# Problem: Ein Hersteller von Glühbirnen behauptet eine
# Mindestlebensdauer von 100000 Stunden für seine Glühbirnen. Der
# Mittelwert einer Stichprobe aus 30 Glühbirnen ergab einen
# Stichprobenmittelwert von 9900 Stunden. Die
# Stichprobenstandardabweichung beträgt 120 Stunden. Können wir bei
# einem Signifikanzniveau von 5% die Behauptung des Herstellers
# verwerfen?

xbar = 9900
mu0 = 10000
s = 120
n = 30

# FALSCH, da t-Verteilung wäre: qnorm(.05, mean = 10000, sd = 120/sqrt(30), lower.tail = T)
qt(.05, df = 29) 
# [1] -1.699127 (Gibt mir die Anzahl der Standardfehler an, die ich nach links muss)
# Bedeutung von t oder z Wert ist die Anzahl von Standardfehlern
120/sqrt(30)
# [1] 21.9089
21.9 * 1.7
10000-37.23
# [1] 9962.77

# Oder direkt
mu0 + qt(0.05, 29) * 120/sqrt(30)

# resp. mit R
x <- scan("C:\\Source\\mas-data-science\\Deskriptive Statistik\\lightbulbs.txt")

t.test(x, mu = 10000, conf.level = .95, alternative =  "less")
# t = -4.9183, df = 29, p-value = 1.592e-05
# t-Wert -> 5 Standardfehler nach unten müsste man für diesen Wert
# Wenns um Mittelwerte geht ist der Standartfehler das gleiche wie 
# bei einzelwerten die Standardabweichung

# Problem: Ein Produzent von Keksen behauptet, dass seine Produkte
# ein Höchstanteil an gesättigten Fettsäuren von 2 g pro Keks enthalten.
# In einer Stichprobe von 35 Keksen wurde ein Mittelwert von 2:1 g
# gemessen. Die Stichprobenstandardabweichung betage 0:3 g. Kann
# die Behauptung bei einem Signifikanzniveau von 5% verworfen
# werden?


x <- scan("C:\\Source\\mas-data-science\\Deskriptive Statistik\\cookies.txt")

t.test(x, mu = 2, conf.level = .95, alternative = "greater")

# 
# Problem: Das durchschnittliche Gewicht von antarktischen
# Königspinguinen einer bestimmten Kolonie betrug im letzten Jahr
# 15:4 kg. Eine Stichprobe von 35 Pinguinen derselben Kolonie zeigte
# ein Durchschnittsgewicht von 14:6 kg. Die
# Stichprobenstandardabweichung beträgt 2:5 kg. Lässt sich die
# Behauptung, dass sich das Durchschnittsgewicht nicht verändert hat,
# bei einem Signifikanzniveau von 5% verwerfen?

x <- scan("C:\\Source\\mas-data-science\\Deskriptive Statistik\\penguins.txt")

t.test(x, mu = 15.4, conf.level = .95, alternative = "two.sided")


# Problem: Die Wahlbeteiligung an den letzten Wahlen betrug 60%. Eine
# telefonische Umfrage ergab, dass 85 von 148 Befragten angaben, an
# den kommenden Wahlen teilzunehmen. Lässt sich die Hypothese,
# dass die kommende Wahlbeteiligung über 60% liegt, bei einem
# Signifikanzniveau von 5% verwerfen?

prop.test(x = 85, n = 148, p = .6, alternative = "less", correct = FALSE)
# Warum correct = FALSE: Da wir ein diskretes Merkmal auf eine stetige Abbildung
# machen, kann das zu Verzerrungen führen und deshalb bei händischer Nachrechnung
# zu anderen Ergebnissen führt (continuity correction)
# Wird beibehalten

# Problem: Das Dataframe immer zeigt die Gerstenernte von sechs
# unterschiedlichen Feldern in den Jahren 1931 bis 1932.
# Wir nehmen an, dass die Erntemengen normalverteilt sind. Schätzen
# Sie mit einem 95%-Konfidenzintervall die Differenz zwischen den
# beiden Jahresdurchschnitten.

library(MASS)
?immer

t.test(immer$Y1, immer$Y2, paired = T)
# Wahre Differenz kann nicht 0 sein, was sich ?auch im p-value wiederspiegelt
# -> wir verwerfen die 0-Hypothese

?mtcars

# Verbrauchen Autos mit Automatikgetriebe mehr Benzin?

t.test(mpg ~ am, data = mtcars)
# Nullhypothese wird auch verworfen