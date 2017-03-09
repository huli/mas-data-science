library(tm)
library(wordcloud)

setwd("/Users/romeokienzler/Documents/romeo/Dropbox/arbeit/r/rkurs/lecture3/spamclassification/TR/")

#get a list of all email from the directory
file_list = list.files()

#remove the first entry (doesn't contain an email)
file_list = file_list[-1]

#create an empty data frame
df = data.frame(emailtext=character(),stringsAsFactors=FALSE) 

#add each email as row to the data frame
for (fileName in file_list){
  text=readChar(fileName, file.info(fileName)$size)
  df=rbind(df,data.frame(text,stringsAsFactors = FALSE))
}

#we have now 2500 emails in the data frame
dim(df)

#create a S3 Corpus Object for easy post processing
spam_corpus=Corpus(VectorSource(df$text))
inspect(spam_corpus[1:3])
clean_corpus=tm_map(spam_corpus, tolower)
clean_corpus=tm_map(clean_corpus, PlainTextDocument)
clean_corpus=tm_map(clean_corpus, removeNumbers)
clean_corpus=tm_map(clean_corpus, removePunctuation)
clean_corpus=tm_map(clean_corpus, removeWords, stopwords())
clean_corpus=tm_map(clean_corpus, stripWhitespace)

#convert list of email to document term matrix
dtm=DocumentTermMatrix(clean_corpus)
inspect(dtm[100:110, 30130:30145])

#plot a word cloud to see whats going on
#wordcloud(clean_corpus[labels==0], min.freq=40)
#wordcloud(clean_corpus[labels==1], min.freq=40)

#load labels from separate file
labels = read.csv('/Users/romeokienzler/Documents/romeo/Dropbox/arbeit/r/rkurs/lecture3/spamclassification/spam-mail.tr.label')
labels = labels[,2]

#wordcloud(spam_corpus[labels$Prediction==1], min.freq=40)

dfLabeled = cbind(df,labels)
sms_raw_train <- dfLabeled[1:1250,]
sms_raw_test <- dfLabeled[1251:2500,]
sms_dtm_train <- dtm[1:1250,]
sms_dtm_test <- dtm[1251:2500,]
spam_corpus_train <- clean_corpus[1:1250]
spam_corpus_test <- clean_corpus[1251:2500]

spam <- subset(sms_raw_train, labels == 1)
ham <- subset(sms_raw_train, labels == 0)

five_times_words <- findFreqTerms(sms_dtm_train, 5)
length(five_times_words)

sms_train <- DocumentTermMatrix(spam_corpus_train, control=list(dictionary = five_times_words))

sms_test <- DocumentTermMatrix(spam_corpus_test, control=list(dictionary = five_times_words))


convert_count <- function(x) {
  y <- ifelse(x > 0, 1,0)
  y <- factor(y, levels=c(0,1), labels=c("No", "Yes"))
  y
}

sms_train <- apply(sms_train, 2, convert_count)
sms_test <- apply(sms_test, 2, convert_count)

library(e1071)
sms_classifier <- naiveBayes(sms_train, factor(sms_raw_train$labels))
class(sms_classifier)
sms_test_pred <- predict(sms_classifier, newdata=sms_test)
table(sms_test_pred, sms_raw_test$labels)
sms_test_pred
truthVector =sms_test_pred == sms_raw_test$labels
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
good/(good+bad)
table(sms_test_pred,sms_raw_test$labels)

