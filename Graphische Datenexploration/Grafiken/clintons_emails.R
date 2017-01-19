
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

# connect to the sqlite file
library(DBI)
con = dbConnect(RSQLite::SQLite(), dbname="c:\\temp\\database.sqlite")

mails = dbGetQuery( con,'select ExtractedSubject, SenderPersonId from Emails Limit 10000' )


mails %>% 
  unnest_tokens(word, ExtractedSubject) ->
  tidy_words

data(stop_words)

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


