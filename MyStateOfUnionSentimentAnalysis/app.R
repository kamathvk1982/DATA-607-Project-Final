#---
#title: "Data607-Final-Project-Shiny App - State of the Union -Sentiment Analysis - Obama vs Trump"
#author: "Vinayak Kamath"
#date: "04/05/2020"
#---


# set up -----------------------------------------------------------------------
# load packages that will be used for the application
library(shiny)
library(shinythemes)

library(leaflet)
library(DT)
library(markdown)

library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)
library(tibble)

library(tidytext)
library("syuzhet")

library(XML)

library(reshape2)
library(wordcloud)

library(quanteda)


suppressWarnings(source("./code/speechData.R"))
suppressWarnings(source("./code/marketData.R"))

suppressWarnings(source("./code/tidyData.R"))
suppressWarnings(source("./code/analyzeSentiments.R"))
suppressWarnings(source("./code/createPlot.R"))
suppressWarnings(source("./code/analyzeMarkets.R"))

# Set up the application ui
ui <- shinyUI(navbarPage("Sentiment Analysis - State of the Union",
                         
                         theme = shinytheme("flatly"),
                         
                   # define the tabs to be used in the app ----------------------------------------
                   # introduction sentiment analysis
                   tabPanel("Intro",
                            includeMarkdown("./md/intro.md"),
                            hr()),
                   
                   # Senitment Analysis for Obama
                   tabPanel("Obama",
                            fluidRow(column(12,
                                            h1("Barack Hussein Obama II"),
                                            p("Barack Hussein Obama II (born August 4, 1961) is an American politician and attorney who served as the 44th president of the United States from 2009 to 2017. A member of the Democratic Party, Barack Obama was the first African-American president of the United States. He previously served as a U.S. senator from Illinois from 2005 to 2008 and an Illinois state senator from 1997 to 2004."),
                                            br(),
                                            h4("Instructions"),
                                            p("Use the radio buttons on the left to chose the Year of Presidency for President Obama."))),
                            hr(),
                            fluidRow(sidebarPanel(width = 3,
                                                  h4("Barack Obama"),
                                                  helpText("Chose the year you would like to see the analysis for."),
                                                  radioButtons("yearObama", NULL,
                                                               c("2009" = "2009",
                                                                 "2010" = "2010",
                                                                 "2011" = "2011",
                                                                 "2012" = "2012",
                                                                 "2013" = "2013",
                                                                 "2014" = "2014",
                                                                 "2015" = "2015",
                                                                 "2016" = "2016",
                                                                 "All" =var.All))),
                                         mainPanel(tabsetPanel(
                                             tabPanel("Histogram", plotOutput("histObama", height = 500)), 
                                             tabPanel("WordCloud", plotOutput("wordObama", height = 500))
                                             , id = "conditionedPanelsObama"
                                         )))
                    ),
                   
                   # Senitment Analysis for Trump
                   tabPanel("Trump",
                            fluidRow(column(12,
                                            h1("Donald John Trump"),
                                            p("Donald John Trump (born June 14, 1946) is the 45th and current president of the United States. Before entering politics, he was a businessman and television personality. Trump was inaugurated as the 45th president of the United States on January 20, 2017."),
                                            br(),
                                            h4("Instructions"),
                                            p("Use the radio buttons on the left to chose the Year of Presidency for President Trump"))),
                            hr(),
                            fluidRow(sidebarPanel(width = 3,
                                                  h4("Year of Presidency"),
                                                  helpText("Chose the year you would like to see the analysis for."),
                                                  radioButtons("yearTrump", NULL,
                                                               c("2017" = "2017",
                                                                 "2018" = "2018",
                                                                 "2019" = "2019",
                                                                 "2020" = "2020",
                                                                 "All" =var.All))),
                                     mainPanel(tabsetPanel(
                                         tabPanel("Histogram", plotOutput("histTrump", height = 500)), 
                                         tabPanel("WordCloud", plotOutput("wordTrump", height = 500))
                                         , id = "conditionedPanelsTrump"
                                     )))
                   ),
                   
                   # Comapring the Presidency for Sentiment Analysis
                   tabPanel("Obama vs Trump",
                            fluidRow(column(12,
                                            h1("Sentiment Analysis Comparison"),
                                            p("Sentiment analysis with NRC Emotion Lexicon. The NRC Sentiment and Emotion Lexicons is a collection of seven lexicons, including the widely used Word-Emotion Association Lexicon. We have used the NRC to track the emotions in the Presidents Speeches."),
                                            p("You can also try the more in-depth digging with search on actual words in the content of these speeches."),
                                            br(),
                                            h4("Instructions"),
                                            p("Use the options on the left to select an sentiment or enter a word of your choice."))),
                            hr(),
                            fluidRow(sidebarPanel(width = 3,
                                                  h4("Select Sentiment"),
                                                  helpText("Chose the option you would like to see the analysis for."),
                                                  selectInput("sentimentInput", "Sentiment",
                                                              sort(unique(InitCap(c(nrc.sentiments$sentiment, var.All)))))
                                                  , h4("   OR  "),
                                                  h4("Enter Word"),
                                                  helpText("Enter word you would like to see the analysis for."),
                                                  textInput("wordInput", "Word",value = "Enter text...")
                                                  ),
                                     mainPanel(tabsetPanel(
                                         tabPanel("Histogram", plotOutput("histSAC", height = 500)), 
                                         tabPanel("WordCloud", plotOutput("wordSAC", height = 500))
                                         , id = "conditionedPanelsSAC"
                                     )))
                   ),
                   
                   # Comapring the Presidency for linguistic complexity
                   tabPanel("Linguistic Complexity Analysis",
                            fluidRow(column(12,
                                            h1("Linguistic Complexity Analysis"),
                                            p("The code below uses the quanteda functions ntoken, nsentence and nsyllable to count the words, sentences, and syllables in each address. Then it uses those values to calculate the Flesch-Kincaid reading grade level, a widely used measure of linguistic complexity."),
                                            br(),
                                            p("Flesch-Kincaid grade level: These readability tests are used extensively in the field of education. The Flesch-Kincaid Grade Level Formula instead presents a score as a U.S. grade level, making it easier for teachers, parents, librarians, and others to judge the readability level of various books and texts. It can also mean the number of years of education generally required to understand this text, relevant when the formula results in a number greater than 10."),
                                            br(),
                                            p("Flesch reading ease: In the Flesch reading-ease test, higher scores indicate material that is easier to read; lower numbers mark passages that are more difficult to read."),
                                            h4("Instructions"),
                                            p("Use the radio buttons on the left to chose the President."))),
                            hr(),
                            fluidRow(sidebarPanel(width = 3,
                                                  h4("Select President"),
                                                  helpText("Chose the option you would like to see the analysis for."),
                                                  selectInput("presidentInput", "President",c(name.Obama, name.Trump, 'Both'))
                                                  ),
                                     mainPanel(tabsetPanel(
                                         tabPanel("Flesch-Kincaid Grade Level", plotOutput("chartLCAfkg", height = 500))
                                         , tabPanel("Flesch Reading Ease", plotOutput("chartLCAfre", height = 500)) 
                                         , id = "conditionedPanelsLCA"
                                         )))
                            
                   ),
                   
                   # Stock market Analysis
                   tabPanel("Stock Market Analysis",
                            fluidRow(column(12,
                                            h1("Stock Market Analysis"),
                                            p("The presidents ability to impact the stock market is indirect and may not be huge. But very often in recent months with president Trump we have seen the market reacting to his tweets and speeches. Here we aim at looking at the Stock market movements on the days leading and post the State of the Union speeches."),
                                            br(),
                                            h4("Instructions"),
                                            p("Use the radio buttons on the left to chose the President and the market index."))),
                            hr(),
                            fluidRow(sidebarPanel(width = 3,
                                                  h4("Select President"),
                                                  helpText("Chose the option you would like to see the analysis for."),
                                                  selectInput("presidentInput1", "Select President",c(name.Obama, name.Trump)),
                                                  h4("Select Market Index"),
                                                  helpText("Chose the option you would like to see the analysis for."),
                                                  radioButtons("indexInput", NULL,
                                                               c("S&P 500" = name.sp500,
                                                                 "Nasdaq" = name.nasdaq,
                                                                 "Dow Jones" =name.dowjones,
                                                                 "All" = var.All))),
                                                  mainPanel(tabsetPanel(
                                                      tabPanel("Speech Day", plotOutput("chartDay", height = 2500))
                                                      , tabPanel("Speech Week", plotOutput("chartWeek", height = 2500)) 
                                                      , tabPanel("Speech Month", plotOutput("chartMonth", height = 2500))
                                                      , id = "conditionedPanelsLCA"
                                                  )))
                    ),
                   # introduction sentiment analysis
                   tabPanel("About",
                            includeMarkdown("./md/about.md"),
                            hr())
                   
                   # close the UI definition
))

# Define server logic required to draw a histogram ----
server <- shinyServer(function(input, output) {
    
    # Expression that generates a histogram. The expression is
    # wrapped in a call to renderPlot to indicate that:
    #
    #  1) It is "reactive" and therefore should be automatically
    #     re-executed when inputs change
    #  2) Its output type is a plot
    
    output$histObama <- renderPlot({
        createHistPlot( name.Obama , input$yearObama)
    })
    
    output$wordObama <- renderPlot({
        createWordCloud( name.Obama , input$yearObama)
    })
    
    output$histTrump <- renderPlot({
        createHistPlot( name.Trump , input$yearTrump)
    })
    
    output$wordTrump <- renderPlot({
        createWordCloud( name.Trump , input$yearTrump)
    })
    
    output$histSAC <- renderPlot({
        createSACHistPlot(input$wordInput, input$sentimentInput)
    })
    
    output$wordSAC <- renderPlot({
        createSACWordCloud(input$wordInput, input$sentimentInput)
    })
    
    output$chartLCAfkg <- renderPlot({
        createLCAFKGChartPlot(input$presidentInput)
    })
    
    output$chartLCAfre <- renderPlot({
        createLCACFREChartPlot(input$presidentInput)
    })
    
    
    output$chartDay <- renderPlot({
        createMarketPLot(input$indexInput, input$presidentInput1, 'Day')
    })
    
    output$chartWeek <- renderPlot({
        createMarketPLot(input$indexInput, input$presidentInput1, "Week")
    })
    
    output$chartMonth <- renderPlot({
        createMarketPLot(input$indexInput, input$presidentInput1, "Month")
    })
    
})

# Create Shiny app ----
shinyApp(ui = ui, server = server)
