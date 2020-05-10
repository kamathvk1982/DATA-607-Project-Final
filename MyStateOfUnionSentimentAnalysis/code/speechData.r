
set.seed(123)
# Read and parse HTML file
doc.html.2009 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20090224.html',useInternal = TRUE)
doc.html.2010 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20100127.html',useInternal = TRUE)
doc.html.2011 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20110125.html',useInternal = TRUE)
doc.html.2012 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20120124.html',useInternal = TRUE)
doc.html.2013 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20130212.html',useInternal = TRUE)
doc.html.2014 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20140128.html',useInternal = TRUE)
doc.html.2015 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20150120.html',useInternal = TRUE)
doc.html.2016 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20160112.html',useInternal = TRUE)
doc.html.2017 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20170228.html',useInternal = TRUE)
doc.html.2018 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20180130.html',useInternal = TRUE)
doc.html.2019 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20190205.html',useInternal = TRUE)
doc.html.2020 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20200204.html',useInternal = TRUE)


# Extract all the paragraphs (HTML tag is p, starting at the root of the document). Unlist flattens the list to
# create a character vector.
doc.text.2009 = unlist(xpathApply(doc.html.2009, '//p', xmlValue))
doc.date.2009 = unlist(xpathApply(doc.html.2009, '//h3', xmlValue))
doc.president.2009 = unlist(xpathApply(doc.html.2009, '//h2', xmlValue))

doc.text.2010 = unlist(xpathApply(doc.html.2010, '//p', xmlValue))
doc.date.2010 = unlist(xpathApply(doc.html.2010, '//h3', xmlValue))
doc.president.2010 = unlist(xpathApply(doc.html.2010, '//h2', xmlValue))

doc.text.2011 = unlist(xpathApply(doc.html.2011, '//p', xmlValue))
doc.date.2011 = unlist(xpathApply(doc.html.2011, '//h3', xmlValue))
doc.president.2011 = unlist(xpathApply(doc.html.2011, '//h2', xmlValue))

doc.text.2012 = unlist(xpathApply(doc.html.2012, '//p', xmlValue))
doc.date.2012 = unlist(xpathApply(doc.html.2012, '//h3', xmlValue))
doc.president.2012 = unlist(xpathApply(doc.html.2012, '//h2', xmlValue))

doc.text.2013 = unlist(xpathApply(doc.html.2013, '//p', xmlValue))
doc.date.2013 = unlist(xpathApply(doc.html.2013, '//h3', xmlValue))
doc.president.2013 = unlist(xpathApply(doc.html.2013, '//h2', xmlValue))

doc.text.2014 = unlist(xpathApply(doc.html.2014, '//p', xmlValue))
doc.date.2014 = unlist(xpathApply(doc.html.2014, '//h3', xmlValue))
doc.president.2014 = unlist(xpathApply(doc.html.2014, '//h2', xmlValue))

doc.text.2015 = unlist(xpathApply(doc.html.2015, '//p', xmlValue))
doc.date.2015 = unlist(xpathApply(doc.html.2015, '//h3', xmlValue))
doc.president.2015 = unlist(xpathApply(doc.html.2015, '//h2', xmlValue))

doc.text.2016 = unlist(xpathApply(doc.html.2016, '//p', xmlValue))
doc.date.2016 = unlist(xpathApply(doc.html.2016, '//h3', xmlValue))
doc.president.2016 = unlist(xpathApply(doc.html.2016, '//h2', xmlValue))

doc.text.2017 = unlist(xpathApply(doc.html.2017, '//p', xmlValue))
doc.date.2017 = unlist(xpathApply(doc.html.2017, '//h3', xmlValue))
doc.president.2017 = unlist(xpathApply(doc.html.2017, '//h2', xmlValue))

doc.text.2018 = unlist(xpathApply(doc.html.2018, '//p', xmlValue))
doc.date.2018 = unlist(xpathApply(doc.html.2018, '//h3', xmlValue))
doc.president.2018 = unlist(xpathApply(doc.html.2018, '//h2', xmlValue))

doc.text.2019 = unlist(xpathApply(doc.html.2019, '//p', xmlValue))
doc.date.2019 = unlist(xpathApply(doc.html.2019, '//h3', xmlValue))
doc.president.2019 = unlist(xpathApply(doc.html.2019, '//h2', xmlValue))


doc.text.2020 = unlist(xpathApply(doc.html.2020, '//p', xmlValue))
doc.date.2020 = unlist(xpathApply(doc.html.2020, '//h3', xmlValue))
doc.president.2020 = unlist(xpathApply(doc.html.2020, '//h2', xmlValue))


# Replace all \n by spaces
doc.text.2009 = gsub('\\n', ' ', doc.text.2009)
doc.text.2010 = gsub('\\n', ' ', doc.text.2010)
doc.text.2011 = gsub('\\n', ' ', doc.text.2011)
doc.text.2012 = gsub('\\n', ' ', doc.text.2012)
doc.text.2013 = gsub('\\n', ' ', doc.text.2013)
doc.text.2014 = gsub('\\n', ' ', doc.text.2014)
doc.text.2015 = gsub('\\n', ' ', doc.text.2015)
doc.text.2016 = gsub('\\n', ' ', doc.text.2016)
doc.text.2017 = gsub('\\n', ' ', doc.text.2017)
doc.text.2018 = gsub('\\n', ' ', doc.text.2018)
doc.text.2019 = gsub('\\n', ' ', doc.text.2019)
doc.text.2020 = gsub('\\n', ' ', doc.text.2020)


# Join all the elements of the character vector into a single
# character string, separated by spaces
doc.text.2009 = paste(doc.text.2009, collapse = ' ')
doc.text.2010 = paste(doc.text.2010, collapse = ' ')
doc.text.2011 = paste(doc.text.2011, collapse = ' ')
doc.text.2012 = paste(doc.text.2012, collapse = ' ')
doc.text.2013 = paste(doc.text.2013, collapse = ' ')
doc.text.2014 = paste(doc.text.2014, collapse = ' ')
doc.text.2015 = paste(doc.text.2015, collapse = ' ')
doc.text.2016 = paste(doc.text.2016, collapse = ' ')
doc.text.2017 = paste(doc.text.2017, collapse = ' ')
doc.text.2018 = paste(doc.text.2018, collapse = ' ')
doc.text.2019 = paste(doc.text.2019, collapse = ' ')
doc.text.2020 = paste(doc.text.2020, collapse = ' ')
 

 gc()