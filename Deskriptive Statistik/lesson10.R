
# Testen von Abhängigkeiten in der Population aufgrund einer Stichprobe

# Beispiel 38: Testen des Zusammenhangs zwischen zwei nominalen
# Merkmalen

ab <- matrix(c(110, 120, 20, 30, 20, 90, 60, 30, 10, 10), nrow = 2, 
             byrow = TRUE)
rownames(ab) <- c("weiblich", "männlich")
colnames(ab) <- c("A","B","C","D","E")

# Damit das alles funktioniert, sollte jedes Spaltentotal
# grösser als 4 sein

chisq.test(ab)
## p-value = 0.001204 -> Kleiner als Konfidenzintervall
## H0 wird verworfen

# Zur Kontrolle noch Grenze bestimmen
qchisq(.95, df = 4)


# Testen einer Verteilungsform / Anpassungstest
# Hinterfragung von Verteilungen

# Beispiel 39

# Überprüfung auf einem Signifikanzniveau α = 0,05, ob das Gewicht von
# Zuckerpaketen nicht normalverteilt ist.
# Stichprobe: n = 100, x 999,93 = , s2 = 0,25
# Beobachtete relative Häufigkeiten (zur Vereinfachung der Darstellung nur
#                                    4 Intervalle):
#   Intervall relative Häufigkeit pib
        # unter 999,5       0,2
        # [999,5; 1.000]    0,32
        # [1.000; 1.000,5]  0,34
        # über 1.000,5      0,14


mu <- 999.93

# Welcher Anteil ist kleiner als 999.5
pnorm(999.5, mean = mu, sd = .5)
## [1] 0.1948945

pnorm(1000, mean = mu, sd = .5) -
  pnorm(999.5, mean = mu, sd = .5)
## [1] 0.3607755

pnorm(1000.5, mean = mu, sd = .5) -
  pnorm(1000, mean = mu, sd = .5)
## [1] 0.3171868

pnorm(1000.5, mean = mu, sd = .5, lower.tail = F)
## [1] 0.1271432

tab <- matrix(c(.2, .32, .34, .14, .1949, .3608, .3172, .1271), nrow = 2, byrow = T)

# Achtung, nun in Stuecken
chisq.test(tab[1,] * 100, p = tab[2,])

# oder
chisq.test(c(20, 32, 34, 14), p = c(.1949, .3608, .3172, .1271))

## So testet auch Steuerverwaltung auf Verteilung von zahlen
## https://en.wikipedia.org/wiki/Benford's_law

# Testen von Hypothesen über einen statistischen Zusammenhang
# zweier metrischer Merkmale

# Aufgabe: Fundierte Entscheidung zwischen zwei konkurrierenden 
# Unterstellungen über den Zusammenhang zweier metrischer Merkmale

# Again: lateinische Buchstaben für Stichproben, griechische für Population

# Beschreibende Statistik
cor(faithful$eruptions, faithful$waiting)

# Wir betrachten jetzt aber eine Stichhprobe und wollen Aussagen 
# über die Grundgesammtheit machen

cor.test(faithful$eruptions, faithful$waiting)
# -> H0 wird verworfen

# Für nicht metrische Werte
# method = c("pearson", "kendall", "spearman"),

plot(faithful$waiting, faithful$eruptions)
abline(lm(eruptions ~ waiting, data = faithful))

# Wenn man fuer zweite Wolke ein zweites Modell machen würde
abline(lm(eruptions ~ waiting, data = faithful[faithful$waiting > 70,]), lty = 3)
abline(lm(eruptions ~ waiting, data = faithful[faithful$waiting <= 70,]), lty = 3)

library(ggplot2)
ggplot(data = faithful, aes(waiting, eruptions)) +
  geom_point() +
  # stat_smooth()
  stat_smooth(method = "lm")

eruptions_lm <- lm(eruptions ~ waiting, data = faithful)
summary(eruptions_lm)

coeffs <- coefficients(eruptions_lm)

# Intercepts = Schnittpunkt y-Achse
# Variable = Steigung
# Residum = Fehlerterm = Abstand vonabline(lm(eruptions ~ waiting, data = faithful[faithful$waiting > 70,]))

plot(faithful$waiting, faithful$eruptions)
abline(coeffs[1], coeffs[2])

# Eruptionszeit berechnen bei Wartezeit
waiting <- 80
coeffs[2] * waiting + coeffs[1]

# Mit predict von R
data_frame <- data.frame(waiting = 90)
predict(eruptions_lm, newdata = data_frame)

# Bestimmtsheismass
# (Hut, resp. ^ weisst immer auf vorhergesagte Werte, Modellwerte hin)

# Bei der linearen Regression entspricht das Bestimmtheitsmass
# dem Quadrat des Korrelationskoeffizienten.
summary(eruptions_lm)
## Multiple R-squared:  0.8115
## Adjusted R-squared rechnet noch die Stichprobengrösse mit ein
## -> 81% der Schwankungen können wir durch die Variable waiting erklären

# Achtung, da es im Quadrat ist und die Faustregel >= 0.6 als stark beurteilt,
# muss hier bereits ab .36 (6*6) herbeiführen

# Signifikanztests
# waiting      0.075628   0.002219   34.09   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# Ist 0.0756 signifikant? p-Wert sagt <2e-16 -> Ja

# Std Error oben und unten dazu gibt Konfidenzintervall von Steigung und Schnittpunkt
# Da 0 nicht möglich ist gemäss dieser Berechnung, ist auch p-Wert Signifikant

# Intercept macht keine Aussage über die Qualität des Modells
# Je nach Modell, wären das zum Beispiel die Fixkosten

# Konfidenzintervalle
predict(eruptions_lm, newdata = data_frame, interval = "confidence")

# Wenn mich nicht der Mittelwert interessiert, sonder der einzelne
predict(eruptions_lm, newdata = data_frame, interval = "predict")

# Die Abweichungen vom Vorausgesagten Wert plotten
eruptions_rests <- resid(eruptions_lm)
plot(faithful$waiting, eruptions_rests)
abline(0,0)

# Muster dürfte eigentlich nicht sein
# Müsste unkorreliert und gleichverteilt sein
# (Gleichmässig verteilt, überall gleiche Bandbreite)

# Wir wollen überprüfen ob die Residuen wirklich normalverteilt sind
# (Plot Normal Q-Q)
plot(eruptions_lm, which = 2)

# Oder alle anschauen
plot(eruptions_lm)



