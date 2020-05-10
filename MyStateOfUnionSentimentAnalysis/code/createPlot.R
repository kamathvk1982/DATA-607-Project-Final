# Function for ggplot
createHistPlot <- function( presidentInp, yearInp){
  
  series.full %>% 
    filter(president == presidentInp & year == (if(grepl('All',yearInp))  year else  yearInp) ) %>%
    inner_join(loughran.sentiments) %>%
    count(word, sentiment, sort = TRUE) %>%
    ungroup()  %>%
    group_by(sentiment) %>%
    top_n(10) %>%
    ungroup() %>%
    mutate(word = reorder(word, n)) %>%
    ggplot(aes(word, n, fill = sentiment)) +
    geom_col(show.legend = FALSE) +
    facet_wrap(~sentiment, scales = "free_y") +
    labs(y = "Contribution to sentiment",
         x = NULL) +
    coord_flip()
}


# Function for wordcloud
createWordCloud <- function( presidentInp, yearInp){
  series.full %>%
    filter(president == presidentInp & year == (if(grepl('All',yearInp))  year else  yearInp)) %>%
    #inner_join(loughran.sentiments) %>%
    count(word) %>%
    with(wordcloud(word, n, max.words = 100 , random.order=FALSE,colors=brewer.pal(8, "Dark2")  ))
}