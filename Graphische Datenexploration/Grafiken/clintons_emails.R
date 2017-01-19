
# http://tidytextmining.com/
# http://jason.bryer.org/timeline/
# https://daattali.com/shiny/timevis-demo/

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


# connect to the sqlite file
library(DBI)
con = dbConnect(RSQLite::SQLite(), dbname="c:\\temp\\database.sqlite")

mails = dbGetQuery( con,'select ExtractedSubject, SenderPersonId from Emails Limit 10000' )


mails %>% 
  unnest_tokens(word, ExtractedSubject) ->
  tidy_words

data(stop_words)

library(dplyr)

# Filter stop words
tidy_words %>%
  anti_join(stop_words) ->
  tidy_words

# Most common words
tidy_words %>% 
  count(word, sort = TRUE) 

# Filter specific word
# What is sid?
filter_words <- c("fw:","re:", "and", "on", "in", "from", "sid", "of", "the", "a", "h:","fw","fwd",
                  "to", "for", "i", "if", "text", "am", "with", "-", "s", "re", "u", "pm", "fm")

tidy_words %>% 
  dplyr::filter(!(word %in% filter_words)) %>% 
  dplyr::filter( str_length(word) > 2) ->
  tidy_words


n <- 100

# Most common words
tidy_words %>% 
  count(word, sort = TRUE) %>% 
  head(n) ->
  top_n_words

# create tag cloud
words <- top_n_words$word
weights <- top_n_words$n

colors <- colorRampPalette( brewer.pal( 12, "Paired" ) )( 100 )
tagcloud( words, weights= weights, col= colors) #, algorithm = "fill" )

# create bar chart
tidy_words %>%
  count(word, sort = TRUE) %>%
  head(10) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_bar(stat = "identity") +
  xlab(NULL) +
  coord_flip()

# sentiment analysis
#?sentiments

# Bing lexikon with score
sentiments_bing <- get_sentiments("bing")

tidy_words %>% 
  inner_join(sentiments_bing) ->
  words_with_sentiments

words_with_sentiments %>% 
  count(word, sort = TRUE) %>% 
  inner_join(sentiments_bing) -> 
  words_count_sentiments

words <- words_count_sentiments$word
weights <- words_count_sentiments$n
sentiments_words <- words_count_sentiments$sentiment

colors <- ifelse(words_count_sentiments$sentiment == "positive", "blue", "red")
tagcloud( words, weights= weights*2, col= colors) #, algorithm = "fill" )


# words over the time
mails = dbGetQuery( con,'select ExtractedSubject, SenderPersonId, MetadataDateSent, ExtractedDateSent from Emails' )

distinct(mails$MetadataDateSent)
mails %>% 
  unnest_tokens(word, ExtractedSubject) ->
  tidy_words

#Anschauen: lubridate

library(reshape2)
library(tidyr)

# tidy_words %>%
#   inner_join(get_sentiments("bing"))  %>%
#   # group by week
#   mutate(week = strftime(MetadataDateSent, format="%W")) %>% 
#   group_by(week, sentiment) %>% 
#   summarise(n = n()) %>% 
#   dcast(week ~ sentiment) %>% 
#   replace_na(list(negative = 0)) ->
#   weeks

# über die wochen
tidy_words %>%
  inner_join(get_sentiments("bing"))  %>%
  # group by week
  mutate(week = strftime(MetadataDateSent, format="%W")) %>% 
  group_by(week, sentiment) %>%
  summarise(n = n()) %>%
  ungroup() %>% 
  mutate(n = ifelse(sentiment == "negative", n*-1, n)) %>% 
  ggplot(aes(x = week, y = n, fill = sentiment)) +
  geom_bar(stat = "identity")


# über die Zeit - geht noch nicht!
tidy_words %>%
  inner_join(get_sentiments("bing"))  %>%
  # group by week
  mutate(hour = strsplit(ExtractedDateSent, " ")[[1]][2]) %>% 
  # mutate(hour = strsplit(strsplit(ExtractedDateSent, 
  #                                 split = " ")[[1]][5], ":")[[1]][1]) %>% 
  group_by(hour, sentiment) %>%
  summarise(n = n()) %>%
  ungroup() %>% 
  mutate(n = ifelse(sentiment == "negative", n*-1, n)) %>% 
  ggplot(aes(x = hour, y = n, fill = sentiment)) +
  geom_bar(stat = "identity")

strsplit(strsplit("Saturday, May 23, 2009 8:57 PM", 
                  split = " ")[[1]][5], ":")[[1]][1]

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
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("#F8766D", "#00BFC4"),
                   max.words = 100)
