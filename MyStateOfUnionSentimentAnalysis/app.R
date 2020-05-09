#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# set up -----------------------------------------------------------------------
# load packages that will be used for the application
library(shiny)
library(leaflet)
library(DT)
library(markdown)
library(wordcloud)
library(shinythemes)

library(dplyr)
library(tidyr)
library(ggplot2)

library(tidytext)
library("syuzhet")

library(XML)



suppressWarnings(source("./code/speechData.R"))
suppressWarnings(source("./code/tidyData.R"))
suppressWarnings(source("./code/analyzeSentiments.R"))
suppressWarnings(source("./code/createPlot.R"))

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
                                            p("Use the radio buttons on the left to chose weekends, weekdays, or a faceted plot of both."))),
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
                                                                 "All" ="All"))),
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
                                            p("Use the radio buttons on the left to chose weekends, weekdays, or a faceted plot of both."))),
                            hr(),
                            fluidRow(sidebarPanel(width = 3,
                                                  h4("Year of Presidency"),
                                                  helpText("Chose the year you would like to see the analysis for."),
                                                  radioButtons("yearTrump", NULL,
                                                               c("2017" = "2017",
                                                                 "2018" = "2018",
                                                                 "2019" = "2019",
                                                                 "2020" = "2020",
                                                                 "All" ="All"))),
                                     mainPanel(tabsetPanel(
                                         tabPanel("Histogram", plotOutput("histTrump", height = 500)), 
                                         tabPanel("WordCloud", plotOutput("wordTrump", height = 500))
                                         , id = "conditionedPanelsTrump"
                                     )))
                   ),
                   
                   # Comapring the Presidency
                   tabPanel("Obama vs Trump",
                            fluidRow(column(12,
                                            h1("Sentiment Analysis Comparison"),
                                            p("his story"),
                                            br(),
                                            h4("Instructions"),
                                            p("Use the radio buttons on the left to chose weekends, weekdays, or a faceted plot of both."))),
                            hr(),
                            fluidRow(sidebarPanel(width = 3,
                                                  h4("Select Sentiment"),
                                                  helpText("Chose the option you would like to see the analysis for."),
                                                  selectInput("sentimentInput", "Sentiment",
                                                              sort(unique(InitCap(c(loughran.sentiments$sentiment, 'All')))))
                                                  ),
                                     mainPanel(tabsetPanel(
                                         tabPanel("Histogram", plotOutput("histSAC", height = 500)), 
                                         tabPanel("WordCloud", plotOutput("wordSAC", height = 500))
                                         , id = "conditionedPanelsSAC"
                                     )))
                   ),
                   
                   # Stock market Analysis
                   tabPanel("Stock Market Analysis",
                            fluidRow(column(12,
                                            h1("Stock market Analysis"),
                                            p("his story"),
                                            br(),
                                            h4("Instructions"),
                                            p("Use the radio buttons on the left to chose weekends, weekdays, or a faceted plot of both."))),
                            hr(),
                            fluidRow(sidebarPanel(width = 3,
                                                  h4("Select Market"),
                                                  helpText("Chose the option you would like to see the analysis for."),
                                                  radioButtons("Index", NULL,
                                                               c("S&P" = "sp",
                                                                 "Nasdaq" = "nasdaq",
                                                                 "Dow Jones" ="dowjones",
                                                                 "All" = "all"))),
                                                  mainPanel(plotOutput("histSMA", height = 500)))
                            
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
        createHistPlot( "Obama" , input$yearObama)
    })
    
    output$wordObama <- renderPlot({
        createWordCloud( "Obama" , input$yearObama)
    })
    
    output$histTrump <- renderPlot({
        createHistPlot( "Trump" , input$yearTrump)
    })
    
    output$wordTrump <- renderPlot({
        createWordCloud( "Trump" , input$yearTrump)
    })
    
    output$histSAC <- renderPlot({
        hist(c(1, 2, 3, 4), col = 'darkgray', border = 'white', main=input$Sentiment)
    })
    
    output$wordSAC <- renderPlot({
        wordcloud(input$sentimentInput)
    })
})

# Create Shiny app ----
shinyApp(ui = ui, server = server)
