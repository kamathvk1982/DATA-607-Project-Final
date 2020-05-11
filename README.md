

#title: "Data607-Final-Project-Shiny App - State of the Union -Sentiment Analysis - Obama vs Trump"

#author: "Vinayak Kamath"

#date: "05/10/2020"

### What is this app?

This is a simple Shiny application created as part of the [_DATA 607, Data Acquisition and Management_] course offered by City University Of New York's (CUNY) Online Masters in Data Science.

The app allows a user to explore president Trump's and Obama’s State of the Union address. Each president’s State of the Union address is an attempt to set the tone for his term in office — what are the administration’s goals, plans and promises? Those questions dominate the 24-hour news cycle around this yearly address to Congress and drives the stock market sentiments.

Nearly 50 million people tuned in to watch President Obama’s first State of the Union address External link  in 2010. President Trump’s speech last year generated more than 4.5 million tweets, External link  the most ever for a presidential address.

It’s been more than a century since President Woodrow Wilson’s first State of the Union address, and while the language presidents use to communicate has evolved, many of the words, phrases, and ideas have stood the test of time. 

Comparing those words, over time, is one way to hold presidencies up against each other, to assess the ways in which presidential communication has changed. How can we objectively compare one State of the Union address to another? Data analysis can be used to transform otherwise dry, static information into comparable statistics that show trends across words, presidents, and years.

The data are sourced from the project by Brad Borevitz at [onetwothree.net](http://stateoftheunion.onetwothree.net/index.shtml), which provides access to the corpus of all the State of the Union addresses from 1790 to 2020. The current corpus contains 234 documents. There are 1,791,471 words in the corpus, and 28,195 unique words. The data is scrapped from the individual speech _html_ format pages.

The stock market data are sourced from [Macrotrends](https://www.macrotrends.net/charts/stock-indexes) - The Premier Research Platform for Long Term Investor. The data is provided in _csv_ format.

As a next for this project, would work on error handling, extend for more years, make it user driven to decide on n-gram value for n.

### How do I use it?

Navigate through the app using the tabs at the top. Further detail and instruction are provided on each tab. A high level overview of what each does presented below:

* __Obama:__ Year wise data and analysis of President Obama's speeches from 2009 to 2016. Visualization using Histogram and WordCloud.
* __Trump:__ Year wise data and analysis of President Trump's speeches from 2017 to 2020. Visualization using Histogram and WordCloud.
* __Obama vs Trump:__ A comparison of the speeches between the two presidents; Sentiment wise comparison using Histogram and WordCloud.
* __Linguistic Complexity Analysis:__ The Flesch–Kincaid readability tests are readability tests designed to indicate how difficult a passage in English is to understand. There are two tests, the Flesch Reading Ease, and the Flesch–Kincaid Grade Level. 
* __Stock market Analysis:__ A look at the stock market movement on and after the speech day for each president.



