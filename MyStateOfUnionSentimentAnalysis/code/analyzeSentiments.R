


# Function for wordcloud
createSACWordCloud <- function( wordInp, sentimentInp){
  
  if (wordInp != 'Enter text...' &  !is.null(wordInp) )
  {
    series.full.n2 %>%
      filter(grepl(tolower(wordInp), tolower(word)) ) %>%
      count(word, president, sort = TRUE) %>%
      acast(word ~ president, value.var = "n", fill = 0) %>%
      comparison.cloud(colors = c("blue", "red"),max.words = 100)
  }
  else
  {
    nrc.sentiments.inp <- nrc.sentiments %>% 
      filter(sentiment == (if(grepl(var.All,sentimentInp))  sentiment else  tolower(sentimentInp) ))
    
    series.full %>%
      inner_join(nrc.sentiments.inp) %>%
      count(word , president, sort = TRUE) %>%
      acast(word ~ president, value.var = "n", fill = 0) %>%
      comparison.cloud(colors = c("blue", "red"),max.words = 100)
  }
}


# Function for Hist Plot
createSACHistPlot <- function( wordInp, sentimentInp){
  
  if (wordInp != 'Enter text...' &  !is.null(wordInp) )
  {
    series.full.n2 %>%
      filter(grepl(tolower(wordInp), tolower(word)) ) %>%
      count(word, president, sort = TRUE) %>%
      ungroup()  %>%
      group_by(president) %>%
      top_n(15) %>%
      ungroup() %>%
      mutate(word = reorder(word, n)) %>%
      ggplot(aes(word, n, fill = word)) +
      geom_col(show.legend = FALSE) +
      facet_wrap(~president, scales = "free_y") +
      labs(y = "Contribution to word",
           x = NULL) +
      coord_flip()
    
  }
  else
  {
    nrc.sentiments.inp <- nrc.sentiments %>% 
      filter(sentiment == (if(grepl(var.All,sentimentInp))  sentiment else  tolower(sentimentInp) ))
    
    series.full %>% 
      inner_join(nrc.sentiments.inp) %>%
      count(president, sentiment, sort = TRUE) %>%
      ungroup()  %>%
      group_by(sentiment) %>%
      top_n(10) %>%
      ungroup() %>%
      mutate(president = reorder(president, n)) %>%
      #mutate(y_cnt = (if (president == 'Donald J. Trump') n/4 else n/8)) %>%
      ggplot(aes(president, n , fill = president)) +
      geom_col(show.legend = FALSE) +
      facet_wrap(~sentiment, scales = "free_y") +
      labs(y = "Contribution to sentiment",
           x = NULL) +
      coord_flip()
    
    

  }
}

# Function for chart Plot Flesch-Kincaid grade level
createLCAFKGChartPlot <- function( presidentInp){

  # reading score chart
  series.full.read.level %>%
    filter(president == (if(grepl('Both',presidentInp))  president else  presidentInp ) ) %>%
    ggplot( aes(x = year, y = fk_grade, color = president, size = words)) +
    geom_point(alpha = 0.5) +
    geom_smooth(se = FALSE, color = "black", method = "lm", size = 0.5, linetype = "dotted") +
    scale_size_area(max_size = 10, guide = FALSE) +
    scale_color_manual(values = party_pal, name = "", breaks = c(name.Obama, name.Trump)) +
    scale_y_continuous(limits = c(4,27), breaks = c(5,10,15,20,25)) +
    theme_minimal(base_size = 18) +
    xlab("Presidency Year") +
    ylab("Reading Level") +
    guides(col = guide_legend(ncol = 2, override.aes = list(size = 4))) +
    theme(legend.position = c(0.4,0.22),
          legend.text = element_text(color="#909090", size = 16),
          panel.grid.minor = element_blank())
  }

# Function for chart Plot Flesch reading ease
createLCACFREChartPlot <- function( presidentInp){
  
  # reading ease chart
  series.full.read.level %>%
    filter(president == (if(grepl('Both',presidentInp))  president else  presidentInp ) ) %>%
    ggplot( aes(x = year, y = fr_grade, color = president, size = words)) +
    geom_point(alpha = 0.5) +
    geom_smooth(se = FALSE, color = "black", method = "lm", size = 0.5, linetype = "dotted") +
    scale_size_area(max_size = 10, guide = FALSE) +
    scale_color_manual(values = party_pal, name = "", breaks = c(name.Obama, name.Trump)) +
    scale_y_continuous(limits = c(4,100), breaks = c(5,10,15,20,25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95)) +
    theme_minimal(base_size = 18) +
    xlab("Presidency Year") +
    ylab("Reading Level") +
    guides(col = guide_legend(ncol = 2, override.aes = list(size = 4))) +
    theme(legend.position = c(0.4,0.22),
          legend.text = element_text(color="#909090", size = 16),
          panel.grid.minor = element_blank())
}

gc()