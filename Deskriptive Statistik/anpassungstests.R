
# Problem: Aufgrund einer früheren Vollumfrage kennt die 
# Unileitung die Rauchstatistiken.
# Heavy Never Occassionaly Regular
# 4.5% 79.5% 8.5% 7.5%
#   Entscheiden Sie, ob die Stichprobe aus survey die 
# Behauptung der Unileitung stützt. Arbeiten Sie mit einem 
# Signifikanzniveau von 5%.

library(MASS)
smoke_freq <- table(survey$Smoke)
smoke_prob <- c(.045, .795, .085, .075)

chisq.test(smoke_freq, p = smoke_prob)
## -> X-squared = 0.10744, df = 3, p-value = 0.9909

# Antwort: Der p-Wert ist deutlich grösser als 5%. Die Nullhypothese H0
# wird daher nicht verworfen. Die Stichprobe verträgt sich mit der
# Behauptung der Unileitung


# Problem: Die Unileitung vermutet folgendes Rauchverhalten 
# ihrer Studierenden.
#   Heavy Never Occassionaly Regular
#   4.5% 79.5% 8.5% 7.5%
# Prüfen Sie, ob die Stichprobe aus survey sich mit dieser 
# Behauptung verträgt. Bestimmen Sie den p-Wert, ohne auf 
# die Funktion chisq.test zurückzugreifen

smoke_freq <- table(survey$Smoke)
smoke_freq_expected <- smoke_prob * length(survey$Smoke)

# Chi-Square berechnen
freq_delta <- smoke_freq - smoke_freq_expected
chi2 <- sum(freq_delta^2 / smoke_freq_expected)
## [1] 0.1112089

df <- length(smoke_freq)-1
pchisq(chi2, df = df, lower.tail = F)
## [1] 0.9904592

