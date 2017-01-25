
# http://tidytextmining.com/
# http://jason.bryer.org/timeline/
# https://daattali.com/shiny/timevis-demo/

#todo
# bei den meist verwendeten wörter,
# könnte man auch eine interessante auswahl 
# treffen und diese gegenüberstellen

# fragen
# wie kriege ich gute triade

# Clinton
library(RSQLite)
library(tidytext)
library(stringr)

library(tagcloud)
library( extrafont )
library(RColorBrewer)
library(ggplot2)


# Ausführung
# Wolke mit allen Wörtern erstellen und die mit Emotionen colorieren
# Zeitverlauf über Tag erstellen
# Balkendiagramm mit den meisten Wörtern
# Ev. noch Zeitleiste
# Ev. Smileys

# connect to the sqlite file
library(DBI)
con = dbConnect(RSQLite::SQLite(), dbname="c:\\temp\\database.sqlite")

mails = dbGetQuery( con,'select ExtractedBodyText, ExtractedSubject, SenderPersonId, MetadataDateSent from Emails' )


mails %>% 
  unnest_tokens(word, ExtractedBodyText) ->
  tidy_words

data(stop_words)

library(dplyr)

# Filter stop words
tidy_words %>%
  anti_join(stop_words) ->
  tidy_words

# Daten range
date_range <- tidy_words[!tidy_words$MetadataDateSent == "",]$MetadataDateSent

# "2009-01-06T05:00:00+00:00"
first_date <- sort(date_range) %>% 
  head(1)

# "2012-12-20T05:00:00+00:00"
last_date <- sort(date_range) %>% 
  tail(10)

# Most common words
tidy_words %>% 
  dplyr::count(word, sort = TRUE) 

# Filter specific word
# What is sid?
filter_words <- c("fw:","re:", "and", "on", "in", "from", "sid", "of", "the", "a", "h:","fw","fwd",
                  "to", "for", "i", "if", "text", "am", "with", "-", "s", "re", "u", "pm", "fm",
                  "state.gov", "2010", "2009", "2015")

tidy_words %>% 
  dplyr::filter(!(word %in% filter_words)) %>% 
  dplyr::filter( str_length(word) > 3) ->
  tidy_words



# Display most common words
# ---------------------------------------------------------------------------------------------

# Date Range
n <- 100

# Most common words
tidy_words %>% 
  dplyr::count(word, sort = TRUE) %>% 
  head(n) ->
  top_n_words

# create tag cloud
words <- top_n_words$word
weights <- top_n_words$n

# Bing lexikon with score
sentiments_bing <- get_sentiments("bing")


# display.brewer.all()
# display.brewer.pal(n=10,name="Blues")

# 1A3148
# 17436D


# colors <- colorRampPalette( brewer.pal(n=3,name="Blues") )( 100 )
colors <- colorRampPalette(c("#17436D", "#9EC5E5"))(100)

#barplot(1:100, col = colors)
tagcloud( words, weights= weights, col= colors, 
          algorithm = "fill", scale = 1.5 , order = "random")




# Barchart of top 10 words
# ---------------------------------------------------------------------------------------------

tidy_words %>% 
  dplyr::count(word, sort = TRUE) %>% 
  head(10) -> 
  top_10_words 

# arrange(!n) ->

ggplot(top_10_words, aes(x = reorder(word, n), y = n)) +
  geom_bar(stat = "identity") +
  coord_flip()


# Barchart of top 10 positiv and negative sentiments
# ---------------------------------------------------------------------------------------------


# Woerter mit Sentiments
tidy_words %>%
  inner_join(sentiments_bing) ->
  words_with_sentiments

words_with_sentiments %>%
  dplyr::count(word, sort = TRUE) %>%
  inner_join(sentiments_bing) ->
  words_count_sentiments

words_count_sentiments[words_count_sentiments$sentiment 
                       == "positive", ] [1:10,] ->
                        top_10_positive

words_count_sentiments[words_count_sentiments$sentiment 
                       == "negative", ]  [1:10,] ->
  top_10_negative

# plot positive
# colors <- brewer.pal(n=10,name="Blues")(11)
# colors <- gray.colors(10)
ggplot(top_10_positive, aes(x = reorder(word, n), y = n)) +
  geom_bar(stat = "identity") +
  coord_flip()


# plot negative
ggplot(top_10_negative, aes(x = reorder(word, n), y = n)) +
  geom_bar(stat = "identity") +
  coord_flip()


# Verlauf ueber die Zeit
# ---------------------------------------------------------------------------------------------

#Anschauen: lubridate

library(reshape2)
library(tidyr)

# über die wochen  -- SORTIERUNG FEHLT
tidy_words %>%
  inner_join(get_sentiments("bing"))  %>%
  dplyr::filter(MetadataDateSent != "") %>% 
  # group by week
    mutate(week = strftime(MetadataDateSent, format="%Y-%W")) %>% 
  group_by(week, sentiment) %>%
  dplyr::summarise(n = n()) %>%
  ungroup() %>% 
  arrange(week) %>% 
  mutate(n = ifelse(sentiment == "negative", n*-1, n)) %>% 
  ggplot(aes(x = week, y = n, fill = sentiment)) +
  geom_bar(stat = "identity") + 
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5, size=5))

# Haiti Earthquake??
# Ev nicht nur Subjects durchsuchen?

# peak at 
# 2010-05  positive     24
# 1 - 7 Februar
## http://www.bbc.com/news/uk-northern-ireland-31930496

# second peak
# 8  2010-34  positive     18
# 23 - 29 August

# tidy_words %>%
#   inner_join(get_sentiments("bing"))  %>%
#   # group by week
#   mutate(week = strftime(MetadataDateSent, format="%Y-%W")) %>% 
#   filter(week == "2010-05")


# not used anymore ----------------------------------------------------------------------------
  
# wordcloud
library(wordcloud)

# einmal ganz einfach
tidy_words %>% 
  dplyr::filter(!(word %in% filter_words)) %>% 
  dplyr::filter( str_length(word) > 2) %>% 
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))

# mit gruppierung gegen positive und negative emotionen
mails = dbGetQuery( con,'select ExtractedSubject from Emails' )

mails %>% 
  unnest_tokens(word, ExtractedSubject) ->
  tidy_words

data(stop_words)

# Filter stop words
tidy_words %>%
  anti_join(stop_words) ->
  tidy_words

tidy_words %>% 
  count(word, sort = TRUE) 

tidy_words %>%
  inner_join(get_sentiments("bing")) %>%
  dplyr::count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("#F8766D", "#00BFC4"),
                   max.words = 1000)
