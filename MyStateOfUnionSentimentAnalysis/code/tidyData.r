

##### Sentiment lexicon - nrc 
# Getting the sentiment lexicom for nrc:

nrc.sentiments <- get_sentiments("nrc")

gc()


# function to translate string to have first letter as upper case and rest as lower case.
InitCap=function(x) paste0(toupper(substr(x, 1, 1)), tolower(substring(x, 2)))

# color palette for parties
party_pal <- c("#1482EE","#228B22")


# default name handling
name.Trump <- 'Donald J. Trump'
name.Obama <- 'Barack Obama '
  
#Vector of year names:
years <- c("2009", "2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020")

#vector of speeches:
speeches <- list(doc.text.2009, doc.text.2010, doc.text.2011, doc.text.2012, doc.text.2013, doc.text.2014
                 , doc.text.2015, doc.text.2016, doc.text.2017, doc.text.2018, doc.text.2019, doc.text.2020)

#vector of speechDates:
speechDates <- list(doc.date.2009, doc.date.2010, doc.date.2011, doc.date.2012, doc.date.2013, doc.date.2014
                    , doc.date.2015, doc.date.2016, doc.date.2017, doc.date.2018, doc.date.2019, doc.date.2020)

#Vector of presidents:
presidents <- list(doc.president.2009, doc.president.2010, doc.president.2011, doc.president.2012, doc.president.2013, 
                   doc.president.2014, doc.president.2015, doc.president.2016, doc.president.2017, doc.president.2018, 
                   doc.president.2019, doc.president.2020)
           
# Creating the tidy dataset series.full:
series.full <- tibble()
series.full.n2 <- tibble()


series.full.read.level <- tibble()

for(i in seq_along(years)) {
  clean <- tibble(year = years[[i]],
                text = speeches[[i]],
                speechDate = speechDates[[i]]) %>%
    unnest_tokens(word, text, token = "ngrams", n = 1) %>%
    mutate(president = presidents[[i]]) %>%
    select(president, everything())

  series.full <- rbind(series.full, clean)

  clean.n2 <- tibble(year = years[[i]],
                  text = speeches[[i]],
                  speechDate = speechDates[[i]]) %>%
    unnest_tokens(word, text, token = "ngrams", n = 2) %>%
    mutate(president = presidents[[i]]) %>%
    select(president, everything())
  
  series.full.n2 <- rbind(series.full.n2, clean.n2)
  
  # for reading level  Flesch-Kincaid grade level
  clean.read.level <- tibble(year = years[[i]],
                     text = speeches[[i]],
                     speechDate = speechDates[[i]]) %>%
    #unnest_tokens(word, text, token = "ngrams", n = 2) %>%
    mutate(president = presidents[[i]], 
           syllables = nsyllable(speeches[[i]]),
           sentences = nsentence(speeches[[i]]),
           words = ntoken(speeches[[i]], remove_punct = TRUE),
           fk_grade = 0.39*(words/sentences) + 11.8*(syllables/words) - 15.59,
           fr_grade = 206.835 - 1.015*(words/sentences) - 84.6*(syllables/words)
           ) %>%
    #arrange(date) %>%
    select(president,syllables ,sentences, words,  fk_grade, everything())
  
  series.full.read.level <- rbind(series.full.read.level, clean.read.level)
}


# Removal of Stop words
series.full <- series.full %>%
  anti_join(stop_words)

series.full.n2 <- series.full.n2 %>%
  anti_join(stop_words)




gc()