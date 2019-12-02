install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")
install.packages("dplyr")
library(rJava)
library(KoNLP)
library(dplyr)
library(rJava)
useNIADic()

txt <- readLines("hiphop.txt")
txt
install.packages("stringr")
library(stringr)

#특수문자 제거
txt <- str_replace_all(txt, "\\W", " ")
txt


extractNoun("대한민국 영토는 한반도와 그 부속도서로 한다")
nouns <- extractNoun(txt)
nouns

wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word, word = Var1, freq = Freq)
df_word

df_word <- filter(df_word, nchar(word) >= 2)

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top_20

install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)

pal <-brewer.pal(8,"Dark2")
set.seed(1234)


wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(4, 0.3),
          colors = pal)