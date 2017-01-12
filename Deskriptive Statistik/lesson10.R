
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
abline(lm(faithful$eruptions ~ faithful$waiting))

