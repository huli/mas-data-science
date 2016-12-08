
# Konfidenzintervall
qnorm(.975)

# Stichproble
# 1 - alpha : Konfidenzniveau
# alpha : Signifikantsniveau

expression(paste("",sigma))

# weiss 10 * 28 , = 283
# schwarz 42
# 42/283

# Praktisches Beispiel mit Reis
library(readxl)
df_reis <- read_excel("c:\\temp\\Reis16.xlsx")

# Daten mal anschauen
head(df_reis)
str(df_reis)
summary(df_reis)

# with(df_reis, {
#   n <- schwarz + weiss
# })

attach(df_reis)
n <- schwarz + weiss
p <- schwarz/n
range(p)

# Konfidenzniveau festlegen

# Signifikantsniveau
alpha <- .05

# SE (Standard error)
SE <- sqrt(p * (1-p)/n) # ist bei jeder Stichprobe anders

# Fehlerbereich (u mal die Wurzel) - Margin of error
E <- qnorm(1- alpha/2) * SE

# E ist auch Schwankungsbreite, resp. Epsilon

# Von Schätzung p wird oben und unten das Intervall abgezogen, resp. addiert
grenze_o <- p+E
grenze_u <- p-E

# Konfidenzintervalle anzeigen
plot(1:22, grenze_u, ylim = c(.07, .4), col = "red")
points(1:22, grenze_o, col = "blue")

# Wert mit grossem Konfidenzintervall:
# Kleine Stichprobe führ zu grosser Unsicherheit, resp. grossem Konfidenzintervall

# Fuer beste Schätzung alle vereinen
durchschnitt <- sum(schwarz)/sum(n)

# Linie hinzufuegen (fuer wahren Wert)
abline(h=durchschnitt)

# Interpretation: Nur eine Messung enhält den wahren Wert nicht,
# was unserem Signifikanzniveau von 5% entspricht (5% von 22 Leuten = ca. 1)
points(1:22, p, type = "b")

# Das ganze noch fuer das Total (sehr grosse Stichprobe)
p_tot <- sum(schwarz)/sum(n)
SE_tot <- sqrt(p_tot * (1-p_tot)/sum(n))
E_tot <- qnorm(1-alpha/2) * SE_tot
grenze_u_tot <- p_tot - E_tot
grenze_o_tot <- p_tot + E_tot

# Das Konfidenzintervall des Totals eintragen
abline(h = grenze_o_tot, col = "blue", lty = 3)
abline(h = grenze_u_tot, col = "blue", lty = 3)

# Six Sigma (6σ) 
# ist ein Managementsystem zur Prozessverbesserung, statistisches 
# Qualitätsziel und zugleich eine Methode des Qualitätsmanagements. Ihr Kernelement 
# ist die Beschreibung, Messung, Analyse, Verbesserung und Überwachung von 
# Geschäftsvorgängen mit statistischen Mitteln.

# Konfidenzniveau gibt sich meistens aus der Umgebung 
# (Sozialwissenschaft, Physik, Medizin)

# Beispiel
# Ein Passagier wiegt im Schnitt 70 kg
# Die Standardabweichung ist 6 kg
# Wie gross ist die Wahrscheinlichkeit, dass ein  80kg Typ kommt?
pnorm(80, 70, 6, lower.tail = FALSE)

# Standardabweichung für Mittelwert: sigma/sqrt(n)
# Varianz: sigma^2/n

# Weil ich zwei unbekannte Zahlen (sd, mean) schätzen muss, kann sich
# mein Fehler doppelt fortpflanzen und ich  muss die t-Verteilung nehmen
# (Wenn ich sd kenne, kann ich Normalverteilung nehmen)

library(MASS)
str(survey)
head(survey)

?survey

# Problem: Bestimmen Sie einen Schätzwert für die Durchschnittsgrösse
# der Studierenden aufgrund der Daten aus survey

# Schätzung aus Stichprobe
mean(survey$Height, na.rm = TRUE )

# Problem: Für die Standardabweichung der Körpergrössen der
# Studierenden gelte σ = 9.48. Bestimmen Sie den Fehlerbereich und
# die Intervallschätzung der durchschnittlichen Körgergrösse bei einem
# Konfidenzniveau von 95%.

height_response <- na.omit(survey$Height)
n <- length(height_response) # Anzahl Stichproben
sigma <- 9.48 # Standardabweichung wurde angegeben
sem <- sigma/sqrt(n) # Standardfehler des Mittelwerts
# Wir arbeiten wieder mit Konfidenzniveau 95%
qnorm(.975)
# -> 1.96
E <- qnorm(.975) * sem
# Zum Schätzwert hinzuzählen
xbar <- mean(height_response)
xbar + c(-E, E)
# -> Wahrer Wert wird zu 95% Sicherheit mit diesem Intervall überdeckt

# Antwort: Bei einer Standardabweichung σ = 9.48 und einem
# Konfidenzniveau von 95% beträgt der Fehlerbereich 1.2852 cm. Der
# wahre durchschnittliche Körpergrösse wird vom Konfidenzintervall
# [171.10; 173.67] mit einer Wahrscheinlichkeit von 95% überdeckt.

library(TeachingDemos)
?TeachingDemos

z.test(height_response, sd=9.48)
# 95 percent confidence interval:
#   171.0956 173.6661
# sample estimates:
#   mean of height_response 
# 172.3809 

# Ueblicherweise weiss man die Standardabweichung aber nicht
# Deshalb schaetzen wir diese auch als Stichprobe
# Hinweis: Formel für korrigierte Varianz nehmen

# Ich nehme die t-Verteilung, da ich die zweite Unschärfe (sd)
# auch kompensieren muss

# Problem: Bestimmen Sie für die durchschnittliche Körpergrösse den
# Fehlerbereich und die Intervallschätzung der durchschnittlichen
# Körgergrösse bei einem Konfidenzniveau von 95%.

# Standardabweichung bestimmen
s <- sd(height_response)
# Hinterer Teil der Formel (Standard error)
SE <- s/sqrt(n)
E <- qt(.975) * SE
# brauch den Degree of Freedom
E <- qt(.975, df=n-1) * SE
xbar + c(-E,E)

# Intervall ist etwas breiter, da wir zwei Dinge 'schätzen' mussten

# Hinweis: Auf natürliche Positionen runden! (Statistiker halten Daumen auf Nachkommastellen)
# Geschätzer Mittelwert = Mittelwert bestummen aus der Stichprobe

# Mit TeachingDemos
t.test(height_response)
# Konfidenzniveau kann auch ueberschrieben werden
# t.test(height_response, conf.level = .5)


