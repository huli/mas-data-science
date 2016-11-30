

load(url("http://www.farys.org/daten/ESS.RDATA"))

# Group-Counter anwenden zum Zaehlen der Laender
ess[, .N, by = Land]

# Welches Land hat am meisten Befragte?
ess[, .N, by = Land][order(-N)][1]

# Welches ist das durchschnittlich glücklichste Land? Welches das unglücklichste?
ess.happy.order <- ess[happy != "NA", .("happy"= mean(happy)), by = Land]

# glücklichste
ess.happy.order[order(-happy)][1]

# unglücklichste
ess.happy.order[order(happy)][1]

# In welchem Land gibt es am meisten “komplett glückliche Menschen” (d.h. angegebener Zufriedenheitswert = 10)?
ess[happy==10, .N, by=Land][order(-N)][1]

# Welches Land hatte von 2008 bis 2010 den grössten Rückgang im Durchschnittsglück?
ess.years <- ess[happy != "NA" & year >= 2008 & year <=2010, .(happy = mean(happy)), by=.(Land, year)]

# from long to wide
# ess.years.cast <- dcast(ess.years, Land ~ year)
ess.years.cast <- ess.years[, .(.SD[year==2008, happy], .SD[year==2010, happy]), by = Land][V1 != "NA" & V2 != "NA"]
ess.years.cast[, .(Land, "delta"=V2-V1)][order(delta)][1]
