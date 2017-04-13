

load(url("http://www.farys.org/daten/ESS.RDATA"))

# Group-Counter anwenden zum Zaehlen der Laender
ess[, .GRP, by = Land]

# Welches Land hat am meisten Befragte?
ess[, .N, by = Land][order(-N)][1]

# Welches ist das durchschnittlich glücklichste Land? Welches das unglücklichste?
ess.happy.order <- ess[!is.na(happy), .("happy"= mean(happy)), by = Land]

# oder so
ess[, .("happy"= mean(happy, rm.na = T)), by = Land]

# Ohne order
# hap <- ess[, mean(happy), by=Land]
# setorder(hap, V1)

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
ess.years.cast <- ess.years[, .(.SD[year==2008, happy], .SD[year==2010, happy]), by = Land][!is.na(V1) & !is.na(V2)]
ess.years.cast[, .(Land, "delta"=V2-V1)][order(delta)][1]

# Andere Variante
rank <- ess[,
            .(
              Dif=mean(happy[year==2010],na.rm=T)-
                mean(happy[year==2008],na.rm=T)
            ),
            by=.(Land)]
setorder(rank, Dif)
rank

# Es konnen auch mehrere Variablen gleichzeitig hinzugefuegt werden
# (Performanter da zwischen einer [])
# ess[, ':=' (komplett=ifelse(happy==10,1,0),
#             garnicht=ifelse(happy==1,1,0))]

# Andere Variante mit subset:
tabelle <- ess[,.(m.happy=mean(happy,na.rm=T)),by=list(year,Land)][
  order(Land,year)]

tabelle[,Differenz:=m.happy[year==2010]-m.happy[year==2008],by=Land][
  year==2010][
    order(Differenz)][
      ,c("Land","Differenz"),with=F]