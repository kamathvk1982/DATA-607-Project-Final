
# function to translate string to have first letter as upper case and rest as lower case.
InitCap=function(x) paste0(toupper(substr(x, 1, 1)), tolower(substring(x, 2)))


#Vector of year names:
years <- c("2009", "2020")

#vector of speeches:
speeches <- list(doc.text.2009, doc.text.2020)

#vector of speechDates:
speechDates <- list(doc.date.2009, doc.date.2020)

#Vector of presidents:
presidents <- c("Obama", "Trump")
           
# Creating the tidy dataset series.full:
series.full <- tibble()

for(i in seq_along(years)) {
  clean <- tibble(year = years[[i]],
                text = speeches[[i]],
                speechDate = speechDates[[i]]) %>%
    unnest_tokens(word, text) %>%
    mutate(president = presidents[[i]]) %>%
    select(president, everything())

  series.full <- rbind(series.full, clean)
}

# Removal of Stop words
series.full <- series.full %>%
  anti_join(stop_words)

gc()