
#loading CSV from Git for the three markets
data.dowjones <- read_csv("https://raw.githubusercontent.com/kamathvk1982/DATA-607-Project-Final/master/MyStateOfUnionSentimentAnalysis/data/dow-jones-industrial-average-last-10-years.csv",  col_names = TRUE , na = c("", "NA"), quoted_na = TRUE)
data.nasdaq <- read_csv("https://raw.githubusercontent.com/kamathvk1982/DATA-607-Project-Final/master/MyStateOfUnionSentimentAnalysis/data/nasdaq-composite-index-10-year-daily-chart.csv",  col_names = TRUE , na = c("", "NA"), quoted_na = TRUE)
data.sp500 <- read_csv("https://raw.githubusercontent.com/kamathvk1982/DATA-607-Project-Final/master/MyStateOfUnionSentimentAnalysis/data/sp500-10-year-daily-chart.csv",  col_names = TRUE , na = c("", "NA"), quoted_na = TRUE)



