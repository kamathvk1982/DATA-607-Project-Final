# Function for wordcloud
createMarketPLot <- function( indexInp, presidentInp, typeInp){
  
  #To filter for president selected
  plotPresidentData <- speechDates %>%
    filter(president == presidentInp)
  
  #To filter for INdex selected
  plotMarketData <- market.data %>% 
    filter(indexName == (if(grepl(var.All,indexInp))  indexName else  indexInp ))
  
  #Converting the day or week or month value selected to number of days
  dayCounts <- case_when( 
    typeInp == "Day" ~ 3
    ,typeInp == "Week" ~ 4
    ,typeInp == "Month" ~   15
              )
  
  #building final data set for plotting
  plotData <- tibble()
  
  for (i in seq_along(plotPresidentData$year)) {
    
    filterDate <- plotPresidentData$day[[i]]
    
    cleanData <- plotMarketData %>%
      filter( date >= filterDate-dayCounts & date <= filterDate + dayCounts   ) %>%
      mutate(speechDate = format(filterDate, "%B %d, %Y") )
    
    plotData <- rbind(plotData, cleanData)
    
  }
  
  #Plotting final data set  
  plotData %>%
    ggplot(aes(x=plotData$date, y=plotData$value, shape = factor(plotData$indexName) )) +
    geom_point(aes(colour = factor(plotData$indexName)), size = 2) + 
    geom_text( label=plotData$value, nudge_y = 1000,check_overlap = T ) +
    stat_smooth(method = "lm", se = FALSE, formula = y ~ x, size = 0.25, colour = "violet")  +
    geom_vline(xintercept=as.Date(plotData$speechDate,format = "%B %d, %Y") , linetype="twodash", color = "dark green", size=1) +
    scale_y_continuous(limits = c(100,35000), breaks = seq(from=150, to=34000, by=2000)) +
    facet_wrap(~plotData$speechDate, scales = "free" , ncol = 1) +
    labs(y = "Index Value",
         x = "Dates",
         colour = "Index Name",
         shape = "Index Name")
    
}
