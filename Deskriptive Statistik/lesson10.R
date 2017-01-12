
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
